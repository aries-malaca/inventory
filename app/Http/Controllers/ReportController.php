<?php

namespace App\Http\Controllers;
use App\ProductPrice;
use Illuminate\Http\Request;
use PDF;
use Excel;
use Validator;
use App\Product;
use App\ProductUnit;
use App\Unit;
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
                    ->get()->all();

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

        if($request->input('format') === 'pdf'){
            $pdf = PDF::loadView('pdf.'.$request->input('type'), array("products"=>$data, "request"=>$request, "field_size"=>$size));
            $pdf->setPaper('letter', 'portrait');
            $pdf->save(public_path($url));
        }
        else{
            Excel::store(collect([]), 'files/generated/product_report.xlsx', 'files');
        }
        return array("path"=>$url, "data"=>$data);
    }

    function generateSalesReport(Request $request){
        $get = Sale::where('date_transaction','>=', $request->input('date_start'))
                    ->where('date_transaction','<=', $request->input('date_end'))
                    ->where('sales_status','sold')
                        ->get()->toArray();
        foreach($get as $key=>$value){
            $sales_data = json_decode($value['sales_data'],true);
            $get[$key]['items'] = SaleItem::leftJoin('products','sale_items.product_id','=','products.id')
                                            ->leftJoin('units','sale_items.unit','=','units.id')
                                            ->where('sales_id', $value['id'])->get()->toArray();
            $get[$key]['client'] = Client::find($value['client_id']);
            $get[$key]['items_count'] = sizeof($get[$key]['items']);
            $get[$key]['name'] = User::find($value['user_id'])->name;
            $get[$key]['terms'] = ($value['date_transaction'] == $value['date_due']?'COD':'Credit');
            $get[$key]['sales_data'] = $sales_data;
        }

        $url = 'generated_'. $request->input('report_type') .'.pdf';
        $pdf = PDF::loadView('pdf.'.$request->input('report_type'), array("sales"=>$get,
                                                                          "date_start"=> $request->input('date_start'),
                                                                          "date_end"=>$request->input('date_end')
                                                                          )
                                                                    );
        $pdf->setPaper('letter', 'landscape');
        $pdf->save(public_path($url));

        return response()->json(['result'=>'success','link'=>$url]);
    }
}
