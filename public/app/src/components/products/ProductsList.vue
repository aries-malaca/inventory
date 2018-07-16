<template>
    <div class="tab-pane active" id="products-tab" style="position: relative;">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">Product List</h3>
                &nbsp;
                <button @click="showAddModal" v-if="gate(user,'products', 'add')" class="btn btn-success btn-sm">Add Product</button>
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
                        <button type="button" class="close" @click="closeModal" v-if="newProduct.id===0 && !is_viewing">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <button type="button" v-else class="close" data-dismiss="modal" aria-label="close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <div v-if="!is_viewing">
                            <h4 class="modal-title" v-if="newProduct.id===0">Add Product</h4>
                            <h4 class="modal-title" v-else>Update Product</h4>
                        </div>
                        <h4 class="modal-title" v-else>{{ productName }}</h4>
                    </div>
                    <div class="modal-body" v-if="!is_viewing" @mouseover="addModalOpenClass">
                        <div class="nav-tabs-custom">
                            <ul class="nav nav-tabs pull-right">
                                <li class=""><a href="#units" data-toggle="tab" aria-expanded="true">Units & Pricing</a></li>
                                <li class="active"><a href="#info" data-toggle="tab" aria-expanded="false">Product Info</a></li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="info">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>Product Code</label>
                                                <input type="text" placeholder="(Required,Unique)" class="form-control" v-model="newProduct.product_code"/>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>Brand</label>
                                                <input type="text" placeholder="(Optional)" class="form-control" v-model="newProduct.brand_name"/>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Description</label>
                                                <input type="text" placeholder="(Required)" class="form-control" v-model="newProduct.product_description"/>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label>Product Size</label>
                                                <input type="text" class="form-control" v-model="newProduct.size"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Product Name</label>
                                                <input type="text" placeholder="(Optional)" class="form-control" disabled :value="productName"/>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Category</label>
                                                <vue-select v-model="newProduct.category" :options="categories"></vue-select>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label>Status</label>
                                                <select v-model="newProduct.is_active" class="form-control">
                                                    <option value="1">Active</option>
                                                    <option value="0">Inactive</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div>
                                        <h4>Pictures</h4>
                                        <div class="row">
                                            <div class="col-md-3" v-for="(pic,key) in newProduct.pictures_data">
                                                <ul class="list-unstyled profile-nav" style="margin-top:5px">
                                                    <li>
                                                        <img v-bind:src="'images/products/'+ pic" v-if="newProduct.id!==0"
                                                             class="img-responsive pic-bordered" alt="" />
                                                        <img v-else v-bind:src="'images/temp/'+ pic"
                                                             class="img-responsive pic-bordered" alt="" />
                                                        <div>
                                                            <a @click="showUploadModal(key)" class="profile-edit"> <i class="fa fa-pencil"></i> </a>
                                                            <a @click="removePicture(key,pic)" style="margin-top:30px" class="profile-edit"> <i class="fa fa-close"></i> </a>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="col-md-3">
                                                <button class="btn btn-success" @click="showUploadModal(newProduct.pictures_data.length)">Add Photo</button>
                                            </div>
                                        </div>
                                        <div v-for="(pic, key) in newProduct.pictures_data">
                                            <uploader
                                                @refresh_host="viewProduct(newProduct)"
                                                category="product"
                                                :param_url="'product_id='+newProduct.id+'&key='+key"
                                                :placeholder_image="'images/products/'+newProduct.pictures_data[key]"
                                                :modal_id="'upload-picture-modal-'+key"
                                                :form_id="'upload-user-picture-form-'+key"
                                                :input_id="'file-'+key">
                                            </uploader>
                                        </div>
                                        <div v-if="newProduct.pictures_data !== undefined">
                                            <uploader
                                                @refresh_host="viewProduct(newProduct)"
                                                category="product"
                                                :param_url="'product_id='+newProduct.id+'&key='+(newProduct.pictures_data.length)"
                                                :placeholder_image="'images/products/'+newProduct.pictures_data[(newProduct.pictures_data.length)]"
                                                :modal_id="'upload-picture-modal-'+(newProduct.pictures_data.length)"
                                                :form_id="'upload-user-picture-form-'+(newProduct.pictures_data.length)"
                                                :input_id="'file-'+(newProduct.pictures_data.length)">
                                            </uploader>
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
                                                    <select :class="unit===null?'background-color: rgb(255, 136, 136);':''" class="form-control" v-model="newProduct.product_units[key].unit">
                                                        <option v-for="unit in units" :value="unit">{{ unit.unit_name }}</option>
                                                    </select>
                                                </td>
                                                <td>
                                                    <input type="text" class="form-control" placeholder="(Optional)" v-model="newProduct.product_units[key].info"/>
                                                </td>
                                                <td>
                                                    <input type="text" class="form-control" placeholder="(Optional)" v-model="newProduct.product_units[key].barcode"/>
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
                                                                <!--td style="width:40px;">
                                                                    <button class="btn btn-danger btn-xs" @click="removePurchasePrice(key,index)">X</button>
                                                                    <button class="btn btn-success btn-xs" @click="addPurchasePrice(key)" v-if="unit.pricing.length === (index+1)">+</button>
                                                                </td-->
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
                                                                                <th rowspan="2" style="width:120px;"></th>
                                                                                <th colspan="2" style="text-align:center">Markup</th>
                                                                                <th colspan="2" style="text-align:center">Selling</th>
                                                                            </tr>
                                                                            <tr>          
                                                                                <th>Percentage</th>
                                                                                <th>Amount</th>
                                                                                <th>W/O Vat</th>
                                                                                <th>W/ Vat</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <tr v-for="(s,x) in p.selling" :style="s.selling_price <= 0 || (((s.selling_price - p.purchase_price) / p.purchase_price) * 100) <= 0 ?'background-color:#FF8888':''">
                                                                                <td>{{ s.name }}</td>
                                                                                <td>
                                                                                    <input type="number" @change="mutateSellingPrice($event, key,index,x, 'percentage')"
                                                                                        class="form-control" :value="(((s.selling_price - p.purchase_price) / p.purchase_price) * 100).toFixed(2)" />
                                                                                </td>
                                                                                <td>
                                                                                    <input type="number" @change="mutateSellingPrice($event, key,index,x, 'amount')"
                                                                                        class="form-control" :value="(s.selling_price - p.purchase_price).toFixed(2)"/>
                                                                                </td>
                                                                                <td>
                                                                                    <input type="number" class="form-control" v-model.number="newProduct.product_units[key].pricing[index].selling[x].selling_price"/>
                                                                                </td>
                                                                                <td>
                                                                                    <input type="number" disabled class="form-control" 
                                                                                    v-bind:value="(s.selling_price + ((s.selling_price*settings.default_vat_percentage)/100)).toFixed(2) "/>
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
                            </div>
                            <!-- /.tab-content -->
                        </div>
                    </div>
                    <div class="modal-body" v-else>
                        <product-view :product="newProduct" v-if="newProduct.id !== undefined"></product-view>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left"  @click="closeModal" v-if="newProduct.id===0 && !is_viewing">Close</button>
                        <button type="button" class="btn btn-default pull-left" v-else data-dismiss="modal">Close</button>
                        <div v-if="!is_viewing">
                            <button type="button" v-if="newProduct.id===0" @click="addProduct" class="btn btn-primary">Save</button>
                            <button type="button" v-else @click="updateProduct" class="btn btn-primary">Update</button>
                            <button type="button" v-if="newProduct.id !== 0" @click="getProduct(newProduct.id)" class="btn btn-warning">Cancel</button>
                        </div>
                        <div v-else>
                            <button type="button" v-if="gate(user, 'products', 'update')" @click="is_viewing=false" class="btn btn-warning">Edit</button>
                        </div>
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
    import Uploader from "../modals/UploadPictureModalSmall.vue";
    import ProductView from "./ProductView.vue";
    import VueSelect from 'vue-select';

    export default {
        name: 'ProductsList',
        components:{ DataTable, VueSelect, Uploader, ProductView },
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
                newProduct:{},
                is_viewing:false,
            }
        },
        methods:{
            addModalOpenClass(){
                $("body").addClass("modal-open");
            },
            closeModal(){
                if(confirm("Are you sure you want to discard this dialog's data?")){
                    axios.get('/api/product/deleteTemporaryPictures?token=' + this.token)
                        .then(function () {
                            $("#add-modal").modal("hide");
                        });
                }
            },
            addProductUnit(){
                this.newProduct.product_units.push({
                    unit:null,
                    quantity_per_parent:0,
                    parent_unit_id:0,
                    info:'',
                    barcode:'',
                    pricing:[],
                    size:''
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
                    size:'',
                    product_name:'',
                    pictures_data:[],
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
                this.is_viewing = false;
                this.addPurchasePrice(0);
                $("#add-modal").modal("show");
            },
            viewProduct:function(product){
                if(product.id===0) {
                    this.newProduct.pictures_data.push(this.last_uploaded);
                    return false;
                }
                this.is_viewing = true;
                this.getProduct(product.id);
                this.addModalOpenClass();
            },
            getProduct(id){
                let u = this;
                this.is_viewing=true;
                $("#add-modal").modal("show");
                this.newProduct = {};
                axios.get('/api/product/getProduct/' + id)
                    .then(function (response) {
                        let cat = u.categories.find((i)=>{
                                return (response.data.category_id===i.value);
                            });
                        u.newProduct = {
                            id:response.data.id,
                            brand_name:response.data.brand_name,
                            product_code:response.data.product_code,
                            product_description:response.data.product_description,
                            size:response.data.size,
                            category:cat===undefined?null:cat,
                            product_units:[],
                            product_name:response.data.product_name,
                            pictures_data:response.data.pictures_data,
                            is_active:response.data.is_active,
                            size:response.data.size
                        };

                        for(var x=0;x<response.data.product_units.length;x++){
                            let unit = response.data.product_units[x];
                            u.newProduct.product_units.push({
                                unit:u.units.find((i)=>{
                                    return (unit.unit_id===i.id);
                                }),
                                quantity_per_parent:unit.quantity_per_parent,
                                parent_unit_id:unit.parent_unit_id,
                                info:unit.info,
                                barcode:unit.barcode,
                                pricing:[]
                            });

                            for(var y=0;y<unit.pricing.length;y++){
                                let price = unit.pricing[y];
                                u.newProduct.product_units[x].pricing.push({
                                    purchase_price:price.purchase_price,
                                    remarks:price.remarks,
                                    selling:[]
                                });

                                for(var z=0;z<price.selling.length;z++){
                                    let selling = price.selling[z];
                                    let category = u.prices.find((i)=>{
                                        return i.id===selling.price_category_id;
                                    });
                                    u.newProduct.product_units[x].pricing[y].selling.push({
                                        selling_price:selling.selling_price,
                                        price_category_id:selling.price_category_id,
                                        default_markup:category.default_markup,
                                        name:category.price_category_name
                                    });
                                }
                            }
                        }
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
                this.makeRequest(event, this.newProduct, API_URL + '/api/product/addProduct?token=' + this.token, "#add-modal", 'fetchProducts');
            },
            updateProduct:function(){
                this.makeRequest(event, this.newProduct, API_URL + '/api/product/updateProduct?token=' + this.token, "#add-modal",  'fetchProducts');
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
            mutateSellingPrice(event,key,index,x,type){
                if(type==='percentage'){
                    this.newProduct.product_units[key].pricing[index].selling[x].selling_price = 
                       this.newProduct.product_units[key].pricing[index].purchase_price + ((this.newProduct.product_units[key].pricing[index].purchase_price*Number(event.target.value))/100)  
                }
                else{
                    this.newProduct.product_units[key].pricing[index].selling[x].selling_price = 
                       Number(event.target.value) + this.newProduct.product_units[key].pricing[index].purchase_price;
                }
            },
            removePicture(key, name){
                if(name === 'no photo.jpg'){
                    this.newProduct.pictures_data.splice(key, 1);
                    return false;
                }
                if(confirm("Are you sure you want to delete this?")){
                    let u = this;
                    axios.post('/api/product/removePicture?token=' + this.token, {product_id:this.newProduct.id, key: key})
                    .then(function (response) {
                        toastr.success(response.data.message);

                        if(u.newProduct.id !== 0)
                            u.viewProduct(u.newProduct);
                        else
                            u.newProduct.pictures_data.splice(key,1);
                    })
                    .catch(function (error) {
                        XHRCatcher(error);
                    });
                }
            },
            showUploadModal:function (key) {
                $("#upload-picture-modal-"+key).modal("show");
                try{
                    $("form")[key].reset();
                }
                catch(error){}
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
            settings(){
                return this.$store.state.settings;
            },
            productName(){
                return (this.newProduct.brand_name +' '+ this.newProduct.product_description +' '+ this.newProduct.size + ' ' + this.newProduct.product_code ).toUpperCase();
            },
            last_uploaded(){
                return this.$store.state.products.last_uploaded_file;
            },
            user(){
                return this.$store.state.user;
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
    .modal-open {
        overflow: scroll;
    }
</style>