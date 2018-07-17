@extends('layouts.app')
@section('content')
<div id="purchases" v-cloak>
    <div class="row">
        <div class="col-md-12">
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">Purchases List</h3>
                    &nbsp;
                    <button class="btn btn-success btn-sm" @click="showAddModal" v-if="authorize('purchases','add')">Add Purchase</button>      
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
                            <option value="approved">Approved</option>
                            <option value="pending">Pending</option>
                            <option value="void">Void</option>
                        </select>
                        Purchases: @{{ numberFormat(total_sum) }}
                    </h4>
                    <table class="table no-margin">
                        <thead>
                            <tr>
                                <th>
                                    <a href="javascript:;" @click="setOrderBy('reference_no',0)">Reference No.
                                    <span v-if="pagination[0].sort_by=='reference_no'" >
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
                                    <a href="javascript:;" @click="setOrderBy('supplier_name',0)">Supplier
                                    <span v-if="pagination[0].sort_by=='supplier_name'" >
                                        <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                        <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                    </span>
                                    </a>
                                </th>
                                <th>
                                    <a href="javascript:;" @click="setOrderBy('date_transaction',0)">Purchase Date
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
                                    <a href="javascript:;" @click="setOrderBy('purchase_status',0)">Status
                                    <span v-if="pagination[0].sort_by=='purchase_status'" >
                                        <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                        <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                    </span>
                                    </a>
                                </th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(purchase,key) in filtered">
                                <td>@{{ purchase.reference_no }}</td>
                                <td>@{{ purchase.items.length }}</td>
                                <td>@{{ purchase.supplier_name }}</td>
                                <td>@{{ dateFormat(purchase.date_transaction,"MM/DD/YYYY") }}</td>
                                <td>@{{ dateFormat(purchase.date_due,"MM/DD/YYYY") }}</td>
                                <td>@{{ purchase.terms }}</td>
                                <td>@{{ purchase.notes }}</td>
                                <td>@{{ purchase.net_amount }}</td>
                                <td>@{{ purchase.name }}</td>
                                <td>
                                    <small class="label bg-yellow" v-if="purchase.purchase_status == 'pending'">Pending</small>
                                    <small class="label bg-green" v-if="purchase.purchase_status == 'approved'">Approved</small>
                                    <small class="label bg-red" v-if="purchase.purchase_status == 'void'">Void</small>
                                    <small class="label bg-purple" v-if="purchase.purchase_status == 'cancelled'">Cancelled</small>
                                </td>
                                
                                <td>
                                    <button class="btn btn-sm btn-info" @click="viewPurchase(purchase)">View</button>
                                    <button class="btn btn-sm btn-danger" v-if="purchase.purchase_status == 'void' || purchase.purchase_status == 'cancelled'" @click="showDeleteModal(purchase)">Delete</button>
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
    @include('modals.purchases_add')
    @include('modals.purchases_delete')
</div>
@push('scripts')
<script src="../../vuejs/components/Pagination.js"></script>
<script src="../../vuejs/instances/purchase.js"></script>
@endpush
@endsection