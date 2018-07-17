<div id="add-product-modal" class="modal fade" tabindex="-1" data-backdrop="static">
    <div class="modal-dialog modal-full">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" v-if="newProduct.id==0">Add Product</h4>
                <h4 class="modal-title" v-else>Update Product</h4>
            </div>
            <div class="modal-body">
                <h4>Product Details</h4>
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Product Name</label>
                            <input type="text" v-bind:value="product_name(newProduct)" readonly class="form-control"/>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Product Code</label>
                            <input type="text" v-model="newProduct.product_code" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Category</label>
                            <select v-model="newProduct.category_id" class="form-control">
                                <option v-for="category in categories" v-bind:value="category.id">
                                    @{{ category.category_name }}
                                </option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Brand</label>
                            <input type="text" v-bind:placeholder="(newProduct.product_desctiption==''?'(Required)':'(Optional)')" v-model="newProduct.brand_name" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Description</label>
                            <input type="text" v-bind:placeholder="(newProduct.brand_name==''?'(Required)':'(Optional)')" v-model="newProduct.product_description" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Status</label>
                            <select v-model="newProduct.is_active" class="form-control">
                                <option value="1">Active</option>
                                <option value="0">Inactive</option>
                            </select>
                        </div>
                    </div>
                </div>
                <h3>Product Units <button class="btn btn-xs btn-success" @click="addUnit">+</button></h3>
                <table class="table no-margin table-hover table-bordered">
                    <tr>
                        <th style="width:30px"></th>
                        <th style="width:120px">Unit</th>
                        <th style="width:160px">Info</th>
                        <th style="width:160px">Bar Code</th>
                        <th style="width:100px">Qty/@{{ getUnitName(newProduct.product_data.product_units[0].unit) }}</th>
                        <th style="width:120px">Purchase Price</th>
                        <th>
                            Selling Prices
                            <button class="btn btn-xs btn-info" @click="applyDefaultMarkup">Apply Default Markup</button>
                        </th>
                    </tr>
                    <tr v-for="(unit,key) in newProduct.product_data.product_units">
                        <td>
                            <button class="btn btn-xs btn-danger" @click="removeUnit(key)">x</button>
                            <button class="btn btn-xs btn-info" v-if="key !=0 " @click="moveUnit(key,key-1)">Up</button>
                            <button class="btn btn-xs btn-info" v-if="(key+1)<newProduct.product_data.product_units.length" @click="moveUnit(key,key+1)">Down</button>
                        </td>
                        <td>
                            <select v-model="newProduct.product_data.product_units[key].unit" class="form-control">
                                <option v-if="!isUnitTaken(key, unit.id)" v-for="unit in units" v-bind:value="unit.id">@{{ unit.unit_name }}</option>
                            </select>
                        </td>
                        <td>
                            <input type="text" class="form-control" placeholder="(Optional)" v-model="newProduct.product_data.product_units[key].info">
                        </td>
                        <td>
                            <input type="text" class="form-control" placeholder="(Optional)" v-model="newProduct.product_data.product_units[key].bar_code">
                        </td>
                        <td>
                            <input type="number" class="form-control" v-bind:disabled="key==0" v-model="newProduct.product_data.product_units[key].quantity">
                            <small v-if="key!=0" style="color:blue">
                               @{{ getUnitName(newProduct.product_data.product_units[key].unit) }} per @{{ getUnitName(newProduct.product_data.product_units[key-1].unit) }}
                            </small>
                        </td>
                        <td>
                            <input type="number" placeholder="0" class="form-control" v-model="newProduct.product_data.product_units[key].purchase_price">
                            <small v-if="newProduct.product_data.product_units[key].quantity>0  && key!=0 && (newProduct.product_data.product_units[key-1].purchase_price/newProduct.product_data.product_units[key].quantity) != newProduct.product_data.product_units[key].purchase_price" style="color:red">
                                Cost for 1 @{{ getUnitName(newProduct.product_data.product_units[key].unit) }}: 
                                @{{ (newProduct.product_data.product_units[key-1].purchase_price/newProduct.product_data.product_units[key].quantity).toFixed(2) }}
                            </small>
                            <button class="btn btn-xs btn-info" @click="fillPrices(key)">Fill Prices</button>
                        </td>
                        <td>
                            <table class="table no-margin table-hover table-bordered">
                                <tr>
                                    <th></th>
                                    <th>%</th>
                                    <th>Markup</th>
                                    <th>Price</th>
                                </tr>
                                <tr v-if="getPrice(price.id) !== undefined" v-for="(price,k) in newProduct.product_data.product_units[key].selling_price" v-bind:style="(Number(newProduct.product_data.product_units[key].selling_price[k].value) < Number(newProduct.product_data.product_units[key].purchase_price)?'background-color:pink':'')">
                                    <td>@{{ getPrice(price.id).price_category_name }}</td>
                                    <td>
                                        <input type="number" class="form-control percent" placeholder="0" v-bind:value="(((newProduct.product_data.product_units[key].selling_price[k].value / newProduct.product_data.product_units[key].purchase_price) * 100)-100).toFixed(2)" @change="evaluate($event,key,k)"/>
                                    </td>
                                    <td>
                                        <input type="number" class="form-control integer" placeholder="0" v-bind:value="(newProduct.product_data.product_units[key].selling_price[k].value - newProduct.product_data.product_units[key].purchase_price).toFixed(2)" @change="evaluate($event,key,k)"/>
                                    </td>
                                    <td>
                                        <input type="number" class="form-control" placeholder="0" v-model="newProduct.product_data.product_units[key].selling_price[k].value"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>

                <h4>Recent Purchases</h4>
                <table class="table no-margin table-hover table-bordered">
                    <tr>
                        <th>Purchase Date</th>
                        <th>Supplier</th>
                        <th>Unit</th>
                        <th>Price</th>
                    </tr>
                    <tr v-for="purchase in newProduct.purchases">
                        <td>@{{ dateFormat(purchase.date_transaction,"MM/DD/YYYY") }}</td>
                        <td>
                            @{{ purchase.supplier_name }}
                        </td>
                        <td>
                            @{{ getUnitName(purchase.unit) }}
                        </td>
                        <td>
                            @{{ numberFormat(purchase.purchase_price) }}
                        </td>
                    </tr>
                </table>
                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                <button type="button" v-if="newProduct.id==0" @click="addProduct" class="btn btn-primary">Save</button>
                <button type="button" v-else @click="updateProduct" class="btn btn-primary">Update</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<div id="add-category-modal" class="modal fade" tabindex="-1" data-backdrop="static">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" v-if="newCategory.id==0">Add Category</h4>
                <h4 class="modal-title" v-else>Update Category</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Category Name</label>
                            <input type="text" v-model="newCategory.category_name" class="form-control"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                <button type="button" v-if="newCategory.id==0" @click="addCategory" class="btn btn-primary">Save</button>
                <button type="button" v-else @click="updateCategory" class="btn btn-primary">Update</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>


