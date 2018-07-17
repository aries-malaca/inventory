<div class="row">
    <div class="col-md-6">
    <select v-model="add_category_id" multiple class="form-control">
        <option v-bind:value="category.id" v-for="category in categories">@{{ category.category_name }}</option>
    </select>
    </div>
    <div class="col-md-6">
        <button class="btn btn-info btn-sm" @click="addAll()">Add All with stocks</button>
        <button class="btn btn-danger btn-sm" @click="syncBeginning()">Sync Beginning Items</button>
    </div>
</div>
<br/>
<input type="text" v-model="search" placeholder="Search / Barcode" 
    @keypress="searchProduct(search, $event)" class="form-control" />
<div style="height:600px; overflow-y:scroll">
    <table class="table no-margin table-bordered table-hover">
        <tr v-for="(product,key) in product_search" v-if="product.is_active == 1">
            <td>
                @{{ product.category_name }}
            </td>
            <td style="width:360px">
                <a target="_blank" href="../../products">
                @{{ product.brand_name }}  
                @{{ product.product_description}}
                </a>
            </td>
            <td>
                <button class="btn btn-info btn-sm" @click="addItem(product)">Add</button>
            </td>
        </tr>
    </table>
</div>
