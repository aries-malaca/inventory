<div id="add-modal" class="modal fade" tabindex="-1" data-backdrop="static">
    <div class="modal-dialog modal-full">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" v-if="newReceive.id==0">Reconcile Stocks</h4>
                <h4 class="modal-title" v-else>Reconciliation Info, ID:@{{ newReceive.id }}</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Reference No.</label>
                            <input type="text" v-bind:disabled="newReceive.receive_status!='pending'" v-model="newReceive.reference_no" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Date:</label>
                            <input type="date" v-bind:disabled="newReceive.receive_status!='pending'" v-model="newReceive.date_received" class="form-control" />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Notes:</label>
                            <input type="text" v-bind:disabled="newReceive.receive_status!='pending'" v-model="newReceive.notes" class="form-control" />
                        </div>
                    </div>
                </div>
                <div class="row pos-container">
                    <div class="col-md-4" v-if="newReceive.receive_status=='pending'">
                        @include('components.product_search2')
                    </div>
                    <div class="col-md-4" v-if="newReceive.receive_status=='approved'">
                        <div class="alert alert-success">
                            <h2 style="text-align:center">Approved</h2>
                        </div>
                    </div>
                    <div class="col-md-4" v-if="newReceive.receive_status=='void'">
                        <div class="alert alert-danger">
                            <h2 style="text-align:center">Void</h2>
                        </div>
                    </div>
                    <div class="col-md-4" v-if="newReceive.receive_status=='cancelled'">
                        <div class="alert bg-purple">
                            <h2 style="text-align:center">Cancelled</h2>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <table class="table no-margin table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th style="width:5%"></th>
                                    <th style="width:12%">Category</th>
                                    <th style="width:15%">Product Name</th>
                                    <th style="width:15%">Beginning</th>
                                    <th style="width:15%">Actual</th>
                                    <th style="width:15%">Difference</th>
                                    <th v-if="newReceive.receive_status=='pending'" style="width:8%"></th>
                                </tr>
                            </thead>
                        </table>
                        <div style="max-height:600px; overflow-y:scroll">
                            <table class="table no-margin table-bordered table-hover">
                                <tbody>
                                    <tr v-for="(item,key) in newReceive.items"> 
                                        <td style="width:5%">
                                            <button v-if="key>0" class="btn btn-xs btn-info" @click="moveItem(key,key-1)"><i class="fa fa-chevron-up"></i></button>
                                            <button v-if="(key+1)<newReceive.items.length" class="btn btn-xs btn-info" @click="moveItem(key,key+1)"><i class="fa fa-chevron-down" ></i></button>
                                        </td>
                                        <td style="width:12%">
                                            @{{ item.product.category_name }}
                                        </td>
                                        <td style="width:15%">
                                            @{{ item.product.brand_name }} 
                                            @{{ item.product.product_description }}
                                        </td>
                                        <td style="background-color:#AAAAFF;width:15%">
                                            <table style="width:100%">
                                                <tr v-for="(unit,k) in item.beginning">
                                                    <td><span>@{{ unit.unit_name }}</span> : </td>
                                                    <td style="text-align:right;width:40%">
                                                        <input type="number" style="width:50px;display:inline" class="pull-right"
                                                            v-bind:value="newReceive.items[key].beginning[k].quantity" disabled/>
                                                    </td>
                                                </tr>
                                                <tr v-if="item.beginning.length>1">
                                                    <td><span>Total @{{ item.beginning[item.beginning.length-1].unit_name }} </span> : </td>
                                                    <td style="text-align:right;width:40%">
                                                        <input type="number" style="width:50px;display:inline" class="pull-right"
                                                            disabled v-bind:value="newReceive.items[key].beginning_retail"/>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="background-color:#AAFFAA;width:15%">
                                            <table style="width:100%">
                                                <tr v-for="(unit,k) in item.actual">
                                                    <td><span>@{{ unit.unit_name }}</span> : </td>
                                                    <td style="text-align:right;width:40%">
                                                        <input type="number" style="width:50px;display:inline" class="pull-right" @change="computeTotals(key)"
                                                            v-model="newReceive.items[key].actual[k].quantity" placeholder="0"/>
                                                    </td>
                                                </tr>
                                                <tr v-if="item.actual.length>1">
                                                    <td><span>Total @{{ item.actual[item.actual.length-1].unit_name }} </span> : </td>
                                                    <td style="text-align:right;width:40%">
                                                        <input type="number" style="width:50px;display:inline" class="pull-right"
                                                            disabled v-bind:value="newReceive.items[key].actual_retail"/>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="background-color:#FFFFAA;width:15%">
                                            <table style="width:100%">
                                                <tr v-for="(unit,k) in item.difference">
                                                    <td><span>@{{ unit.unit_name }}</span> : </td>
                                                    <td style="text-align:right;width:40%">
                                                        <input type="number" style="width:50px;display:inline" class="pull-right" disabled
                                                            v-bind:value="newReceive.items[key].difference[k].quantity"/>
                                                    </td>
                                                </tr>
                                                <tr v-if="item.actual.length>1">
                                                    <td><span>Total @{{ item.actual[item.actual.length-1].unit_name }} </span> : </td>
                                                    <td style="text-align:right;width:40%">
                                                        <input type="number" style="width:50px;display:inline" class="pull-right"
                                                            disabled v-bind:value="newReceive.items[key].difference_retail"/>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="width:6%" v-if="newReceive.receive_status=='pending'">
                                            <button class="btn btn-danger btn-sm" @click="removeItem(key)">X</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <h3>Items: @{{ newReceive.items.length }}</h3>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                <div v-if="newReceive.items.length>0">
                    <button type="button" v-show="newReceive.id==0" @click="addReceive($event)" data-loading-text="Please wait..." class="btn btn-primary">Save</button>
                    <button type="button" v-if="authorize('reconciliations','update')" data-loading-text="Please wait..." v-show="newReceive.id!=0 && newReceive.receive_status=='pending'" 
                        @click="updateReceive($event)" class="btn btn-success">Update</button>
                    <button type="button" v-if="authorize('reconciliations','update')" data-loading-text="Please wait..." v-show="newReceive.id!=0 && newReceive.receive_status=='pending'" 
                        @click="exportAsSales($event)" class="btn btn-success">Export as Sales</button>
                </div>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>