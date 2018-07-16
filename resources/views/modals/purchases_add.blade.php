<div id="add-modal" class="modal fade" tabindex="-1" data-backdrop="static">
    <div class="modal-dialog modal-full">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" v-if="newPurchase.id==0">Add Purchase</h4>
                <h4 class="modal-title" v-else>Purchase Info, ID:@{{ newPurchase.id }}</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Receipt/Invoice No.</label>
                            <input type="text" v-model="newPurchase.receipt_no" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Reference No.</label>
                            <input type="text" v-model="newPurchase.reference_no" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Supplier</label>
                            <select v-model="newPurchase.supplier_id" class="form-control">
                                <option v-bind:value="supplier.id" v-for="supplier in suppliers" v-if="supplier.is_active==1">
                                    @{{ supplier.supplier_name }}
                                </option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Purchase Date:</label>
                            <input type="date" v-model="newPurchase.date_transaction" class="form-control" />
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Due Date:</label>
                            <input type="date" v-model="newPurchase.date_due" class="form-control" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Notes:</label>
                            <input type="text" v-model="newPurchase.notes" class="form-control" />
                        </div>
                    </div>
                    <div class="col-md-8">
                        <h4 style="text-align:center">Purchase Items (@{{ newPurchase.items.length }})</h4>
                    </div>
                </div>
                <div class="row pos-container">
                    <div class="col-md-4">
                        @include('components.product_search')
                    </div>
                    <div class="col-md-8">
                        <table class="table no-margin table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th style="width:2%">

                                    </th>
                                    <th style="width:23%">Product Name</th>
                                    <th style="width:9%">Quantity</th>
                                    <th style="width:12%">Unit</th>
                                    <th style="width:11%">Unit Price</th>
                                    <th style="width:11%">Discount</th>
                                    <th style="width:11%">Unit Cost</th>
                                    <th style="width:13%">Amount</th>
                                    <th style="width:5%"></th>
                                    <th style="width:2%"></th>
                                </tr>
                            </thead>   
                        </table>                     
                        <div style="max-height:600px; overflow-y:scroll" id="scroll-table">
                            <table class="table no-margin table-bordered table-hover">
                                <tr v-for="(item,key) in newPurchase.items" v-bind:style="(item.quantity<1||(item.unit==0||item.unit===undefined))?'background-color:pink':''">
                                    <td style="width:3%"> 
                                        <button v-if="key>0" class="btn btn-xs btn-info" @click="moveItem(key,key-1)"><i class="fa fa-chevron-up"></i></button>
                                        <button v-if="(key+1)<newPurchase.items.length" class="btn btn-xs btn-info" @click="moveItem(key,key+1)"><i class="fa fa-chevron-down" ></i></button>
                                    </td>
                                    <td style="width:24%"> 
                                        @{{ item.product.brand_name }} 
                                        @{{ item.product.product_description }}
                                    </td>
                                    <td style="width:10%">
                                        <input number placeholder="0" @change="newPurchase.items[key].received_quantity=newPurchase.items[key].quantity" 
                                             type="number" v-model="newPurchase.items[key].quantity" class="form-control pos-price"/>
                                    </td>
                                    <td style="width:13%">
                                        <select v-if="item.product.product_data !== undefined" @change="changeUnit(key), evaluate(key)" class="form-control" v-model="newPurchase.items[key].unit">
                                            <option v-bind:value="unit.unit" v-for="unit in item.product.units">@{{ unit.name }}</option>
                                        </select>
                                    </td>
                                    <td style="width:12%">
                                        <input number @change="evaluate(key,'unit_price')" type="number" 
                                            v-model="newPurchase.items[key].unit_price" class="form-control pos-price"/>
                                    </td>
                                    <td style="width:12%">
                                        <input number @change="evaluate(key,'discount')" type="number" 
                                            v-model="newPurchase.items[key].discount" class="form-control pos-price"/>
                                    </td>
                                    <td style="width:12%">
                                        <input number disabled type="number" v-model="newPurchase.items[key].purchase_price" class="form-control pos-price"/>
                                    </td>
                                    <td style="width:15%">
                                        <input disabled type="text" v-bind:value="numberFormat(newPurchase.items[key].purchase_price * newPurchase.items[key].quantity)" 
                                            class="form-control pos-price"/>
                                    </td>
                                    <td style="width:5%">
                                        <button class="btn btn-danger btn-sm" @click="removeItem(key)">x</button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <hr/>
                        <div class="row" v-if="net_amount > 0">
                            <div class="col-md-7">
                                <ul class="nav nav-tabs pull-left">
                                    <li class="active"><a href="#payment-tab" data-toggle="tab" aria-expanded="true">Payment</a></li>
                                    <li class=""><a href="#received-tab" data-toggle="tab" aria-expanded="false">Received Items</a></li>
                                </ul>
                                <div class="tab-content no-padding">
                                    <div class="tab-pane active" id="payment-tab">
                                        <table class="table no-margin table-bordered table-hover">
                                            <tr>
                                                <th style="width:40px">
                                                    <button @click="addPayment" class="btn btn-success btn-xs">+</button>
                                                </th>
                                                <th>Method</th>
                                                <th style="width:110px;">Amount</th>
                                                <th>Details</th>
                                            </tr>
                                            <tr v-for="(payment,key) in newPurchase.payment_data">
                                                <td>
                                                    <button @click="removePayment(key)" class="btn btn-danger btn-xs">x</button>
                                                </td>
                                                <td>
                                                    <select v-model="newPurchase.payment_data[key].method" class="form-control">
                                                        <option value="Cash">Cash</option>
                                                        <option value="Check">Check</option>
                                                    </select>
                                                </td>
                                                <td>
                                                    <input type="number" class="form-control" v-model="newPurchase.payment_data[key].amount"/>
                                                </td>
                                                <td>
                                                    <input type="text" v-if="newPurchase.payment_data[key].method!='Cash'" class="form-control" v-model="newPurchase.payment_data[key].details"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>Total Payment:</td>
                                                <td>@{{ numberFormat(payment_total) }}</td>
                                                <td>
                                                    <small class="label pull-right bg-green" v-if="net_amount == payment_total">Paid</small>
                                                    <small class="label pull-right bg-red" v-if="net_amount > payment_total">Unpaid</small>
                                                    <small class="label pull-right bg-red" v-if="net_amount < payment_total">Overpaid</small>
                                                </td>
                                            </tr>
                                            <tr v-if="net_amount != payment_total">
                                                <td></td>
                                                <td>Balance:</td>
                                                <td>@{{ numberFormat(net_amount-payment_total) }}</td>
                                                <td>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="tab-pane" id="received-tab">
                                        <div class="clearfix">
                                        </div>
                                        <div style="max-height:300px;overflow-y:scroll">
                                            <table class="table no-margin table-bordered table-hover" style="font-size:90%">
                                                <tr>
                                                    <th>Item</th>
                                                    <th>Unit</th>
                                                    <th>Purchased</th>
                                                    <th style="width:80px">Received</th>
                                                    <th>Pending</th>
                                                </tr>
                                                <tr v-for="(item,key) in newPurchase.items">
                                                    <td>(@{{ item.product.product_code }})
                                                        @{{ item.product.brand_name }} 
                                                        @{{ item.product.product_description }}
                                                    </td>
                                                    <td>@{{ item.unit_name }}</td>
                                                    <td style="width:120px;text-align:center">@{{ newPurchase.items[key].quantity }}</td>
                                                    <td>
                                                        <input number type="number" @change="checkReceivedQuantity(key)" v-model="newPurchase.items[key].received_quantity" class="form-control pos-price"/>
                                                    </td>
                                                    <td><h4 style="text-align:center;color:red">@{{ newPurchase.items[key].quantity - newPurchase.items[key].received_quantity  }}</h4></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <br/>
                                <div class="row">
                                    <div class="col-md-12" v-if="newPurchase.purchase_status=='approved'">
                                        <div class="alert alert-success">
                                            <h3 style="text-align:center">Approved</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-12" v-if="newPurchase.purchase_status=='void'">
                                        <div class="alert alert-danger">
                                            <h3 style="text-align:center">Void</h3>
                                        </div>
                                    </div>
                                    <div class="col-md-12" v-if="newPurchase.purchase_status=='cancelled'">
                                        <div class="alert bg-purple">
                                            <h3 style="text-align:center">Cancelled</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <table class="table no-margin table-bordered table-hover">
                                    <tr>
                                        <td></td>
                                        <td class="pull-right">
                                            <select v-model="newPurchase.purchase_data.vat_enabled" class="form-control">
                                                <option value="1">W/ Vat</option>
                                                <option value="0">W/O Vat</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Total Amount:</td>
                                        <td class="pull-right"> @{{ numberFormat(total) }}</td>
                                    </tr>
                                    <tr>
                                        <td>Discount:</td>
                                        <td class="pull-right"><input type="number" class="form-control" style="font-size:110%;width:120px;text-align:right" v-model="newPurchase.purchase_data.discount"/></td>
                                    </tr>
                                    <tr>
                                        <td>Gross Amount: </td>
                                        <td class="pull-right"> @{{ numberFormat(gross_amount) }}</td>
                                    </tr>
                                    <tr v-if="newPurchase.purchase_data.vat_enabled ==1">
                                        <td>VAT (@{{ settings.default_vat_percentage }}%):</td>
                                        <td class="pull-right"> @{{ numberFormat(vat) }}</td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight:bolder;font-size:110%">Net Amount:</td>
                                        <td class="pull-right" style="font-weight:bolder;font-size:110%"> @{{ numberFormat(net_amount) }}</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" v-if="newPurchase.items.length>0" v-show="newPurchase.id==0" @click="addPurchase($event)" data-loading-text="Please wait..." class="btn btn-primary">Save</button>
                <button type="button" v-if="newPurchase.items.length>0" v-show="newPurchase.id!=0 && newPurchase.purchase_status!='void' && newPurchase.purchase_status!='cancelled'" data-loading-text="Please wait..." @click="updatePurchase($event)" class="btn btn-success">Update</button>
                <button type="button" v-if="newPurchase.items.length>0" v-show="newPurchase.id!=0 && newPurchase.purchase_status=='pending'" data-loading-text="Please wait..." @click="approvePurchase($event)" class="btn btn-primary">Approve</button>
                <button type="button" v-if="newPurchase.items.length>0" v-show="newPurchase.id!=0 && newPurchase.purchase_status=='pending'" data-loading-text="Please wait..." @click="cancelPurchase($event)" class="btn btn-danger pull-left">Cancel</button>
                <button type="button" v-if="newPurchase.items.length>0" v-if="authorize('purchases','void')"  v-show="newPurchase.id!=0 && newPurchase.purchase_status=='approved'" data-loading-text="Please wait..." @click="voidPurchase($event)" class="btn btn-danger">Void</button>
               
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>