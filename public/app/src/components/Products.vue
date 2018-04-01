<template>
    <div>
        <div class="nav-tabs-custom" v-if="gate(user,'products','view')">
            <!-- Tabs within a box -->
            <ul class="nav nav-tabs pull-right">
                <li><a href="#categories-tab" data-toggle="tab" aria-expanded="true">Prices, Categories, Units</a></li>
                <li class="active"><a href="#products-tab" data-toggle="tab" aria-expanded="false">Product List</a></li>
                <li class="pull-left header"><i class="fa fa-inbox"></i> {{ title }}</li>
            </ul>
            <div class="tab-content no-padding">
                <products-list></products-list>
                <categories></categories>
            </div>
        </div>
        <unauthorized v-else></unauthorized>
    </div>
</template>
<script>
    import ProductsList from './products/ProductsList.vue';
    import Categories from './products/Categories.vue';
    import Unauthorized from './errors/Unauthorized.vue';
    export default {
        name: 'Products',
        components:{ ProductsList, Categories, Unauthorized },
        data(){
            return{
                title:'Products'
            }
        },
        mounted(){
            this.$store.commit('updateTitle', this.title);
            this.$store.dispatch('products/fetchProducts');
            this.$store.dispatch('products/fetchPrices');
            this.$store.dispatch('products/fetchCategories');
            this.$store.dispatch('products/fetchUnits');
        },
        computed:{
            user(){
                return this.$store.state.user;
            }
        }
    }
</script>