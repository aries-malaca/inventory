<template>

</template>
<script>
    export default {
        name: 'Profile',
        data(){
            return{
                title:'Profile'
            }
        },
        mounted:function(){
            this.$store.commit('updateTitle', this.title);
        }
    }
</script>