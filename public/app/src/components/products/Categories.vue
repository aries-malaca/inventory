<template>
    <div class="tab-pane" id="categories-tab" style="position: relative;">
        <div class="row">
            <div class="col-md-4">
                <div class="box box-success">
                    <div class="box-header with-border">
                        <h3 class="box-title">Product Categories</h3>
                        &nbsp;
                        <button @click="showAddCategoryModal" class="btn btn-success btn-sm">Add Category</button>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <data-table
                                :columns="categoryTable.columns"
                                :rows="categories"
                                :paginate="true"
                                :onClick="categoryTable.rowClicked"
                                styleClass="table table-bordered table-hover table-striped">
                        </data-table>
                    </div>
                    <!-- /.box-body -->
                </div>
            </div>
            <div class="col-md-4">
                <div class="box box-warning">
                    <div class="box-header with-border">
                        <h3 class="box-title">Price Categories</h3>
                        &nbsp;
                        <button @click="showAddPriceModal" class="btn btn-success btn-sm">Add Price Category</button>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <data-table
                                :columns="priceTable.columns"
                                :rows="prices"
                                :paginate="true"
                                :onClick="priceTable.rowClicked"
                                styleClass="table table-bordered table-hover table-striped">
                        </data-table>
                    </div>
                    <!-- /.box-body -->
                </div>
            </div>
            <div class="col-md-4">
                <div class="box box-warning">
                    <div class="box-header with-border">
                        <h3 class="box-title">Units</h3>
                        &nbsp;
                        <button @click="showAddUnitModal" class="btn btn-success btn-sm">Add Unit</button>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <data-table
                                :columns="unitTable.columns"
                                :rows="units"
                                :paginate="true"
                                :onClick="unitTable.rowClicked"
                                styleClass="table table-bordered table-hover table-striped">
                        </data-table>
                    </div>
                    <!-- /.box-body -->
                </div>
            </div>
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


        <div id="add-price-modal" class="modal fade" tabindex="-1" data-backdrop="static">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title" v-if="newPrice.id==0">Add Price Category</h4>
                        <h4 class="modal-title" v-else>Update Price Category</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>Price Category Name</label>
                                    <input type="text" v-model="newPrice.price_category_name" class="form-control"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Default Markup %</label>
                                    <input type="number" v-model="newPrice.default_markup" class="form-control"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Min. Purchase</label>
                                    <input type="number" v-model="newPrice.minimum_purchase" class="form-control"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                        <button type="button" v-if="newPrice.id==0" @click="addPrice($event)" class="btn btn-primary">Save</button>
                        <button type="button" v-else @click="updatePrice($event)" class="btn btn-primary">Update</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

        <div id="add-unit-modal" class="modal fade" tabindex="-1" data-backdrop="static">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title" v-if="newUnit.id==0">Add Unit</h4>
                        <h4 class="modal-title" v-else>Update Unit</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>Unit Name</label>
                                    <input type="text" v-model="newUnit.unit_name" class="form-control"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                        <button type="button" v-if="newUnit.id==0" @click="addUnit" class="btn btn-primary">Save</button>
                        <button type="button" v-else @click="updateUnit" class="btn btn-primary">Update</button>
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
    export default {
        name: 'Categories',
        components: { DataTable },
        data(){
            return{
                categoryTable:{
                    columns: [
                        { label: 'ID', field: 'id' },
                        { label: 'Category Name', field: 'category_name', filterable:true },
                    ],
                    rowClicked: this.viewCategory,
                },
                priceTable:{
                    columns: [
                        { label: 'ID', field: 'id' },
                        { label: 'Price Name', field: 'price_category_name', filterable:true  },
                        { label: 'Default Markup', field: 'default_markup_percent', filterable:true  },
                        { label: 'Min. Purchase', field: 'minimum_purchase_fixed', filterable:true  },
                    ],
                    rowClicked: this.viewPrice,
                },
                unitTable:{
                    columns: [
                        { label: 'ID', field: 'id' },
                        { label: 'Unit Name', field: 'unit_name', filterable:true },
                    ],
                    rowClicked: this.viewUnit,
                },
                newPrice:{},
                newCategory:{},
                newUnit:{}
            }
        },
        methods:{
            showAddCategoryModal(){
                this.newCategory ={
                    id:0,
                    category_name:''
                };
                $("#add-category-modal").modal("show");
            },
            showAddPriceModal(){
                this.newPrice ={
                    id:0,
                    price_category_name:'',
                    default_markup:5,
                    minimum_purchase:0
                };
                $("#add-price-modal").modal("show");
            },
            showAddUnitModal(){
                this.newUnit ={
                    id:0,
                    unit_name:''
                };
                $("#add-unit-modal").modal("show");
            },
            viewCategory(category){
                this.newCategory ={
                    id:category.id,
                    category_name:category.category_name
                };
                $("#add-category-modal").modal("show");
            },
            viewPrice(price){
                this.newPrice ={
                    id:price.id,
                    price_category_name:price.price_category_name,
                    default_markup:price.default_markup,
                    minimum_purchase:price.minimum_purchase
                };
                $("#add-price-modal").modal("show");
            },
            viewUnit(unit){
                this.newUnit ={
                    id:unit.id,
                    unit_name:unit.unit_name
                };
                $("#add-unit-modal").modal("show");
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
            addCategory(event){
                this.makeRequest(event, this.newCategory, API_URL + '/api/product/addCategory?token=' + this.token, "#add-category-modal", 'fetchCategories');
            },
            updateCategory(event){
                this.makeRequest(event, this.newCategory, API_URL + '/api/product/updateCategory?token=' + this.token, "#add-category-modal", 'fetchCategories');
            },
            addPrice(event){
                this.makeRequest(event, this.newPrice, API_URL + '/api/product/addPrice?token=' + this.token, "#add-price-modal", 'fetchPrices');
            },
            updatePrice(event){
                this.makeRequest(event, this.newPrice, API_URL + '/api/product/updatePrice?token=' + this.token, "#add-price-modal", 'fetchPrices');
            },
            addUnit(event){
                this.makeRequest(event, this.newUnit, API_URL + '/api/product/addUnit?token=' + this.token, "#add-unit-modal", 'fetchUnits');
            },
            updateUnit(event){
                this.makeRequest(event, this.newUnit, API_URL + '/api/product/updateUnit?token=' + this.token, "#add-unit-modal", 'fetchUnits');
            }
        },
        computed:{
            categories(){
                return this.$store.state.products.categories;
            },
            units(){
                return this.$store.state.products.units;
            },
            prices(){
                return this.$store.state.products.prices.map((price)=>{
                    price.default_markup_percent = price.default_markup + '%';
                    price.minimum_purchase_fixed = price.minimum_purchase.toFixed(2);
                    return price;
                });
            },
            token(){
                return this.$store.state.token;
            }
        }
    }
</script>