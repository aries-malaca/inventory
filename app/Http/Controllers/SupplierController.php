<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Supplier;
use Validator;

class SupplierController extends Controller{

    function getSuppliers(){
        return response()->json(Supplier::get()->toArray());
    }

    function addSupplier(Request $request){
        $validator = Validator::make($request->all(), [
            'supplier_name' => 'required|unique:suppliers,supplier_name|max:255',
            'supplier_address' => 'required|max:255',
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()], 400);

        $api = $this->authenticateAPI();

        if($api['result'] === 'success') {
            $supplier = new Supplier;
            $supplier->supplier_name = $request->input('supplier_name');
            $supplier->supplier_address = $request->input('supplier_address');
            $supplier->supplier_contact_person = $request->input('supplier_contact_person');
            $supplier->supplier_email = $request->input('supplier_email');
            $supplier->supplier_telephone_no = $request->input('supplier_telephone_no');
            $supplier->supplier_mobile_no = $request->input('supplier_mobile_no');
            $supplier->supplier_fax = $request->input('supplier_fax');
            $supplier->contact_person_designation = ($request->input('contact_person_designation')!==null?$request->input('contact_person_designation'):'');
            $supplier->is_active = 1;
            $supplier->save();

            return response()->json(['result'=>'success', 'message'=>'Successfully added supplier.']);
        }

        return response()->json($api, $api["status_code"]);
    }

    function updateSupplier(Request $request){
        $validator = Validator::make($request->all(), [
            'supplier_name' => 'required|unique:suppliers,supplier_name,'.$request->input('id').'|max:255',
            'supplier_address' => 'required|max:255'
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()], 400);

        $api = $this->authenticateAPI();

        if($api['result'] === 'success') {
            $supplier = Supplier::find($request->input('id'));
            $supplier->supplier_name = $request->input('supplier_name');
            $supplier->supplier_address = $request->input('supplier_address');
            $supplier->supplier_contact_person = $request->input('supplier_contact_person');
            $supplier->supplier_email = $request->input('supplier_email');
            $supplier->supplier_telephone_no = $request->input('supplier_telephone_no');
            $supplier->supplier_mobile_no = $request->input('supplier_mobile_no');
            $supplier->supplier_fax = $request->input('supplier_fax');
            $supplier->is_active = $request->input('is_active');
            $supplier->contact_person_designation = ($request->input('contact_person_designation')!==null?$request->input('contact_person_designation'):'');
            $supplier->save();

            return response()->json(['result'=>'success', 'message'=>'Successfully updated supplier.']);
        }

        return response()->json($api, $api["status_code"]);
    }
}