<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Quotation extends Model
{
    public function items(){
        return $this->hasMany('App\QuotationItem');
    }
}
