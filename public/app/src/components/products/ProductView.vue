<template>
    <div class="row">
        <div class="col-md-3">
            <div class="form-group">
                <label>Product Name</label>
                <div>{{ product.product_name }}</div>
            </div>
        </div>
    </div>  
</template>
<script>
export default {
    name: 'ProductView',
    props: ['product'],
    data() {
        return{
        }
    },
    methods:{

    }
}
</script>