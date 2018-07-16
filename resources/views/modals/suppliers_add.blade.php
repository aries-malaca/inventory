<div id="add-modal" class="modal fade" tabindex="-1" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" v-if="newSupplier.id==0">Add Supplier</h4>
                <h4 class="modal-title" v-else>Update Supplier</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Supplier Name</label>
                            <input type="text" v-model="newSupplier.supplier_name" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Supplier Address</label>
                            <textarea v-model="newSupplier.supplier_address" class="form-control"></textarea>
                        </div>
                    </div>
                </div>
                <h4>Contact Information</h4>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Contact Person</label>
                            <input type="text" v-model="newSupplier.supplier_contact_person" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Position</label>
                            <input type="text" v-model="newSupplier.contact_person_designation" placeholder="Manager/Agent" class="form-control"/>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Telephone No.</label>
                            <input type="text" v-model="newSupplier.supplier_telephone_no" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Mobile No.</label>
                            <input type="text" v-model="newSupplier.supplier_mobile_no" class="form-control"/>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Fax</label>
                            <input type="text" v-model="newSupplier.supplier_fax" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Email</label>
                            <input type="text" v-model="newSupplier.supplier_email" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group" v-if="newSupplier.id!=0">
                            <label>Status</label>
                            <select v-model="newSupplier.is_active" class="form-control">
                                <option value="1">Active</option>
                                <option value="0">Inactive</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                <button type="button" v-if="newSupplier.id==0" @click="addSupplier" class="btn btn-primary">Save</button>
                <button type="button" v-else @click="updateSupplier" class="btn btn-primary">Update</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>