<div id="add-modal" class="modal fade" tabindex="-1" data-backdrop="static">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" v-if="newUnit.id==0">Add Unit</h4>
                <h4 class="modal-title" v-else>Update Unit</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Unit Name</label>
                            <input type="text" v-model="newUnit.unit_name" class="form-control"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                <button type="button" v-if="newUnit.id==0" @click="addUnit" class="btn btn-primary">Save</button>
                <button type="button" v-else @click="updateUnit" class="btn btn-primary">Update</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>