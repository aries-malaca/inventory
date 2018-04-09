<template>
    <div class="tab-pane active" id="product-reports-tab" style="position: relative;">
        <div class="row">
            <div class="col-md-5">
                <div class="form-group">
                    <label>Category:</label>
                    <vue-select multiple :options="categories" v-model="newReport.categories"></vue-select>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label>Selling Price:</label>
                    <select v-model="newReport.selling_price" class="form-control">
                        <option v-for="price in prices" :value="price.id">{{ price.price_category_name }}</option>
                    </select>
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
                    <label>Show Picture:</label>
                    <select v-model="newReport.show_picture" class="form-control">
                        <option :value="true">YES</option>
                        <option :value="false">NO</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-9">

            </div>
            <div class="col-md-3">
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
                    selling_price:0,
                    format:'pdf',
                    show_picture:false,
                    type:'product_report'
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
                var d = this.$store.state.products.categories.map((item)=>{
                    return { label:item.category_name, value: item.id };
                });
                d.push({ label:"All", value: 0});
                return d;
            },
            prices(){
                return this.$store.state.products.prices;
            },
            token(){
                return this.$store.state.token;
            },
        },
        mounted(){

        }
    }
</script>