<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\User;
use App\Level;
use Validator;
use JWTAuth;
use Hash;
use DB;

class UserController extends Controller{
    public function login(Request $request){
        $validator = Validator::make($request->all(), [
            'email' => 'required|max:255',
            'password' => 'required|max:255',
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed','error'=>$validator->errors()->all()], 400);

        //attempt to login the system
        $u = User::where('email', $request['email'])->get()->first();

        if(isset($u['id'])){
            if($u['is_active'] == 0)
                return response()->json(["result"=>"failed","error"=>"Account is inactive. Please check verify it by checking your email address or go to 'Forgot Password' to resend email"],400);

            if(Hash::check($request['password'], $u['password'])){
                $token = JWTAuth::fromUser(User::find($u['id']));

                if($request->input('device') === null)
                    $this->registerToken($u['id'], $token);
                else
                    $this->registerToken($u['id'], $token, $request->input('device'), $request->input('device_info'));

                return response()->json(["token"=>$token, "result"=>'success']);
            }
            return response()->json(["result"=>"failed","error"=>"Incorrect Password"],400);
        }

        return response()->json(["result"=>"failed","error"=>"User not found."],400);
    }

    function getUsers(){
        $data = User::leftJoin('levels','users.level','=','levels.id')
                        ->select('level_name','users.*')
                        ->get()->toArray();
        foreach($data as $key=>$value)
            $data[$key]['user_data'] = json_decode($value['user_data']);
        
        return response()->json($data);
    }

    function addUser(Request $request){
        $validator = Validator::make($request->all(), [
            'name' => 'required|unique:users,name|max:255',
            'email' => 'required|email|max:255',
            'level' => 'required|not_in:0'
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()],400);

        $api = $this->authenticateAPI();

        if($api['result'] === 'success') {
            $user = new User;
            $user->name = $request->input('name');
            $user->email = $request->input('email');
            $user->level = $request->input('level');
            $user->password = bcrypt('secret');
            $user->address = $request->input('address');
            $user->mobile = $request->input('mobile');
            $user->photo = 'default.jpg';
            $user->is_active = $request->input('is_active');
            $user->branch_id = 1;
            $user->device_data = '[]';
            $user->user_data = '{}';
            $user->last_login = date('Y-m-d');
            $user->last_activity = date('Y-m-d');
            $user->save();

            return response()->json(['result'=>'success','message'=>'User has been added.']);
        }

        return response()->json($api, $api["status_code"]);
    }

    function updateUser(Request $request){
        $validator = Validator::make($request->all(), [
            'name' => 'required|unique:users,name,'.$request->input('id').'|max:255',
            'email' => 'required|email|max:255',
            'level' => 'required|not_in:0',
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()],400);

        $api = $this->authenticateAPI();

        if($api['result'] === 'success') {
            $user = User::find($request->input('id'));
            $user->name = $request->input('name');
            $user->email = $request->input('email');
            $user->level = $request->input('level');
            $user->address = $request->input('address');
            $user->mobile = $request->input('mobile');
            $user->is_active = $request->input('is_active');
            $user->save();

            return response()->json(['result'=>'success','message'=>'User has been updated.']);
        }
        
        return response()->json($api, $api["status_code"]);
    }

    function getUser(){
        $api = $this->authenticateAPI();

        if($api['result'] === 'success'){
            $level = Level::find($api['user']['level']);
            $api['user']['level_name'] = $level->level_name;
            $api['user']['level_data'] = json_decode($level->level_data);

            $api['user']['picture_html_big'] = '<img class="img-responsive" style="width:80px" src="images/users/'. $api['user']['photo'] .'" />';
            $api["user"]['user_data'] = json_decode($api["user"]['user_data']);
            $api["user"]['device_data'] = json_decode($api["user"]['device_data']);

            return response()->json( ["user"=>$api["user"],
                                        "menus"=>$this->getMenus($api["user"]),
                                        "settings"=> $this->getSettings()
                                    ],
                                    $api["status_code"]);
        }

        return response()->json($api, $api["status_code"]);
    }

    public function destroyToken(Request $request){
        $api = $this->authenticateAPI();

        if($api['result'] === 'success'){
            $user = User::find($request->input('user_id'));
            $tokens = json_decode($user->device_data, true);
            $new_tokens = array();
            if(sizeof($tokens) == 0)
                $user->device_data = json_encode(array());
            else{
                foreach ($tokens as $t=>$v){
                    if($v['token']!= $request->input('token'))
                        $new_tokens[] = $v;
                }
                $user->device_data = json_encode($new_tokens);
            }
            $user->save();

            return response()->json(["result"=>"success"]);

        }

        return response()->json($api, $api["status_code"]);
    }

    function getUserLogs(Request $request){
        $data = DB::select(DB::raw("SELECT * FROM audits WHERE new_values <> '[]' AND user_id=" .$request->segment(4) ) . " 
                            ORDER BY created_at DESC 
                            LIMIT 20");
        $logs = array();
        foreach($data as $key=>$value){
            $old = json_decode($value->old_values);
            $new = json_decode($value->new_values);
            $action = ucfirst($value->event) . ' ' . str_replace("App\\", "", $value->auditable_type);
            if($value->new_values !== '[]'){
                $body = [];

                if($value->event==='updated')
                    foreach($old as $k=>$v)
                        $body[] = [$k=>$v .' -> ' . $new->$k ];
                else
                    foreach($new as $k=>$v)
                        $body[] = [$k=>$v];

                $category = strtolower(str_replace("App\\", "", $value->auditable_type));
                if($value->user_id === $value->auditable_id){
                    if(isset($old->last_login)){
                        $action = "Logged in the system";
                        $body = [];
                    }
                    else
                        $action = "Updated Profile";

                    $category = 'user';
                }

                $logs[] = array(
                    "action" => $action,
                    "body" => $body,
                    "category"=>$category,
                    "ip_address"=>$value->ip_address,
                    "created_at"=>$value->created_at
                );
            }
        }

        return response()->json($logs);
    }
}