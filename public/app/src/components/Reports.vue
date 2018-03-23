<template>

</template>
<script>
    export default {
        name: 'Reports',
        data(){
            return{
                title:'Reports'
            }
        },
        mounted:function(){
            this.$store.commit('updateTitle', this.title);
        }
    }
</script>