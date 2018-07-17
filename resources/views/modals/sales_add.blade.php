<div id="add-modal" class="modal fade" tabindex="-1" data-backdrop="static">
    <div class="modal-dialog modal-full">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" v-if="newSale.id==0">Add Sale</h4>
                <h4 class="modal-title" v-else>Sale Info, ID:@{{ newSale.id }}</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Receipt No.</label>
                            <input type="text" v-bind:disabled="newSale.sale_status!='pending' && newSale.id!=0" v-model="newSale.receipt_no" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Client</label>
                            <select v-model="newSale.client_id" @change="changeClient" v-bind:disabled="newSale.sale_status!='pending' && newSale.id!=0" class="form-control">
                                <option v-bind:value="client.id" v-for="client in clients">@{{ client.client_name }}</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Address</label>
                            <input type="text" disabled v-bind:value="'Address'" class="form-control" />
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Date Trans.:</label>
                            <input type="date" v-bind:disabled="newSale.sale_status!='pending' && newSale.id!=0" v-model="newSale.date_transaction" class="form-control" />
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Date Due:</label>
                            <input type="date" v-bind:disabled="newSale.sale_status!='pending' && newSale.id!=0" v-model="newSale.date_due" class="form-control" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label style="display:inline">Notes:</label>
                            <input style="display:inline" type="text" v-bind:disabled="newSale.sale_status!='pending' && newSale.id!=0" v-model="newSale.notes" class="form-control" />
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label style="display:inline">Price Category:</label>
                            <select style="display:inline" @change="changePrice" v-bind:disabled="newSale.sale_status!='pending' && newSale.id!=0" v-model="newSale.price_category_id" class="form-control">
                                <option v-bind:value="category.id" v-for="category in price_categories">@{{ category.price_category_name }}</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3" v-if="newSale.id==0">
                        <div class="form-group">
                            <label style="display:inline">Checkout As:</label>
                            <select style="display:inline" v-model="newSale.sale_status" class="form-control">
                                <option value="sold">Sold</option>
                                <option value="pending">Pending</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row pos-container">
                    <div class="col-md-4" v-if="newSale.sale_status=='pending' || newSale.id==0">
                        @include('components.product_search')
                    </div>
                    <div class="col-md-4" v-if="newSale.sale_status=='sold' && newSale.id!=0">
                        <div class="alert alert-success">
                            <h2 style="text-align:center">Sold</h2>
                        </div>
                    </div>
                    <div class="col-md-4" v-if="newSale.sale_status=='void' && newSale.id!=0">
                        <div class="alert alert-danger">
                            <h2 style="text-align:center">Void</h2>
                        </div>
                    </div>
                    <div class="col-md-4" v-if="newSale.sale_status=='cancelled' && newSale.id!=0">
                        <div class="alert bg-purple">
                            <h2 style="text-align:center">Cancelled</h2>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <h3>Sale Items 
                            <div v-if="newSale.sale_status=='pending' || newSale.id==0">
                                <button v-if="lock_price" class="btn btn-xs btn-info pull-right" @click="showUnlockModal"><i class="fa fa-unlock"></i> Unlock Price</button> 
                                <button v-else class="btn btn-xs btn-warning pull-right" @click="lockPrice"><i class="fa fa-lock"></i> Lock Price</button>
                            </div>
                        </h3> 
                        <table class="table no-margin table-bordered">
                            <thead>
                                <tr>
                                    <th style="width:25%">Product Name</th>
                                    <th style="width:15%">Quantity</th>
                                    <th style="width:15%">Unit</th>
                                    <th style="width:17%">Unit Price</th>
                                    <th style="width:18%">Amount</th>
                                    <th v-if="newSale.sale_status=='pending' || newSale.id==0" style="width:10%"></th>
                                </tr>
                            </thead>
                        </table>
                        <div style="max-height:600px; overflow-y:scroll">
                            <table class="table no-margin table-bordered">
                                <tbody>
                                    <tr v-if="item.product!==undefined" v-for="(item,key) in newSale.items" v-bind:style="item.quantity<1?'background-color:pink':''">
                                        <td style="width:25%">
                                            @{{ item.product.brand_name }} 
                                            @{{ item.product.product_description }}
                                        </td>
                                        <td style="width:15%">
                                            <input v-bind:disabled="newSale.sale_status!='pending' && newSale.id!=0" @change="checkStocks(key)" 
                                                type="number" v-model="newSale.items[key].quantity" placeholder="0" class="form-control pos-price"/>
                                        </td>
                                        <td style="width:15%">
                                            <select v-if="item.product.product_data !== undefined" v-bind:disabled="newSale.sale_status!='pending' && newSale.id!=0" @change="changeUnit(key),checkStocks(key)" class="form-control" v-model="newSale.items[key].unit">
                                                <option v-bind:value="unit.unit" v-for="unit in item.product.units">@{{ unit.name }}</option>
                                            </select>
                                        </td>
                                        <td style="width:17%">
                                            <input v-bind:disabled="lock_price" type="number" v-model="newSale.items[key].selling_price" class="form-control pos-price"/> 
                                            <br/>
                                            <small style="color:red" v-if="item.purchase_price > Number(item.selling_price)">
                                                Selling price is less than the Purchase price (@{{ item.purchase_price.toFixed(2) }}).
                                            </small>
                                        </td>
                                        <td style="width:18%">
                                            <input disabled type="text" v-bind:value="numberFormat(newSale.items[key].selling_price * newSale.items[key].quantity)" class="form-control pos-price"/>
                                        </td>
                                        <td style="width:7%" v-if="newSale.sale_status=='pending' || newSale.id==0">
                                            <button class="btn btn-danger btn-sm" @click="removeItem(key)">X</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <br/>
                        <div class="row" v-if="net_amount > 0">
                            <div class="col-md-7">
                                <h3>Payment <button @click="addPayment" class="btn btn-success btn-xs">+</button></h3> 
                                <table class="table no-margin table-bordered table-hover">
                                    <tr>
                                        <th style="width:40px"></th>
                                        <th>Method</th>
                                        <th style="width:110px;">Amount</th>
                                        <th>Details</th>
                                    </tr>
                                    <tr v-for="(payment,key) in newSale.payment_data">
                                        <td>
                                            <button @click="removePayment(key)" class="btn btn-danger btn-xs">x</button>
                                        </td>
                                        <td>
                                            <select v-model="newSale.payment_data[key].method" class="form-control">
                                                <option value="Cash">Cash</option>
                                                <option value="Check">Check</option>
                                            </select>
                                        </td>
                                        <td>
                                            <input type="number" class="form-control" v-model="newSale.payment_data[key].amount"/>
                                        </td>
                                        <td>
                                            <input type="text" class="form-control" v-model="newSale.payment_data[key].details"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Total Payment:</td>
                                        <td class="pull-right">@{{ numberFormat(payment_total) }}</td>
                                        <td>
                                            <small class="label pull-right bg-green" v-if="net_amount == payment_total">Paid</small>
                                            <small class="label pull-right bg-red" v-if="net_amount > payment_total">Unpaid</small>
                                            <small class="label pull-right bg-red" v-if="net_amount < payment_total">Overpaid</small>
                                        </td>
                                    </tr>
                                    <tr v-if="net_amount != payment_total">
                                        <td></td>
                                        <td>Balance:</td>
                                        <td class="pull-right">@{{ numberFormat(net_amount-payment_total) }}</td>
                                        <td>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td></td>
                                        <td style="font-weight:bolder;font-size:110%">Enter Cash:</td>
                                        <td class="pull-right">
                                            <input type="number" class="form-control" style="font-size:110%;width:120px;text-align:right" v-model="newSale.sale_data.cash"/>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td style="font-weight:bolder;font-size:110%">Change:</td>
                                        <td class="pull-right"> @{{ numberFormat(newSale.sale_data.cash - net_amount) }}</td>
                                        <td></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-md-5">
                                <table class="table no-margin table-bordered table-hover">
                                    <tr>
                                        <td></td>
                                        <td class="pull-right">
                                            <select v-bind:disabled="newSale.sale_status!='pending'" v-model="newSale.sale_data.vat_enabled" class="form-control">
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
                                        <td class="pull-right">
                                            <input v-bind:disabled="newSale.sale_status!='pending'" type="number" class="form-control" style="font-size:110%;width:120px;text-align:right" v-model="newSale.sale_data.discount"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Gross Amount: </td>
                                        <td class="pull-right"> @{{ numberFormat(gross_amount) }}</td>
                                    </tr>
                                    <tr v-if="newSale.sale_data.vat_enabled ==1">
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
                <button type="button" v-if="newSale.items.length>0" v-show="newSale.id==0 || newSale.sale_status=='pending'" @click="checkoutSale" class="btn btn-success">Checkout <span v-if="newSale.id!=0">as Sold</span></button>
                <button type="button" v-if="newSale.items.length>0" v-show="newSale.sale_status=='pending' && newSale.id!=0" @click="updateSale" class="btn btn-primary">Update</button>
                <button type="button" v-if="newSale.items.length>0" v-show="newSale.id!=0 && newSale.sale_status=='pending'" @click="cancelSale" class="btn btn-danger pull-left">Cancel</button>
                <button type="button" v-if="newSale.items.length>0" v-show="newSale.id!=0 && newSale.sale_status=='sold'" @click="voidSale" class="btn btn-danger" v-if="authorize('sales','void')">Void</button>
                <button type="button" v-if="newSale.items.length>0" v-show="newSale.sale_status=='sold' && newSale.id!=0" @click="printReceipt" class="btn btn-warning">Receipt</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>