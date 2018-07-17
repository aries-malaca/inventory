<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Branch;
use Validator;

class BranchController extends Controller
{
    function index(){
        if(!$this->initApp()){
            return redirect('login');
        }

        $this->data['title'] = 'Branches';
        return view('branches',$this->data);
    }

    function getBranches(){
        return response()->json(Branch::get()->toArray());
    }

    function addBranch(Request $request){
        $validator = Validator::make($request->all(), [
            'branch_name' => 'required|unique:branches,branch_name|max:255',
            'branch_address' => 'required|max:255',
            'branch_contact' => 'required|max:255',
            'branch_role' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()]);
        }

        $branch = new Branch;
        $branch->branch_name = $request->input('branch_name');
        $branch->branch_address = $request->input('branch_address');
        $branch->branch_role = $request->input('branch_role');
        $branch->branch_contact = $request->input('branch_contact');
        $branch->is_active = 1;
        $branch->save();

        return response()->json(['result'=>'success']);
    }

    function updateBranch(Request $request){
        $validator = Validator::make($request->all(), [
            'branch_name' => 'required|unique:branches,branch_name,'.$request->input('id').'|max:255',
            'branch_address' => 'required|max:255',
            'branch_contact' => 'required|max:255',
            'branch_role' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()]);
        }

        $branch = Branch::find($request->input('id'));
        $branch->branch_name = $request->input('branch_name');
        $branch->branch_address = $request->input('branch_address');
        $branch->branch_role = $request->input('branch_role');
        $branch->branch_contact = $request->input('branch_contact');
        $branch->is_active = $request->input('is_active');
        $branch->save();

        return response()->json(['result'=>'success']);
    }
}
