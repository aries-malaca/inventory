<template>
    <div class="tab-pane active" id="products-tab" style="position: relative;">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">Product List</h3>
                &nbsp;
                <button @click="showAddModal" class="btn btn-success btn-sm">Add Product</button>

                <div class="pull-right">
                    <input type="text" v-model="barcode" class="form-control" placeholder="Find product by Barcode."/>
                </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
                <div v-if="barcode !== '' && products.length === 0" class="alert alert-warning">
                    <h4>No item found for barcode: {{ barcode }}</h4>
                </div>
                <data-table v-else
                        :columns="productTable.columns"
                        :rows="products"
                        :paginate="true"
                        :onClick="productTable.rowClicked"
                        styleClass="table table-bordered table-hover table-striped">
                </data-table>
            </div>
            <!-- /.box-body -->
        </div>

        <div id="add-modal" class="modal fade" tabindex="-1" data-backdrop="static">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title" v-if="newProduct.id==0">Add Product</h4>
                        <h4 class="modal-title" v-else>Update Product</h4>
                    </div>
                    <div class="modal-body">
                        <div class="nav-tabs-custom">
                            <ul class="nav nav-tabs pull-right">
                                <li class="" v-if="newProduct.id!==0"><a href="#inventory" data-toggle="tab" aria-expanded="false">Inventory</a></li>
                                <li class=""><a href="#units" data-toggle="tab" aria-expanded="true">Units & Pricing</a></li>
                                <li class="active"><a href="#info" data-toggle="tab" aria-expanded="false">Product Info</a></li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="info">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>Product Code</label>
                                                <input type="text" class="form-control" v-model="newProduct.product_code"/>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>Brand</label>
                                                <input type="text" placeholder="(Optional)" class="form-control" v-model="newProduct.brand_name"/>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Description</label>
                                                <input type="text" placeholder="(Required)" class="form-control" v-model="newProduct.product_description"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label>Product Name</label>
                                            <input type="text" placeholder="(Optional)" class="form-control" disabled :value="productName"/>
                                        </div>
                                        <div class="col-md-4">
                                            <label>Category</label>
                                            <vue-select v-model="newProduct.category" :options="categories"></vue-select>
                                        </div>
                                        <div class="col-md-2">
                                            <label>Status</label>
                                            <select v-model="newProduct.is_active" class="form-control">
                                                <option value="1">Active</option>
                                                <option value="0">Inactive</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.tab-pane -->
                                <div class="tab-pane" id="units">
                                    <table class="table table-condensed table-bordered table-hover" v-for="(unit, key) in newProduct.product_units">
                                        <thead>
                                            <tr>
                                                <th>Unit #{{ key+1 }} </th>
                                                <th>Info</th>
                                                <th>Barcode</th>
                                                <th style="width:120px;">
                                                    <span v-if="key>0">
                                                        <span v-if="unit.unit!==null">
                                                           {{ unit.unit.unit_name }}
                                                        </span>
                                                        <span v-else>Qty</span>
                                                        per {{ newProduct.product_units[key-1].unit.unit_name }}
                                                    </span>
                                                    <span v-else>Qty</span>
                                                </th>
                                                <th style="width:120px;"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <select class="form-control" v-model="newProduct.product_units[key].unit">
                                                        <option v-for="unit in units" :value="unit">{{ unit.unit_name }}</option>
                                                    </select>
                                                </td>
                                                <td>
                                                    <input type="text" class="form-control" v-model="newProduct.product_units[key].info"/>
                                                </td>
                                                <td>
                                                    <input type="text" class="form-control" v-model="newProduct.product_units[key].barcode"/>
                                                </td>
                                                <td>
                                                    <input type="number" class="form-control" :disabled="key===0" v-model.number="newProduct.product_units[key].quantity_per_parent">
                                                </td>
                                                <td>
                                                    <button class="btn btn-danger btn-xs" @click="removeProductUnit(key)">X</button>
                                                    <button class="btn btn-success btn-xs" @click="addProductUnit" v-if="newProduct.product_units.length === (key+1) && unit.unit!==null">+</button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="5">
                                                    <table class="table table-condensed table-bordered table-hover" style="margin-bottom:0px">
                                                        <tbody>
                                                            <tr v-for="(p,index) in unit.pricing">
                                                                <td style="width:40px;">
                                                                    <button class="btn btn-danger btn-xs" @click="removePurchasePrice(key,index)">X</button>
                                                                    <button class="btn btn-success btn-xs" @click="addPurchasePrice(key)" v-if="unit.pricing.length === (index+1)">+</button>
                                                                </td>
                                                                <td style="width:340px;">
                                                                    <div class="row">
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <label>Purchase Price</label>
                                                                                <input type="number" class="form-control" v-model.number="newProduct.product_units[key].pricing[index].purchase_price"/>
                                                                                <small style="color:red" v-if="key > 0 && unit.unit !== null">
                                                                                    <span v-if="p.purchase_price !== Number((newProduct.product_units[key -1].pricing[0].purchase_price/unit.quantity_per_parent).toFixed(2))">
                                                                                        Cost for 1 {{ unit.unit.unit_name }}: {{ (newProduct.product_units[key -1].pricing[0].purchase_price/unit.quantity_per_parent).toFixed(2) }}
                                                                                    </span>
                                                                                </small>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-8">
                                                                            <div class="form-group">
                                                                                <label>Remarks</label>
                                                                                <input type="text" class="form-control" v-model="newProduct.product_units[key].pricing[index].remarks"/>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <div class="col-md-12">
                                                                            <button class="btn btn-warning btn-xs" @click="autoFillPurchasePrices(key, index)">Auto-fill Purchase Prices</button>
                                                                            <button class="btn btn-info btn-xs" @click="applyDefaultMarkups(key, index)">Apply Default Markups</button>
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <table class="table table-condensed table-bordered table-hover" style="margin-bottom:0px">
                                                                        <thead>
                                                                            <tr>                                                                           
                                                                                <th style="width:120px;"></th>
                                                                                <th>%</th>
                                                                                <th>Markup</th>
                                                                                <th>Price</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <tr v-for="(s,x) in p.selling" :style="s.selling_price <= 0 || (((s.selling_price - p.purchase_price) / p.purchase_price) * 100) <= 0 ?'background-color:#FF8888':''">
                                                                                <td>{{ s.name }}</td>
                                                                                <td>
                                                                                    <input type="number" class="form-control" :value="(((s.selling_price - p.purchase_price) / p.purchase_price) * 100).toFixed(2)" />
                                                                                </td>
                                                                                <td>
                                                                                    <input type="number" class="form-control" :value="(s.selling_price - p.purchase_price).toFixed(2)"/>
                                                                                </td>
                                                                                <td>
                                                                                    <input type="number" class="form-control" v-model.number="newProduct.product_units[key].pricing[index].selling[x].selling_price"/>
                                                                                </td>
                                                                            </tr>
                                                                        </tbody>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- /.tab-pane -->
                                <div class="tab-pane" id="inventory">

                                </div>
                                <!-- /.tab-pane -->
                            </div>
                            <!-- /.tab-content -->
                        </div>
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

    </div>
