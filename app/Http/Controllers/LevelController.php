<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Level;
use Validator;

class LevelController extends Controller{
    function getLevels(){
        $data = Level::get()->toArray();
        foreach($data as $key=>$value)
            $data[$key]['level_data'] = json_decode($value['level_data']);
        
        return response()->json($data);
    }

    function addLevel(Request $request){
        $validator = Validator::make($request->all(), [
            'level_name' => 'required|unique:levels,level_name|max:255',
            'is_active' => 'required' 
        ]);

        if ($validator->fails()) {
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()],400);
        }

        $api = $this->authenticateAPI();

        if($api['result'] === 'success') {
            $level = new Level;
            $level->level_name = $request->input('level_name');
            $level->level_description = $request->input('level_description');
            $level->is_active = $request->input('is_active');
            $level->is_default = 0;
            $level->level_data = json_encode($request->input('level_data'));
            $level->save();
            return response()->json(['result'=>'success','message'=>'Level has been added.']);
        }
        
        return response()->json($api, $api["status_code"]);   
    }

    function updateLevel(Request $request){
        $validator = Validator::make($request->all(), [
            'level_name' => 'required|unique:levels,level_name,'.$request->input('id').'|max:255',
            'is_active' => 'required' 
        ]);

        if ($validator->fails()) {
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()],400);
        }

        $api = $this->authenticateAPI();

        if($api['result'] === 'success') {
            $level = Level::find($request->input('id'));
            $level->level_name = $request->input('level_name');
            $level->level_description = $request->input('level_description');
            $level->is_active = $request->input('is_active');
            $level->level_data = json_encode($request->input('level_data'));
            $level->save();

            return response()->json(['result'=>'success','message'=>'Level has been updated.']);
        }
        
        return response()->json($api, $api["status_code"]);
    }
}