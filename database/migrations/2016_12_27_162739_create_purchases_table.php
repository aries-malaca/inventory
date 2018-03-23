<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePurchasesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('purchases', function (Blueprint $table) {
            $table->increments('id');
            $table->timestamps();
            $table->string('receipt_no');
            $table->string('reference_no');
            $table->datetime('date_transaction');
            $table->datetime('date_due');
            $table->integer('supplier_id');
            $table->integer('user_id');
            $table->string('notes');
            $table->integer('branch_id');
            $table->text('purchase_data');
            $table->text('payment_data');
            $table->string('purchase_status'); //pending //sold //cancelled //void
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('purchases');
    }
}
