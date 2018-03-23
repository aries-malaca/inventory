<template>

</template>
<script>
    export default {
        name: 'Branches',
        data(){
            return{
                title:'Branches'
            }
        },
        mounted:function(){
            this.$store.commit('updateTitle', this.title);
        }
    }
</script>