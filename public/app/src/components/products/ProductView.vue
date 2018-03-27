<template>
    <div>
        <div class="row">
            <div class="col-md-6">
                <h3>Product Details</h3>
                Product Name : {{ product.product_name }}
            </div>
            <div class="col-md-6">
                <h3>Pictures</h3>
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