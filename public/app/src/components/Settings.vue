<template>
    <div class="nav-tabs-custom">
        <!-- Tabs within a box -->
        <ul class="nav nav-tabs pull-right">
            <li class="pull-left header"><i class="fa fa-inbox"></i> Settings</li>
            <li><a href="#users-tab" data-toggle="tab" aria-expanded="true">Users</a></li>
            <li><a href="#userlevels-tab" data-toggle="tab" aria-expanded="true">User Levels</a></li>
            <li class="active"><a href="#settings-tab" data-toggle="tab" aria-expanded="false">System Settings</a></li>
        </ul>
        <div class="tab-content no-padding">
            <users></users>
            <system-settings></system-settings>
            <user-levels></user-levels>
        </div>
    </div>
</template>
<script>
    import Users from './settings/Users.vue';
    import SystemSettings from './settings/SystemSettings.vue';
    import UserLevels from './settings/UserLevels.vue';
    export default {
        name: 'Settings',
        components:{ Users, SystemSettings, UserLevels },
        data(){
            return{
                title:'Settings'
            }
        },
        mounted:function(){
            this.$store.commit('updateTitle', this.title);
        }
    }
</script>