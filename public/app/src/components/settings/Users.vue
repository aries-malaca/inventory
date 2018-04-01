<template>
    <div class="tab-pane" id="users-tab" style="position: relative;">
    	<div class="box box-warning">
			<div class="box-header with-border">
	    		<h3 class="box-title">Users</h3>
	            &nbsp;
	            <button class="btn btn-success btn-sm" v-if="gate(user, 'users', 'add')" @click="showAddModal">Add User</button>
        	</div>
        	<div class="box-body">
        		<data-table
		            :columns="userTable.columns"
		            :rows="computed_users"
		            :paginate="true"
		            :onClick="viewUser"
		            styleClass="table table-bordered table-hover table-striped">
		        </data-table>
		        <div class="modal fade" id="user-modal" tabindex="1">
		            <div class="modal-dialog">
		                <div class="modal-content">
		                    <div class="modal-header">
		                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                        <h4 class="modal-title" v-if="newUser.id !==0">Update User</h4>
		                        <h4 class="modal-title" v-else>Add User</h4>
		                    </div>
		                    <div class="modal-body">
		                        <div class="row">
		                            <div class="col-md-6">
		                            	<div class="form-group">
		                            		<label>Name</label>
		                            		<input class="form-control" type="text" v-model="newUser.name"/>
		                            	</div>
		                            </div>
		                            <div class="col-md-6">
		                            	<div class="form-group">
		                            		<label>Email</label>
		                            		<input class="form-control" type="text" v-model="newUser.email"/>
		                            	</div>
		                            </div>
		                        </div>
		                        <div class="row">
		                        	<div class="col-md-12">
		                            	<div class="form-group">
		                            		<label>Address</label>
		                            		<input class="form-control" type="text" v-model="newUser.address"/>
		                            	</div>
		                        	</div>
		                        </div>
		                        <div class="row">
		                            <div class="col-md-6">
		                            	<div class="form-group">
		                            		<label>Mobile</label>
		                            		<input class="form-control" type="text" v-model="newUser.mobile"/>
		                            	</div>
		                            </div>
		                            <div class="col-md-6">
		                            	<div class="form-group">
		                            		<label>Level</label>
		                            		<select class="form-control" v-model="newUser.level">
		                            			<option v-for="level in levels" :value="level.id">{{ level.level_name }}</option>
		                            		</select>
		                            	</div>
		                            </div>
		                        </div>
		                        <div class="row">
		                        	<div class="col-md-4">
		                            	<div class="form-group">
		                            		<label>Status</label>
		                            		<select class="form-control" v-model="newUser.is_active">
		                            			<option value="1">Active</option>
		                            			<option value="0">Inactive</option>
		                            		</select>
		                            	</div>
		                            </div>
		                        </div>
		                    </div>
		                    <div class="modal-footer">
		                    	<button type="button" class="btn btn-success" v-if="newUser.id===0" @click="addUser">Save</button>
		                        <button type="button" class="btn btn-success" v-else @click="updateUser">Update</button>
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
        name: 'Users',
        components:{ DataTable },	
        data(){
            return{
            	newUser:{},
            	users:[],
                userTable:{
                    columns: [
                        { label: 'Name', field: 'name' },
                        { label: 'Level', field: 'level_name' },
                        { label: 'Email', field: 'email' },
                        { label: 'Mobile', field: 'mobile' },
                        { label: 'Address', field: 'address' },
                        { label: 'Status', field: 'status', html:true }
                    ]
                }
            }
        },
        methods:{
        	getUsers(){
                let u = this;
                axios.get('/api/users/getUsers')
                    .then(function (response) {
                        u.users = response.data;
                    })
                    .catch(function (error) {
                        XHRCatcher(error);
                    });
        	},
        	viewUser(user){
        		this.newUser = {
        			id:user.id,
        			name:user.name,
        			mobile:user.mobile,
        			is_active:user.is_active,
        			user_data:{
        			},
        			level:user.level,
        			address:user.address,
        			email:user.email
        		};
        		
        		$("#user-modal").modal("show");
        	},
        	showAddModal(){
        		this.newUser = {
        			id:0,
        			name:'',
        			mobile:'',
        			is_active:1,
        			user_data:{
        			},
        			level:1,
        			address:'',
        			email:''
        		};
        		$("#user-modal").modal("show");
        	},
        	addUser(){
                let u = this;
                let $btn = $(event.target);
                $btn.button('loading');
                axios.post('/api/users/addUser?token=' + this.token, this.newUser)
                    .then(function (response) {
                        toastr.success(response.data.message);
                        $("#user-modal").modal("hide");
                        $btn.button('reset');
                        u.getUsers();
                    })
                    .catch(function (error) {
                        $btn.button('reset');
                        XHRCatcher(error);
                    });
        	},
        	updateUser(){
                if(gate(user, 'users', 'update')){
                    toastr.error("Not allowed to update");
                    return false;
                }

				let u = this;
                let $btn = $(event.target);
                $btn.button('loading');
                axios.post('/api/users/updateUser?token=' + this.token, this.newUser)
                    .then(function (response) {
                        toastr.success(response.data.message);
                        $("#user-modal").modal("hide");
                        $btn.button('reset');
                        u.getUsers();
                    })
                    .catch(function (error) {
                        $btn.button('reset');
                        XHRCatcher(error);
                    });
        	}
        },
        mounted(){
        	this.getUsers();
        },
        computed:{
        	computed_users(){
        		return this.users.map((item)=>{
        			item.status = item.is_active === 1?'<span class="label label-info">Active</span>':'<span class="label label-warning">Inactive</span>';
        			return item;
        		});
        	},
        	token(){
        		return this.$store.state.token;
        	},
			levels(){
        		return this.$store.state.levels.levels.filter((item)=>{
        			return item.is_active===1;
        		});
        	}
        }
    }
</script>