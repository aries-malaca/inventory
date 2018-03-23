<?php

use Illuminate\Database\Seeder;
use App\Level;
class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $this->call(LevelTableSeeder::class);
        $this->call(UsersTableSeeder::class);
    }
}

class LevelTableSeeder extends Seeder{
    public function run(){
        DB::table('levels')->insert([
            'level_name' => 'Admin',
            'level_description' => 'Super User',
            'level_data' => '{ permissions:{} }',
            'is_default' => 1,
            'is_active'=>1
        ]);
    }
}

class UsersTableSeeder extends Seeder{
    public function run(){
        DB::table('users')->insert([
            'name' => 'Admin',
            'email' => 'admin@test.com',
            'password' => bcrypt('secret'),
            'photo' => 'default.jpg',
            'address' => 'Philippines',
            'mobile' => '0909',
            'level' => Level::get()->first()['id'],
            'branch_id' => 1,
            'is_active'=>1
        ]);
    }
}