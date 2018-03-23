@extends('layouts.app')
@section('content')
<div id="settings" v-cloak>
    <div class="row">
        <div class="col-md-6">
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">General Settings</h3>
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
                                    <th>Setting Name</th>
                                    <th>Value</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(setting,key) in settings">
                                    <td>@{{ setting.setting_label }}</td>
                                    <td>
                                        <input type="text" v-if="setting.setting_type == 'string'" class="form-control" v-model="settings[key].setting_value"/>
                                        <input type="number" v-if="setting.setting_type == 'number'" class="form-control" v-model="settings[key].setting_value"/>
                                        <select v-if="setting.setting_type == 'yes_no'" class="form-control" v-model="settings[key].setting_value">
                                            <option value="1">Yes</option>
                                            <option value="0">No</option>
                                        </select>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <button v-if="settings.length>0" class="btn btn-success btn-md" @click="updateSettings">Update</button>
                    </div>
                    <!-- /.table-responsive -->
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
        <div class="col-md-6">
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">
                        Product Units
                        <button class="btn btn-success btn-sm" @click="showAddModal">Add Unit</button>   
                    </h3>
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
                                    <th>Unit Name</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(unit,key) in units">
                                    <td>@{{ unit.unit_name }}</td>
                                    <td>
                                        <button class="btn btn-info btn-sm" @click="editUnit(unit)">Edit</button>
                                        <button class="btn btn-danger btn-sm" @click="deleteUnit(unit)">Delete</button>
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
        </div>
    </div>
    @include('modals.units_add')
</div>
@push('scripts')
<script src="../../vuejs/instances/settings.js"></script>
@endpush
@endsection