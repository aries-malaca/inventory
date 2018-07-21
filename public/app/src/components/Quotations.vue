<template>
    <div>
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title"> <i class="fa fa-inbox"></i> Quotations</h3>
                &nbsp;
                <button @click="showAddModal" v-if="gate(user,'quotations', 'add')" class="btn btn-success btn-sm">Add Quotation</button>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
                <data-table
                        :columns="quotationTable.columns"
                        :rows="quotations"
                        :paginate="true"
                        :onClick="quotationTable.rowClicked"
                        styleClass="table table-bordered table-hover table-striped">
                </data-table>
            </div>
            <!-- /.box-body -->
        </div>
        <div class="modal fade" id="add-quotation-modal" tabindex="1">
            <div class="modal-dialog modal-full">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title" v-if="newQuotation.id === 0">Add Quotation</h4>
                        <h4 class="modal-title" v-else>Edit Quotation</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Reference #:</label>
                                    <input type="text" class="form-control" placeholder="(Required, Unique)" v-model="newQuotation.reference_no"/>
                                </div>
                                <div class="form-group">
                                    <label>Client Name:</label>
                                    <input type="text" class="form-control" placeholder="(Required)" v-model="newQuotation.client_name"/>
                                </div>
                                <div class="form-group">
                                    <label>Address:</label>
                                    <input type="text" class="form-control" placeholder="(Optional)" v-model="newQuotation.client_address"/>
                                </div>
                                <div class="form-group">
                                    <label>Company:</label>
                                    <input type="text" class="form-control" placeholder="(Optional)" v-model="newQuotation.client_company"/>
                                </div>
                                <div class="form-group">
                                    <label>Tax Number:</label>
                                    <input type="text" class="form-control" placeholder="(Optional)" v-model="newQuotation.tax_number"/>
                                </div>
                                <div class="form-group">
                                    <label>Mobile:</label>
                                    <input type="text" class="form-control" placeholder="(Optional)" v-model="newQuotation.client_phone"/>
                                </div>
                                <div class="form-group">
                                    <label>Email:</label>
                                    <input type="text" class="form-control" placeholder="(Optional)" v-model="newQuotation.client_email"/>
                                </div>
                                <div class="form-group">
                                    <label>Notes:</label>
                                    <textarea rows="2" class="form-control" placeholder="(Optional)" v-model="newQuotation.notes"></textarea>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="row">
                                    <div class="col-md-2">
                                        <div class="form-group">
                                            <label>Input by:</label>
                                            <select class="form-control" v-model="input_by">
                                                <option value="name">Product Name</option>
                                                <option value="barcode">Barcode</option>  
                                            </select>
                                        </div>
                                    </div> 
                                    <div class="col-md-7" v-if="input_by==='name'">
                                        <div class="form-group">
                                            <label>Select Product</label>
                                            <vue-select v-model="selected_product" :options="product_selection"></vue-select>
                                        </div>
                                    </div>
                                    <div class="col-md-3" v-if="input_by==='name'">
                                        <div class="form-group" v-if="selected_product !== null && selected_product !== undefined">
                                            <label>Unit</label>
                                            <div class="input-group">
                                                <select class="form-control" v-model="selected_unit">
                                                    <option v-for="unit in unit_selection" v-bind:value="unit">{{ unit.unit_name }}</option>
                                                </select>
                                                <div class="input-group-btn">
                                                    <button type="button" class="btn btn-success" style="height: 28px;" @click="addItem(selected_product, selected_unit, false)">Add</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6" v-if="input_by==='barcode'">
                                        <div class="form-group">
                                            <label>Barcode (Scan)</label>
                                            <input type="text" v-model="barcode" @keypress="searchBarcode" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="col-md-3" v-if="input_by==='barcode' && barcode_result !== undefined">
                                        <span class="label label-info" v-if="barcode_result !== false">{{ barcode_result }}</span>
                                        <span class="label label-danger" v-else>Item Not Found!</span>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label>Price Category</label>
                                            <select class="form-control" v-model="price_category">
                                                <option v-for="price in prices" :value="price.id">{{ price.price_category_name }}</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label>VAT Status</label>
                                            <select class="form-control" v-model="with_vat">
                                                <option :value="true">W/ VAT</option>
                                                <option :value="false">W/O VAT</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <table class="table table-bordered table-condensed table-hover table-stripped">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Product</th>
                                            <th>Unit</th>
                                            <th style="width:80px">QTY</th>
                                            <th style="width:100px">Price</th>
                                            <th style="width:120px">Amount</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="item,x in newQuotation.items">
                                            <td>
                                                <button class="btn btn-danger btn-xs" @click="removeItem(x)">X</button>
                                            </td>
                                            <td>{{ item.product.product_name }}</td>
                                            <td>{{ item.unit.unit_name }}</td>
                                            <td>
                                                <input type="number" v-model="newQuotation.items[x].quantity" class="form-control"/>
                                            </td>
                                            <td>
                                                <input type="number" v-model="newQuotation.items[x].selling_price" class="form-control"/>
                                            </td>
                                            <td>
                                                <input type="number" disabled class="form-control"
                                                    v-bind:value="(newQuotation.items[x].quantity * newQuotation.items[x].selling_price).toFixed(2)" />
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-md-12">
                                        <h2 class="pull-right"> <strong style="color:red">Total: {{ total.toFixed(2) }} </strong> </h2>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn pull-left" data-dismiss="modal">Close</button>
                        <button class="btn btn-info">Print</button>
                        <button class="btn btn-success" v-if="newQuotation.id===0" @click="addQuotation">Save</button>
                        <button class="btn btn-success" v-else @click="updateQuotation">Save</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
    </div>
