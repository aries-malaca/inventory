<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Validator;
use App\User;
use Hash;
use Illuminate\Support\Facades\Auth;

class ProfileController extends Controller{
    function index(){
        if(!$this->initApp()){
            return redirect('login');
        }

        $this->data['title'] = 'Profile';
        return view('profile',$this->data);
    }

    function updateProfile(Request $request){
        $validator = Validator::make($request->all(), [
            'address' => 'required|max:255',
            'email' => 'required|email',
            'mobile' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()]);
        }

        $user = User::find(Auth::user()->id);
        $user->name = $request->input('name');
        $user->email = $request->input('email');
        $user->address = $request->input('address');
        $user->mobile = $request->input('mobile');
        $user->photo = 'default.jpg';
        $user->save();

        return response()->json(['result'=>'success']);
    }

    function changePassword(Request $request){
        if(!Hash::check($request->input('old'), Auth::user()->password)){
            return response()->json(['result'=>'failed', 'errors'=>"Wrong old password."]);
        }

        if($request->input('new')!=$request->input('new2')){
            return response()->json(['result'=>'failed', 'errors'=>"New password mismatch."]);
        }

        if(strlen($request->input('new'))<6){
            return response()->json(['result'=>'failed', 'errors'=>"Password must be atleast 6 characters long."]);
        }

        $user = User::find(Auth::user()->id);
        $user->password = $request->input('new');
        $user->save();

        return response()->json(['result'=>'success']);
    }
}