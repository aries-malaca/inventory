<template>
    <div>
        <div class="row">
            <div class="col-md-6">
                <sample></sample>
            </div>
            <div class="col-md-6"></div>
        </div>
    </div>
</template>
<script>
    import Sample from '../charts/Sample.vue';
    export default {
        name: 'AccountingSystemDashboard',
        components:{ Sample },
        data(){
            return{
            }
        }
    }
</script>