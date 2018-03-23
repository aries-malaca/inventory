<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateSalesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('sales', function (Blueprint $table) {
            $table->increments('id');
            $table->timestamps();
            $table->string('receipt_no');
            $table->datetime('date_transaction');
            $table->datetime('date_due');
            $table->integer('user_id');
			$table->integer('client_id');
            $table->string('notes');
            $table->text('sales_data');
            $table->text('payment_data');
            $table->integer('branch_id');
            $table->string('sales_status'); //pending //accepted //cancelled //void
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('sales');
    }
}
