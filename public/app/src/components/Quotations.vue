<template>
    <div>
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title"><i class="fa fa-inbox"></i>Quotations</h3>
                &nbsp;
                <button @click="showAddModal" v-if="gate(user,'quotations', 'add')" class="btn btn-success btn-sm">Add Quotation</button>
            </div>
            <!-- /.box-header -->
            <div class="box-body">

            </div>
            <!-- /.box-body -->
        </div>
        <div class="modal fade" id="add-quotation-modal" tabindex="1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title" v-if="newQuotation.id === 0">Add Quotation</h4>
                        <h4 class="modal-title" v-else>Edit Quotation</h4>
                    </div>
                    <div class="modal-body">

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn pull-left" data-dismiss="modal">Close</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
    </div>
</template>
<script>
    export default {
        name: 'Quotations',
        data(){
            return{
                title:'Quotations',
                newQuotation:{},
                quotations:[]
            }
        },
        methods:{
            getQuotations(){
                let u = this;
                axios.get('/api/quotations/getQuotations')
                    .then(function (response) {
                        u.quotations = response.data;
                    })
                    .catch(function (error) {
                        XHRCatcher(error);
                    });
            },
            showAddModal(){
                this.newQuotation = {
                    id:0
                };
                $("#add-quotation-modal").modal("show");
            }
        },
        mounted:function(){
            this.$store.commit('updateTitle', this.title);
            this.getQuotations();
        },
        computed:{
            user(){
                return this.$store.state.user;
            }
        }
    }
</script>