<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Product;
use App\ProductUnit;
use App\ProductPrice;
use App\Inventory;
use App\Unit;
use App\PurchaseItem;
use Illuminate\Support\Facades\Auth;
use Validator;

class ProductController extends Controller{
    function getProducts(){
        $data = Product::leftJoin('categories','products.category_id','=','categories.id')
                                        ->select('products.*','category_name')
                                        ->orderBy('category_name')
                                        ->orderBy('product_name')
                                        ->get()->toArray();

        foreach($data as $key=>$value){
            $data[$key]['product_units'] = ProductUnit::leftJoin('units','product_units.unit_id','=','units.id')
                                                ->where('product_id',$value['id'])->get()->toArray();
        }

        return response()->json($data);
    }

    function getProduct(Request $request){
        $product = Product::find($request->segment(4));
        if($product->id !== null){
            $product['product_units'] = ProductUnit::leftJoin('units','product_units.unit_id','=','units.id')
                                    ->where('product_id',$product->id)->get()->toArray();
            $product['product_prices'] = ProductPrice::leftJoin('price_categories','product_prices.price_category_id','=','price_categories.id')
                ->where('product_id',$product->id)->get()->toArray();

            return response()->json($product);
        }
        return response()->json(["result"=>"failed"], 404);
    }

    //disconnected from get products
    function hasWrongPrice($product_units){
        foreach($product_units as $key=>$value){
            if($key!=0){
                if($value['purchase_price'] != ($product_units[$key-1]['purchase_price'] / $value['quantity']) )
                    return true;
            }
        }
        return false;
    }

    //disconnected from get products
    function getRecentPurchases($product){
        $get = PurchaseItem::leftJoin('purchases','purchase_items.purchase_id','=','purchases.id')
                            ->leftJoin('suppliers','purchases.supplier_id','suppliers.id')
                            ->where('product_id', $product)
                            ->where('purchase_status','approved')
                            ->orderBy('date_transaction','DESC')
                            ->take(5)
                            ->get()->toArray();
        return $get;
    }

    function addProduct(Request $request){
        print_r($request->input());
        $validator = Validator::make($request->all(), [
            'product_code' => 'required|unique:products,product_code|max:255',
            'category_id' => 'required|not_in:0',
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()]);

        $product = new Product;
        $product->product_code = $request->input('product_code');
        $product->brand_name = ($request->input('brand_name')!==null?$request->input('brand_name'):'');
        $product->category_id = $request->input('category_id');
        $product->sub_category_id = 0;
        $product->product_name = ($request->input('brand_name')!==null && $request->input('brand_name')!==''?$request->input('brand_name'):'') .' ' . ($request->input('product_description')!==null?$request->input('product_description'):'');
        $product->product_description = ($request->input('product_description')!==null?$request->input('product_description'):'');
        $product->is_active = 1;
        $product->product_data = json_encode($request->input('product_data'));
        $product->pictures_data = '[]';

        if($this->checkDuplicateName($product->product_name))
            return response()->json(['result'=>'failed', 'errors'=>'Product name already exists.']);

        $product->save();

        return response()->json(['result'=>'success']);
    }

    function updateProduct(Request $request){
        $validator = Validator::make($request->all(), [
            'product_code' => 'required|unique:products,product_code,'.$request->input('id').'|max:255',
            'category_id' => 'required|not_in:0',
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()]);

        $product = Product::find($request->input('id'));
        $product->product_code = $request->input('product_code');
        $product->brand_name = ($request->input('brand_name')!==null ?$request->input('brand_name'):'');
        $product->category_id = $request->input('category_id');
        $product->sub_category_id = 0;
        $product->product_name = ($request->input('brand_name')!==null && $request->input('brand_name')!==''?$request->input('brand_name'):'') .' ' . ($request->input('product_description')!==null?$request->input('product_description'):'');
        $product->product_description = ($request->input('product_description')!==null?$request->input('product_description'):'');
        $product->is_active = $request->input('is_active');
        $product->product_data = json_encode($request->input('product_data'));
        $product->pictures_data = '[]';

        if($this->checkDuplicateName($product->product_name,$request->input('id')))
            return response()->json(['result'=>'failed', 'errors'=>'Product name already exists.']);

        $product->save();

        return response()->json(['result'=>'success']);
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
}