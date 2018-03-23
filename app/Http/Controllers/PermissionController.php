<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Permission;
use Validator;

class PermissionController extends Controller
{
    function index(){
        if(!$this->initApp()){
            return redirect('login');
        }

        $this->data['title'] = 'Permissions';
        $this->data['parent_title'] = 'Users';
        $this->data['parent_url'] = '#';
        return view('permissions',$this->data);
    }

    function getPermissions(){
        return response()->json(Permission::get()->toArray());
    }

    function addPermission(Request $request){

    }

    function updatePermission(Request $request){

    }

    function deletePermission(Request $request){

    }
}
