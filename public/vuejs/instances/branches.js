var vue_branches = new Vue({
    el:"#branches",
    data:{
        pagination:[Filter('branch_name')],
        table:'filtered_branch',
        show_inactive:false,
        newBranch:{
            id:0,
            branch_name:'',
            branch_address:'',
            branch_contact:'',
            branch_role:'IN',
            is_active:1
        },
        branches:[]
    },
    methods:{
        getAuth:function(){
             $.get('../../users/getAuth', function(data){
                vue_branches.auth = data;
            });
        },
        clearForm:function(){
            this.newBranch={
                id:0,
                branch_name:'',
                branch_address:'',
                branch_contact:'',
                branch_role:'IN',
                is_active:1
            }
        },
        getBranches:function(){
            this.getData('../../branches/getBranches', 'branches');
        },
        getData:function(url, field){
            $.get(url, function(data){
                vue_branches[field] = [];
                data.forEach(function(item,i){
                    vue_branches[field].push(item)
                });
            }).
            fail(function(){
                vue_branches.getData(url,field);
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
        showAddModal:function(){
            if(this.newBranch.id != 0){
                this.clearForm();
            }
            $("#add-modal").modal("show");
        },
        addBranch:function(){
            this.postData('../../branches/addBranch', this.newBranch, function(data){
                if(data.result == 'success'){
                    toastr.success('Successfully added branch.');
                    $("#add-modal").modal("hide");
                }
                else{
                    toastr.error("Failed to add branch, " + data.errors.toString());
                }
                vue_branches.getBranches();     
            });
        },
        updateBranch:function(){
            this.postData('../../branches/updateBranch', this.newBranch, function(data){
                if(data.result == 'success'){
                    toastr.success('Successfully updated branch.');
                    $("#add-modal").modal("hide");
                }
                else{
                    toastr.error("Failed to update branch, " + data.errors.toString());
                }
                vue_branches.getBranches();
            });
        },
        editBranch:function(branch){
            this.newBranch = {
                id:branch.id,
                branch_name:branch.branch_name,
                branch_address:branch.branch_address,
                branch_contact:branch.branch_contact,
                branch_role:branch.branch_role,
                is_active:branch.is_active
            }
            $("#add-modal").modal("show");
        },
        authorize:function(page, permission){
            if(vue_menu.auth.level_data === undefined){
                return false;
            }
            for(var x=0;x<vue_menu.auth.level_data.permissions.length;x++){
                if(page == vue_menu.auth.level_data.permissions[x].page){
                    for(var y=0;y<vue_menu.auth.level_data.permissions[x].permission.length;y++) {
                        if(vue_menu.auth.level_data.permissions[x].permission[y].action == permission && vue_menu.auth.level_data.permissions[x].permission[y].value == "true"){
                            return true;
                        }
                    }
                }
            }
            return false;
        },
        setPage: SetPage,
        setOrderBy:SetOrderBy,
    },
    computed:{
        filtered:Pagination,
        filtered_branch:function(){
            return this.branches.filter(function(item){
                if(!item.is_active && !vue_branches.show_inactive){
                    return false;
                }
                return true;
            });
        },
    },
    mounted:function(){
        this.getBranches();
    }
});