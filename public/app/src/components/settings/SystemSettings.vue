<template>
    <div>
        <data-table
            :columns="settingTable.columns"
            :rows="settings"
            :paginate="true"
            :onClick="settingTable.rowClicked"
            styleClass="table table-bordered table-hover table-striped">
        </data-table>
    </div>
</template>
<script>
    import DataTable from '../components/DataTable.vue';
    export default {
        name: 'SystemSettings',
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
            updateSettings(event){
                let u = this;
                let $btn = $(event.target);
                $btn.button('loading');
                axios.post(url, this.newSetting)
                    .then(function (response) {
                        toastr.success(response.data.message);
                        $("#settings-modal").modal("hide");
                        $btn.button('reset');
                    })
                    .catch(function (error) {
                        $btn.button('reset');
                        XHRCatcher(error);
                    });
            }
        },
        mounted(){
            this.getSettings();
        }
    }
</script>