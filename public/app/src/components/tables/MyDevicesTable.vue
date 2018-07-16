<template>
    <div>
        <h4>Device Management</h4>
        <table class="table-responsive table table-hover table-bordered">
            <thead>
            <tr>
                <th>Devices</th>
                <th>Registered</th>
                <th>Last Activity</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="device in devices">
                <td>{{ device.type }}</td>
                <td>{{ moment(device.registered).format("MM/DD/YYYY hh:mm A") }}</td>
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
        props: ['user_id','devices'],
        data: function(){
            return {
            }
        },
        methods:{
            moment:moment,
            destroyToken:function(token){
                let u = this;

                if(confirm('Are you sure you want to logout from this session?')) {
                    axios.post('/api/user/destroyToken?token=' + this.token, { token : token, user_id : u.user_id})
                        .then(function () {
                            toastr.success("Device has been logged out.");
                            u.$emit('emit_host');
                        })
                        .catch(function (error) {
                            XHRCatcher(error);
                        });
                }   
            }
        },
        computed:{
            token(){
                return this.$store.state.token;
            }
        }
    }
</script>