<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Quotation;
use App\QuotationItem;
use Validator;

class QuotationController extends Controller{
    function getQuotations(){
        $data = Quotation::get();
        foreach($data as $key=>$value)
            $data[$key]['items'] = $value->items();

        return response()->json($data->toArray());
    }

    function addQuotation(Request $request){
        $validator = Validator::make($request->all(), [
            'client_name' => 'required|max:255',
            'reference_no'=>'required|unique:quotations,reference_no'
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()], 400);

        $api = $this->authenticateAPI();
        if($api['result'] === 'success') {
            $quotation = new Quotation;
            $quotation->client_name = $request->input('client_name');
            $quotation->client_address = $request->input('client_address');
            $quotation->client_company = $request->input('client_company');
            $quotation->client_phone = $request->input('client_phone');
            $quotation->client_mobile = $request->input('client_mobile');
            $quotation->client_email = $request->input('client_email');
            $quotation->reference_no = $request->input('reference_no');
            $quotation->notes = $request->input('notes');
            $quotation->quotation_data = '{}';
            $quotation->user_id = $api['user']['id'];
            $quotation->save();

            foreach($request->input('items') as $key=>$value){
                $item = new QuotationItem;
                $item->product_id = $value['product_id'];
                $item->quotation_id = $quotation->id;
                $item->quantity = $value['quantity'];
                $item->discount = $value['discount'];
                $item->base_price = $value['base_price'];
                $item->selling_price = $value['selling_price'];
                $item->last_price = $value['last_price'];
                $item->final_price = $value['final_price'];
                $item->quotation_item_data = '{}';
                $item->save();
            }

            return response()->json(['result'=>'success', 'message'=>'Successfully added client.']);
        }

        return response()->json($api, $api["status_code"]);
    }

    function updateQuotation(Request $request){
        $validator = Validator::make($request->all(), [
            'client_name' => 'required|max:255',
            'reference_no'=>'required|unique:quotations,reference_no,'.$request->input('id')
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()], 400);

        $api = $this->authenticateAPI();
        if($api['result'] === 'success') {
            $quotation = Quotation::find($request->input('id'));
            $quotation->client_name = $request->input('client_name');
            $quotation->client_address = $request->input('client_address');
            $quotation->client_company = $request->input('client_company');
            $quotation->client_phone = $request->input('client_phone');
            $quotation->client_mobile = $request->input('client_mobile');
            $quotation->client_email = $request->input('client_email');
            $quotation->reference_no = $request->input('reference_no');
            $quotation->notes = $request->input('notes');
            $quotation->quotation_data = '{}';
            $quotation->user_id = $api['user']['id'];
            $quotation->save();

            QuotationItem::where('quotation_id', $quotation->id)
                            ->delete();

            foreach($request->input('items') as $key=>$value){
                $item = new QuotationItem;
                $item->product_id = $value['product_id'];
                $item->quotation_id = $quotation->id;
                $item->quantity = $value['quantity'];
                $item->discount = $value['discount'];
                $item->base_price = $value['base_price'];
                $item->selling_price = $value['selling_price'];
                $item->last_price = $value['last_price'];
                $item->final_price = $value['final_price'];
                $item->quotation_item_data = '{}';
                $item->save();
            }
            return response()->json(['result'=>'success', 'message'=>'Successfully added client.']);
        }

        return response()->json($api, $api["status_code"]);
    }
}