<template>
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-5">
                    <ul class="list-group list-group-unbordered">
                        <li class="list-group-item">
                            <b>Product Code</b> <a class="pull-right">{{ product.product_code }}</a>
                        </li>
                        <li class="list-group-item">
                            <b>Product Brand</b> <a class="pull-right">{{ product.brand_name }}</a>
                        </li>
                        <li class="list-group-item">
                            <b>Description</b> <a class="pull-right">{{ product.product_description }}</a>
                        </li>
                        <li class="list-group-item">
                            <b>Size</b> <a class="pull-right">{{ product.size }}</a>
                        </li>
                        <li class="list-group-item">
                            <b>Status</b>
                            <a class="pull-right">
                                <span v-if="product.is_active===1">
                                    <span class="label label-info">Active</span>
                                </span>
                                <span v-else>
                                    <span class="label label-danger">Inactive</span>
                                </span>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="col-md-2"></div>
                <div class="col-md-4">
                    <!-- Product Image -->
                        <img class="img-responsive" :src="product.pictures_data!==[0]?'images/products/' + product.pictures_data: 'images/products/no-image.jpg'" alt="Product Image">
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <h4>Product Units and Pricing</h4>
                    <table class="table table-condensed table-bordered table-hover">
                        <tr>
                            <th>Unit</th>
                            <th>Bar Code</th>
                            <th>Qty</th>
                            <th>Purchase Price</th>
                            <th></th>
                        </tr>
                        <tr>
                            <td>{{product.unit}}</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                                <table class="table table-condensed table-bordered table-hover" style="margin-bottom:0px">
                                    <thead>
                                        <tr>                                                                           
                                            <th rowspan="2" style="width:120px;"></th>
                                            <th colspan="2" style="text-align:center">Markup</th>
                                            <th colspan="2" style="text-align:center">Selling</th>
                                        </tr>
                                        <tr>          
                                            <th>Percentage</th>
                                            <th>Amount</th>
                                            <th>W/O Vat</th>
                                            <th>W/ Vat</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
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