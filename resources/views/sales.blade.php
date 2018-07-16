@extends('layouts.app')
@section('content')
<div id="sales" v-cloak>
    <div class="row">
        <div class="col-md-12">
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">Sales List</h3>
                    &nbsp;
                    <button class="btn btn-success btn-sm" v-if="authorize('sales','add')" @click="showAddModal">Add Sale</button>      
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                    </button>
                </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                <div class="table-responsive">
                    @include('pagination.header_0')
                    <h4 class="pull-right">
                        Total 
                        <select v-model="status_select">
                            <option value="all">All</option>
                            <option value="sold">Sold</option>
                            <option value="pending">Pending</option>
                            <option value="void">Void</option>
                        </select>
                        Sales: @{{ numberFormat(total_sum) }}
                    </h4>
                    <table class="table no-margin">
                        <thead>
                            <tr>
                                <th>
                                    <a href="javascript:;" @click="setOrderBy('receipt_no',0)">Receipt No.
                                    <span v-if="pagination[0].sort_by=='receipt_no'" >
                                        <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                        <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                    </span>
                                    </a>
                                </th>
                                <th>
                                    <a href="javascript:;" @click="setOrderBy('client_name',0)">Client Name
                                    <span v-if="pagination[0].sort_by=='client_name'" >
                                        <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                        <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                    </span>
                                    </a>
                                </th>
                                <th>
                                    <a href="javascript:;" @click="setOrderBy('items_count',0)">Items
                                    <span v-if="pagination[0].sort_by=='items_count'" >
                                        <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                        <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                    </span>
                                    </a>
                                </th>
                                <th>
                                    <a href="javascript:;" @click="setOrderBy('date_transaction',0)">Transaction Date
                                    <span v-if="pagination[0].sort_by=='date_transaction'" >
                                        <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                        <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                    </span>
                                    </a>
                                </th>
                                <th>
                                    <a href="javascript:;" @click="setOrderBy('date_due',0)">Due Date
                                    <span v-if="pagination[0].sort_by=='date_due'" >
                                        <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                        <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                    </span>
                                    </a>
                                </th>
                                <th>
                                    <a href="javascript:;" @click="setOrderBy('terms',0)">Terms
                                    <span v-if="pagination[0].sort_by=='terms'" >
                                        <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                        <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                    </span>
                                    </a>
                                </th>
                                <th>
                                    <a href="javascript:;" @click="setOrderBy('notes',0)">Notes
                                    <span v-if="pagination[0].sort_by=='notes'" >
                                        <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                        <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                    </span>
                                    </a>
                                </th>
                                <th>
                                    <a href="javascript:;" @click="setOrderBy('net_amount',0)">Net Amount
                                    <span v-if="pagination[0].sort_by=='net_amount'" >
                                        <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                        <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                    </span>
                                    </a>
                                </th>
                                <th>
                                    <a href="javascript:;" @click="setOrderBy('name',0)">Encoder
                                    <span v-if="pagination[0].sort_by=='name'" >
                                        <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                        <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                    </span>
                                    </a>
                                </th>
                                <th>
                                    <a href="javascript:;" @click="setOrderBy('sales_status',0)">Status
                                    <span v-if="pagination[0].sort_by=='sales_status'" >
                                        <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                        <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                    </span>
                                    </a>
                                </th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(sale,key) in filtered">
                                <td>@{{ sale.receipt_no }}</td>
                                <td>@{{ sale.client_name }}</td>
                                <td>@{{ sale.items_count }}</td>
                                <td>@{{ dateFormat(sale.date_transaction,"MM/DD/YYYY") }}</td>
                                <td>@{{ dateFormat(sale.date_due,"MM/DD/YYYY") }}</td>
                                <td>@{{ sale.terms }}</td>
                                <td>@{{ sale.notes }}</td>
                                <td>@{{ sale.net_amount }}</td>
                                <td>@{{ sale.name }}</td>
                                <td>
                                    <small class="label bg-yellow" v-if="sale.sales_status == 'pending'">Pending</small>
                                    <small class="label bg-green" v-if="sale.sales_status == 'sold'">Sold</small>
                                    <small class="label bg-red" v-if="sale.sales_status == 'void'">Void</small>
                                    <small class="label bg-purple" v-if="sale.sales_status == 'cancelled'">Cancelled</small>
                                </td>
                                
                                <td>
                                    <button class="btn btn-sm btn-info" @click="viewSale(sale)">View</button>
                                    <button class="btn btn-sm btn-danger" v-if="sale.sales_status == 'void' || sale.sales_status == 'cancelled'" @click="showDeleteModal(sale)">Delete</button>
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
    </div>
    @include('modals.sales_add')
    @include('modals.sales_delete')
    @include('modals.unlock_price')
</div>
@push('scripts')
<script src="../../vuejs/components/Pagination.js"></script>
<script src="../../vuejs/instances/sale.js"></script>
@endpush
@endsection