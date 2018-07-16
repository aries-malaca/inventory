<div id="add-user-modal" class="modal fade" tabindex="-1" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" v-if="newUser.id==0">Add User</h4>
                <h4 class="modal-title" v-else>Update User</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Name</label>
                            <input type="text" v-model="newUser.name" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Address</label>
                            <textarea v-model="newUser.address" class="form-control"></textarea>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Email</label>
                            <input type="text" v-model="newUser.email" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Mobile</label>
                            <input type="text" v-model="newUser.mobile" class="form-control"/>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Level</label>
                            <select v-model="newUser.level" class="form-control">
                                <option v-for="level in levels" v-bind:value="level.id">
                                    @{{ level.level_name }}
                                </option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Branch</label>
                            <select v-model="newUser.branch_id" class="form-control">
                                <option v-for="branch in branches" v-bind:value="branch.id">
                                    @{{ branch.branch_name }}
                                </option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Status</label>
                            <select v-model="newUser.is_active" class="form-control">
                                <option value="1">Active</option>
                                <option value="0">Inactive</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                <button type="button" v-if="newUser.id==0" @click="addUser" class="btn btn-primary">Save</button>
                <button type="button" v-else @click="updateUser" class="btn btn-primary">Update</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<div id="add-level-modal" class="modal fade" tabindex="-1" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" v-if="newLevel.id==0">Add Level</h4>
                <h4 class="modal-title" v-else>Update Level</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Level Name</label>
                            <input type="text" v-model="newLevel.level_name" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Description</label>
                            <textarea v-model="newLevel.level_description" class="form-control"></textarea>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Is Default</label>
                            <select v-model="newLevel.is_default" v-bind:disabled="newLevel.id==1" class="form-control">
                                <option value="1">Yes</option>
                                <option value="0">No</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Status</label>
                            <select v-model="newLevel.is_active" class="form-control">
                                <option value="1">Active</option>
                                <option value="0">Inactive</option>
                            </select>
                        </div>
                    </div>
                </div>
                <h3>Permissions</h3>
                <table class="table no-margin table-bordered table-hover">
                    <tr v-for="(p,key) in newLevel.level_data.permissions">
                        <td>@{{ p.page }}</td>
                        <td>
                            <label v-for="(action,k) in p.permission"><input type="checkbox" v-model="newLevel.level_data.permissions[key].permission[k].value">@{{ action.action }} &nbsp; &nbsp; </label> 
                        </td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                <button type="button" v-if="newLevel.id==0" @click="addLevel" class="btn btn-primary">Save</button>
                <button type="button" v-else @click="updateLevel" class="btn btn-primary">Update</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>