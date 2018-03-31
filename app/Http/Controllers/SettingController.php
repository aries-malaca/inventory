<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Setting;
use Validator;
use Storage;
use Artisan;

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

    function getBackups(){
        $files = Storage::files('backups');
        $array = array();
        foreach($files as $key=>$file){
            $array[] = [
                "filename"=>str_replace('backups/','',$file),
                "size"=>number_format(Storage::size($file)/102400, 2) .'Mb',
                "created"=>date('m/d/Y h:i A',Storage::lastModified($file))
            ];
        }
        rsort($array);
        return response()->json($array);
    }

    function runBackup(){
        $code = Artisan::call('backup:mysql-dump');
        if($code===0)
            return response()->json(['result'=>'success', 'message'=>'Backup Success.']);

        return  response()->json(['result'=>'success', 'errors'=>'Backup Failed to execute.'], 400);
    }

    function restoreBackup(Request $request){
        if(Storage::exists('backups/' . $request->input('filename'))){
            $code = Artisan::call('backup:mysql-restore', ['--filename' => $request->input('filename'), '--yes'=>true]);
            if($code ===0)
                return response()->json(['result'=>'success', 'message'=>"Database successfully restored."]);
        }

        return  response()->json(['result'=>'failed', 'errors'=>'DB restore Failed to execute.'], 400);
    }

    function deleteBackup(Request $request){
        if(Storage::exists('backups/' . $request->input('filename'))){
            Storage::delete('backups/' . $request->input('filename'));
            return response()->json(['result'=>'success', 'message'=>"Backup successfully deleted."]);
        }
        return response()->json(['result'=>'failed', 'errors'=>"Failed to delete backup file."],400);
    }
}