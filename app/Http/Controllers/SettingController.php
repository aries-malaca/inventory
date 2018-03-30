<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Setting;
use Validator;

class SettingController extends Controller{
    function getSettings(){
        return response()->json(Setting::get());
    }

    function updateSettings(Request $request){
        $validator = Validator::make($request->all(), [
            'setting_value' => 'required|max:255',
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()], 400);

        $api = $this->authenticateAPI();

        if($api['result'] === 'success') {
            $setting = Setting::find($request->input('id'));
            $setting->setting_value = $request->input('setting_value');
            $setting->save();

            return response()->json(['result'=>'success', 'message'=>'Successfully update setting.']);
        }

        return response()->json($api, $api["status_code"]);
    }
}