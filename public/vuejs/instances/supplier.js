var vue_supplier = new Vue({
    el:"#suppliers",
    data:{
        pagination:[Filter('supplier_name')],
        table:'filtered_suppliers',
        suppliers:[],
        price_categories:[],
        show_inactive:false,
        newSupplier:{
            id:0,
            supplier_name:'',
            supplier_address:'',
            supplier_contact_person:'',
            supplier_email:'',
            is_active:1,
            contact_person_designation:'',
            supplier_telephone_no:'',
            supplier_mobile_no:'',
            supplier_fax:'',
        }
    },
    methods:{
        clearForm:function(){
            this.newSupplier={
                id:0,
                supplier_name:'',
                supplier_address:'',
                supplier_contact_person:'',
                supplier_email:'',
                is_active:1,
                contact_person_designation:'',
                supplier_telephone_no:'',
                supplier_mobile_no:'',
                supplier_fax:'',
            }
        },
        getData:function(url, field){
            $.get(url, function(data){
                vue_supplier[field] = [];
                data.forEach(function(item,i){
                    vue_supplier[field].push(item)
                });
            }).
            fail(function(){
                vue_supplier.getData(url, field);
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
        getSuppliers:function(){
            this.getData('../../suppliers/getSuppliers','suppliers');
        },
        getPriceCategories:function(){
            this.getData('../../products/getPriceCategories','price_categories');
        },
        addSupplier:function(){
            this.postData('../../suppliers/addSupplier', this.newSupplier, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully added supplier.");
                    $("#add-modal").modal("hide");
                }
                else{
                    toastr.error("Failed to add supplier, " + data.errors.toString());
                }
                vue_supplier.getSuppliers();                
            });
        },
        deleteSupplier:function(supplier){
            if(!confirm("Are you sure?")){
                return false;
            }

            this.postData('../../suppliers/deleteSupplier', supplier, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully deleted supplier.");
                }
                else{
                    toastr.error("Failed to delete supplier, " + data.errors.toString());
                }
                vue_supplier.getSuppliers();                
            });
        },
        updateSupplier:function(){
            this.postData('../../suppliers/updateSupplier', this.newSupplier, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully updated supplier.");
                    $("#add-modal").modal("hide");
                }
                else{
                    toastr.error("Failed to update supplier, " + data.errors.toString());
                }
                vue_supplier.getSuppliers();
            });
        },
        showAddModal:function(){
            if(this.newSupplier.id != 0){
                this.clearForm();
            }
            $("#add-modal").modal("show");
        },
        editSupplier:function(supplier){
            this.newSupplier = {
                supplier_name: supplier.supplier_name,
                supplier_address: supplier.supplier_address,
                id: supplier.id,
                supplier_contact_person:supplier.supplier_contact_person,
                supplier_email:supplier.supplier_email,
                supplier_contact_info:supplier.supplier_contact_info,
                is_active:supplier.is_active,
                contact_person_designation:supplier.contact_person_designation,
                supplier_telephone_no:supplier.supplier_telephone_no,
                supplier_mobile_no:supplier.supplier_mobile_no,
                supplier_fax:supplier.supplier_fax,
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
        filtered_suppliers:function(){
            return this.suppliers.filter(function(item){
                if(!item.is_active && !vue_supplier.show_inactive){
                    return false;
                }
                return true;
            });
        }
    },
    mounted:function(){
        this.getSuppliers();
        this.getPriceCategories();
    }
});