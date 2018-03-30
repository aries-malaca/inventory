<template>
    <div class="tab-pane" id="userlevels-tab" style="position: relative;">
    	<div class="box box-info">
			<div class="box-header with-border">
	    		<h3 class="box-title">User Levels</h3>
	            &nbsp;
	            <button class="btn btn-success btn-sm" @click="showAddModal">Add Level</button> 
        	</div>
        	<div class="box-body">
        		<data-table
		            :columns="levelTable.columns"
		            :rows="computed_levels"
		            :paginate="true"
		            :onClick="viewLeveL"
		            styleClass="table table-bordered table-hover table-striped">
		        </data-table>
		        <div class="modal fade" id="level-modal" tabindex="1">
		            <div class="modal-dialog">
		                <div class="modal-content">
		                    <div class="modal-header">
		                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                        <h4 class="modal-title" v-if="newLevel.id !==0">Update Level</h4>
		                        <h4 class="modal-title" v-else>Add Level</h4>
		                    </div>
		                    <div class="modal-body">
		                        <div class="row">
		                            <div class="col-md-8">
		                            	<div class="form-group">
		                            		<label>Level Name</label>
		                            		<input class="form-control" type="text" v-model="newLevel.level_name"/>
		                            	</div>
		                            </div>
		                            <div class="col-md-4">
		                            	<div class="form-group">
		                            		<label>Status</label>
		                            		<select class="form-control" v-model="newLevel.is_active">
		                            			<option value="1">Active</option>
		                            			<option value="0">Inactive</option>
		                            		</select>
		                            	</div>
		                            </div>
		                        </div>
		                        <div class="row">
		                        	<div class="col-md-12">
		                            	<div class="form-group">
		                            		<label>Description</label>
		                            		<input class="form-control" type="text" v-model="newLevel.level_description"/>
		                            	</div>
		                        	</div>
		                        </div>
		                    </div>
		                    <div class="modal-footer">
		                    	<button type="button" class="btn btn-success" v-if="newLevel.id===0" @click="addLevel">Save</button>
		                        <button type="button" class="btn btn-success" v-else @click="updateLevel">Update</button>
		                        <button type="button" class="btn pull-left" data-dismiss="modal">Close</button>
		                    </div>
		                </div>
		                <!-- /.modal-content -->
		            </div>
		            <!-- /.modal-dialog -->
		        </div>
        	</div>
    	</div>
	</div>
</template>
<script>
    import DataTable from '../components/DataTable.vue';
    export default {
        name: 'UserLevels',
        components:{ DataTable },
        data(){
            return{
            	newLevel:{},
                levelTable:{
                    columns: [
                        { label: 'Level Name', field: 'level_name' },
                        { label: 'Description', field: 'level_description' },
                        { label: 'Status', field: 'status', html:true }
                    ]
                }
            }
        },
        methods:{
        	getLevels(){
                let u = this;
                axios.get('/api/levels/getLevels')
                    .then(function (response) {
                        u.$store.commit('levels/updateLevels', response.data);
                    })
                    .catch(function (error) {
                        XHRCatcher(error);
                    });
        	},
        	viewLeveL(level){
        		this.newLevel = {
        			id:level.id,
        			level_name:level.level_name,
        			level_description:level.level_description,
        			is_active:level.is_active,
        			level_data:{
        				permissions:[]
        			}
        		};


        		let u = this;
        		level.level_data.permissions.forEach((item)=>{
        			u.newLevel.level_data.permissions.push(item);
        		});
        		
        		$("#level-modal").modal("show");
        	},
        	showAddModal(){
	       		this.newLevel = {
	    			id:0,
	    			level_name:'',
	    			level_description:'',
	    			is_active:1,
	    			level_data:{
	    				permissions:[]
	    			}
	    		};

        		$("#level-modal").modal("show");
        	},
        	addLevel(){
                let u = this;
                let $btn = $(event.target);
                $btn.button('loading');
                axios.post('/api/levels/addLevel?token=' + this.token, this.newLevel)
                    .then(function (response) {
                        toastr.success(response.data.message);
                        $("#level-modal").modal("hide");
                        $btn.button('reset');
                        u.getLevels();
                    })
                    .catch(function (error) {
                        $btn.button('reset');
                        XHRCatcher(error);
                    });
        	},
        	updateLevel(){
				let u = this;
                let $btn = $(event.target);
                $btn.button('loading');
                axios.post('/api/levels/updateLevel?token=' + this.token, this.newLevel)
                    .then(function (response) {
                        toastr.success(response.data.message);
                        $("#level-modal").modal("hide");
                        $btn.button('reset');
                        u.getLevels();
                    })
                    .catch(function (error) {
                        $btn.button('reset');
                        XHRCatcher(error);
                    });
        	}
        },
        mounted(){
        	this.getLevels();
        },
        computed:{
        	computed_levels(){
        		return this.levels.map((item)=>{
        			item.status = item.is_active === 1?'<span class="label label-info">Active</span>':'<span class="label label-warning">Inactive</span>';
        			return item;
        		});
        	},
        	token(){
        		return this.$store.state.token;
        	},
        	levels(){
        		return this.$store.state.levels.levels;
        	}
        }
    }
</script>