<template>
    <div class="box box-success">
        <div class="box-header with-border">
            <h3 class="box-title"><i class="fa fa-inbox"></i>Suppliers</h3>
            &nbsp;
            <button @click="showAddModal" class="btn btn-success btn-sm">Add Supplier</button>
        </div>
        <!-- /.box-header -->
        <div class="box-body">
            <data-table
                    :columns="supplierTable.columns"
                    :rows="suppliers"
                    :paginate="true"
                    :onClick="supplierTable.rowClicked"
                    styleClass="table table-bordered table-hover table-striped">
            </data-table>
        </div>
        <!-- /.box-body -->

        <div id="add-modal" class="modal fade" tabindex="-1" data-backdrop="static">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title" v-if="newSupplier.id==0">Add Supplier</h4>
                        <h4 class="modal-title" v-else>Update Supplier</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Supplier Name</label>
                                    <input type="text" v-model="newSupplier.supplier_name" class="form-control"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Supplier Address</label>
                                    <textarea v-model="newSupplier.supplier_address" class="form-control"></textarea>
                                </div>
                            </div>
                        </div>
                        <h4>Contact Information</h4>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Contact Person</label>
                                    <input type="text" v-model="newSupplier.supplier_contact_person" class="form-control"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Position</label>
                                    <input type="text" v-model="newSupplier.contact_person_designation" placeholder="Manager/Agent" class="form-control"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Telephone No.</label>
                                    <input type="text" v-model="newSupplier.supplier_telephone_no" class="form-control"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Mobile No.</label>
                                    <input type="text" v-model="newSupplier.supplier_mobile_no" class="form-control"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Fax</label>
                                    <input type="text" v-model="newSupplier.supplier_fax" class="form-control"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Email</label>
                                    <input type="text" v-model="newSupplier.supplier_email" class="form-control"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group" v-if="newSupplier.id!=0">
                                    <label>Status</label>
                                    <select v-model="newSupplier.is_active" class="form-control">
                                        <option value="1">Active</option>
                                        <option value="0">Inactive</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                        <button type="button" v-if="newSupplier.id==0" @click="addSupplier" data-loading-text="Saving..." class="btn btn-primary">Save</button>
                        <button type="button" v-else @click="updateSupplier" data-loading-text="Saving..." class="btn btn-primary">Save</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

    </div>
</template>
<script>
    import DataTable from './components/DataTable.vue';
    export default {
        name: 'Suppliers',
        components: { DataTable },
        data(){
            return{
                title:'Suppliers',
                supplierTable:{
                    columns: [
                        { label: 'ID', field: 'id' },
                        { label: 'Supplier Name', field: 'supplier_name', filterable: true },
                        { label: 'Address', field: 'supplier_address', filterable: true },
                        { label: 'Contact Info', field: 'supplier_contact_info', filterable: true },
                        { label: 'Contact Person', field: 'supplier_contact_person', filterable: true },
                        { label: 'Email', field: 'supplier_email', filterable: true },
                        { label: 'Status', field: 'status_html', html:true, filterable: true },
                    ],
                    rowClicked: this.viewSupplier,
                },
                newSupplier:{}
            }
        },
        methods:{
            showAddModal(){
                this.newSupplier = {
                    id:0,
                    supplier_name:'',
                    supplier_address:'',
                    supplier_contact_person:'',
                    supplier_email:'',
                    is_active:1,
                    contact_person_designation:'',
                    supplier_telephone_no:'',
                    supplier_mobile_no:'',
                    supplier_fax:'',
                };
                $("#add-modal").modal("show");
            },
            viewSupplier(supplier){
                this.newSupplier = {
                    id:supplier.id,
                    supplier_name:supplier.supplier_name,
                    supplier_address:supplier.supplier_address,
                    supplier_contact_person:supplier.supplier_contact_person,
                    supplier_email:supplier.supplier_email,
                    is_active:supplier.is_active,
                    contact_person_designation:supplier.contact_person_designation,
                    supplier_telephone_no:supplier.supplier_telephone_no,
                    supplier_mobile_no:supplier.supplier_mobile_no,
                    supplier_fax:supplier.supplier_fax
                };
                $("#add-modal").modal("show");
            },
            addSupplier(event){
                this.makeRequest(event, API_URL + '/api/supplier/addSupplier?token=' + this.token);
            },
            updateSupplier(event){
                this.makeRequest(event, API_URL + '/api/supplier/updateSupplier?token=' + this.token);
            },
            makeRequest(event, url){
                let u = this;
                let $btn = $(event.target);
                $btn.button('loading');
                axios.post(url, this.newSupplier)
                    .then(function (response) {
                        u.$store.dispatch('suppliers/fetchSuppliers');
                        toastr.success(response.data.message);
                        $("#add-modal").modal("hide");
                        $btn.button('reset');
                    })
                    .catch(function (error) {
                        $btn.button('reset');
                        XHRCatcher(error);
                    });
            }
        },
        mounted:function(){
            this.$store.commit('updateTitle', this.title);
            this.$store.dispatch('suppliers/fetchSuppliers');
        },
        computed:{
            suppliers(){
                return this.$store.state.suppliers.suppliers.map((supplier)=>{
                    supplier.status_html = supplier.is_active===1? '<span class="label label-info">Active</span>':'<span class="label label-danger">Inactive</span>';
                    return supplier;
                });
            },
            token(){
                return this.$store.state.token;
            }
        }
    }
</script>