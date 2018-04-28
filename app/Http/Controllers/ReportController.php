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

        $distict_categories = $this->groupByCategories($data);


        $big_data = array("products"=>$distict_categories,
                        "request"=>$request,
                        "field_size"=>$size,
                        "categories"=>in_array(0, $new_array)?['All']:Category::whereIn('id', $new_array)->pluck("category_name")->toArray(),
                        "price_category"=>PriceCategory::find($request->input('selling_price')));

        if($request->input('format') === 'pdf'){
            $pdf = PDF::loadView('pdf.'.$request->input('type'), $big_data);
            $pdf->setPaper('letter', 'portrait');
            $pdf->save(public_path($url));
        }
        else
            Excel::store(new ProductList($big_data), 'files/generated/product_report.xlsx', 'files');

        return array("path"=>$url, "data"=>$data);
    }
}