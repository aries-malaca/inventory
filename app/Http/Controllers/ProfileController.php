<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Validator;
use App\User;
use Hash;
use Illuminate\Support\Facades\Auth;

class ProfileController extends Controller{
    function updateProfile(Request $request){
        $validator = Validator::make($request->all(), [
            'address' => 'required|max:255',
            'email' => 'required|email',
            'mobile' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()],400);
        }
        $api = $this->authenticateAPI();


        if($api['result'] === 'success') {
            $user = User::find($api['user']['id']);
            $user->name = $request->input('name');
            $user->email = $request->input('email');
            $user->address = $request->input('address');
            $msg = '';
            if($request->input('password')!=='' AND $request->input('password') !== null){

                if(Hash::check($request->input('old_password'), $user->password)){
                    if($request->input('password') === $request->input('password2'))
                        $user->password = bcrypt($request->input('password'));
                    else
                        return response()->json(['result'=>'failed', 'errors'=>"Password mismatch."],400);
                }
                else
                     return response()->json(['result'=>'failed', 'errors'=>"Old password is incorrect"],400);

                $msg = 'Password changed.';
            }
            
            $user->mobile = $request->input('mobile');
            $user->save();

            return response()->json(['result'=>'success', 'message'=>'Profile successfully updated. ' . $msg]);
        }

        return response()->json($api, $api["status_code"]);
    }

    function uploadPicture(Request $request){
        $api = $this->authenticateAPI();
        if($api['result'] === 'success') {
            if($request->input('image') === null)
                return response()->json(["result"=>"failed","error"=>"No File to be uploaded."], 400);
            $data = $request->input('image');
            list($type, $data) = explode(';',$data);
            list(,$data) = explode(',', $data);
            if($type == 'data:image/jpeg')
               $ext = 'jpg';
            elseif($type == 'data:image/png')
                $ext = 'png';
            else
                return response()->json(["result"=>"failed","error"=>"Invalid File Format."],400);
            $filename = $request->input('user_id') . '_' . time().'.'.$ext ;
            $data = base64_decode($data);
            file_put_contents(public_path('images/users/'). $filename, $data );
            $user = User::find($request->input('user_id'));
            if($user->photo != 'default.jpg')
                if(file_exists(public_path('/images/users/'.$user->photo)))
                    unlink(public_path('/images/users/'.$user->photo));
            $user->photo = $filename;
            $user->save();
            return response()->json(["result"=>"success"],200);
        }
        return response()->json($api, $api["status_code"]);

    }
}