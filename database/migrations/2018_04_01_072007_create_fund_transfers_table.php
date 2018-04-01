<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateFundTransfersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('fund_transfers', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('from_account_id');
            $table->integer('to_account_id');
            $table->float('fund_transfer_amount');
            $table->string('fund_transfer_notes');
            $table->text('fund_transfer_data');
            $table->datetime('fund_transfer_date');
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
        Schema::dropIfExists('fund_transfers');
    }
}
