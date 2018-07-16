@extends('layouts.app')
@section('content')
<div id="receives" v-cloak>
    <div class="row">
        <div class="col-md-12">
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">Reconciliations List</h3>
                    &nbsp;
                    <button class="btn btn-success btn-sm" @click="showAddModal" v-if="authorize('reconciliations','add')">Reconcile</button>      
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
                                        <a href="javascript:;" @click="setOrderBy('date_received',0)">Date Received
                                        <span v-if="pagination[0].sort_by=='date_received'" >
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
                                    <td>@{{ dateFormat(receive.date_received,"MM/DD/YYYY") }}</td>
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
    @include('modals.reconciliations_add')
    @include('modals.reconciliations_delete')
</div>
@push('scripts')
<script src="../../vuejs/components/Pagination.js"></script>
<script src="../../vuejs/instances/reconciliations.js"></script>
@endpush
@endsection