<template>

</template>
<script>
    export default {
        name: 'Settings',
        data(){
            return{
                title:'Settings'
            }
        },
        mounted:function(){
            this.$store.commit('updateTitle', this.title);
        }
    }
</script>