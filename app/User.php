<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;
use OwenIt\Auditing\Contracts\Auditable;
class User extends Authenticatable implements Auditable
{
    use Notifiable;
    use \OwenIt\Auditing\Auditable;

    protected $auditExclude = [
        'device_data', 'last_activity','password', 'is_active','level','user_data','photo','branch_id'
    ];
}
