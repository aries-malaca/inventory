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
                                    <label>Mobile:</label>
                                    <input type="text" class="form-control" placeholder="(Optional)" v-model="newQuotation.client_mobile"/>
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
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <label>Select Product</label>
                                            <vue-select v-model="selected_product" :options="product_selection"></vue-select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>Unit</label>
                                            <vue-select v-model="selected_unit" :options="unit_selection"></vue-select>
                                        </div>
                                    </div>
                                </div>
                                <table class="table table-boredered table-hover table-stripped">
                                    <thead>
                                        <tr>
                                            <th>Product</th>
                                            <th>Unit</th>
                                            <th>Price</th>
                                            <th>QTY</th>
                                            <th>Amount</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn pull-left" data-dismiss="modal">Close</button>
                        <button class="btn btn-info">Print</button>
                        <button class="btn btn-success">Save</button>
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
                title:'Quotations',
                newQuotation:{},
                quotations:[],
                selected_product:null,
                selected_unit:null,
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
            addItem(product, unit){
                let c = this.newQuotation.items.find((item)=>{
                    return item.unit.id === unit.id && item.product.id === product.id;
                });

                if(c !== undefined){
                    toastr.error("Already in the list.");
                    return false;
                }


                let u = this;
                axios.get('/api/product/getProduct/' + id)
                    .then(function (response) {
                        u.newQuotation.items.push({
                            product:product,
                            unit:unit,
                            quantity:1,
                        });
                    });
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
                    client_address:'',
                    client_mobile:'',
                    client_company:'',
                    reference_no:'',
                    client_email:'',
                    notes:'',
                    items:[]
                };
                $("#add-quotation-modal").modal("show");
            },
            viewQuotation(quotation){
                $("#add-quotation-modal").modal("show");
            }
        },
        mounted:function(){
            this.$store.commit('updateTitle', this.title);
            this.getQuotations();
            this.$store.dispatch('products/fetchProducts');
        },
        computed:{
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
                let d = [];

                if(this.selected_product !== null)
                    this.selected_product.units.forEach((item)=>{
                        d.push({ label:item.unit_name, value: item.id});
                    });

                return d;
            }
        },
        watch:{
            selected_product(){
                this.selected_unit = null;
                if(this.selected_product !== null)
                    this.selected_unit = { label:this.selected_product.units[0].unit_name, value: this.selected_product.units[0].id}
            }
        }
    }
</script>
<style>
    .form-group{
        margin-bottom:6px !important;
    }
</style>