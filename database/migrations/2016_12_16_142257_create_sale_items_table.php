<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateSaleItemsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('sale_items', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('product_id');
            $table->integer('sales_id');
            $table->integer('quantity');
            $table->float('discount');
            $table->float('base_price');
            $table->float('selling_price');
            $table->float('last_price');
            $table->float('final_price');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('sale_items');
    }
}
