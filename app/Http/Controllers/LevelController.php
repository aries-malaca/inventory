<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Level;
use Validator;

class LevelController extends Controller
{
    function index(){
        if(!$this->initApp()){
            return redirect('login');
        }

        $this->data['title'] = 'Levels';
        $this->data['parent_title'] = 'Users';
        $this->data['parent_url'] = '#';
        return view('levels',$this->data);
    }

    function getLevels(){
        return response()->json(Level::get()->toArray());
    }

    function addLevel(Request $request){
        $validator = Validator::make($request->all(), [
            'level_name' => 'required|unique:levels,level_name|max:255',
            'is_default' => 'required',
            'is_active' => 'required' 
        ]);

        if ($validator->fails()) {
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()]);
        }

        $level = new Level;
        $level->level_name = $request->input('level_name');
        $level->level_description = $request->input('level_description');
        $level->is_active = $request->input('is_active');
        $level->is_default = $request->input('is_default');
        $level->level_data = json_encode($request->input('level_data'));
        $level->save();
        return response()->json(['result'=>'success']);
    }

    function updateLevel(Request $request){
        $validator = Validator::make($request->all(), [
            'level_name' => 'required|unique:levels,level_name,'.$request->input('id').'|max:255',
            'is_default' => 'required',
            'is_active' => 'required' 
        ]);

        if ($validator->fails()) {
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()]);
        }

        $level = Level::find($request->input('id'));
        $level->level_name = $request->input('level_name');
        $level->level_description = $request->input('level_description');
        $level->is_active = $request->input('is_active');
        $level->is_default = $request->input('is_default');
        $level->level_data = json_encode($request->input('level_data'));
        $level->save();
        return response()->json(['result'=>'success']);
    }

    function deleteLevel(Request $request){
        if(Level::find($request->input('id'))->is_default == 1 )
            return response()->json(['result'=>'failed', 'erros'=>'Unable to delete user level.']);

        Level::destroy($request->input('id'));
        return response()->json(['result'=>'success']);
    }
}
