@extends('layouts.app')
@section('content')
<div class="row" id="branches" v-cloak>
    <div class="col-md-12">
        <!-- TABLE: LATEST ORDERS -->
          <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">Branches List</h3>
              &nbsp;
              <button @click="showAddModal" class="btn btn-success btn-sm" v-if="authorize('branches','add')">Add Branch</button>
              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <div class="table-responsive">
                @include('pagination.header_0')
                <label>
                    <input type="checkbox" v-model="show_inactive"> Show Inactive
                </label>
                <table class="table no-margin">
                    <thead>
                        <tr>
                            <th>
                                <a href="javascript:;" @click="setOrderBy('id',0)">Branch ID
                                <span v-if="pagination[0].sort_by=='id'" >
                                    <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                    <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                </span>
                                </a>
                            </th>
                            <th>
                                <a href="javascript:;" @click="setOrderBy('branch_name',0)">Branch Name
                                <span v-if="pagination[0].sort_by=='branch_name'" >
                                    <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                    <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                </span>
                                </a>
                            </th>
                            <th>
                                <a href="javascript:;" @click="setOrderBy('branch_address',0)">Branch Address
                                <span v-if="pagination[0].sort_by=='branch_address'" >
                                    <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                    <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                </span>
                                </a>
                            </th>
                            <th>
                                <a href="javascript:;" @click="setOrderBy('branch_contact',0)">Branch Contact
                                <span v-if="pagination[0].sort_by=='branch_contact'" >
                                    <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                    <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                </span>
                                </a>
                            </th>
                            <th>
                                <a href="javascript:;" @click="setOrderBy('branch_role',0)">Branch Role
                                <span v-if="pagination[0].sort_by=='branch_role'" >
                                    <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                    <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                </span>
                                </a>
                            </th>
                            <th>
                                <a href="javascript:;" @click="setOrderBy('is_active',0)">Status
                                <span v-if="pagination[0].sort_by=='is_active'" >
                                    <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                    <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                </span>
                                </a>
                            </th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(branch,key) in filtered">
                            <td>@{{ branch.id }}</td>
                            <td>@{{ branch.branch_name }}</td>
                            <td>@{{ branch.branch_address }}</td>
                            <td>@{{ branch.branch_contact }}</td>
                            <td>@{{ branch.branch_role }}</td>
                            <td>
                                <small class="label label-success" v-if="branch.is_active == 1">Active</small>
                                <small class="label label-danger" v-else>Inactive</small>
                            </td>
                            <td>
                                <button class="btn btn-info btn-sm" v-if="authorize('branches','update')" @click="editBranch(branch)">Edit</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
                @include('pagination.footer_0')
              </div>
              <!-- /.table-responsive -->
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
    </div>
    @include('modals.branches_add')
</div>

@push('scripts')
<script src="../../vuejs/components/Pagination.js"></script>
<script src="../../vuejs/instances/branches.js"></script>
@endpush
@endsection