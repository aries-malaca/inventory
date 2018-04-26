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
                </div>
            </div>
        </div>

        <div id="category-modal" class="modal fade" tabindex="-1" data-backdrop="static">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title">View Category</h4>
                    </div>
                    <div class="modal-body">

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
    export default {
        name: 'ProductInquiryDashboard',
        components:{ DataTable },
        data(){
            return{
                categoryTable:{
                    columns: [
                        { label: 'Category Name', field: 'category_name', filterable:true },
                        { label: 'Product Count', field: 'count', filterable:true },
                    ],
                    rowClicked: this.viewCategory,
                },
            }
        },
        methods:{
            viewCategory(category){
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
            }
        }
    }
</script>