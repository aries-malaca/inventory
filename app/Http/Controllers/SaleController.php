<?php

namespace App\Http\Controllers;
use App\Sale;
use App\SaleItem;
use App\User;
use App\Client;
use Illuminate\Http\Request;
use Validator;
use Illuminate\Support\Facades\Auth;
use App\Unit;
use App\Product;
use App\Setting;

class SaleController extends Controller
{
    function index(){
        if(!$this->initApp()){
            return redirect('login');
        }
        
        $this->data['title'] = 'Point of Sales';
        $this->data['parent_title'] = 'Transactions';
        $this->data['parent_url'] = '#';
        return view('sales',$this->data);
    }

    function getTempID(){
        $sale = Sale::orderBy('created_at','desc')->get()->first();
        if(isset($sale['receipt_no']))
            $number = (int)$sale['receipt_no'];
        else
            $number = 1;
        for($x=0;$x<100;$x++){
            $number = str_pad($number, 8, "0", STR_PAD_LEFT);  //00002
            if(Sale::where('receipt_no', $number)->count() == 0){
                return response()->json($number);
            }
            $number++;
        }

    }

    function getSales(){
        $get = Sale::get()->toArray();
        foreach($get as $key=>$value){
            $sales_data = json_decode($value['sales_data'],true);
            $get[$key]['items'] = SaleItem::where('sales_id', $value['id'])->get()->toArray();
            $get[$key]['client_name'] = Client::find($value['client_id'])->client_name;
            $get[$key]['items_count'] = sizeof($get[$key]['items']);
            $get[$key]['name'] = User::find($value['user_id'])->name;
            $get[$key]['terms'] = ($value['date_transaction'] == $value['date_due']?'COD':'Credit');
            $get[$key]['net_amount'] = (isset($sales_data['net_amount'])?number_format($sales_data['net_amount'],2):0);
        }
        return response()->json($get);
    }

    function checkoutSale(Request $request){
        $validator = Validator::make($request->all(), [
            'receipt_no' => $request->input('id')==0?'required|unique:sales,receipt_no':'required|unique:sales,receipt_no,'.$request->input('id'),
            'client_id' => 'required|not_in:0',
            'date_transaction' => 'required',
            'date_due' => 'required'
        ]);

        if ($validator->fails()) {
            return response()->json(['result'=>'failed', 'errors'=>$validator->errors()->all()]);
        }
        $current_status = '';
        if($request->input('id') == 0){
            $sale = new Sale;
            $current_items = array();
        }
        else{
            $sale = Sale::find($request->input('id'));
            $current_status = $sale->sales_status; 
            $current_items = SaleItem::where('sales_id',$request->input('id'))->get()->toArray();
        }
        
        $sale->receipt_no = $request->input('receipt_no');
        $sale->notes = $request->input('notes');
        $sale->client_id = $request->input('client_id');
        $sale->price_category_id = $request->input('price_category_id');
        $sale->date_transaction = date('Y-m-d',strtotime($request->input('date_transaction')));
        $sale->date_due = date('Y-m-d',strtotime($request->input('date_due')));
        $sale->user_id = Auth::user()->id;
        $sale->branch_id = Auth::user()->branch_id;
        $sale->sales_status = $request->input('sale_status');
        $sale->sales_data = json_encode($request->input('sale_data'));
        $sale->payment_data = json_encode($request->input('payment_data'));
        $sale->save();

        if($request->input('id') != 0){
           SaleItem::where('sales_id',$sale->id)->delete();
        }

        foreach($request->input('items') as $key=>$value){
            $item = new SaleItem;
            $item->product_id = $value['product_id'];
            $item->quantity = $value['quantity'];
            $item->sales_id = $sale->id;
            $item->unit = $value['unit'];
            $item->sold_quantity = $value['sold_quantity'];
            $item->original_price = $value['original_price'];
            $item->selling_price = $value['selling_price'];
            $item->discount = $value['discount'];
            $item->save();
        }

        if($request->input('sale_status') == 'sold' && ($current_status == 'pending' || $request->input('id')==0)){
            $this->dispenseStocks($request->input('items'),Auth::user()->branch_id);
        }

        return response()->json(['result'=>'success','id'=>$sale->id]);
    }

