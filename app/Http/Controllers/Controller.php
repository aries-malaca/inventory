<?php
namespace App\Http\Controllers;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Support\Facades\Auth;
use App\Inventory;
use App\Product;
use App\Setting;
use App\User;
use App\Menu;
use Tymon\JWTAuth\Exceptions\JWTException;
use Tymon\JWTAuth\Exceptions\TokenInvalidException;
use Tymon\JWTAuth\Exceptions\TokenExpiredException;
use JWTAuth;

class Controller extends BaseController{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    function getSettings(){
        $data = Setting::get()->toArray();
        $array = array();
        foreach($data as $key=>$value)
            $array[$value['setting_name']] = $value['setting_value'];

        return $array;
    }

    public function getMenus($user){
        return Menu::orderBy('menu_order')
                    ->get()->toArray();
    }

    public function authenticateAPI(){
        try{
            if (! $user = JWTAuth::parseToken()->authenticate())
                return ["result"=>"failed","errors"=>"token_user_not_found","status_code"=>401];
        }
        catch(TokenExpiredException $e){
            return ["result"=>"failed","errors"=>"token_expired", "status_code"=>401];
        }
        catch(TokenInvalidException $e){
            return ["result"=>"failed","errors"=>"token_invalid", "status_code"=>401];
        }
        catch(JWTException $e){
            return ["result"=>"failed","errors"=>"token_absent","status_code"=>401];
        }

        $parsed = JWTAuth::getToken();
        $tokens = json_decode($user['device_data'],true);
        if(sizeof($tokens) == 0){
            return ["result"=>"failed","errors"=>"no_token_registered","status_code"=>401];
        }
        else{
            foreach($tokens as $key=>$value){
                if($parsed == $value['token']){
                    // token is valid and update the last activity
                    $this->updateToken($value['token'], $user);
                    return ["result"=>"success", "user"=>$user, "status_code"=>200];
                }
            }
        }
        return ["result"=>"failed","errors"=>"token_not_found" ,"status_code"=>401];
    }

    function updateToken($token, $user){
        User::where('id', $user['id'])->update(['last_activity'=>date('Y-m-d H:i')]);

        $u = User::find($user['id']);
        $data = json_decode($u->device_data,true);
        foreach($data as $key=>$value){
            if($value['token'] == $token) {
                $data[$key]['last_activity'] = date('Y-m-d H:i');
                $u->device_data = json_encode($data);
            }
        }

        $u->save();
    }

    /**
     * @param $user_id
     * @param $token
     * @param string $type
     * @param null $device_info
     */
    public function registerToken($user_id, $token, $type='WEB', $device_info=null){
        if($type == 'WEB'){
            $device_info = $_SERVER['HTTP_USER_AGENT'];
        }

        $user = User::find($user_id);
        $tokens = json_decode($user->device_data, true);
        $data = array("token" => $token,
            "type" => $type,
            "device_info" => $device_info,
            "registered" => date('Y-m-d H:i'),
            "last_activity" => date('Y-m-d H:i')
        );
        array_unshift($tokens, $data);
        $user->last_login = date('Y-m-d H:i');
        $user->device_data = json_encode($tokens);
        $user->save();
    }

    function initApp(){
        if(Auth::user() !== null){
            
            //load global data there

            return true;
        }
        
        return false;
    }

    function format($string, $format){
        return date($format, strtotime($string));
    }

    function receiveStocks($data, $branch_id){
        foreach($data as $key=>$value){
            $inventory = Inventory::where('branch_id', $branch_id )
                                ->where('product_id', $value['product_id'])
                                ->where('unit', $value['unit'])
                                ->get()->first();
            if(isset($inventory['product_id'])){
                $update = Inventory::find($inventory['id']);
                $update->quantity+=(isset($value['received_quantity'])?$value['received_quantity']:$value['quantity']);
                $update->save();
            }
            else{
                $new = new Inventory;
                $new->product_id = $value['product_id'];
                $new->branch_id = $branch_id;
                $new->quantity = (isset($value['received_quantity'])?$value['received_quantity']:$value['quantity']);
                $new->unit = $value['unit'];
                $new->inventory_data = '{}';
                $new->save();
            }
        }
    }

    function discardStocks($items, $branch_id){
         foreach($items as $key=>$item){
            $inventory = Inventory::where('branch_id', $branch_id)
                                ->where('product_id', $item['product_id'])
                                ->where('unit', $item['unit'])
                                ->get()->first();
            if(isset($inventory['product_id'])){
                $update = Inventory::find($inventory['id']);
                $update->quantity-=(isset($item['received_quantity'])?$item['received_quantity']:$item['quantity']);
                $update->save();
            }
        }
    }

    function dispenseStocks($items, $branch_id){
         foreach($items as $key=>$item){
            $inventory = Inventory::where('branch_id', $branch_id)
                                ->where('product_id', $item['product_id'])
                                ->where('unit', $item['unit'])
                                ->get()->first();
            if(isset($inventory['product_id'])){
                $update = Inventory::find($inventory['id']);
                $update->quantity-=$item['sold_quantity'];
                $update->save();
            }
        }
    }

    function returnStocks($data, $branch_id){
        foreach($data as $key=>$value){
            $inventory = Inventory::where('branch_id', $branch_id )
                                ->where('product_id', $value['product_id'])
                                ->where('unit', $value['unit'])
                                ->get()->first();
            if(isset($inventory['product_id'])){
                $update = Inventory::find($inventory['id']);
                $update->quantity+=$value['sold_quantity'];
                $update->save();
            }
            else{
                $new = new Inventory;
                $new->product_id = $value['product_id'];
                $new->branch_id = $branch_id;
                $new->quantity = $value['sold_quantity'];
                $new->unit = $value['unit'];
                $new->inventory_data = '{}';
                $new->save();
            }
        }
    }
    function changePurchasePrice($item){
        $get = Product::where('id',$item->product_id)->get()->first();
        if(isset($get['id'])){
            $data = json_decode($get->product_data,true);
            foreach($data['product_units'] as $key=>$value){
                if($value['unit'] == $item->unit){
                    if(!isset($item->new_cost))
                        $data['product_units'][$key]['purchase_price'] =  (isset($item->purchase_price)?$item->purchase_price:$item->unit_cost);
                    else
                        $data['product_units'][$key]['purchase_price'] =  $item->new_cost;
                }
            }
        }
        Product::where('id',$get['id'])->update(['product_data'=>json_encode($data)]);
    }
}
