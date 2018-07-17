@extends('layouts.app')
@section('content')
<div id="receives" v-cloak>
    <div class="row">
        <div class="col-md-12">
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">Receivings List</h3>
                    &nbsp;
                    <button class="btn btn-success btn-sm" @click="showAddModal" v-if="authorize('receives','add')">Add Receiving</button>      
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                    </button>
                </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="table-responsive">
                        @include('pagination.header_0')
                        <table class="table no-margin">
                            <thead>
                                <tr>
                                    <th>
                                        <a href="javascript:;" @click="setOrderBy('reference_no',0)">Referenence No.
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
                                        <a href="javascript:;" @click="setOrderBy('from_branch_name',0)">From
                                        <span v-if="pagination[0].sort_by=='from_branch_name'" >
                                            <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                            <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                        </span>
                                        </a>
                                    </th>
                                    <th>
                                        <a href="javascript:;" @click="setOrderBy('to_branch_name',0)">To
                                        <span v-if="pagination[0].sort_by=='to_branch_name'" >
                                            <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                            <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                        </span>
                                        </a>
                                    </th>
                                    <th>
                                        <a href="javascript:;" @click="setOrderBy('date_received',0)">Date Received
                                        <span v-if="pagination[0].sort_by=='date_received'" >
                                            <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                            <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                        </span>
                                        </a>
                                    </th>
                                    <th>
                                        <a href="javascript:;" @click="setOrderBy('total_amount',0)">Amount
                                        <span v-if="pagination[0].sort_by=='total_amount'" >
                                            <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                            <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                        </span>
                                        </a>
                                    </th>
                                    <th>
                                        <a href="javascript:;" @click="setOrderBy('receive_status',0)">Status
                                        <span v-if="pagination[0].sort_by=='receive_status'" >
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
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(receive,key) in filtered">
                                    <td>@{{ receive.reference_no }}</td>
                                    <td>@{{ receive.items_count }}</td>
                                    <td>@{{ receive.from_branch_name }}</td>
                                    <td>@{{ receive.to_branch_name }}</td>
                                    <td>@{{ dateFormat(receive.date_received,"MM/DD/YYYY") }}</td>
                                    <td>@{{ receive.total_amount }}</td>
                                    <td>
                                        <small class="label bg-yellow" v-if="receive.receive_status == 'pending'">Pending</small>
                                        <small class="label bg-green" v-if="receive.receive_status == 'approved'">Approved</small>
                                        <small class="label bg-red" v-if="receive.receive_status == 'void'">Void</small>
                                        <small class="label bg-purple" v-if="receive.receive_status == 'cancelled'">Cancelled</small>
                                    </td>
                                    <td>@{{ receive.name }}</td>
                                    <td>
                                        <button class="btn btn-sm btn-info" @click="viewReceive(receive)">View</button>
                                        <button class="btn btn-sm btn-danger" v-if="receive.receive_status != 'approved'" @click="showDeleteModal(receive)">Delete</button>
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
    @include('modals.receives_add')
    @include('modals.receives_delete')
</div>
@push('scripts')
<script src="../../vuejs/components/Pagination.js"></script>
<script src="../../vuejs/instances/receive.js"></script>
@endpush
@endsection