<?php

namespace App\Http\Controllers;
use App\PriceCategory;
use App\ProductPrice;
use Illuminate\Http\Request;
use PDF;
use Excel;
use Validator;
use App\Product;
use App\Category;
use App\ProductUnit;
use App\Unit;
use App\Exports\ProductList;
class ReportController extends Controller{

    function generateReport(Request $request){
        $validator = Validator::make($request->all(), [
            'type' => 'required',
            'selling_price' => 'required|not_in:0',
            'categories' => 'required',
            'brands' => 'required'
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed','errors'=>$validator->errors()->all()], 400);

        if($request->input('type') === 'product_report'){
            $response = $this->generateProductReport($request);
            if($response !== false)
                return response()->json($response);
        }

        return response()->json(["errors"=>"No output has been generated.", "result"=>"failed"], 400);
    }

    function generateProductReport($request){
        $new_array = array();

        foreach($request->input('categories') as $key=>$value)
            $new_array[] = $value['value'];

        $data = Product::leftJoin('categories', 'products.category_id', '=', 'categories.id')
                        ->select("products.*",'category_name');
        if(!in_array(0, $new_array))
            $data = $data->whereIn('category_id', $new_array);

        if(!in_array("All", $request->input('brands')))
            $data = $data->whereIn('brand_name', $request->input('brands'));

        
        $data = $data->orderBy($request->input('sort_by'), $request->input('sort_order'))
                    ->get();

        foreach($data as $key=>$product){
            $data[$key]['product_units'] = Product::find($product['id'])->units()->get();
            $data[$key]['pictures_data'] = json_decode($product->pictures_data);

            if(sizeof($data[$key]['pictures_data']) > 0)
                $path = public_path('images/products/'. $data[$key]['pictures_data'][0]);
            else
                $path = public_path('images/products/no-image.jpg');

            $type = pathinfo($path, PATHINFO_EXTENSION);
            $raw = file_get_contents($path);
            $base64 = 'data:image/' . $type . ';base64,' . base64_encode($raw);
            $data[$key]['pictures_data'] = $base64;

            foreach($data[$key]['product_units'] as $k=>$unit){
                $data[$key]['product_units'][$k]['pricing'] = ProductUnit::find($unit['id'])->prices()->get();
                $data[$key]['product_units'][$k]['unit'] = Unit::find($unit['unit_id']);
                foreach($data[$key]['product_units'][$k]['pricing'] as $kk=>$pp)
                    $data[$key]['product_units'][$k]['pricing'][$kk]['selling'] = ProductPrice::find($pp['id'])->selling_prices()->get();
            }
        }

        $url = 'files/generated/'.$request->input('type') .'.' . $request->input('format');
        $size = 0;
        if($request->input('display_purchase_price'))
            $size++;
        if($request->input('display_vat_price'))
            $size++;

        $type = pathinfo(public_path('images/logo.jpg'), PATHINFO_EXTENSION);
        $raw = file_get_contents(public_path('images/logo.jpg'));
        $base64 = 'data:image/' . $type . ';base64,' . base64_encode($raw);
        $logo = $base64;

        $big_data = array("products"=>$this->groupByCategories($data->toArray()),
                        "request"=>$request,
                        "field_size"=>$size,
                        "logo"=>$logo,
                        "categories"=>in_array(0, $new_array)?['All']:Category::whereIn('id', $new_array)->pluck("category_name")->toArray(),
                        "price_category"=>PriceCategory::find($request->input('selling_price')));

        if($request->input('format') === 'pdf'){
            $pdf = PDF::loadView('pdf.'.$request->input('type'), $big_data);
            $pdf->setPaper('letter', 'portrait');
            $pdf->save(public_path($url));
        }
        else{
            Excel::load(public_path('templates/product_report.xlsx'), function($excel) use($big_data) {
                $excel->sheet('Sheet1', function($sheet) use($big_data) {
                    $origin = 3;
                    $sheet->setFreeze('A3');
                    foreach($big_data['products'] as $e => $group){
                        $sheet->row($origin, array($group['category_name']));
                        $sheet->row($origin, function($row) {
                            // call cell manipulation methods
                            $row->setFontColor('#FFFFFF');
                            $row->setBackground('#000056');
                        });
                        $origin ++;
                        $headers = [];
                        
                        $headers[] = 'S.N.';
                        $headers[] = 'Brand';
                        $headers[] = 'Code';
                        $headers[] = 'Description';
                        $headers[] = 'Color';
                        $headers[] = 'Size';
                        for($x=0;$x<3;$x++){
                            $headers[] = 'Unit '. ($x+1);
                            if($x>0)
                                $headers[] = 'Notes';
                            
                            if($big_data['request']->input('display_purchase_price'))
                                $headers[] = 'Cost Price';
                            
                                                        
                            if($big_data['request']->input('display_vat_price'))
                                $headers[] = 'Vat Selling Price';

                            $headers[] = 'Selling';
                        }
                        $headers[] = 'Packaging';

                        $sheet->row(2, $headers);
                        foreach($group['products'] as $key=>$product){
                            $content = array(
                                $key+1,
                                $product['brand_name'],
                                $product['product_code'],
                                $product['product_description'],
                                '',
                                $product['size'],
                            );

                            for($x=0;$x<3;$x++){
                                if(isset($product['product_units'][$x])){
                                    $content[] = $product['product_units'][$x]['unit']->unit_name;
                                    if($x>0)
                                        $content[] = $product['product_units'][$x]['unit']->unit_name .'/'. $product['product_units'][$x-1]['unit']->unit_name .':'. $product['product_units'][$x]['quantity_per_parent'];
                                    
                                    if($big_data['request']->input('display_purchase_price'))
                                        $content[] = number_format($product['product_units'][0]['pricing'][0]['purchase_price'], 2);

                                    if($big_data['request']->input('display_vat_price'))
                                        foreach($product['product_units'][$x]['pricing'][0]['selling'] as $s=> $selling)
                                            if($selling['price_category_id'] == $big_data['request']->input('selling_price'))
                                                $content[] = number_format( (($selling['selling_price'] * .12) + $selling['selling_price']), 2);
                                    
                                    foreach($product['product_units'][$x]['pricing'][0]['selling'] as $s=> $selling)
                                        if($selling['price_category_id'] == $big_data['request']->input('selling_price'))
                                            $content[] = number_format($selling['selling_price'], 2);
                                }
                            }

                            $sheet->row($origin, $content);
                            $origin ++;
                       }
                    }
                });
            })->store('xlsx', public_path('files/generated'));;
        }

        return array("path"=>$url, "data"=>$big_data);
    }

    function groupByCategories($data){
        $categories = [];

        foreach($data as $key=>$value){
            $index = $this->groupIndex($categories, $value);

            if($index !== false){
                $categories[$index]['products'][] = $value;
            }
            else{
                $categories[] = array("products"=>array($value), "category_id"=> $value['category_id'], 
                                        "category_name"=>$value['category_name']);
            }
        }

        return $categories;
    }

    function groupIndex($categories, $product){
        foreach($categories as $key=>$value){
            if($product['category_id'] == $value['category_id'])
                return $key;
        }
        return false;
    }
}