    function voidSale(Request $request){
        $sale = Sale::find($request->input('id'));
        $sale->sales_status = 'void';
        $sale->save();

        $items = SaleItem::where('sales_id',$request->input('id'))->get();
        $this->returnStocks($items,Auth::user()->branch_id);
        
        return response()->json(['result'=>'success']);
    }

    function cancelSale(Request $request){
        $sale = Sale::find($request->input('id'));
        $sale->sales_status = 'cancelled';
        $sale->save();
        
        return response()->json(['result'=>'success']);
    }

    function printReceipt(Request $request){
        $sale = Sale::leftJoin('clients','sales.client_id','=','clients.id')
                    ->where('sales.id', $request->segment(3))
                    ->get()->first();
        $items = SaleItem::where('sales_id', $request->segment(3))->get()->toArray();
        echo '<style>
        html,table{
            font-family: "Agency FB";
            font-size:14px
        }
        </style>';
        date_default_timezone_set('Asia/Manila');
        echo '<center>Grad Bookstore and Supplies<br/>Brgy Dampulan<br/>Jaen, Nueva Ecija</center><br/>';
        echo 'Receipt No.' . $sale['receipt_no'] .'<br/>';
        echo 'Customer: ' . $sale['client_name'] .'<br/>';
        if($sale['client_address']  != '')
            echo 'Address: ' . $sale['client_address'] .'<br/>';
        echo date('F j, Y g:i a  ') .'<br/>';
        echo '<center>-------------------------------------------------</center>';        
        echo '<center>Sale Items </center>';
        echo '<center>-------------------------------------------------</center>';

        foreach($items as $key=>$value){
            $u = Unit::find($value['unit']);
            $unit = '';

            if(isset($u->unit_name)){
               $unit = $u->unit_name; 
            }

            // echo $value['quantity'] . '&nbsp;&nbsp;' . $unit . '&nbsp;&nbsp;&nbsp;&nbsp;';
            $p = Product::find($value['product_id']);
            
            echo '<table style="width:100%">';
            //head
            echo '<tr>';
            echo '<td> Item ';
            echo '</td>';
            echo '<td style="float:right"> Price';
            echo '</td>';
            echo '</tr>';

            //Product Brand and Desc
            echo '<tr>';
            echo '<td>'; echo $p->brand_name . ' ' . $p->product_description .'<br/>';
            echo '</td>';
            echo '</tr>';

            //Qty, Price
            echo '<tr>';
            echo '<td>'; echo $value['quantity'] . '&nbsp;&nbsp;' . $unit . '&nbsp;&nbsp; @ &nbsp;&nbsp; P'; echo number_format($value['selling_price'],2);
            echo '</td>';
            echo '<td style="float:right"> P'; echo number_format($value['selling_price'] * $value['quantity'],2);
            echo '</td>';
            echo '</tr>';
            echo '</table>';
        }
        echo '<br/><br/>';
        $data = json_decode($sale->sales_data,true);
        echo '<table style="width:100%">';
        
        echo '<tr>';
        echo '<td> Total Amount: ';
        echo '</td>';
        echo '<td style="float:right"> P'; echo number_format($data['total_amount'],2);
        echo '</td>';
        echo '</tr>';

        if($data['discount'] > 0){
            echo '<tr>';
            echo '<td> Discount: ';
            echo '</td>';
            echo '<td style="float:right"> P'; echo number_format($data['discount'],2);
            echo '</td>';
            echo '</tr>';
        }

        if($data['vat_amount'] > 0){
            echo '<tr>';
            echo '<td> Vat (12%): ';
            echo '</td>';
            echo '<td style="float:right"> P'; echo number_format($data['vat_amount'],2);
            echo '</td>';
            echo '</tr>';
        }
        echo '<tr>';
        echo '<td> Amount Due: ';
        echo '</td>';
        echo '<td style="float:right"> P'; echo number_format($data['net_amount'],2);
        echo '</td>';
        echo '</tr>';

        echo '<table>';
        echo '<br/><br/>';
        echo '<center>THANK YOU!</center><br/><br/>';
        
        
        echo '<script>window.print()</script>';
    }


    function deleteSale(Request $request){
        $password = Setting::find(5)->setting_value;
        if($password == $request->input('password')){
            Sale::destroy($request->input('id'));
            SaleItem::where('sales_id', $request->input('id'))->delete();
            return response()->json(['result'=>'success']);
        }

        return response()->json(['result'=>'failed', 'errors'=>'Incorrect password.']);
    }
}
