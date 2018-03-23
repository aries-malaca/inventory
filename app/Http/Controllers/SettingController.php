<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Setting;
use Validator;

class SettingController extends Controller{
    function index(){
        if(!$this->initApp()){
            return redirect('login');
        }

        $this->data['title'] = 'Settings';
        return view('settings',$this->data);
    }

    function getSettings(){
        return response()->json(Setting::get());
    }

    function updateSettings(Request $request){
        foreach($request->input('data') as $key=>$value){
            Setting::where('id',$value['id'])->update(['setting_value'=>$value['setting_value']]);
        }
        return response()->json(['result'=>'success']);
    }
    

}
