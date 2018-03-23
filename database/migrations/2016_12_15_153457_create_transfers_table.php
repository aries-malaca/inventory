<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTransfersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('transfers', function (Blueprint $table) {
            $table->increments('id');
            $table->string('reference_no');
            $table->integer('from_branch_id');
            $table->integer('to_branch_id');
            $table->datetime('date_transferred');
            $table->text('notes');
            $table->integer('user_id');
            $table->timestamps();
            $table->string('transfer_status'); //pending or accepted or void or cancelled
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('transfers');
    }
}
