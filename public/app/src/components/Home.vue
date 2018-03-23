<template>
    <div>
        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-3">
                        <!-- small box -->
                        <div class="small-box bg-aqua">
                            <div class="inner">
                                <h3>0</h3>
                                <a style="color:white" href="../../#/transactions"><p>Today's Sales</p></a>
                            </div>
                            <div class="icon">
                                <i class="ion ion-bag"></i>
                            </div>
                        </div>
                    </div>
                    <!-- ./col -->
                    <div class="col-lg-3">
                        <!-- small box -->
                        <div class="small-box bg-yellow">
                            <div class="inner">
                                <h3>0</h3>
                                <a style="color:white" href="../../#/transactions"><p>Today's Purchases</p></a>
                            </div>
                            <div class="icon">
                                <i class="ion ion-person-add"></i>
                            </div>
                        </div>
                    </div>
                    <!-- ./col -->
                    <div class="col-lg-2">
                        <!-- small box -->
                        <div class="small-box bg-red">
                            <div class="inner">
                                <h3>{{ products.length }}</h3>
                                <a style="color:white" href="../../#/products"><p>Products</p></a>
                            </div>
                            <div class="icon">
                                <i class="ion ion-pie-graph"></i>
                            </div>
                        </div>
                    </div>
                    <!-- ./col -->
                    <div class="col-lg-2">
                        <!-- small box -->
                        <div class="small-box bg-green">
                            <div class="inner">
                                <h3>{{ clients.length }}</h3>
                                <a style="color:white" href="../../#/clients"><p>Clients</p></a>
                            </div>
                            <div class="icon">
                                <i class="ion ion-pie-graph"></i>
                            </div>
                        </div>
                    </div>
                    <!-- ./col -->
                    <div class="col-lg-2">
                        <!-- small box -->
                        <div class="small-box bg-blue">
                            <div class="inner">
                                <h3>{{ suppliers.length }}</h3>
                                <a style="color:white" href="../../#/suppliers"><p>Suppliers</p></a>
                            </div>
                            <div class="icon">
                                <i class="ion ion-pie-graph"></i>
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
        name: 'Home',
        data(){
            return{
                title:'Home'
            }
        },
        mounted(){
            this.$store.commit('updateTitle', this.title);
        },
        computed:{
            suppliers(){
                return this.$store.getters['suppliers/activeSuppliers'];
            },
            products(){
                return this.$store.getters['products/activeProducts'];
            },
            clients(){
                return this.$store.getters['clients/activeClients'];
            }
        }
    }
</script>