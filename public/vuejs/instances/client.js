var vue_client = new Vue({
    el:"#clients",
    data:{
        pagination:[Filter('client_name')],
        table:'filtered_clients',
        clients:[],
        show_inactive:false,
        price_categories:[],
        newClient:{
            id:0,
            client_name:'',
            client_address:'',
            client_company:'',
            client_contact_person:'',
            client_email:'',
            client_contact_info:'',
            price_category_id:0,
            is_active:1,
            contact_person_designation:''
        }
    },
    methods:{
        clearForm:function(){
            this.newClient={
                id:0,
                client_name:'',
                client_address:'',
                client_company:'',
                client_contact_person:'',
                client_email:'',
                client_contact_info:'',
                price_category_id:0,
                is_active:1,
                contact_person_designation:''
            }
        },
        getData:function(url, field){
            $.get(url, function(data){
                vue_client[field] = [];
                data.forEach(function(item,i){
                    vue_client[field].push(item)
                });
            }).
            fail(function(){
                vue_client.getData(url,field);
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
        getClients:function(){
            this.getData('../../clients/getClients','clients');
        },
        getPriceCategories:function(){
            this.getData('../../products/getPriceCategories','price_categories');
        },
        addClient:function(){
            this.postData('../../clients/addClient', this.newClient, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully added client.");
                    $("#add-modal").modal("hide");
                }
                else{
                    toastr.error("Failed to add client, " + data.errors.toString());
                }
                vue_client.getClients();                
            });
        },
        updateClient:function(){
            this.postData('../../clients/updateClient', this.newClient, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully updated client.");
                    $("#add-modal").modal("hide");
                }
                else{
                    toastr.error("Failed to update client, " + data.errors.toString());
                }
                vue_client.getClients();
            });
        },
        showAddModal:function(){
            if(this.newClient.id != 0){
                this.clearForm();
            }
            $("#add-modal").modal("show");
        },
        editClient:function(client){
            this.newClient = {
                client_name: client.client_name,
                client_address: client.client_address,
                id: client.id,
                client_company:client.client_company,
                client_contact_person:client.client_contact_person,
                client_email:client.client_email,
                client_contact_info:client.client_contact_info,
                price_category_id:client.price_category_id,
                is_active:client.is_active,
                contact_person_designation:client.contact_person_designation
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
        filtered_clients:function(){
            return this.clients.filter(function(item){
                if(!item.is_active && !vue_client.show_inactive){
                    return false;
                }
                return true;
            });
        },
    },
    mounted:function(){
        this.getClients();
        this.getPriceCategories();
    }
});