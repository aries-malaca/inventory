<template>
    <div>
        <div class="nav-tabs-custom" v-if="gate(user, 'settings', 'view')">
            <!-- Tabs within a box -->
            <ul class="nav nav-tabs pull-right">
                <li class="pull-left header"><i class="fa fa-inbox"></i> Settings</li>
                <li v-if="gate(user, 'database', 'view')"><a href="#database-tab" data-toggle="tab" aria-expanded="true">Database</a></li>
                <li v-if="gate(user, 'users', 'view')"><a href="#userlevels-tab" data-toggle="tab" aria-expanded="true">User Levels</a></li>
                <li v-if="gate(user, 'users', 'view')"><a href="#users-tab" data-toggle="tab" aria-expanded="true">Users</a></li>
                <li class="active"><a href="#settings-tab" data-toggle="tab" aria-expanded="false">System Settings</a></li>
            </ul>
            <div class="tab-content no-padding">
                <users></users>
                <system-settings></system-settings>
                <user-levels></user-levels>
                <database></database>
            </div>
        </div>
        <unauthorized v-else></unauthorized>
    </div>
</template>
<script>
    import Users from './settings/Users.vue';
    import SystemSettings from './settings/SystemSettings.vue';
    import UserLevels from './settings/UserLevels.vue';
    import Database from './settings/Database.vue';
    import Unauthorized from './errors/Unauthorized.vue';
    export default {
        name: 'Settings',
        components:{ Users, SystemSettings, UserLevels, Database, Unauthorized },
        data(){
            return{
                title:'Settings'
            }
        },
        mounted:function(){
            this.$store.commit('updateTitle', this.title);
        },
        computed:{
            user(){
                return this.$store.state.user;
            }
        }
    }
</script>