</template>
<script>
    import DataTable from './components/DataTable.vue';
    import VueSelect from 'vue-select';
    export default {
        name: 'Quotations',
        components:{ DataTable, VueSelect },
        data(){
            return{
                barcode:'',
                barcode_result:undefined,
                title:'Quotations',
                newQuotation:{},
                quotations:[],
                selected_product:null,
                price_category:undefined,
                with_vat:true,
                selected_unit:null,
                input_by:'name',
                quotationTable:{
                    columns: [
                        { label: 'Reference #', field: 'reference_no', filterable: true  },
                        { label: 'Client Name', field: 'client_name', filterable: true },
                        { label: 'Company', field: 'client_company', filterable: true },
                        { label: 'Date', field: 'quotation_date', filterable: true },
                        { label: 'Total', field: 'total', filterable: true },
                        { label: 'Notes', field: 'notes', filterable: true },
                        { label: 'Quoted By', field: 'quoted_by_name', filterable: true },
                    ],
                    rowClicked: this.viewQuotation,
                },
            }
        },
        methods:{
            addQuotation(event){
                this.makeRequest(event, this.newQuotation, '/api/quotations/addQuotation?token=' + this.token, "#add-quotation-modal");
            },
            updateQuotation(event){
                this.makeRequest(event, this.newQuotation, '/api/quotations/updateQuotation?token=' + this.token, "#add-quotation-modal");
            },
            makeRequest(event, data, url, modal){
                this.newQuotation.quotation_data = {
                    price_category:this.price_category,
                    with_vat:this.with_vat
                };

                let u = this;
                let $btn = $(event.target);
                $btn.button('loading');
                axios.post(url, data)
                    .then(function (response) {
                        toastr.success(response.data.message);
                        $(modal).modal("hide");
                        u.getQuotations();
                        $btn.button('reset');
                    })
                    .catch(function (error) {
                        $btn.button('reset');
                        XHRCatcher(error);
                    });
            },
            searchBarcode(event){
                let u = this;
                if(event.keyCode === 13){
                    this.products.forEach((product)=>{
                        product.product_units.forEach((unit)=>{
                            if(unit.barcode === u.barcode){
                                u.barcode = "";
                                u.barcode_result = product.product_name + " " + "("+ unit.unit_name +") - Found!";
                                u.addItem(product, unit, true);
                            }
                        });
                    });

                    if(u.barcode_result === undefined)
                        u.barcode_result = false;
                }
            },
            addItem(product, unit, add_to_existing){ 
                if(this.price_category === undefined){
                    toastr.error("Please select price category.");
                    return false;
                }

                let u = this;

                if(add_to_existing)
                    product.value = product.id;

                axios.get('/api/product/getProduct/' + product.value)
                    .then(function (response) {
                        var c = undefined;
                        u.newQuotation.items.forEach((item,key)=>{
                            if(item.unit.id === unit.id && item.product.id === product.value)
                                c = key;
                        });
                        
                        if(c !== undefined){
                            if(!add_to_existing){
                                toastr.error("Already in the list.");
                                return false;
                            }
                            else 
                                u.newQuotation.items[c].quantity ++;
                        }
                        else{ 
                            var price = u.getPrice(response.data, unit.id);
                            u.newQuotation.items.push({
                                product:response.data,
                                unit:unit,
                                base_price: price,
                                selling_price: price,
                                quantity:1,
                            });
                        }
                    });
            },
            getPrice(product, unit_id){
                console.log(unit_id);
                let u = this;
                var price = 0;
                product.product_units.forEach((unit)=>{
                    if(unit_id === unit.unit_id){
                        unit.pricing[0].selling.forEach((s)=>{
                            if(s.price_category_id === u.price_category){
                                if(u.with_vat)
                                    price = s.selling_price + (s.selling_price * (u.settings.default_vat_percentage/100))
                                else
                                    price = s.selling_price;
                            }    
                        });
                    }
                });

                return Math.round(price * 100) /100;
            },
            removeItem(index){
                this.newQuotation.items.splice(index, 1);
            },
            getQuotations(){
                let u = this;
                axios.get('/api/quotations/getQuotations')
                    .then(function (response) {
                        u.quotations = response.data;
                    })
                    .catch(function (error) {
                        XHRCatcher(error);
                    });
            },
            showAddModal(){
                this.newQuotation = {
                    id:0,
                    client_name:'',
                    tax_number:'',
                    client_address:'',
                    client_phone:'',
                    client_company:'',
                    reference_no:'',
                    client_email:'',
                    notes:'',
                    items:[],
                    quotation_data:{}
                };
                $("#add-quotation-modal").modal("show");
            },
            viewQuotation(quotation){
                let u = this;
                this.newQuotation = {
                    id:quotation.id,
                    client_name:quotation.client_name,
                    tax_number:quotation.tax_number,
                    client_address:quotation.client_address,
                    client_phone:quotation.client_phone,
                    client_company:quotation.client_company,
                    reference_no:quotation.reference_no,
                    client_email:quotation.client_email,
                    notes:quotation.notes,
                    items:[],
                    quotation_data:{
                        price_category:quotation.quotation_data.price_category,
                        with_vat:quotation.quotation_data.with_vat
                    }
                };
                this.price_category = quotation.quotation_data.price_category;
                this.with_vat = quotation.quotation_data.with_vat;
                quotation.items.forEach((item)=>{
                    u.newQuotation.items.push({
                        product: u.products.find((i)=>{
                            return i.id === item.product_id
                        }),
                        unit: u.units.find((i)=>{
                            return i.id === item.unit_id
                        }),
                        base_price: item.base_price,
                        selling_price: item.selling_price,
                        quantity:item.quantity,
                    });
                });

                $("#add-quotation-modal").modal("show");
            }
        },
        mounted:function(){
            this.$store.commit('updateTitle', this.title);
            this.getQuotations();
            this.$store.dispatch('products/fetchUnits');
        },
        computed:{
            settings(){
                return this.$store.state.settings;
            },
            user(){
                return this.$store.state.user;
            },
            token(){
                return this.$store.state.token;
            },
            products(){
                return this.$store.getters['products/activeProducts'];
            },
            product_selection(){
                let d = [];
                this.products.forEach((item)=>{
                    d.push({ label:item.product_name, value: item.id, units:item.product_units });
                });

                return d;
            },
            unit_selection(){
                if(this.selected_product !== null)
                    return this.selected_product.units;

                return [];
            },
            prices(){
                return this.$store.state.products.prices;
            },
            total(){
                var total = 0;
                if(this.newQuotation.items !== undefined)
                    this.newQuotation.items.forEach((item)=>{
                        total += (item.quantity * item.selling_price);
                    });

                return total;
            },
            units(){
                return this.$store.state.products.units;
            },
        },
        watch:{
            selected_product(){
                this.selected_unit = null;
                if(this.selected_product !== null)
                    this.selected_unit = this.selected_product.units[0];
            },
            barcode(){
                this.barcode_result = undefined;
            }
        }
    }
</script>
<style>
    .form-group{
        margin-bottom:6px !important;
    }
    .form-control{
        height: 28px !important;
        padding: 2px 10px;
    }
</style>