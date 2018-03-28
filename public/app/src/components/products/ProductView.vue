<template>
    <div class="row">
        <div class="col-md-5">
            <h4 class="username text-left">{{ product.product_name }}</h4>
            <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                    <b>Product Code</b> <a class="pull-right">{{ product.product_code }}</a>
                </li>
                <li class="list-group-item">
                    <b>Status</b>
                    <a class="pull-right">
                        <span v-if="product.is_active===1">
                           Active
                        </span>
                        <span v-else>
                           Inactive
                        </span>
                    </a>
                </li>
            </ul>
        </div>
        <div class="col-md-2"></div>
        <div class="col-md-4">
            <!-- Profile Image -->
            <div class="box-body box-profile">
                <span v-if="product.pictures_data === 'k'">
                    <img class="img-responsive" :src="'images/products/no-image.jpg'" alt="Product Image">
                </span>
                <span v-else>
                    <img class="img-responsive" :src="'images/products/' + product.pictures_data" alt="Product Image">
                </span>
            </div>
            <!-- /.box-body -->
        </div>
        <!-- /.box -->
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