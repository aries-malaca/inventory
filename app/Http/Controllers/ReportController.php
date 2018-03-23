<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use PDF;
use App\Sale;
use App\SaleItem;
use App\User;
use App\Client;
use Validator;
use Illuminate\Support\Facades\Auth;
use App\Unit;
use App\Product;

class ReportController extends Controller
{
    function index(){
        if(!$this->initApp()){
            return redirect('login');
        }

        $this->data['title'] = 'Reports';
        return view('reports',$this->data);
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
