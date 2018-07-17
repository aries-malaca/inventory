<div id="add-modal" class="modal fade" tabindex="-1" data-backdrop="static">
    <div class="modal-dialog modal-full">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" v-if="newReceive.id==0">Add Receiving</h4>
                <h4 class="modal-title" v-else>Receiving Info, ID:@{{ newReceive.id }}</h4>
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
                            <label>From Branch</label>
                            <select v-model="newReceive.from_branch_id" v-bind:disabled="newReceive.receive_status!='pending'"  class="form-control">
                                <option v-if="branch.id != auth.branch_id" v-bind:value="branch.id" v-for="branch in branches">@{{ branch.branch_name }}</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>To Branch</label>
                            <select disabled v-model="newReceive.to_branch_id" class="form-control">
                                <option v-bind:value="branch.id" v-for="branch in branches">@{{ branch.branch_name }}</option>
                            </select>
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
                        @include('components.product_search')
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
                                    <th style="width:25%">Product Name</th>
                                    <th style="width:15%">Quantity</th>
                                    <th style="width:15%">Unit</th>
                                    <th style="width:15%">Unit Cost</th>
                                    <th style="width:15%">Amount</th>
                                    <th v-if="newReceive.receive_status=='pending'" style="width:10%"></th>
                                </tr>
                            </thead>
                        </table>
                        <div style="max-height:600px; overflow-y:scroll">
                            <table class="table no-margin table-bordered table-hover">
                                <tbody>
                                    <tr v-for="(item,key) in newReceive.items" v-bind:style="item.quantity<1?'background-color:pink':''"> 
                                        <td style="width:25%">
                                            @{{ item.product.brand_name }} 
                                            @{{ item.product.product_description }}
                                        </td>
                                        <td style="width:15%"> 
                                            <input placeholder="0" v-bind:disabled="newReceive.receive_status!='pending'" type="number" v-model="newReceive.items[key].quantity" class="form-control pos-price"/>
                                        </td>
                                        <td style="width:15%">
                                            <select v-if="item.product.product_data !== undefined" v-bind:disabled="newReceive.receive_status!='pending'" 
                                                    @change="changeUnit(key)" class="form-control" v-model="newReceive.items[key].unit">
                                                <option v-bind:value="unit.unit" v-for="unit in item.product.units">@{{ unit.name }}</option>
                                            </select>
                                        </td>
                                        <td style="width:15%"> 
                                            <input number type="number" v-bind:disabled="newReceive.receive_status!='pending'" v-model="newReceive.items[key].unit_cost" class="form-control pos-price"/>
                                        </td>
                                        <td style="width:15%">
                                            <input disabled type="text" v-bind:value="numberFormat(newReceive.items[key].unit_cost * newReceive.items[key].quantity)" 
                                                class="form-control pos-price"/>
                                        </td>
                                        <td style="width:7%" v-if="newReceive.receive_status=='pending'">
                                            <button class="btn btn-danger btn-sm" @click="removeItem(key)">X</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                            </div>
                            <div class="col-md-6">
                                <table class="table no-margin table-bordered table-hover">
                                    <th><h3>Total Amount:</h3></th>
                                    <th><h3 class="pull-right">@{{ numberFormat(total) }}</h3></th>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                <div v-if="newReceive.items.length>0">
                    <button type="button" v-show="newReceive.id==0" @click="addReceive" class="btn btn-primary">Save</button>
                    <button type="button" v-show="newReceive.id!=0 && newReceive.receive_status=='pending'" @click="updateReceive" class="btn btn-success">Update</button>
                    <button type="button" v-show="newReceive.id!=0 && newReceive.receive_status=='pending'" @click="approveReceive" class="btn btn-primary">Approve</button>
                    <button type="button" v-show="newReceive.id!=0 && newReceive.receive_status=='pending'" @click="cancelReceive" class="btn btn-danger">Cancel</button>
                    <button type="button" v-if="authorize('receives','void')" v-show="newReceive.id!=0 && newReceive.receive_status=='approved'" @click="voidReceive" class="btn btn-danger">Void</button>
                </div>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>