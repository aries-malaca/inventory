<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class InventoryController extends Controller{
    function index(){
        if(!$this->initApp()){
            return redirect('login');
        }

        $this->data['title'] = 'Inventory';
        $this->data['parent_title'] = 'Transactions';
        $this->data['parent_url'] = '#';
        return view('inventory',$this->data);
    }
}
