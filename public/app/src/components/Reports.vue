<template>
    <div>
        <div class="nav-tabs-custom" v-if="gate(user, 'reports', 'view')">
            <!-- Tabs within a box -->
            <ul class="nav nav-tabs pull-right">
                <li class="active" v-if="gate(user, 'reports', 'product_reports')"><a href="#product-reports-tab" data-toggle="tab" aria-expanded="true">Product Reports</a></li>
                <li v-if="gate(user, 'reports', 'accounting_reports')"><a href="#accounting-reports-tab" data-toggle="tab" aria-expanded="false">Accounting Reports</a></li>
                <li class="pull-left header"><i class="fa fa-inbox"></i> {{ title }}</li>
            </ul>
            <div class="tab-content no-padding">
                <product-reports></product-reports>
            </div>
        </div>
        <unauthorized v-else></unauthorized>
    </div>
</template>
<script>
    import Unauthorized from './errors/Unauthorized.vue';
    import ProductReports from './reports/ProductReports.vue';
    export default {
        name: 'Reports',
        components:{ Unauthorized, ProductReports },
        data(){
            return{
                title:'Reports'
            }
        },
        mounted:function(){
            this.$store.commit('updateTitle', this.title);
        },
        computed:{
            user(){
                return this.$store.state.user;
            }
        }
    }
</script>