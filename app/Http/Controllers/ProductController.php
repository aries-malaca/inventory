<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Product;
use App\ProductUnit;
use App\ProductPrice;
use App\Inventory;
use App\Unit;
use App\PurchaseItem;
use App\ProductSellingPrice;
use Illuminate\Support\Facades\Auth;
use Validator;

class ProductController extends Controller{
    function getProducts(){
        $data = Product::leftJoin('categories','products.category_id','=','categories.id')
                                        ->select('products.*','category_name')
                                        ->orderBy('category_name')
                                        ->orderBy('product_name')
                                        ->get()->toArray();
        foreach($data as $key=>$value)
            $data[$key]['product_units'] = ProductUnit::leftJoin('units','product_units.unit_id','=','units.id')
                                                ->where('product_id',$value['id'])->get()->toArray();

        return response()->json($data);
    }

    function getProduct(Request $request){
        $product = Product::find($request->segment(4));
        if($product->id !== null){
            $product['product_units'] = $product->units()->get();
            $product['pictures_data'] = json_decode($product->pictures_data);
            foreach($product['product_units'] as $key=>$value){
                $product['product_units'][$key]['pricing'] = $value->prices()->get();

                foreach($product['product_units'][$key]['pricing'] as $k=>$v)
                    $product['product_units'][$key]['pricing'][$k]['selling'] = $v->selling_prices()->get();
            }
            return response()->json($product);
        }
        return response()->json(["result"=>"failed"], 404);
    }

    function addProduct(Request $request){
        $validator = Validator::make($request->all(), [
            'product_code' => 'required|unique:products,product_code|max:255',
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()], 400);
        
        if($errors = $this->evaluateUnits($request->input('product_units')))
            return response()->json(['result'=>'failed', 'errors'=>$errors], 400);
        
        $product = new Product;
        $product->product_code = $request->input('product_code');
        $product->brand_name = ($request->input('brand_name')!==null?$request->input('brand_name'):'');
        $product->category_id = $request->input('category')['value'];
        $product->sub_category_id = 0;
        $product->product_name = ($request->input('brand_name')!==null && $request->input('brand_name')!==''?$request->input('brand_name'):'') .' ' . ($request->input('product_description')!==null?$request->input('product_description'):'');
        $product->product_description = ($request->input('product_description')!==null?$request->input('product_description'):'');
        $product->is_active = $request->input('is_active');
        $product->pictures_data = '[]';

        if($this->checkDuplicateName($product->product_name))
            return response()->json(['result'=>'failed', 'errors'=>'Product name already exists.'], 400);

        $product->save();

        foreach($request->input('product_units') as $key=>$value){
            $unit = new ProductUnit;
            $unit->product_id = $product->id;
            $unit->unit_id = $value['unit']['id'];
            $unit->parent_unit_id = $key===0?0:$value['parent_unit_id'];
            $unit->info = $value['info'];
            $unit->quantity_per_parent = $value['quantity_per_parent'];
            $unit->barcode = $value['barcode'];
            $unit->save();

            foreach($value['pricing'] as $k=>$v){
                $price = new ProductPrice;
                $price->purchase_price = $v['purchase_price'];
                $price->remarks= $v['remarks'];
                $price->product_unit_id = $unit->id;
                $price->save();

                foreach($v['selling'] as $e=>$f){
                    $selling = new ProductSellingPrice;
                    $selling->price_category_id = $f['price_category_id'];
                    $selling->selling_price = $f['selling_price'];
                    $selling->product_price_id = $price->id;
                    $selling->save();
                }   
            }
        }

        return response()->json(['result'=>'success','message'=>'Product has been added.']);
    }

    function updateProduct(Request $request){
        $validator = Validator::make($request->all(), [
            'product_code' => 'required|unique:products,product_code,'.$request->input('id').'|max:255',
          ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()], 400);
        
        if($errors = $this->evaluateUnits($request->input('product_units')))
            return response()->json(['result'=>'failed', 'errors'=>$errors], 400);

        $product = Product::find($request->input('id'));
        $this->clearProductUnits($request->input('id'));

        $product->product_code = $request->input('product_code');
        $product->brand_name = ($request->input('brand_name')!==null?$request->input('brand_name'):'');
        $product->category_id = $request->input('category')['value'];
        $product->sub_category_id = 0;
        $product->product_name = ($request->input('brand_name')!==null && $request->input('brand_name')!==''?$request->input('brand_name'):'') .' ' . ($request->input('product_description')!==null?$request->input('product_description'):'');
        $product->product_description = ($request->input('product_description')!==null?$request->input('product_description'):'');
        $product->is_active = $request->input('is_active');
        $product->pictures_data = '[]';

        if($this->checkDuplicateName($product->product_name, $request->input('id')))
            return response()->json(['result'=>'failed', 'errors'=>'Product name already exists.'], 400);

        $product->save();

        foreach($request->input('product_units') as $key=>$value){
            $unit = new ProductUnit;
            $unit->product_id = $product->id;
            $unit->unit_id = $value['unit']['id'];
            $unit->parent_unit_id = $key===0?0:$value['parent_unit_id'];
            $unit->info = $value['info'];
            $unit->quantity_per_parent = $value['quantity_per_parent'];
            $unit->barcode = $value['barcode'];
            $unit->save();

            foreach($value['pricing'] as $k=>$v){
                $price = new ProductPrice;
                $price->purchase_price = $v['purchase_price'];
                $price->remarks= $v['remarks'];
                $price->product_unit_id = $unit->id;
                $price->save();

                foreach($v['selling'] as $e=>$f){
                    $selling = new ProductSellingPrice;
                    $selling->price_category_id = $f['price_category_id'];
                    $selling->selling_price = $f['selling_price'];
                    $selling->product_price_id = $price->id;
                    $selling->save();
                }   
            }
        }

        return response()->json(['result'=>'success','message'=>'Product has been updated.']);
    }

