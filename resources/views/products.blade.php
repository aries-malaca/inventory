@extends('layouts.app')

@section('content')
<div id="products" v-cloak>
    <div class="row">
        <div class="col-md-12">
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">Product List</h3>
                    &nbsp;
                    <button @click="showAddModal('product')" class="btn btn-success btn-sm" v-if="authorize('products','add')">Add Product</button>      
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="table-responsive">
                        @include('pagination.header_0')
                        <label> Category:
                            <select class="form-control" v-model="filter_category">
                                <option value="0">All</option>
                                <option v-bind:value="category.id" v-for="category in categories">@{{ category.category_name }}</option>
                            </select>
                        </label>
                        <label>
                            <input type="checkbox" v-model="show_inactive"> Show Inactive
                        </label>
                        <table class="table no-margin">
                            <thead>
                                <tr>
                                    <th>
                                        <a href="javascript:;" @click="setOrderBy('product_code',0)">Product Code
                                        <span v-if="pagination[0].sort_by=='product_code'" >
                                            <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                            <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                        </span>
                                        </a>
                                    </th>
                                    <th>
                                        <a href="javascript:;" @click="setOrderBy('product_name',0)">Product Name
                                        <span v-if="pagination[0].sort_by=='product_name'" >
                                            <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                            <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                        </span>
                                        </a>
                                    </th>
                                    <th>
                                        <a href="javascript:;" @click="setOrderBy('category_name',0)">Category
                                        <span v-if="pagination[0].sort_by=='category_name'" >
                                            <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                            <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                        </span>
                                        </a>
                                    </th>
                                    <th>
                                        <a href="javascript:;" @click="setOrderBy('is_active',0)">Status
                                        <span v-if="pagination[0].sort_by=='is_active'" >
                                            <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                            <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                        </span>
                                        </a>
                                    </th>
                                    <th>
                                        <a href="javascript:;" @click="setOrderBy('stocks_message',0)">Stocks
                                        <span v-if="pagination[0].sort_by=='stocks_message'" >
                                            <i v-if="pagination[0].sort_order==-1" class="fa fa-angle-down pull-right"></i>
                                            <i v-if="pagination[0].sort_order==1" class="fa fa-angle-up pull-right"></i>
                                        </span>
                                        </a>
                                    </th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(product,key) in filtered">
                                    <td>@{{ product.product_code }}</td>
                                    <td>
                                        <a href="javascript:;" v-bind:style="product.has_wrong_price&&product.product_data.product_units.length>1?'color:red':''" @click="showProductInfo(product)">
                                            @{{ product.product_name }}
                                        </a>
                                    </td>
                                    <td>@{{ product.category_name }}</td>
                                    <td>
                                        <small class="label label-success" v-if="product.is_active == 1">Active</small>
                                        <small class="label label-danger" v-else>Inactive</small>
                                    </td>
                                    <td>
                                        <a href="javascript:;" @click="viewInventory(product)">@{{ product.stocks_message }}</a>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-info" @click="editProduct(product)" v-if="authorize('products','update')">Edit</button>
                                        <button class="btn btn-sm btn-warning" @click="cloneProduct(product)" v-if="authorize('products','add')">Clone</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        @include('pagination.footer_0')
                    </div>
                    <!-- /.table-responsive -->
                </div>
                <!-- /.box-body -->
            </div>
        </div>
        <!-- /.box -->
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="box box-success" v-if="authorize('category','view')">
                <div class="box-header with-border">
                    <h3 class="box-title">Product Categories</h3>
                    &nbsp;
                    <button @click="showAddModal('category')" class="btn btn-success btn-sm" v-if="authorize('category','add')">Add Category</button> 
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="table-responsive">
                        @include('pagination.header_1')
                        <table class="table no-margin">
                            <thead>
                                <tr>
                                    <th>Category Name</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(category,key) in filtered1">
                                    <td>@{{ category.category_name }}</td>
                                    <td>
                                        <button class="btn btn-sm btn-info" @click="editCategory(category)" v-if="authorize('category','update')">Edit</button>
                                        <button class="btn btn-sm btn-danger" @click="deleteCategory(category)" v-if="authorize('category','delete')">Delete</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        @include('pagination.footer_1')
                    </div>
                    <!-- /.table-responsive -->
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
        <div class="col-md-6">
            <div class="box box-danger" v-if="authorize('price_category','view')">
                <div class="box-header with-border">
                    <h3 class="box-title">Price Categories</h3>&nbsp;
                    <button @click="showAddModal('pricecategory')" class="btn btn-success btn-sm" v-if="authorize('price_category','add')">Add Price Category</button> 
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="table-responsive">
                        <table class="table no-margin">
                            <thead>
                                <tr>
                                    <th>Price Category</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(category,key) in price_categories">
                                    <td>@{{ category.price_category_name }}</td>
                                    <td>
                                        <button class="btn btn-sm btn-info" @click="editPriceCategory(category)" v-if="authorize('price_category','update')">Edit</button>
                                        <button class="btn btn-sm btn-danger" @click="deletePriceCategory(category)" v-if="authorize('price_category','delete')">Delete</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- /.table-responsive -->
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
    </div>
    @include('modals.products_add')
    @include('modals.products_info')
</div>

@push('scripts')
<script src="../../vuejs/components/Pagination.js"></script>
<script src="../../vuejs/instances/product.js"></script>
@endpush

@endsection