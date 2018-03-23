<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Receive;
use App\ReceiveItem;
use App\Branch;
use App\Inventory;
use Validator;
use App\User;
use Illuminate\Support\Facades\Auth;
use App\Setting;

class ReceiveController extends Controller{
    function index(){
        if(!$this->initApp()){
            return redirect('login');
        }

        $this->data['title'] = 'Receives';
        $this->data['parent_title'] = 'Transactions';
        $this->data['parent_url'] = '#';
        return view('receives',$this->data);
    }

    function getReceives(){
        $data = Receive::get();
        foreach($data as $key=>$value){
            $received_data = json_decode($value['received_data'],true);
            $data[$key]['items'] = ReceiveItem::where('receive_id', $value['id'])->get()->toArray();
            $data[$key]['from_branch_name'] = Branch::find($value['from_branch_id'])->branch_name;
            $data[$key]['to_branch_name'] = Branch::find($value['to_branch_id'])->branch_name;
            $data[$key]['name'] = User::find($value['user_id'])->name;
            $data[$key]['items_count'] = sizeof($data[$key]['items']);
            $data[$key]['total_amount'] = (isset($received_data['total_amount'])?number_format($received_data['total_amount'],2):0);
        }

        return response()->json($data);
    }

    function addReceive(Request $request){
        $validator = Validator::make($request->all(), [
            'from_branch_id' => 'required|not_in:0',
            'to_branch_id' => 'required|not_in:0',
            'date_received' => 'required',
            'reference_no' => 'required|unique:receives,reference_no'
        ]);

        if ($validator->fails()) {
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()]);
        }

        $receive = new Receive;
        $receive->reference_no = $request->input('reference_no');
        $receive->from_branch_id = $request->input('from_branch_id');
        $receive->to_branch_id = $request->input('to_branch_id');
        $receive->notes = $request->input('notes');
        $receive->date_received = date('Y-m-d',strtotime($request->input('date_received')));
        $receive->user_id = Auth::user()->id;
        $receive->receive_status = $request->input('receive_status');
        $receive->received_data = json_encode($request->input('received_data'));
        $receive->save();

        foreach($request->input('items') as $key=>$value){
            $item = new ReceiveItem;
            $item->product_id = $value['product_id'];
            $item->quantity = $value['quantity'];
            $item->unit = $value['unit'];
            $item->unit_cost = $value['unit_cost'];
            $item->receive_id = $receive->id;
            $item->save();
        }

        return response()->json(['result'=>'success']);
    }

    function updateReceive(Request $request){
        $validator = Validator::make($request->all(), [
            'from_branch_id' => 'required|not_in:0',
            'to_branch_id' => 'required|not_in:0',
            'date_received' => 'required',
            'reference_no' => 'required|unique:receives,reference_no,'.$request->input('id')
        ]);

        if ($validator->fails()) {
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()]);
        }

        $receive = Receive::find($request->input('id'));
        $receive->reference_no = $request->input('reference_no');
        $receive->from_branch_id = $request->input('from_branch_id');
        $receive->to_branch_id = $request->input('to_branch_id');
        $receive->notes = $request->input('notes');
        $receive->date_received = date('Y-m-d',strtotime($request->input('date_received')));
        $receive->user_id = Auth::user()->id;
        $receive->receive_status = $request->input('receive_status');
        $receive->received_data = json_encode($request->input('received_data'));
        $receive->save();

        ReceiveItem::where('receive_id', $receive->id)->delete();

        foreach($request->input('items') as $key=>$value){
            $item = new ReceiveItem;
            $item->product_id = $value['product_id'];
            $item->quantity = $value['quantity'];
            $item->receive_id = $receive->id;
            $item->unit = $value['unit'];
            $item->unit_cost = $value['unit_cost'];
            $item->save();

            if($receive->receive_status == 'approved'){
                $this->changePurchasePrice($item);
            }
        }

        if($receive->receive_status == 'approved'){
            $this->receiveStocks($request->input('items'), $receive->to_branch_id);
        }

        return response()->json(['result'=>'success']);
    }
    
    function voidReceive(Request $request){
        $receive = Receive::find($request->input('id'));
        $receive->receive_status = 'void';
        $receive->save();

        $items = ReceiveItem::where('receive_id',$request->input('id'))->get();
        $this->discardStocks($items,$receive->to_branch_id);
        
        return response()->json(['result'=>'success']);
    }
    
    function cancelReceive(Request $request){
        $receive = Receive::find($request->input('id'));
        $receive->receive_status = 'cancelled';
        $receive->save();

        return response()->json(['result'=>'success']);
    }

    function deleteReceive(Request $request){
        $password = Setting::find(5)->setting_value;
        if($password == $request->input('password')){
            Receive::destroy($request->input('id'));
            ReceiveItem::where('receive_id', $request->input('id'))->delete();
            return response()->json(['result'=>'success']);
        }

        return response()->json(['result'=>'failed', 'errors'=>'Incorrect password.']);
    }
}
