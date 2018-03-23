<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Branch;
use App\Inventory;
use Validator;
use App\User;
use Illuminate\Support\Facades\Auth;
use App\Setting;
use App\Reconciliation;
use App\ReconciliationItem;
use Excel;
use App\Product;
use App\Category;
use App\Sale;
use App\SaleItem;

class ReconciliationController extends Controller{
    function index(){
        if(!$this->initApp()){
            return redirect('login');
        }

        $this->data['title'] = 'Stocks Reconcialiation';
        $this->data['parent_title'] = 'Transactions';
        $this->data['parent_url'] = '#';
        return view('reconciliations',$this->data);
    }

    function getReconciliations(){
        $data = Reconciliation::get();
        foreach($data as $key=>$value){
            $received_data = json_decode($value['received_data'],true);
            $data[$key]['items'] = ReconciliationItem::where('reconciliation_id', $value['id'])->get()->toArray();
            $data[$key]['name'] = User::find($value['user_id'])->name;
            $data[$key]['items_count'] = sizeof($data[$key]['items']);
        }

        return response()->json($data);
    }

    function addReconciliation(Request $request){
        $validator = Validator::make($request->all(), [
            'date_received' => 'required',
            'reference_no' => 'required|unique:reconciliations,reference_no'
        ]);

        if ($validator->fails()) {
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()]);
        }

        $receive = new Reconciliation;
        $receive->reference_no = $request->input('reference_no');
        $receive->notes = $request->input('notes');
        $receive->date_received = date('Y-m-d',strtotime($request->input('date_received')));
        $receive->user_id = Auth::user()->id;
        $receive->receive_status = $request->input('receive_status');
        $receive->received_data = json_encode($request->input('received_data'));
        $receive->save();

        foreach($request->input('items') as $key=>$value){
            $item = new ReconciliationItem;
            $item->product_id = $value['product_id'];
            $item->beginning = json_encode($value['beginning']);
            $item->difference = json_encode($value['difference']);
            $item->actual = json_encode($value['actual']);
            $item->beginning_retail = $value['beginning_retail'];
            $item->actual_retail = $value['actual_retail'];
            $item->difference_retail = $value['difference_retail'];
            $item->reconciliation_id = $receive->id;
            $item->save();
        }

        return response()->json(['result'=>'success']);
    }

    function updateReconciliation(Request $request){
        $validator = Validator::make($request->all(), [
            'date_received' => 'required',
            'reference_no' => 'required|unique:reconciliations,reference_no,'.$request->input('id')
        ]);

        if ($validator->fails()) {
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()]);
        }

        $receive = Reconciliation::find($request->input('id'));
        $receive->reference_no = $request->input('reference_no');
        $receive->notes = $request->input('notes');
        $receive->date_received = date('Y-m-d',strtotime($request->input('date_received')));
        $receive->user_id = Auth::user()->id;
        $receive->receive_status = $request->input('receive_status');
        $receive->received_data = json_encode($request->input('received_data'));
        $receive->save();

        ReconciliationItem::where('reconciliation_id', $receive->id)->delete();

        foreach($request->input('items') as $key=>$value){
            $item = new ReconciliationItem;
            $item->product_id = $value['product_id'];
            $item->beginning = json_encode($value['beginning']);
            $item->actual = json_encode($value['actual']);
            $item->difference = json_encode($value['difference']);
            $item->beginning_retail = $value['beginning_retail'];
            $item->actual_retail = $value['actual_retail'];
            $item->difference_retail = $value['difference_retail'];
            $item->reconciliation_id = $receive->id;
            $item->save();
        }

        return response()->json(['result'=>'success']);
    }

    function deleteReconciliation(Request $request){
        $password = Setting::find(5)->setting_value;
        if($password == $request->input('password')){
            Reconciliation::destroy($request->input('id'));
            ReconciliationItem::where('reconciliation_id', $request->input('id'))->delete();
            return response()->json(['result'=>'success']);
        }

        return response()->json(['result'=>'failed', 'errors'=>'Incorrect password.']);
    }
    function exportAsSales(Request $request){
        $data = $this->getReconciliation($request->segment(3));
        $sale = new Sale;
        $sale->receipt_no = json_decode(file_get_contents('http://localhost/sales/getTempID'));
        $sale->notes = 'Recon reference no:' . $data['info']['reference_no'];
        $sale->client_id = 2;
        $sale->price_category_id = 15;
        $sale->date_transaction = date('Y-m-d');
        $sale->date_due = date('Y-m-d');
        $sale->user_id = Auth::user()->id;
        $sale->branch_id = Auth::user()->branch_id;
        $sale->sales_status = 'pending';
        $sale->sales_data = json_encode(["vat_inclusive"=>"0",
                                            "vat_enabled"=>"0",
                                            "total_amount"=>0,
                                            "discount"=>"0",
                                            "gross_amount"=>0,
                                            "vat_amount"=>"0",
                                            "vat_rate"=>"12",
                                            "net_amount"=>0,
                                            "paid_amount"=>"0",
                                            "balance"=>"0",
                                            "cash"=>"0",
                                            "recent_sales_id"=>"0"]);
        $sale->payment_data = json_encode([["method"=>"Cash","amount"=>"0","details"=>null]]);
        $sale->save();

        $total = 0;
        foreach($data['items'] as $key=>$value){
            $difference = $value['difference'];
            foreach($difference as $k=>$v){
                if($v['quantity'] > 0){
                    $item = new SaleItem;
                    $item->product_id = $value['product_id'];
                    $item->quantity = $v['quantity'];
                    $item->sales_id = $sale->id;
                    $item->unit = $v['unit'];
                    $item->sold_quantity = $v['quantity'];
                    $item->original_price = $this->getPrice($value['product_id'],$v['unit']);
                    $item->selling_price = $this->getPrice($value['product_id'],$v['unit']);
                    $item->discount = 0;
                    $item->save();

                    $total+=$item->selling_price;
                }
            }
        }

        $sale = Sale::find($sale->id);
        $sale->sales_data =   json_encode(["vat_inclusive"=>"0",
                                            "vat_enabled"=>"0",
                                            "total_amount"=>$total,
                                            "discount"=>"0",
                                            "gross_amount"=>$total,
                                            "vat_amount"=>"0",
                                            "vat_rate"=>"12",
                                            "net_amount"=>$total,
                                            "paid_amount"=>"0",
                                            "balance"=>"0",
                                            "cash"=>"0",
                                            "recent_sales_id"=>"0"]
                                        );
        $sale->save();

        return response()->json(['result'=>'success','receipt_no'=>$sale->receipt_no]);
    }

    function getReconciliation($id){
        $get = ReconciliationItem::where('reconciliation_id',$id)->get()->toArray();
        $array = array();
        foreach($get as $key=>$value){
            $product = Product::find($value['product_id']);
            $array[] = array("product_name" => $product->product_name,
                             "category" => Category::find($product->category_id)->category_name,
                             "beginning" => json_decode($value['beginning'],true),
                             "actual" => json_decode($value['actual'],true),
                             "difference" => json_decode($value['difference'],true),
                             "product_id" => $value['product_id']
                             );
        }
        return array("info"=>Reconciliation::find($id),"items"=>$array);
    }

    function getPrice($product_id, $unit_id){
        $price = 0;
        $products = Product::get()->toArray();
        foreach($products as $key=>$value){
            if($value['id'] == $product_id){
                $product_data = json_decode($value['product_data'], true);
                foreach($product_data['product_units'] as $k=>$v){
                    if($v['unit'] == $unit_id){
                        foreach($v['selling_price'] as $i){
                            if($i['id'] == 15){
                                return (double)$i['value'];
                            }
                        }
                    }
                }
            }
        }

        return (double)$price;
    }

    function num2alpha($n){
        for($r = ""; $n >= 0; $n = intval($n / 26) - 1)
            $r = chr($n%26 + 0x41) . $r;
        return $r;
    }
}