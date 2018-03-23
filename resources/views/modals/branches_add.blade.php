<div id="add-modal" class="modal fade" tabindex="-1" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" v-if="newBranch.id==0">Add Branch</h4>
                <h4 class="modal-title" v-else>Update Branch</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Branch Name</label>
                            <input type="text" v-model="newBranch.branch_name" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Branch Address</label>
                            <textarea v-model="newBranch.branch_address" class="form-control"></textarea>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Contact</label>
                            <input type="text" v-model="newBranch.branch_contact" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Role</label>
                            <select v-model="newBranch.branch_role" class="form-control">
                                <option value="IN">Stock-in</option>
                                <option value="OUT">Stock-out</option>
                                <option value="BOTH">Both</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group" v-if="newBranch.id!=0">
                            <label>Status</label>
                            <select v-model="newBranch.is_active" class="form-control">
                                <option value="1">Active</option>
                                <option value="0">Inactive</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                <button type="button" v-if="newBranch.id==0" @click="addBranch" class="btn btn-primary">Save</button>
                <button type="button" v-else @click="updateBranch" class="btn btn-primary">Update</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>