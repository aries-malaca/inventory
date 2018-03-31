<template>
    <div>
        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-lg-3">
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
                    <div class="col-lg-3">
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
            </div>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'AccountingSystemDashboard',
        data(){
            return{
            }
        },
        computed:{
            products(){
                return this.$store.getters['products/activeProducts'];
            },
            users(){
                return this.$store.getters['users/activeUsers'];
            }
        }
    }
</script>