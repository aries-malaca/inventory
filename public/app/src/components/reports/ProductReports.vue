<template>
    <div class="tab-pane active" id="product-reports-tab" style="position: relative;">
        <div class="row">
            <div class="col-md-5">
                <div class="form-group">
                    <label>Category:</label>
                    <vue-select multiple :options="categories" v-model="newReport.categories"></vue-select>
                </div>
            </div>
            <div class="col-md-5">
                <div class="form-group">
                    <label>Brand:</label>
                    <vue-select multiple :options="brands" v-model="newReport.brands"></vue-select>
                </div>
            </div>
            <div class="col-md-2">
                <div class="form-group">
                    <label>Selling Price:</label>
                    <select v-model="newReport.selling_price" class="form-control">
                        <option v-for="price in prices" :value="price.id">{{ price.price_category_name }}</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <label>Display Fields:</label>
                <div class="row">
                    <div class="col-md-6">
                        <div class="checkbox"><label><input type="checkbox" v-model="newReport.display_purchase_price"/> Purchase Price</label></div>
                        <div class="checkbox"><label><input type="checkbox" v-model="newReport.show_picture"/> Show Picture</label></div>
                    </div>
                    <div class="col-md-6">
                        <div class="checkbox"><label><input type="checkbox" v-model="newReport.display_vat_price"/> VAT Price</label></div>
                    </div>
                </div>
            </div>
            <div class="col-md-2">
                <div class="form-group">
                    <label>Report Format:</label>
                    <select v-model="newReport.format" class="form-control">
                        <option value="pdf">PDF</option>
                        <option value="xlsx">EXCEL</option>
                    </select>
                </div>
            </div>
            <div class="col-md-2">
                <div class="form-group">
                    <label>Sort By:</label>
                    <select v-model="newReport.sort_by" class="form-control">
                        <option value="product_name">Product Name</option>
                        <option value="brand_name">Brand</option>
                        <option value="category_name">Category</option>
                    </select>
                </div>
            </div>
            <div class="col-md-2">
                <div class="form-group">
                    <label>Sort Order:</label>
                    <select v-model="newReport.sort_order" class="form-control">
                        <option value="ASC">Ascending</option>
                        <option value="DESC">Descending</option>
                    </select>
                </div>
            </div>
            <div class="col-md-2">
                <button class="btn btn-success pull-right" @click="generateReport($event)">Generate</button>
            </div>
        </div>

        <div id="product-report-modal" class="modal fade" tabindex="-1" data-backdrop="static">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title">Generated Report</h4>
                    </div>
                    <div class="modal-body">
                        <a class="btn btn-lg btn-success btn-block" :href="'../../' + download_link" target="_blank">View Generated</a>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

    </div>
</template>
<script>
    import VueSelect from 'vue-select';
    export default {
        name: 'ProductReports',
        components:{ VueSelect },
        data(){
            return{
                newReport:{
                    categories:null,
                    brands:null,
                    selling_price:0,
                    format:'pdf',
                    show_picture:false,
                    type:'product_report',
                    display_purchase_price:false,
                    display_vat_price:false,
                    sort_by:'product_name',
                    sort_order:'ASC'
                },
                download_link:false
            }
        },
        methods:{
            generateReport(event){
                let u = this;
                let $btn = $(event.target);
                this.download_link = false;
                $btn.button('loading');
                axios.post('/api/reports/generateReport', this.newReport)
                    .then(function (response) {
                        u.download_link = response.data.path;
                        $btn.button('reset');
                        $("#product-report-modal").modal("show");
                    })
                    .catch(function (error) {
                        $btn.button('reset');
                        XHRCatcher(error);
                    });
            }
        },
        computed:{
            categories(){
                var d = [];
                d.push({ label:"All", value: 0});

                this.$store.state.products.categories.forEach((item)=>{
                    d.push({ label:item.category_name, value: item.id });
                });

                return d;
            },
            brands(){
                var d = ["All"];
                this.products.forEach((item)=>{
                    if(d.indexOf(item.brand_name) === -1)
                        d.push(item.brand_name);
                });
                return d;
            },
            prices(){
                return this.$store.state.products.prices;
            },
            token(){
                return this.$store.state.token;
            },
            products(){
                return this.$store.getters['products/activeProducts'];
            }
        },
        mounted(){

        }
    }
</script>