    public function uploadPicture(Request $request){
        $api = $this->authenticateAPI();
        if($api['result'] === 'success') {
            //valid extensions
            $valid_ext = array('jpeg', 'gif', 'png', 'jpg');
            //check if the file is submitted
            if ($request->hasFile('file')) {
                $file = $request->file('file');
                $ext = $file->getClientOriginalExtension();
                //check if extension is valid
                if (in_array($ext, $valid_ext)) {
                    $timestamp = time().'.'.$ext ;
                    $file->move('images/products/', $request->input('product_id') . '_' . $timestamp);
                    $product = Product::find($request->input('product_id'));
                    $pics = json_decode($product->pictures_data,true);
                    $pics[$request->input('key')] = $request->input('product_id') . '_' . $timestamp;
                    $product->pictures_data = json_encode($pics);
                    $product->save();
                    return response()->json(["result"=>"success",'message'=>'Picture has been uploaded.'],200);
                }
                return response()->json(["result"=>"failed","error"=>"Invalid File Format."],400);
            }
            return response()->json(["result"=>"failed","error"=>"No File to be uploaded."], 400);
        }
        return response()->json($api, $api["status_code"]);
    }

    function removePicture(Request $request){
        $api = $this->authenticateAPI();
        if($api['result'] === 'success') {
            $product = Product::find($request->input('product_id'));
            $pics = json_decode($product->pictures_data,true);
            $file_name = $pics[$request->input('key')];
            unset($pics[$request->input('key')]);
            $product->pictures_data = json_encode($pics);
            if(file_exists(public_path('/images/products/'.$file_name)))
                unlink(public_path('/images/products/'.$file_name));
            $product->save();
            return response()->json(["result"=>"success","message"=>"Picture has been deleted"],200);
        }
        return response()->json($api, $api["status_code"]);
    }

    function clearProductUnits($product_id){
        $units = ProductUnit::where('product_id', $product_id)->get()->toArray();
        foreach($units as $key=>$value){
            ProductUnit::destroy($value['id']);
            $prices = ProductPrice::where('product_unit_id', $value['id'])->get()->toArray();

            foreach($prices as $price){
                ProductPrice::destroy($price['id']);
                ProductSellingPrice::where('product_price_id', $price['id'])->delete();
            }
        }
    }

    function checkDuplicateName($name, $id=0){
        $check = Product::where('product_name', $name);
        if($id==0){
            if($check->count()>0)
                return true;
        }
        else{
            if($check->where('id','<>',$id)->count() > 0)
                return true;
        }

        return false;
    }

    function getTempID(){
        $product = Product::orderBy('created_at','desc')->get()->first();
        if(isset($product['product_code']))
            $number = (int)$product['product_code'];
        else
            $number = 1;
        for($x=0;$x<100;$x++){
            $number = str_pad($number, 6, "0", STR_PAD_LEFT);  //00002
            if(Product::where('product_code', $number)->count() == 0)
                return response()->json($number);
            $number++;
        }
    }

    function proceedConvert(Request $request){
        $get = Inventory::where('product_id', $request->input('product_id'))
                            ->where('unit', $request->input('from_unit'))
                            ->get()->first();
        Inventory::where('id', $get['id'])->update(['quantity'=> $get['quantity'] - $request->input('from_quantity') ]);

        $get = Inventory::where('product_id', $request->input('product_id'))
                            ->where('unit', $request->input('to_unit'))
                            ->get()->first();

        if(isset($get['product_id']))
            Inventory::where('id', $get['id'])->update(['quantity'=> $get['quantity'] + $request->input('to_quantity') ]);
        else{
            $new = new Inventory;
            $new->quantity = $request->input('to_quantity');
            $new->product_id = $request->input('product_id');
            $new->unit = $request->input('to_unit');
            $new->branch_id = Auth::user()->branch_id;
            $new->inventory_data = '{}';
            $new->save();
        }
        return response()->json(['result'=>'success']);
    }
    //disconnected from get products
    function getStocksSummary($data, $product_id){
        $stocks = 0;
        $unit = 'pieces';
        foreach($data as $key=>$value){
            $inventory = 0;

            if(isset($value['stocks']))
                $inventory = $value['stocks'];

            if($key+1 < sizeof($data))
                $stocks += $data[$key+1]['quantity']*$inventory;

            if($key+1 == sizeof($data))
                $stocks += $inventory;

            if($key==(sizeof($data) - 1)){
                $u = Unit::find($value['unit']);

                if(isset($u->unit_name))
                    $unit = $u->unit_name;
            }
        }
        return $stocks .' '. $unit;
    }

    function mergeProductName(){
        $products = Product::get()->toArray();
        foreach($products as $key=>$value){
            Product::where('id', $value['id'])
                    ->update(['product_name'=> ($value['brand_name']==''?'':$value['brand_name']. ' ' ). $value['product_description']]);
        }
    }

    function evaluateUnits($units){
        $errors = array();
        foreach($units as $key=> $value){
            if($value['unit'] == null)
                $errors[] = "Unit " . ($key+1) . " is required.";
        }

        if(sizeof($errors)>0)
            return $errors;

        return false;
    }
}