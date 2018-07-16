@extends('layouts.app')

@section('content')
<div class="row" id="clients" v-cloak>
    <div class="col-md-12">
        <!-- TABLE: LATEST ORDERS -->
          <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">Clients List</h3>
              &nbsp;
              <button @click="showAddModal" class="btn btn-success btn-sm" v-if="authorize('clients','add')">Add Client</button>
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
                                <a href="javascript:;" @click="setOrderBy('id',0)">Client ID
                                <span v-if="pagination[0].sort_by=='id'" >
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
                                <a href="javascript:;" @click="setOrderBy('client_address',0)">Client Address
                                <span v-if="pagination[0].sort_by=='client_address'" >
                                    <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                    <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                </span>
                                </a>
                            </th>
                            <th>
                                <a href="javascript:;" @click="setOrderBy('client_contact_info',0)">Contact Info
                                <span v-if="pagination[0].sort_by=='client_contact_info'" >
                                    <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                    <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                </span>
                                </a>
                            </th>
                            <th>
                                <a href="javascript:;" @click="setOrderBy('client_contact_person',0)">Contact Person
                                <span v-if="pagination[0].sort_by=='client_contact_person'" >
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
                        <tr v-for="(client,key) in filtered">
                            <td>@{{ client.id }}</td>
                            <td>@{{ client.client_name }}</td>
                            <td>@{{ client.client_address }}</td>
                            <td>@{{ client.client_contact_info }}</td>
                            <td>
                                @{{ client.client_contact_person }}
                                <span v-if="client.contact_person_designation != ''">(@{{ client.contact_person_designation }})</span>
                            </td>
                            <td>
                                <small class="label label-success" v-if="client.is_active == 1">Active</small>
                                <small class="label label-danger" v-else>Inactive</small>
                            </td>
                            <td>
                                <button @click="editClient(client)" v-if="authorize('clients','update')" class="btn btn-info btn-sm">Edit</button>
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
    @include('modals.clients_add')
</div>

@push('scripts')
<script src="../../vuejs/components/Pagination.js"></script>
<script src="../../vuejs/instances/client.js"></script>
@endpush

@endsection