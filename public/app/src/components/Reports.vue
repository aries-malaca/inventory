<template>
    <div>
        <div v-if="gate(user, 'reports', 'view')">

        </div>
        <unauthorized v-else></unauthorized>
    </div>
</template>
<script>
    import Unauthorized from './errors/Unauthorized.vue';
    export default {
        name: 'Reports',
        components:{ Unauthorized },
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