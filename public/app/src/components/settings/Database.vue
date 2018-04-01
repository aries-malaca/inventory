<template>
    <div class="tab-pane" id="database-tab" style="position: relative;">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">Database</h3>
                &nbsp;
                <button class="btn btn-success" v-if="gate(user, 'database', 'backup')" @click="runBackup">Backup Database</button>
            </div>
            <div class="box-body">
                <data-table
                        :columns="backupTable.columns"
                        :rows="backups"
                        :paginate="true"
                        :onClick="viewBackup"
                        styleClass="table table-bordered table-hover table-striped">
                </data-table>
                <div class="modal fade" id="backup-modal" tabindex="1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                <h4 class="modal-title">Backup File</h4>
                            </div>
                            <div class="modal-body">
                                <table class="table table-condensed table-hover table-bordered table-striped">
                                    <tbody>
                                        <tr>
                                            <th>Filename</th>
                                            <td>{{ newBackup.filename }}</td>
                                        </tr>
                                        <tr>
                                            <th>Size</th>
                                            <td>{{ newBackup.size }}</td>
                                        </tr>
                                        <tr>
                                            <th>Created</th>
                                            <td>{{ newBackup.created }}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" v-if="gate(user, 'database', 'backup')" @click="deleteBackup">Delete</button>
                                <button type="button" class="btn btn-success" v-if="gate(user, 'database', 'restore')" @click="restoreBackup">Restore</button>
                                <button type="button" class="btn pull-left" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import DataTable from '../components/DataTable.vue';
    export default{
        name:'Database',
        components:{ DataTable },
        data(){
            return{
                newBackup:{},
                backups:[],
                backupTable:{
                    columns: [
                        { label: 'Filename', field: 'filename' },
                        { label: 'Size', field: 'size' },
                        { label: 'Created', field: 'created' }
                    ]
                }
            }
        },
        methods:{
            moment:moment,
            viewBackup(backup){
                this.newBackup = {
                    filename:backup.filename,
                    size:backup.size,
                    created:backup.created
                };
                $("#backup-modal").modal("show");
            },
            getBackups(){
                let u = this;
                axios.get('/api/settings/getBackups')
                    .then(function (response) {
                        u.backups = response.data;
                    })
                    .catch(function (error) {
                        XHRCatcher(error);
                    });
            },
            runBackup(){
                let u = this;
                axios.get('/api/settings/runBackup')
                    .then(function (response) {
                        toastr.success(response.data.message);
                        u.getBackups();
                    })
                    .catch(function (error) {
                        XHRCatcher(error);
                    });
            },
            restoreBackup(){
                if(confirm("Are you sure you want to restore this backup?")){
                    let $btn = $(event.target);
                    $btn.button('loading');
                    axios.post('/api/settings/restoreBackup?token=' + this.token, this.newBackup)
                        .then(function (response) {
                            toastr.success(response.data.message);
                            $("#backup-modal").modal("hide");
                            $btn.button('reset');
                        })
                        .catch(function (error) {
                            $btn.button('reset');
                            XHRCatcher(error);
                        });
                }
            },
            deleteBackup(){
                if(confirm("Are you sure you want to delete this backup?")){
                    let u = this;
                    let $btn = $(event.target);
                    $btn.button('loading');
                    axios.post('/api/settings/deleteBackup?token=' + this.token, this.newBackup)
                        .then(function (response) {
                            toastr.success(response.data.message);
                            $("#backup-modal").modal("hide");
                            $btn.button('reset');
                            u.getBackups();
                        })
                        .catch(function (error) {
                            $btn.button('reset');
                            XHRCatcher(error);
                        });
                }
            }
        },
        mounted(){
            this.getBackups();
        },
        computed:{
            token(){
                return this.$store.state.token;
            }
        }
    }
</script>