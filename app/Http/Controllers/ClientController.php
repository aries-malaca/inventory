<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Client;
use Validator;

class ClientController extends Controller{
    function getClients(){
        $data = Client::leftJoin('price_categories', 'clients.price_category_id', '=', 'price_categories.id')
                        ->select('clients.*','price_category_name')
                        ->get()->toArray();
        return response()->json($data);
    }

    function addClient(Request $request){
        $validator = Validator::make($request->all(), [
            'client_name' => 'required|unique:clients,client_name|max:255',
            'price_category_id' => 'required|not_in:0'
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()], 400);

        $api = $this->authenticateAPI();

        if($api['result'] === 'success') {
            $client = new Client;
            $client->client_name = $request->input('client_name');
            $client->client_company = $request->input('client_company');
            $client->client_address = $request->input('client_address');
            $client->client_contact_person = $request->input('client_contact_person');
            $client->client_email = $request->input('client_email');
            $client->client_contact_info = $request->input('client_contact_info');
            $client->price_category_id = $request->input('price_category_id');
            $client->contact_person_designation = $request->input('contact_person_designation');
            $client->is_active = 1;
            $client->save();

            return response()->json(['result'=>'success', 'message'=>'Successfully added client.']);
        }

        return response()->json($api, $api["status_code"]);
    }

    function updateClient(Request $request){
        $validator = Validator::make($request->all(), [
            'client_name' => 'required|unique:clients,client_name,'.$request->input('id').'|max:255',
            'price_category_id' =>'required|not_in:0'
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()], 400);

        $api = $this->authenticateAPI();

        if($api['result'] === 'success') {
            $client = Client::find($request->input('id'));
            $client->client_name = $request->input('client_name');
            $client->client_company = $request->input('client_company');
            $client->client_address = $request->input('client_address');
            $client->client_contact_person = $request->input('client_contact_person');
            $client->client_email = $request->input('client_email');
            $client->client_contact_info = $request->input('client_contact_info');
            $client->price_category_id = $request->input('price_category_id');
            $client->is_active = $request->input('is_active');
            $client->contact_person_designation = $request->input('contact_person_designation');
            $client->save();

            return response()->json(['result'=>'success', 'message'=>'Successfully updated client']);
        }

        return response()->json($api, $api["status_code"]);
    }
}