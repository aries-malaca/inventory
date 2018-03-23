@extends('layouts.app')
@section('content')
<div id="users" v-cloak>
    <div class="row">
        <div class="col-md-6">
            <div class="box box-success">
                <div class="box-header with-border">
                    <h3 class="box-title">Users List</h3>
                    &nbsp;
                    <button @click="showAddModal('user')" class="btn btn-success btn-sm">Add User</button> 
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                <div class="table-responsive">
                    <table class="table no-margin">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Mobile</th>
                                <th>Level</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(user,key) in users">
                                <td>@{{ user.id }}</td>
                                <td>@{{ user.name }}</td>
                                <td>@{{ user.mobile }}</td>
                                <td>@{{ user.level_name }}</td>
                                <td>
                                    <button class="btn btn-sm btn-info" @click="editUser(user)">Edit</button>
                                    <button class="btn btn-sm btn-danger" @click="deleteUser(user)">Delete</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!-- /.table-responsive -->
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
            <div class="box box-warning">
                <div class="box-header with-border">
                    <h3 class="box-title">User Levels</h3>&nbsp;
                    <button @click="showAddModal('level')" class="btn btn-success btn-sm">Add User Level</button> 
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                <div class="table-responsive">
                    <table class="table no-margin">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Level Name</th>
                                <th>Description</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(level,key) in levels">
                                <td>@{{ level.id }}</td>
                                <td>@{{ level.level_name }}</td>
                                <td>@{{ level.level_description }}</td>
                                <td>
                                    <button class="btn btn-sm btn-info" @click="editLevel(level)">Edit</button>
                                    <button class="btn btn-sm btn-danger" @click="deleteLevel(level)">Delete</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!-- /.table-responsive -->
                </div>
                <!-- /.box-body -->
            </div>
        </div>
        <div class="col-md-6">
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">Permissions</h3>   
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                    </button>
                </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                <div class="table-responsive">
                    <table class="table no-margin">
                        <thead>
                            <tr>
                                <th>Permission</th>
                                <th>Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(permission,key) in permissions">
                                <td>@{{ permission.permission_name }}</td>
                                <td>@{{ permission.permission_data.toString() }}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!-- /.table-responsive -->
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
    </div>
    @include('modals.users_add')
</div>

@push('scripts')
<script src="../../vuejs/instances/user.js"></script>
@endpush

@endsection