<div id="add-pricecategory-modal" class="modal fade" tabindex="-1" data-backdrop="static">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" v-if="newPriceCategory.id==0">Add Price Category</h4>
                <h4 class="modal-title" v-else>Update Price Category</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Price Category Name</label>
                            <input type="text" v-model="newPriceCategory.price_category_name" class="form-control"/>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Default Markup</label>
                            <input type="number" v-model="newPriceCategory.default_markup" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Min. Purchase</label>
                            <input type="number" v-model="newPriceCategory.minimum_purchase" class="form-control"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                <button type="button" v-if="newPriceCategory.id==0" @click="addPriceCategory" class="btn btn-primary">Save</button>
                <button type="button" v-else @click="updatePriceCategory" class="btn btn-primary">Update</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>


<div id="inventory-modal" class="modal fade" tabindex="-1" data-backdrop="static">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">Inventory Info : @{{ inventory.product_name }}</h4>
            </div>
            <div class="modal-body">
                <table class="table no-margin table-hover table-bordered">
                    <tr>
                        <th>Unit</th>
                        <th>Stocks</th>
                    </tr>
                    <tr v-for="unit in inventory.units">
                        <td>@{{ getUnitName(unit.unit) }}</td>
                        <td>@{{ unit.stocks }}</td>
                    </tr>
                </table>
                <div v-if="inventory.units.length>1">
                    <hr/>
                    <h4>Convert/Loose</h4>
                    <table class="table no-margin table-hover table-bordered">
                        <tr>
                            <th>From</th>
                            <th style="width:90px">Qty</th>
                            <th>To</th>
                            <th style="width:90px">Qty</th>
                            <th></th>
                        </tr>
                        <tr>
                            <td>
                                <select v-model="convertStocks.from_unit" class="form-control">
                                    <option v-for="unit in inventory.units" v-bind:value="unit.unit">@{{ getUnitName(unit.unit) }}</option>
                                </select>
                            </td>
                            <td>
                                <input @change="checkQ" type="number" class="form-control" v-model="convertStocks.from_quantity" />
                            </td>
                            <td>
                                <select v-model="convertStocks.to_unit" class="form-control">
                                    <option v-if="unit.unit!=convertStocks.from_unit" v-for="unit in inventory.units" v-bind:value="unit.unit">@{{ getUnitName(unit.unit) }}</option>
                                </select>
                            </td>
                            <td>
                                <input type="number" disabled class="form-control" v-bind:value="outputQuantity"/>
                            </td>
                            <td>
                                <button v-if="outputQuantity % 1 === 0 && outputQuantity!=0" class="btn btn-md btn-success" @click="proceedConvert">Proceed</button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>