<input type="text" v-model="search" placeholder="Search / Barcode" 
    @keypress="searchProduct(search, $event)" class="form-control" />
<div style="height:600px; overflow-y:scroll">
    <table class="table no-margin table-bordered table-hover">
        <tr v-for="(product,key) in product_search" v-if="product.is_active == 1">
            <td>
                <a target="_blank" href="../../products">
                @{{ product.brand_name }}  
                @{{ product.product_description}}
                </a>
            </td>
            <td style="width:90px">
                <input type="number" placeholder="0" class="form-control">
            </td>
            <td style="width:100px">
                <select class="form-control">
                    <option v-bind:value="unit.unit" v-for="unit in product.units">@{{ unit.name }}</option>
                </select>
            </td>
            <td>
                <button class="btn btn-info btn-sm" @click="addItem(product,$event)">Add</button>
            </td>
        </tr>
    </table>
</div>