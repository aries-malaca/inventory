<template>
    <div class="box box-info">
        <div class="box-header with-border">
            <h3 class="box-title"><i class="fa fa-inbox"></i>Clients</h3>
            &nbsp;
            <button @click="showAddModal" class="btn btn-success btn-sm">Add Client</button>
        </div>
        <!-- /.box-header -->
        <div class="box-body">
            <data-table
                    :columns="clientTable.columns"
                    :rows="clients"
                    :paginate="true"
                    :onClick="clientTable.rowClicked"
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
                        <h4 class="modal-title" v-if="newClient.id==0">Add Client</h4>
                        <h4 class="modal-title" v-else>Update Client</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Client Name</label>
                                    <input type="text" v-model="newClient.client_name" class="form-control"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Client Address</label>
                                    <textarea v-model="newClient.client_address" class="form-control"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Company</label>
                                    <input type="text" v-model="newClient.client_company" class="form-control"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Email</label>
                                    <input type="text" v-model="newClient.client_email" class="form-control"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Contact Person</label>
                                    <input type="text" v-model="newClient.client_contact_person" class="form-control"/>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Contact Info</label>
                                    <input type="text" v-model="newClient.client_contact_info" class="form-control"/>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Position</label>
                                    <input type="text" v-model="newClient.contact_person_designation" placeholder="Manager/Agent" class="form-control"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Price Category</label>
                                    <select v-model="newClient.price_category_id" class="form-control">
                                        <option v-for="price in prices" v-bind:value="price.id">
                                            {{ price.price_category_name }}
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group" v-if="newClient.id!=0">
                                    <label>Status</label>
                                    <select v-model="newClient.is_active" class="form-control">
                                        <option value="1">Active</option>
                                        <option value="0">Inactive</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                        <button type="button" v-if="newClient.id==0" @click="addClient" data-loading-text="Saving..." class="btn btn-primary">Save</button>
                        <button type="button" v-else @click="updateClient" data-loading-text="Saving..." class="btn btn-primary">Save</button>
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
        name: 'Clients',
        components: { DataTable },
        data(){
            return{
                title:'Clients',
                clientTable:{
                    columns: [
                        { label: 'ID', field: 'id' },
                        { label: 'Client Name', field: 'client_name', filterable: true },
                        { label: 'Address', field: 'client_address', filterable: true },
                        { label: 'Contact Info', field: 'client_contact_info', filterable: true },
                        { label: 'Contact Person', field: 'client_contact_person', filterable: true },
                        { label: 'Price Category', field: 'price_category_name', filterable: true },
                        { label: 'Status', field: 'status_html', html:true, filterable: true },
                    ],
                    rowClicked: this.viewClient,
                },
                newClient:{}
            }
        },
        methods:{
            makeRequest(event, url){
                let u = this;
                let $btn = $(event.target);
                $btn.button('loading');
                axios.post(url, this.newClient)
                    .then(function (response) {
                        u.$store.dispatch('clients/fetchClients');
                        toastr.success(response.data.message);
                        $("#add-modal").modal("hide");
                        $btn.button('reset');
                    })
                    .catch(function (error) {
                        $btn.button('reset');
                        XHRCatcher(error);
                    });
            },
            addClient(event){
                this.makeRequest(event, API_URL + '/api/client/addClient?token=' + this.token);
            },
            updateClient(event){
                this.makeRequest(event, API_URL + '/api/client/updateClient?token=' + this.token);
            },
            showAddModal(){
                this.newClient = {
                    id:0,
                        client_name:'',
                        client_address:'',
                        client_company:'',
                        client_contact_person:'',
                        client_email:'',
                        client_contact_info:'',
                        price_category_id:0,
                        is_active:1,
                        contact_person_designation:''
                };
                $("#add-modal").modal("show");
            },
            viewClient(client){
                this.newClient = {
                    id:client.id,
                    client_name:client.client_name,
                    client_address:client.client_address,
                    client_company:client.client_company,
                    client_contact_person:client.client_contact_person,
                    client_email:client.client_email,
                    client_contact_info:client.client_contact_info,
                    price_category_id:client.price_category_id,
                    is_active:client.is_active,
                    contact_person_designation:client.contact_person_designation
                };
                $("#add-modal").modal("show");
            }
        },
        mounted:function(){
            this.$store.commit('updateTitle', this.title);
            this.$store.dispatch('clients/fetchClients');
            this.$store.dispatch('products/fetchPrices');
        },
        computed:{
            clients(){
                return this.$store.state.clients.clients.map((client)=>{
                    client.status_html = client.is_active===1? '<span class="label label-info">Active</span>':'<span class="label label-danger">Inactive</span>';
                    return client;
                });
            },
            prices(){
                return this.$store.state.products.prices;
            },
            token(){
                return this.$store.state.token;
            }
        }
    }
</script>