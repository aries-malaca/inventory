<?php
namespace App\Exports;
use Illuminate\Contracts\View\View;
use Maatwebsite\Excel\Concerns\FromView;

class ProductList implements FromView
{
    var $data = [];
    var $request;
    public function __construct($data){
        $this->data = $data;
    }
    public function view(): View{
        return view('excel.product_report', $this->data);
    }

}