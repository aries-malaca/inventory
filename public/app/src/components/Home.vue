<template>
    <div>
        <div v-if="user.level_data !== undefined">
            <product-dashboard  v-if="user.level_data.dashboard==='ProductDashboard'"></product-dashboard>
            <accounting-dashboard  v-if="user.level_data.dashboard==='AccountingDashboard'"></accounting-dashboard>
        </div>
    </div>
</template>
<script>
    import ProductDashboard from './dashboards/ProductDashboard.vue';
    import AccountingDashboard from './dashboards/AccountingDashboard.vue';
    export default {
        name: 'Home',
        components:{ ProductDashboard, AccountingDashboard },
        data(){
            return{
                title:'Home'
            }
        },
        mounted(){
            this.$store.commit('updateTitle', this.title);
        },
        computed:{
            user(){
                return this.$store.state.user;
            }
        }
    }
</script>