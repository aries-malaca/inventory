@extends('layouts.app')
@section('content')
<div class="row" id="suppliers" v-cloak>
    <div class="col-md-12">
        <!-- TABLE: LATEST ORDERS -->
          <div class="box box-success">
            <div class="box-header with-border">
              <h3 class="box-title">Suppliers List</h3>
              &nbsp;
              <button @click="showAddModal" class="btn btn-success btn-sm" v-if="authorize('suppliers','add')">Add Supplier</button>
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
                                <a href="javascript:;" @click="setOrderBy('id',0)">ID
                                <span v-if="pagination[0].sort_by=='id'" >
                                    <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                    <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                </span>
                                </a>
                            </th>
                            <th>
                                <a href="javascript:;" @click="setOrderBy('supplier_name',0)">Supplier Name
                                <span v-if="pagination[0].sort_by=='supplier_name'" >
                                    <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                    <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                </span>
                                </a>
                            </th>
                            <th>
                                <a href="javascript:;" @click="setOrderBy('supplier_address',0)">Supplier Address
                                <span v-if="pagination[0].sort_by=='supplier_address'" >
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
                        <tr v-for="(supplier,key) in filtered">
                            <td>@{{ supplier.id }}</td>
                            <td>@{{ supplier.supplier_name }}</td>
                            <td>@{{ supplier.supplier_address }}</td>
                            <td>
                                <small class="label label-success" v-if="supplier.is_active == 1">Active</small>
                                <small class="label label-danger" v-else>Inactive</small>
                            </td>
                            <td>
                                <button @click="editSupplier(supplier)" class="btn btn-info btn-sm" v-if="authorize('suppliers','update')">Edit</button>
                                <button @click="deleteSupplier(supplier)" class="btn btn-danger btn-sm">Delete</button>
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
    @include('modals.suppliers_add')
</div>


@push('scripts')
<script src="../../vuejs/components/Pagination.js"></script>
<script src="../../vuejs/instances/supplier.js"></script>
@endpush

@endsection