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
                    <img class="img-responsive" :src="'images/products/' + product.pictures_data[0]" alt="Product Image">
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <h4>Product Units and Pricing</h4>
                    <table class="table table-condensed table-bordered table-hover" v-for="(unit, key) in product.product_units">
                        <tr>
                            <th style="width:10%">Unit #{{ key+1 }}</th>
                            <th style="width:10%">Bar Code</th>
                            <th style="width:10%">
                                <span v-if="key>0">
                                    <span v-if="product.unit!==null">
                                        {{ unit.unit.unit_name }}
                                    </span>
                                    <span v-else>Qty</span>
                                    per {{ product.product_units[key-1].unit.unit_name }}
                                </span>
                                <span v-else>Qty</span>
                            </th>   
                            <th style="width:10%">Purchase Price</th>
                            <th></th>
                        </tr>
                        <tr>
                            <td>
                                {{ product.product_units[key].unit.unit_name }}
                            </td>
                            <td>
                                {{product.product_units[key].barcode}}
                            </td>
                            <td>
                                {{ product.product_units[key].quantity_per_parent }}
                            </td>
                            <td v-if="product.product_units[key].pricing !== undefined">
                                {{ product.product_units[key].pricing[0].purchase_price.toFixed(2) }}
                            </td>
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
                                    <tbody v-if="product.product_units[key].pricing !== undefined">
                                        <tr v-for="s in product.product_units[key].pricing[0].selling">
                                            <td>{{ s.name }}</td>
                                            <td>{{ (((s.selling_price - product.product_units[key].pricing[0].purchase_price) / product.product_units[key].pricing[0].purchase_price) * 100).toFixed(2) }}</td>
                                            <td>{{ (s.selling_price - product.product_units[key].pricing[0].purchase_price).toFixed(2) }}</td>
                                            <td>{{ s.selling_price.toFixed(2) }}</td>
                                            <td>{{ (s.selling_price + ((s.selling_price*settings.default_vat_percentage)/100)).toFixed(2) }}</td>
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

    },
    computed:{
        user(){
            return this.$store.state.user;
        },
        settings(){
            return this.$store.state.settings;
        },
    }
}
</script>