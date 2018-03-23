<template>
    <div class="nav-tabs-custom">
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
</template>
<script>
    import ProductsList from './products/ProductsList.vue';
    import Categories from './products/Categories.vue';
    export default {
        name: 'Products',
        components:{ ProductsList, Categories },
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
        }
    }
</script>