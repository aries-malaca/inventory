@extends('layouts.app')
@section('content')
<div class="row" id="profile">
    <div class="col-md-5">
        <div class="box box-primary">
            <div class="box-body box-profile">
              <img class="profile-user-img img-responsive img-circle" v-bind:src="'../../images/users/'+auth.photo" alt="User profile picture">

              <h3 class="profile-username text-center">@{{ auth.name }}</h3>

              <p class="text-muted text-center">@{{ auth.level_name }}</p>
              <div class="row">
                <div class="col-md-3">
                    <b>Name</b> 
                </div>
                <div class="col-md-9">
                    <input type="text" class="form-control" v-model="auth.name">
                </div>
              </div>
              <br/>
              <div class="row">
                <div class="col-md-3">
                    <b>Address</b> 
                </div>
                <div class="col-md-9">
                    <input type="text" class="form-control" v-model="auth.address">
                </div>
              </div>
              <br/>
              <div class="row">
                <div class="col-md-3">
                    <b>Mobile</b> 
                </div>
                <div class="col-md-9">
                    <input type="text" class="form-control" v-model="auth.mobile">
                </div>
              </div>
              <br/>
              <div class="row">
                <div class="col-md-3">
                    <b>Email</b> 
                </div>
                <div class="col-md-9">
                    <input type="text" class="form-control" v-model="auth.email">
                </div>
              </div>
              <br/>
              <a href="#" class="btn btn-primary btn-block" @click="updateProfile">Update Profile</a>
              <a href="#" class="btn btn-danger btn-block" @click="showPasswordModal">Change Password</a>
            </div>
            <!-- /.box-body -->
          </div>
    </div>

    <div id="password-modal" class="modal fade" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">Change Password</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Old Password</label>
                                <input type="password" v-model="password.old" class="form-control"/>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>New Password</label>
                                <input type="password" v-model="password.new" class="form-control"/>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Re-enter New Password</label>
                                <input type="password" v-model="password.new2" class="form-control"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                    <button type="button" @click="changePassword" class="btn btn-success">Update</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>


</div>
@push('scripts')
<script src="../../vuejs/instances/profile.js"></script>
@endpush
@endsection