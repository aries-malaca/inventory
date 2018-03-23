<template>

</template>
<script>
    export default {
        name: 'Transactions',
        data(){
            return{
                title:'Transactions'
            }
        },
        mounted:function(){
            this.$store.commit('updateTitle', this.title);
        }
    }
</script>