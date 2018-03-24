<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProductUnit extends Model
{
    public function prices(){
        return $this->hasMany('App\ProductPrice');
    }
}
