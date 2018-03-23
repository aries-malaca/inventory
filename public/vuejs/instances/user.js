vue_user = new Vue({
    el:"#users",
    data:{
        users:[],
        levels:[],
        permissions:[],
        branches:[],
        newUser:{
            id:0,
            name:'',
            address:'',
            email:'',
            mobile:'',
            level:0,
            branch_id:0,
            is_active:1,
        },
        newLevel:{
            id:undefined,
            level_name:'',
            level_description:'',
            is_default:0,
            is_active:1,
            level_data:{
                permissions:[]
            }
        }
    },
    methods:{
        clearUserForm:function(){
            this.newUser={
                id:0,
                name:'',
                address:'',
                email:'',
                mobile:'',
                level:0,
                branch_id:0,
                is_active:1,
            }
        },
        clearLevelForm:function(){
            this.newLevel={
                id:0,
                level_name:'',
                level_description:'',
                is_default:0,
                is_active:1,
                level_data:{
                    permissions:[]
                }
            }
            this.permissions.forEach(function(per){
                var data = [];
                for(var x=0;x<per.permission_data.length;x++){
                    data.push({
                        action:per.permission_data[x],
                        value:true
                    });
                }
                vue_user.newLevel.level_data.permissions.push(
                    {
                        page:per.permission_name,
                        permission:data
                    });
            });
        },
        getData:function(url, field){
            $.get(url, function(data){
                vue_user[field] = [];
                data.forEach(function(item,i){
                    if(field=='permissions'){
                        item.permission_data = JSON.parse(item.permission_data);
                    }
                    if(field=='levels'){
                        item.level_data = JSON.parse(item.level_data);
                    }
                    vue_user[field].push(item)
                });
            });
        },
        postData:function(url, inputs, callback){
            $.ajax({
                method:'post',
                url:url,
                data:inputs,
                success:callback
            });
        },
        refreshData:function(){
            this.getData('../../branches/getBranches','branches');
            this.getData('../../levels/getLevels','levels');
            this.getData('../../permissions/getPermissions','permissions');
            this.getData('../../users/getUsers','users');
        },
        showAddModal:function(what){
            if(what == 'user'){
                if(this.newUser.id != 0){
                    this.clearUserForm();
                }
                $("#add-user-modal").modal("show");
            }
            else if(what == 'level'){
                if(this.newLevel.id != 0){
                    this.clearLevelForm();
                }
                $("#add-level-modal").modal("show");
            }
        },
        addUser:function(){
            this.postData('../../users/addUser', this.newUser, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully added user.");
                    vue_user.refreshData();
                    vue_user.clearUserForm();
                    $("#add-user-modal").modal("hide");
                }
                else{
                    toastr.error("Failed to add user. " + data.errors.toString());
                }
            });
        },
        updateUser:function(){
            this.postData('../../users/updateUser', this.newUser, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully updated user.");
                    vue_user.refreshData();
                    vue_user.clearUserForm();
                    $("#add-user-modal").modal("hide");
                }
                else{
                    toastr.error("Failed to update user. " + data.errors.toString());
                }
            });
        },
        deleteUser:function(user){
            if(!confirm("Are you sure you want to delete this user?")){
                return false;
            }

            this.postData('../../users/deleteUser', {id:user.id}, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully deleted user.");
                    vue_user.refreshData();
                }
                else{
                    toastr.error("Failed to delete user. " + data.errors.toString());
                }
            });
        },
        editUser:function(user){
            this.newUser={
                id:user.id,
                name:user.name,
                address:user.address,
                email:user.email,
                mobile:user.mobile,
                level:user.level,
                branch_id:user.branch_id,
                is_active:user.is_active,
            }
            $("#add-user-modal").modal("show");
        },
        deleteLevel:function(level){
            if(!confirm("Are you sure you want to delete this user level?")){
                return false;
            }

            this.postData('../../levels/deleteLevel', {id:level.id}, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully deleted user level.");
                    vue_user.refreshData();
                }
                else{
                    toastr.error("Failed to delete user level. " + data.errors.toString());
                }
            });
        },
        addLevel:function(){
            this.postData('../../levels/addLevel', this.newLevel, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully added user level.");
                    vue_user.refreshData();
                    vue_user.clearLevelForm();
                    $("#add-level-modal").modal("hide");
                }
                else{
                    toastr.error("Failed to add user level. " + data.errors.toString());
                }
            });
        },
        updateLevel:function(){
            this.postData('../../levels/updateLevel', this.newLevel, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully updated user level.");
                    vue_user.refreshData();
                    vue_user.clearLevelForm();
                    $("#add-level-modal").modal("hide");
                }
                else{
                    toastr.error("Failed to update user level. " + data.errors.toString());
                }
            });
        },
        editLevel:function(level){
            this.newLevel={
                id:level.id,
                level_name:level.level_name,
                level_description:level.level_description,
                is_default:level.is_default,
                is_active:level.is_active,
                level_data:{
                    permissions:[]
                }
            }
            var new_data = [];
            this.permissions.forEach(function(per){
                var data = [];
                for(var x=0;x<per.permission_data.length;x++){
                    data.push({
                        action:per.permission_data[x],
                        value:vue_user.findPermissionValue(level, per.permission_name, per.permission_data[x])
                    });
                }
                new_data.push(
                    {
                        page:per.permission_name,
                        permission:data
                    });
            });
            this.newLevel.level_data.permissions = new_data;

            $("#add-level-modal").modal("show");
        },
        findPermissionValue:function(level,permission,action){
            for(var x=0;x<level.level_data.permissions.length;x++){
                if(permission == level.level_data.permissions[x].page){
                    for(var y=0;y<level.level_data.permissions[x].permission.length;y++){
                        if(level.level_data.permissions[x].permission[y].action==action){
                            return level.level_data.permissions[x].permission[y].value == "true";
                        }
                    }
                }
            }        
            return false;
        }
    },
    mounted:function(){
        this.refreshData();
    }
});