<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Purchase;
use App\PurchaseItem;
use App\User;
use App\Supplier;
use App\Product;
use Validator;
use Illuminate\Support\Facades\Auth;
use App\Setting;

class PurchaseController extends Controller{
    function index(){
        if(!$this->initApp()){
            return redirect('login');
        }

        $this->data['title'] = 'Purchases';
        $this->data['parent_title'] = 'Transactions';
        $this->data['parent_url'] = '#';
        return view('purchases',$this->data);
    }

    function getPurchases(){
        $data = Purchase::get();
        foreach($data as $key=>$value){
            $purchase_data = json_decode($value['purchase_data'],true);
            $data[$key]['items'] = PurchaseItem::where('purchase_id', $value['id'])->get()->toArray();
            $data[$key]['items_count'] = sizeof($data[$key]['items']);
            $data[$key]['supplier_name'] = Supplier::find($value['supplier_id'])->supplier_name;
            $data[$key]['name'] = User::find($value['user_id'])->name;
            $data[$key]['terms'] = ($value['date_transaction'] == $value['date_due']?'COD':'Credit');
            $data[$key]['net_amount'] = (isset($purchase_data['net_amount'])?number_format($purchase_data['net_amount'],2):0);
        }

        return response()->json($data);
    }

    function addPurchase(Request $request){
        $validator = Validator::make($request->all(), [
            'receipt_no' => 'required|unique:purchases,reference_no',
            'supplier_id' => 'required|not_in:0',
            'date_transaction' => 'required',
            'date_due' => 'required',
            'reference_no' => 'required|unique:purchases,reference_no'
        ]);

        if ($validator->fails()) {
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()]);
        }

        $purchase = new Purchase;
        $purchase->reference_no = $request->input('reference_no');
        $purchase->receipt_no = $request->input('receipt_no');
        $purchase->notes = $request->input('notes');
        $purchase->supplier_id = $request->input('supplier_id');
        $purchase->date_transaction = date('Y-m-d',strtotime($request->input('date_transaction')));
        $purchase->date_due = date('Y-m-d',strtotime($request->input('date_due')));
        $purchase->user_id = Auth::user()->id;
        $purchase->branch_id = Auth::user()->branch_id;
        $purchase->purchase_status = $request->input('purchase_status');
        $purchase->purchase_data = json_encode($request->input('purchase_data'));
        $purchase->payment_data = json_encode($request->input('payment_data'));
        $purchase->save();

        foreach($request->input('items') as $key=>$value){
            $item = new PurchaseItem;
            $item->product_id = $value['product_id'];
            $item->quantity = $value['quantity'];
            $item->purchase_id = $purchase->id;
            $item->unit = $value['unit'];
            $item->received_quantity = $value['received_quantity'];
            $item->purchase_price = $value['purchase_price'];
            $item->unit_price = $value['unit_price'];
            $item->discount = $value['discount'];
            $item->save();
        }

        return response()->json(['result'=>'success']);
    }

    function updatePurchase(Request $request){
        $validator = Validator::make($request->all(), [
            'receipt_no' => 'required|unique:purchases,reference_no,'.$request->input('id'),
            'supplier_id' => 'required|not_in:0',
            'date_transaction' => 'required',
            'date_due' => 'required',
            'reference_no' => 'required|unique:purchases,reference_no,'.$request->input('id')
        ]);

        if ($validator->fails()) {
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()]);
        }

        $purchase = Purchase::find($request->input('id'));
        $current_status = $purchase->purchase_status;
        $current_items =  PurchaseItem::where('purchase_id',$purchase->id)->get()->toArray();
        $purchase->reference_no = $request->input('reference_no');
        $purchase->receipt_no = $request->input('receipt_no');
        $purchase->notes = $request->input('notes');
        $purchase->supplier_id = $request->input('supplier_id');
        $purchase->date_transaction = date('Y-m-d',strtotime($request->input('date_transaction')));
        $purchase->date_due = date('Y-m-d',strtotime($request->input('date_due')));
        $purchase->user_id = Auth::user()->id;
        $purchase->purchase_status = $request->input('purchase_status');
        $purchase->purchase_data = json_encode($request->input('purchase_data'));
        $purchase->payment_data = json_encode($request->input('payment_data'));
        $purchase->save();
        
       
        PurchaseItem::where('purchase_id',$purchase->id)->delete();
        foreach($request->input('items') as $key=>$value){
            $item = new PurchaseItem;
            $item->product_id = $value['product_id'];
            $item->quantity = $value['quantity'];
            $item->received_quantity = $value['received_quantity'];
            $item->purchase_id = $purchase->id;
            $item->unit = $value['unit'];
            $item->purchase_price = $value['purchase_price'];
            $item->unit_price = $value['unit_price'];
            $item->discount = $value['discount'];
            $item->save();

            if($purchase->purchase_status == 'approved'){
                $this->changePurchasePrice($item);
            }
        }

        if($purchase->purchase_status == 'approved' && $current_status == 'pending'){
            $this->receiveStocks($request->input('items'), $purchase->branch_id);
        }
        elseif($purchase->purchase_status == 'approved' && $current_status == 'approved'){
            $this->discardStocks($current_items,$purchase->branch_id);
            $this->receiveStocks($request->input('items'), $purchase->branch_id);
        }

        return response()->json(['result'=>'success']);
    }

    function voidPurchase(Request $request){
        $purchase = Purchase::find($request->input('id'));
        $purchase->purchase_status = 'void';
        $purchase->save();

        $items = PurchaseItem::where('purchase_id',$request->input('id'))->get();
        $this->discardStocks($items,$purchase->branch_id);
        
        return response()->json(['result'=>'success']);
    }
    
    function cancelPurchase(Request $request){
        $purchase = Purchase::find($request->input('id'));
        $purchase->purchase_status = 'cancelled';
        $purchase->save();

        return response()->json(['result'=>'success']);
    }

    function deletePurchase(Request $request){
        $password = Setting::find(5)->setting_value;
        if($password == $request->input('password')){
            Purchase::destroy($request->input('id'));
            PurchaseItem::where('purchase_id', $request->input('id'))->delete();
            return response()->json(['result'=>'success']);
        }

        return response()->json(['result'=>'failed', 'errors'=>'Incorrect password.']);
    }

    function getPriceHistory(Request $request){
        $get = PurchaseItem::leftJoin('purchases','purchase_items.purchase_id','=','purchases.id')
                            ->leftJoin('suppliers','purchases.supplier_id','=','suppliers.id')
                            ->where('purchase_items.product_id', $request->segment(3))
                            ->where('purchases.purchase_status','approved')
                            ->get()->toArray();
        return response()->json($get);
    }
}