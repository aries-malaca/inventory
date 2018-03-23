@extends('layouts.app')
@section('content')
<div class="row" id="reports" v-cloak>
    <div class="col-md-12">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">Generate Report</h3>
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                    </button>
                </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#sales-report-tab" data-toggle="tab" aria-expanded="true">Sales Report</a></li>
                </ul> 
                <div class="tab-content">
                    <div id="sales-report-tab" class="tab-pane active">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Date Start</label>
                                    <input type="date" class="form-control" v-model="newSalesReport.date_start" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Date End</label>
                                    <input type="date" v-model="newSalesReport.date_end" class="form-control" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Report Type</label>
                                    <select v-model="newSalesReport.report_type" class="form-control">
                                        <option v-for="report in report_types" v-bind:value="report.name">@{{ report.title }}</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>&nbsp;</label><br/>
                                    <button @click="generateSalesReport" class="btn btn-success btn-md">Generate</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.box-body -->
        </div>
        <!-- /.box -->
    </div>
</div>
@push('scripts')
<script src="../../vuejs/instances/reports.js"></script>
@endpush
@endsection