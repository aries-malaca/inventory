<div id="product-info-modal" class="modal fade" tabindex="-1" data-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" v-if="newCategory.id==0">@{{ product_name(newProduct) }}</h4>
            </div>
            <div class="modal-body">
                <h4>Product Units and Pricing</h4>
                <table class="table no-margin table-hover table-bordered">
                    <tr>
                        <th>Unit</th>
                        <th>Info</th>
                        <th>Bar Code</th>
                        <th>Qty/@{{ getUnitName(newProduct.product_data.product_units[0].unit) }}</th>
                        <th>Purchase Price</th>
                        <th></th>
                    </tr>
                    <tr v-for="(unit,key) in newProduct.product_data.product_units">
                        <td>
                            @{{ getUnitName(newProduct.product_data.product_units[key].unit) }}
                        </td>
                        <td>
                            @{{ newProduct.product_data.product_units[key].info }}
                        </td>
                        <td>
                            @{{ newProduct.product_data.product_units[key].bar_code }}
                        </td>
                        <td>
                            @{{ newProduct.product_data.product_units[key].quantity }}
                            <br/>
                            <small v-if="key!=0" style="color:blue">
                               @{{ getUnitName(newProduct.product_data.product_units[key].unit) }} per @{{ getUnitName(newProduct.product_data.product_units[key-1].unit) }}
                            </small>
                        </td>
                        <td>
                            @{{ numberFormat(newProduct.product_data.product_units[key].purchase_price) }}
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
                                        @{{ (((newProduct.product_data.product_units[key].selling_price[k].value / newProduct.product_data.product_units[key].purchase_price) * 100)-100).toFixed(2) }}
                                    </td>
                                    <td>
                                        @{{ (newProduct.product_data.product_units[key].selling_price[k].value - newProduct.product_data.product_units[key].purchase_price).toFixed(2) }}
                                    </td>
                                    <td>
                                        @{{ numberFormat(newProduct.product_data.product_units[key].selling_price[k].value) }}
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
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
