<template>
    <div class="tab-pane active" id="settings-tab" style="position: relative;">
        <div class="box box-success">
            <div class="box-header with-border">
                <h3 class="box-title">System Settings</h3>
            </div>
            <div class="box-body">
                <data-table
                    :columns="settingTable.columns"
                    :rows="settings"
                    :paginate="true"
                    :onClick="settingTable.rowClicked"
                    styleClass="table table-bordered table-hover table-striped">
                </data-table>
                <div class="modal fade" id="setting-modal" tabindex="1">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                <h4 class="modal-title">Update Setting</h4>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>{{ newSetting.setting_label }}:</label>
                                            <input v-if="newSetting.setting_type==='string' || newSetting.setting_type==='number'"
                                                :type="newSetting.setting_type==='string'?'text':'number'"
                                                v-model="newSetting.setting_value" class="form-control"/>
                                            <select v-model="newSetting.setting_value" v-else class="form-control">
                                                <option :value="1">Yes</option>
                                                <option :value="0">No</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-success" data-loading-text="Saving..." @click="updateSetting">Update</button>
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
    export default {
        name: 'SystemSettings',
        components:{ DataTable },
        data(){
            return{
                settings:[],
                settingTable:{
                    columns: [
                        { label: 'Setting Name', field: 'setting_name' },
                        { label: 'Value', field: 'setting_value' },
                        { label: 'Description', field: 'setting_label' }
                    ],
                    rowClicked: this.viewSetting,
                },
                newSetting:{}
            }
        },
        methods:{
            viewSetting(setting){
                this.newSetting = {
                    id:setting.id,
                    setting_value:setting.setting_value,
                    setting_label:setting.setting_label,
                    setting_type:setting.setting_type
                };
                $("#setting-modal").modal("show");
            },
            getSettings(){
                let u = this;
                axios.get('/api/settings/getSettings')
                    .then(function (response) {
                        u.settings = response.data;
                    })
                    .catch(function (error) {
                        XHRCatcher(error);
                    });
            },
            updateSetting(event){
                if(!this.gate(this.user, 'settings', 'update')){
                    toastr.error("Not allowed to update");
                    return false;
                }

                let u = this;
                let $btn = $(event.target);
                $btn.button('loading');
                axios.post('/api/settings/updateSettings?token=' + this.token, this.newSetting)
                    .then(function (response) {
                        toastr.success(response.data.message);
                        $("#setting-modal").modal("hide");
                        $btn.button('reset');
                        u.getSettings();
                    })
                    .catch(function (error) {
                        $btn.button('reset');
                        XHRCatcher(error);
                    });
            }
        },
        mounted(){
            this.getSettings();
        },
        computed:{
            token(){
                return this.$store.state.token;
            },
            user(){
                return this.$store.state.user;
            }
        }
    }
</script>