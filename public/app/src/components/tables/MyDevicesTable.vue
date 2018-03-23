<template>
    <div>
        <h4>Device Management</h4>
        <table class="table-responsive table table-hover table-bordered">
            <thead>
            <tr>
                <th>Platform</th>
                <th>Last Activity</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="device in devices">
                <td>{{ device.type }}</td>
                <td>
                    <span v-if="device.token != token">{{ moment(device.last_activity).fromNow() }}</span>
                    <span v-else>Currently In-use</span>
                </td>
                <td>
                    <button v-if="device.token != token" class="btn btn-xs btn-danger" @click="destroyToken(device.token)">Logout</button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</template>


<script>
    export default {
        name: 'MyDevicesTable',
        props: ['user_id','devices','token'],
        data: function(){
            return {
            }
        },
        methods:{
            moment:moment,
            destroyToken:function(token){
                let u = this;

                SweetConfirmation('Are you sure you want to logout from this session?', function(){
                    axios.patch('/api/user/destroyToken', { token : token, user_id : u.user_id})
                        .then(function () {
                            toastr.success("Device has been logged out.");
                            u.$emit('emit_host');
                        })
                        .catch(function (error) {
                            XHRCatcher(error);
                        });
                });
            }
        }
    }
</script>