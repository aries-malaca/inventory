<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProductPrice extends Model
{
    public function selling_prices(){
        return $this->hasMany('App\ProductSellingPrice');
    }
}
