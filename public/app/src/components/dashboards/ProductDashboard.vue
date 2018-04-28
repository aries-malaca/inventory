<template>
    <div>
        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-lg-4">
                        <!-- small box -->
                        <div class="small-box bg-red">
                            <div class="inner">
                                <h3>{{ products.length }}</h3>
                                <a style="color:white" href="../../#/products"><p>Products</p></a>
                            </div>
                            <div class="icon">
                                <i class="fa fa-shopping-cart"></i>
                            </div>
                        </div>
                    </div>
                    <!-- ./col -->
                    <div class="col-lg-4">
                        <!-- small box -->
                        <div class="small-box bg-yellow">
                            <div class="inner">
                                <h3>{{ categories.length }}</h3>
                                <a style="color:white" href="#"><p>Categories</p></a>
                            </div>
                            <div class="icon">
                                <i class="fa fa-grid"></i>
                            </div>
                        </div>
                    </div>
                    <!-- ./col -->
                    <div class="col-lg-4">
                        <!-- small box -->
                        <div class="small-box bg-green">
                            <div class="inner">
                                <h3>{{ users.length }}</h3>
                                <a style="color:white" href="#"><p>Users</p></a>
                            </div>
                            <div class="icon">
                                <i class="fa fa-users"></i>
                            </div>
                        </div>
                    </div>
                    <!-- ./col -->
                </div>
                <!-- /.row -->
                <div class="row">
                    <div class="col-md-6">
                        <data-table
                                :columns="categoryTable.columns"
                                :rows="categories"
                                :paginate="true"
                                :onClick="categoryTable.rowClicked"
                                styleClass="table table-bordered table-hover table-striped">
                        </data-table>
                    </div>
                    <div class="col-md-6">
                        <sample :datasets="datasets" :labels="labels"></sample>
                    </div>
                </div>
            </div>
        </div>

        <div id="category-modal" class="modal fade" tabindex="-1" data-backdrop="static">
            <div class="modal-dialog">
                <div class="modal-content" v-if="selectedCategory !== undefined">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title">{{ selectedCategory.category_name }}</h4>
                    </div>
                    <div class="modal-body">
                        <data-table
                                :columns="productTable.columns"
                                :rows="selectedCategory.products"
                                :paginate="true"
                                styleClass="table table-bordered table-hover table-striped">
                        </data-table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
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
    import Sample from '../charts/Sample.vue';
    export default {
        name: 'ProductInquiryDashboard',
        components:{ DataTable, Sample },
        data(){
            return{
                selectedCategory:undefined,
                categoryTable:{
                    columns: [
                        { label: 'Category Name', field: 'category_name', filterable:true },
                        { label: 'Product Count', field: 'count', filterable:true },
                    ],
                    rowClicked: this.viewCategory,
                },
                productTable:{
                    columns: [
                        { label: 'Product Code', field: 'product_code', filterable:true },
                        { label: 'Product Name', field: 'product_name', filterable:true },
                    ]
                },
            }
        },
        methods:{
            viewCategory(category){
                this.selectedCategory = category;
                $("#category-modal").modal("show");
            },
        },
        computed:{
            products(){
                return this.$store.getters['products/activeProducts'];
            },
            categories(){
                let u = this;
                return this.$store.state.products.categories.map((item)=>{
                    item.products = function(){
                        return u.products.filter((product)=>{
                            return (product.category_id===item.id)
                        });
                    }();
                    item.count = item.products.length;
                    return item;
                });
            },
            users(){
                return this.$store.getters['users/activeUsers'];
            },
            labels(){
                var labels = [];
                this.categories.forEach((item)=>{
                    labels.push(item.category_name);
                });
                return labels;
            },
            datasets(){
                return [
                    {
                        data: this.categories.map((item)=>{
                            return item.count;
                        }),
                        backgroundColor: this.categories.map((item)=>{
                            return function(){
                                var letters = '0123456789ABCDEF';
                                var color = '#';
                                for (var i = 0; i < 6; i++) {
                                    color += letters[Math.floor(Math.random() * 16)];
                                }
                                return color;
                            }();
                        }),
                    }
                ]
            }
        }
    }
</script>