</template>
<script>
    import DataTable from '../components/DataTable.vue';
    import VueSelect from 'vue-select';

    export default {
        name: 'ProductsList',
        components:{ DataTable, VueSelect },
        data(){
            return{
                barcode:'',
                modalState:'viewing',
                active_tab:'info',
                productTable:{
                    columns: [
                        { label: 'Product Code', field: 'product_code' },
                        { label: 'Product Name', field: 'product_name', filterable: true },
                        { label: 'Category', field: 'category_name', filterable: true },
                        { label: 'Status', field: 'status_html', filterable: true, html:true },
                    ],
                    rowClicked: this.viewProduct,
                },
                newProduct:{}
            }
        },
        methods:{
            addProductUnit(){
                this.newProduct.product_units.push({
                    unit:null,
                    quantity_per_parent:0,
                    parent_unit_id:0,
                    info:'',
                    barcode:'',
                    pricing:[]
                });
                this.addPurchasePrice(this.newProduct.product_units.length - 1);
            },
            removeProductUnit(key){
                if(this.newProduct.product_units.length === 1){
                    toastr.error("Cannot delete all units.");
                    return false;
                }
                this.newProduct.product_units.splice(key, 1);
                this.newProduct.product_units[0].quantity_per_parent = 1;
            },
            addPurchasePrice(key){
                var generated_selling = this.prices.map((item)=>{
                    return {    selling_price:0,
                                name:item.price_category_name,
                                default_markup:item.default_markup,
                                price_category_id: item.id}
                });
                this.newProduct.product_units[key].pricing.push({
                    purchase_price:0,
                    remarks:'',
                    selling:generated_selling
                });
            },
            removePurchasePrice(key, index){
                if(this.newProduct.product_units[key].pricing.length === 1){
                    toastr.error("Cannot delete all purchase price.");
                    return false;
                }
                this.newProduct.product_units[key].pricing.splice(index, 1);
            },
            showAddModal(){
                this.newProduct = {
                    id:0,
                    brand_name:'',
                    product_code:'',
                    product_description:'',
                    category:null,
                    is_active:1,
                    product_units:[
                        {
                            unit:null,
                            quantity_per_parent:1,
                            parent_unit_id:0,
                            info:'',
                            barcode:'',
                            pricing:[]
                        }
                    ]
                };
                this.addPurchasePrice(0);
                $("#add-modal").modal("show");
            },
            viewProduct:function(product){
                let u = this;
                axios.get('/api/product/getProduct/' + product.id)
                    .then(function (response) {
                        u.newProduct = {
                            id:response.data.id,
                            brand_name:response.data.brand_name,
                            product_code:response.data.product_code,
                            product_description:response.data.product_description,
                            category_id:response.data.category_id,
                            is_active:response.data.is_active
                        };

                        $("#add-modal").modal("show");
                    });
            },
            autoFillPurchasePrices(i, j){
                var o = i;
                while(i>0){
                    i--;
                    this.newProduct.product_units[i].pricing[j].purchase_price = this.newProduct.product_units[i+1].quantity_per_parent * this.newProduct.product_units[i+1].pricing[j].purchase_price;
                }

                while(o<(this.newProduct.product_units.length-1)){
                    o++;
                    this.newProduct.product_units[o].pricing[j].purchase_price = this.newProduct.product_units[o-1].pricing[j].purchase_price / this.newProduct.product_units[o].quantity_per_parent;
                }
            },
            applyDefaultMarkups(i, j){
                for(var x=0;x<this.newProduct.product_units[i].pricing[j].selling.length;x++){
                    var p = this.newProduct.product_units[i].pricing[j].purchase_price;
                    var m = this.newProduct.product_units[i].pricing[j].selling[x].default_markup;
                    this.newProduct.product_units[i].pricing[j].selling[x].selling_price =
                         p + (p*(m/100));
                }
            },
            addProduct:function(){
                this.makeRequest(event, this.newCategory, API_URL + '/api/product/addProduct?token=' + this.token, "#add-modal", 'fetchProducts');
            },
            updateProduct:function(){
                this.makeRequest(event, this.newCategory, API_URL + '/api/product/updateProduct?token=' + this.token, "#add-modal",  'fetchProducts');
            },
            makeRequest(event, data, url, modal, fetch){
                let u = this;
                let $btn = $(event.target);
                $btn.button('loading');
                axios.post(url, data)
                    .then(function (response) {
                        u.$store.dispatch('products/'+fetch);
                        toastr.success(response.data.message);
                        $(modal).modal("hide");
                        $btn.button('reset');
                    })
                    .catch(function (error) {
                        $btn.button('reset');
                        XHRCatcher(error);
                    });
            },
        },
        computed:{
            products(){
                let u = this;

                return this.$store.state.products.products.map((product)=>{
                    product.status_html = product.is_active===1? '<span class="label label-info">Active</span>':'<span class="label label-danger">Inactive</span>';
                    return product;
                }).filter((product)=>{

                    return product.product_units.find((unit)=>{
                        return unit.barcode === u.barcode;
                    }) !== undefined || u.barcode === ''

                });
            },
            prices(){
                return this.$store.state.products.prices;
            },
            units(){
                return this.$store.state.products.units;
            },
            categories(){
                return this.$store.state.products.categories.map((item)=>{
                    return { label:item.category_name, value: item.id };
                });
            },
            token(){
                return this.$store.state.token;
            },
            productName(){
                return (this.newProduct.brand_name +' '+ this.newProduct.product_description).toUpperCase();
            }
        }
    }
</script>
<style>
    div#units .form-control {
        padding: 2px;
        height: 25px;
    }
    div#units{
        font-size:12px;
    }
</style>