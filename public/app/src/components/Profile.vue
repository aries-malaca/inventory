<template>
    <div>
        <div class="row">
            <div class="col-md-3">
              <!-- Profile Image -->
              <div class="box box-primary">
                <div class="box-body box-profile">
                  <img class="profile-user-img img-responsive img-circle" :src="'../../images/users/'+user.photo" 
                    alt="User profile picture">
                  <h3 class="profile-username text-center">{{ user.name }}</h3>
                  <p class="text-muted text-center">{{ user.level_name }}</p>
                  <button @click="editProfile" class="btn btn-primary btn-block"><b>Edit Profile</b></button>
                  <button @click="showPictureModal" class="btn btn-success btn-block"><b>Change Picture</b></button>
                </div>
                <!-- /.box-body -->
              </div>
              <!-- /.box -->

              <!-- About Me Box -->
              <div class="box box-primary">
                <div class="box-header with-border">
                  <h3 class="box-title">About Me</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <strong><i class="fa fa-envelope margin-r-5"></i> Email</strong>
                    <p class="text-muted">{{ user.email }}</p>
                    <hr>
                    <strong><i class="fa fa-map-marker margin-r-5"></i> Address</strong>
                    <p class="text-muted">{{ user.address }}</p>
                    <hr>
                    <strong><i class="fa fa-phone margin-r-5"></i> Mobile</strong>
                    <p class="text-muted">{{ user.mobile }}</p>
                    <hr>
                </div>
                <!-- /.box-body -->
              </div>
              <!-- /.box -->
            </div>
            <!-- /.col -->
            <div class="col-md-9">
              <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                  <li class="active"><a href="#activity" data-toggle="tab">Activities</a></li>
                  <li class=""><a href="#tokens" data-toggle="tab">Access Tokens</a></li>
                </ul>
                <div class="tab-content">
                  <div class="tab-pane active" id="activity">
                      <activities :logs="computed_logs"></activities>
                  </div>
                  <!-- /.tab-pane -->
                  <div id="tokens" class="tab-pane">
                    <my-devices-table @emit_host="refreshProfile" :devices="user.device_data" 
                    :user_id="user.id">
                    </my-devices-table>
                  </div>
                </div>
                <!-- /.tab-content -->
              </div>
              <!-- /.nav-tabs-custom -->
            </div>
            <!-- /.col -->
        </div>
        <div class="modal fade" id="profile-modal" tabindex="1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title">Update Profile</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Name</label>
                                    <input class="form-control" type="text" v-model="newProfile.name" disabled/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Mobile</label>
                                    <input class="form-control" type="text" v-model="newProfile.mobile"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>Address</label>
                                    <input class="form-control" type="text" v-model="newProfile.address"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Email</label>
                                    <input class="form-control" type="text" v-model="newProfile.email"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Old Password</label>
                                    <input class="form-control" type="password" v-model="newProfile.old_password"/>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>New Password</label>
                                    <input class="form-control" type="password" v-model="newProfile.password"/>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Re-type Password</label>
                                    <input class="form-control" type="password" v-model="newProfile.password2"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-success" data-loading-text="Saving..." @click="updateProfile">Update</button>
                        <button type="button" class="btn pull-left" data-dismiss="modal">Close</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <upload-picture-modal
            @refresh_host="refreshProfile"
            category="profile"
            :token="token"
            :param_url="'user_id='+user.id"
            :placeholder_image="'images/users/'+user.photo"
            modal_id="upload-picture-modal"
            form_id="upload-user-picture-form"
            input_id="file">
        </upload-picture-modal>
    </div>
</template>
<script>
    import UploadPictureModal from './modals/UploadPictureModal.vue';
    import MyDevicesTable from './tables/MyDevicesTable.vue';
    import Activities from './timelines/Activities.vue';
    export default {
        name: 'Profile',
        components:{ UploadPictureModal, MyDevicesTable, Activities },
        data(){
            return{
                title:'Profile',
                newProfile:{},
                newPassword:{},
                logs:[]
            }
        },
        methods:{
            refreshProfile(){
                this.$store.dispatch('fetchAuthenticatedUser');
            },
            editProfile(){
                this.newProfile = {
                    name:this.user.name,
                    address:this.user.address,
                    mobile:this.user.mobile,
                    email:this.user.email,
                    old_password:'',
                    password:'',
                    password2:''
                };
                $("#profile-modal").modal("show");
            },
            showPasswordModal(){
                $("#password-modal").modal("show");
            },
            showPictureModal(){
               $("#upload-picture-modal").modal("show"); 
            },
            updateProfile(){
                let u = this;
                let $btn = $(event.target);
                $btn.button('loading');
                axios.post('/api/profile/updateProfile?token=' + this.token, this.newProfile)
                    .then(function (response) {
                        toastr.success(response.data.message);
                        $("#profile-modal").modal("hide");
                        $btn.button('reset');
                        u.$store.dispatch('fetchAuthenticatedUser');
                    })
                    .catch(function (error) {
                        $btn.button('reset');
                        XHRCatcher(error);
                    });
            },
            getUserLogs(){
                let u = this;
                axios.get('/api/users/getUserLogs/' + this.user.id)
                    .then(function (response) {
                        u.logs = response.data;
                    })
                    .catch(function (error) {
                        XHRCatcher(error);
                    });
            },
            moment:moment
        },
        mounted:function(){
            this.$store.commit('updateTitle', this.title);
            this.refreshProfile();
            this.getUserLogs();
        },
        computed:{
            user(){
                return this.$store.state.user;
            },
            token(){
                return this.$store.state.token;
            },
            computed_logs(){
                return this.logs.map((item)=>{
                    item.body = JSON.stringify(item.body);
                    return item;
                });
            }
        }
    }
</script>