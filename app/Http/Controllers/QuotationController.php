<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Quotation;
use App\QuotationItem;
use App\Product;
use App\Unit;
use Validator;
use App\User;
use PDF;

class QuotationController extends Controller{
    function getQuotations(){
        $data = Quotation::get();
        foreach($data as $key=>$value){
            $data[$key]['items'] = $value->items()->get();
            $data[$key]['quotation_data'] = json_decode($value['quotation_data']);
            $user = User::find($value['user_id']);
            $data[$key]['quoted_by_name'] = isset($user->id)?$user->name:'N/A';
        }

        return response()->json($data->toArray());
    }

    function addQuotation(Request $request){
        $validator = Validator::make($request->all(), [
            'client_name' => 'required|max:255',
            'reference_no'=>'required|unique:quotations,reference_no'
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()], 400);

        if (sizeof($request->input('items')) < 1)
            return response()->json(['result'=>'failed', 'errors'=>"No items has been added."], 400);

        $api = $this->authenticateAPI();
        if($api['result'] === 'success') {
            $quotation = new Quotation;
            $quotation->client_name = $request->input('client_name');
            $quotation->client_address = $request->input('client_address');
            $quotation->client_company = $request->input('client_company');
            $quotation->client_phone = $request->input('client_phone');
            $quotation->client_email = $request->input('client_email');
            $quotation->reference_no = $request->input('reference_no');
            $quotation->notes = $request->input('notes');
            $quotation->tax_number = $request->input('tax_number');
            $quotation->quotation_data = json_encode($request->input('quotation_data'));
            $quotation->user_id = $api['user']['id'];
            $quotation->save();

            foreach($request->input('items') as $key=>$value){
                $item = new QuotationItem;
                $item->product_id = $value['product']['id'];
                $item->quotation_id = $quotation->id;
                $item->unit_id = $value['unit']['id'];
                $item->quantity = $value['quantity'];
                $item->discount = 0;
                $item->base_price = $value['base_price'];
                $item->selling_price = $value['selling_price'];
                $item->last_price = 0;
                $item->final_price = 0;
                $item->quotation_item_data = '{}';
                $item->save();
            }

            return response()->json(['result'=>'success', 'message'=>'Successfully added quotation.']);
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

        if (sizeof($request->input('items')) < 1)
            return response()->json(['result'=>'failed', 'errors'=>"No items has been added."], 400);

        $api = $this->authenticateAPI();
        if($api['result'] === 'success') {
            $quotation = Quotation::find($request->input('id'));
            $quotation->client_name = $request->input('client_name');
            $quotation->client_address = $request->input('client_address');
            $quotation->client_company = $request->input('client_company');
            $quotation->client_phone = $request->input('client_phone');
            $quotation->client_email = $request->input('client_email');
            $quotation->reference_no = $request->input('reference_no');
            $quotation->notes = $request->input('notes');
            $quotation->tax_number = $request->input('tax_number');
            $quotation->quotation_data = json_encode($request->input('quotation_data'));
            $quotation->user_id = $api['user']['id'];
            $quotation->save();

            QuotationItem::where('quotation_id', $quotation->id)
                            ->delete();

            foreach($request->input('items') as $key=>$value){
                $item = new QuotationItem;
                $item->product_id = $value['product']['id'];
                $item->quotation_id = $quotation->id;
                $item->unit_id = $value['unit']['id'];
                $item->quantity = $value['quantity'];
                $item->discount = 0;
                $item->base_price = $value['base_price'];
                $item->selling_price = $value['selling_price'];
                $item->last_price = 0;
                $item->final_price = 0;
                $item->quotation_item_data = '{}';
                $item->save();
            }
            return response()->json(['result'=>'success', 'message'=>'Successfully updated quotation.']);
        }

        return response()->json($api, $api["status_code"]);
    }

    function printQuotation(Request $request){
        $type = pathinfo(public_path('images/logo.jpg'), PATHINFO_EXTENSION);
        $raw = file_get_contents(public_path('images/logo.jpg'));
        $base64 = 'data:image/' . $type . ';base64,' . base64_encode($raw);
        $logo = $base64;

        $quotation = Quotation::find($request->segment(3));
        $quotation->items = $quotation->items()->get();
        $quotation->quotation_data = json_decode($quotation->quotation_data);
        $total = 0;

        foreach($quotation->items as $key=>$item){
            $quotation->items[$key]->product = Product::find($item['product_id']);
            $quotation->items[$key]->unit = Unit::find($item['unit_id']);
            $total += $item['quantity'] * $item['selling_price'];
            $quotation->items[$key]->image = json_decode($quotation->items[$key]->product->pictures_data);

            if(sizeof($quotation->items[$key]->image) > 0)
                $path = public_path('images/products/'.$quotation->items[$key]->image[0]);
            else
                $path = public_path('images/products/no-image.jpg');

            $type = pathinfo($path, PATHINFO_EXTENSION);
            $raw = file_get_contents($path);
            $base64 = 'data:image/' . $type . ';base64,' . base64_encode($raw);
            $quotation->items[$key]->image = $base64;
        }
        if(!isset($quotation->id))
            return response()->json("Not found.", 404);

        $pdf = PDF::loadView('pdf.'.'quotation', array("logo"=>$logo,
                                                        "total"=>$total,
                                                       "data"=> $quotation ));
        $pdf->setPaper('letter', 'portrait');
        $pdf->save(public_path('files/generated/quotation.pdf'));
        
        return response()->file(public_path('files/generated/quotation.pdf'));
    }
}