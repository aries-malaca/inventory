<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Category;
use App\PriceCategory;
use App\Product;
use Validator;
use App\Unit;

class ProductMiscController extends Controller{
    function getPrices(){
        return response()->json(PriceCategory::orderBy('price_category_name')
                                            ->get()->toArray());
    }

    function getCategories(){
        return response()->json(Category::orderBy('category_name')
                                        ->get()->toArray());
    }

    function getUnits(){
        return response()->json(Unit::orderBy('unit_name')
                                    ->get()->toArray());
    }

    function addCategory(Request $request){
        $validator = Validator::make($request->all(), [
            'category_name' => 'required|unique:categories,category_name|max:255',
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()], 400);

        $api = $this->authenticateAPI();

        if($api['result'] === 'success') {
            $category = new Category;
            $category->category_name = $request->input('category_name');
            $category->save();

            return response()->json(['result'=>'success', 'message'=>'Successfully added category.']);
        }

        return response()->json($api, $api["status_code"]);
    }

    function updateCategory(Request $request){
        $validator = Validator::make($request->all(), [
            'category_name' => 'required|unique:categories,category_name,'.$request->input('id').'|max:255',
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()], 400);

        $api = $this->authenticateAPI();

        if($api['result'] === 'success') {
            $category = Category::find($request->input('id'));
            $category->category_name = $request->input('category_name');
            $category->save();

            return response()->json(['result'=>'success', 'message'=>'Successfully updated category.']);
        }

        return response()->json($api, $api["status_code"]);
    }

    function addPrice(Request $request){
        $validator = Validator::make($request->all(), [
                    'price_category_name' => 'required|unique:price_categories,price_category_name|max:255',
                    'minimum_purchase' => 'required|numeric',
                    'default_markup' => 'required|numeric',
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()], 400);

        $api = $this->authenticateAPI();

        if($api['result'] === 'success') {
            $category = new PriceCategory;
            $category->price_category_name = $request->input('price_category_name');
            $category->default_markup = $request->input('default_markup');
            $category->minimum_purchase = $request->input('minimum_purchase');
            $category->save();

            //add inside the product data
            $products = Product::get()->toArray();
            foreach($products as $key=>$value){
                $data = json_decode($value['product_data'],true);
                $percentage = $category->default_markup/100;
                foreach($data['product_units'] as $k=>$unit){
                    $data['product_units'][$k]['selling_price'][] = array("id"=>$category->id, "value"=> $data['product_units'][$k]['purchase_price'] + ($percentage * $data['product_units'][$k]['purchase_price']) );
                }
                Product::where('id', $value['id'])->update(['product_data'=>json_encode($data)]);
            }
            return response()->json(['result'=>'success', 'message'=>'Successfully added price category.']);
        }

        return response()->json($api, $api["status_code"]);
    }

    function updatePrice(Request $request){
        $validator = Validator::make($request->all(), [
                    'price_category_name' => 'required|unique:price_categories,price_category_name,'.$request->input('id').'|max:255',
                    'minimum_purchase' => 'required|numeric',
                    'default_markup' => 'required|numeric',
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()], 400);

        $api = $this->authenticateAPI();

        if($api['result'] === 'success') {
            $category = PriceCategory::find($request->input('id'));
            $category->price_category_name = $request->input('price_category_name');
            $category->default_markup = $request->input('default_markup');
            $category->minimum_purchase = $request->input('minimum_purchase');
            $category->save();

            return response()->json(['result'=>'success', 'message'=>'Successfully updated price category.']);
        }

        return response()->json($api, $api["status_code"]);
    }



    function addUnit(Request $request){
        $validator = Validator::make($request->all(), [
            'unit_name' => 'required|unique:units,unit_name|max:255'
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()], 400);

        $api = $this->authenticateAPI();

        if($api['result'] === 'success') {
            $unit = new Unit;
            $unit->unit_name = $request->input('unit_name');
            $unit->save();

            return response()->json(['result'=>'success', 'message'=>'Successfully added product unit.']);
        }

        return response()->json($api, $api["status_code"]);
    }

    function updateUnit(Request $request){
        $validator = Validator::make($request->all(), [
            'unit_name' => 'required|unique:units,unit_name,'.$request->input('id').'|max:255'
        ]);

        if ($validator->fails())
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()], 400);

        $api = $this->authenticateAPI();

        if($api['result'] === 'success') {
            $unit = Unit::find($request->input('id'));
            $unit->unit_name = $request->input('unit_name');
            $unit->save();

            return response()->json(['result'=>'success', 'message'=>'Successfully updated product unit.']);
        }

        return response()->json($api, $api["status_code"]);
    }
}