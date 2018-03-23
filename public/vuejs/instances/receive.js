var vue_receives = new Vue({
    el:"#receives",
    data:{
        confirmation_password:'',
        delete_id:0,
        pagination:[Filter('reference_no')],
        table:'receives',
        receives:[],
        branches:[],
        newReceive:{
            id:0,
            items:[],
            reference_no:'',
            received_data:{
                total_amount:0
            },
            from_branch_id:0,
            to_branch_id:0,
            date_received:moment().format("YYYY-MM-DD"),
            notes:'',
            receive_status:'pending',
        },
        units:[],
        products:[],
        auth:{},
        search:'',
        settings:{},
    },
    methods:{
        getAuth:function(){
             $.get('../../users/getAuth', function(data){
                vue_receives.auth = data;
                vue_receives.newReceive.to_branch_id = data.branch_id;
            }).
            fail(function(){
                vue_receives.getAuth();
            });
        },
        getSettings:function(){
             $.get('../../settings/getSettings', function(data){
                data.forEach(function(item,i){
                    vue_receives.settings[item.setting_name] = (item.setting_type=='string'?item.setting_value:Number(item.setting_value));
                });
            }).
            fail(function(){
                vue_receives.getSettings();
            });
        },
        getData:function(url, field){
            $.get(url, function(data){
                vue_receives[field] = [];
                data.forEach(function(item,i){
                    if(field == 'products'){
                        item.units = vue_receives.getProductUnits(item);
                    }
                    if(field == 'receives'){
                        item.received_data = JSON.parse(item.received_data);
                    }
                    if(field == 'branches'){
                        if(vue_receives.auth.branch_id == item.id)
                            vue_receives.newReceive.to_branch_id = item.id;
                    }
                    vue_receives[field].push(item)
                });
            }).
            fail(function(){
                vue_receives.getData(url, field);
            });
        },
        getProductUnits:function(product){
            var units = [];
            for(var x=0;x<product.product_data.product_units.length;x++){
                units.push({
                    unit:product.product_data.product_units[x].unit,
                    name:this.getUnitName(product.product_data.product_units[x].unit)
                });
            }
            return units;
        },
        getUnitName:function(unit_id){
            for(var x=0;x<this.units.length;x++){
                if(unit_id == this.units[x].id){
                    return this.units[x].unit_name;
                }
            }
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
            this.getData('../../receives/getReceives','receives');
            this.getData('../../settings/getUnits','units');
        },
        searchProduct:function(search,event){
            var found = [];

            if(event.keyCode == 13){
                for(var x=0;x<this.products.length;x++){
                    for(var y=0;y<this.products[x].product_data.product_units.length;y++){
                        if(this.products[x].product_data.product_units[y].bar_code == search){
                            found.push({
                                product:this.products[x],
                                unit:this.products[x].product_data.product_units[y].unit
                            })
                            this.addItem(found[0].product, found[0].unit);
                            this.search = '';
                            return 
                        }
                    }
                }

                if(found.length > 1){
                    toastr.error("Multiple items detected, please choose and add using button.");
                    return 
                }

                toastr.error("Barcode not registered.");
            }
        },
        getProduct:function(product_id){
            for(var x=0;x<this.products.length;x++){
                if(product_id == this.products[x].id){
                    return this.products[x];
                }
            }
            return false;
        },
        addItem:function(product,event){
            var unit_id = event;
            var qt = 0;
            if(isNaN(event)){
                unit_id = event.target.parentElement.parentElement.children[2].children[0].value;
                qt = event.target.parentElement.parentElement.children[1].children[0].value;
                event.target.parentElement.parentElement.children[1].children[0].value = "";
            }

            if(unit_id === undefined){
                toastr.error("Please indicate the unit.");
                return;
            }
            var item_exists_key = false;
            for(var x=0;x<this.newReceive.items.length;x++){
                if(this.newReceive.items[x].product_id == product.id && unit_id == this.newReceive.items[x].unit ){
                    item_exists_key = x;
                    break;
                }
            }
            if(item_exists_key === false){
                var unit_cost = 0;
                for(var x=0; x<product.product_data.product_units.length;x++){
                    if(product.product_data.product_units[x].unit == unit_id){
                        unit_cost = product.product_data.product_units[x].purchase_price; 
                    }
                }
                var quantity = qt;

                if(!isNaN(event)){
                    quantity = 1;
                }

                this.newReceive.items.push({
                    product_id:product.id,
                    product:product,
                    unit:unit_id,
                    unit_name:this.getUnitName(unit_id),
                    unit_cost:unit_cost,
                    quantity:quantity
                });
            }
            else{
                this.newReceive.items[item_exists_key].quantity ++;
            }
        },
        removeItem:function(key){
            this.newReceive.items.splice(key,1);
        },
        showAddModal:function(){
            if(this.products.length==0 || this.units.length==0 || this.branches.length==0){
                toastr.warning("Please wait until product list finished loading.");
                return false;
            }
            if(this.newReceive.id!=0)
                this.newReceive={
                    id:0,
                    received_data:{
                        total_amount:0
                    },
                    items:[],
                    reference_no:'',
                    from_branch_id:0,
                    to_branch_id:0,
                    date_received:moment().format("YYYY-MM-DD"),
                    notes:'',
                    receive_status:'pending',
                };
            $("#add-modal").modal("show");
        },
        addReceive:function(){
            for(var x=0;x<this.newReceive.items.length;x++){
                if(this.newReceive.items[x].quantity<1){
                    toastr.error("Positive quantity is required.");
                    return false;
                }
            }

            this.postData('../../receives/addReceive', this.newReceive,function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully added receiving.");
                    $("#add-modal").modal("hide");
                    vue_receives.refreshData();
                }
                else{
                    toastr.error(data.errors.toString());
                }
            });
        },
        viewReceive:function(receive){
            if(this.products.length==0 || this.units.length==0 || this.branches.length==0){
                toastr.warning("Please wait until product list finished loading.");
                return false;
            }
            this.newReceive ={
                id:receive.id,
                items:[],
                received_data:{
                    total_amount:receive.received_data.total_amount
                },
                reference_no:receive.reference_no,
                from_branch_id:receive.from_branch_id,
                to_branch_id:receive.to_branch_id,
                date_received:moment(receive.date_received).format("YYYY-MM-DD"),
                notes:receive.notes,
                receive_status:receive.receive_status
            }

            for(var x=0;x<receive.items.length;x++){
                this.newReceive.items.push({
                    product_id:receive.items[x].product_id,
                    quantity:receive.items[x].quantity,
                    unit:receive.items[x].unit,
                    product:this.getProduct(receive.items[x].product_id),
                    unit_name:this.getUnitName(receive.items[x].unit),
                    unit_cost:receive.items[x].unit_cost,
                });
            }

            $("#add-modal").modal("show");
        },
        approveReceive:function(){
            this.newReceive.receive_status = 'approved';
            if(!this.updateReceive()){
                this.newReceive.receive_status = 'pending';
            }
        },
        updateReceive:function(){
            for(var x=0;x<this.newReceive.items.length;x++){
                if(this.newReceive.items[x].quantity<1){
                    toastr.error("Positive quantity is required.");
                    return false;
                }
            }

            if(!confirm("Are you sure you want to commit changes? ")){
                return false;
            }

            this.postData('../../receives/updateReceive', this.newReceive,function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully "+(vue_receives.newReceive.receive_status=='pending'?'updated':'approved')+" receiving.");
                    $("#add-modal").modal("hide");
                    vue_receives.refreshData();
                }
                else{
                    toastr.error(data.errors.toString());
                }
            });
        },
        voidReceive:function(){
            if(!confirm("Are you sure you want to void this receiving? Warning:inventory will also affected.")){
                return false;
            }
            this.postData('../../receives/voidReceive', {id:this.newReceive.id},function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully voided receiving.");
                    $("#add-modal").modal("hide");
                    vue_receives.refreshData();
                }
                else{
                    toastr.error(data.errors.toString());
                }
            });
        },
        cancelReceive:function(){
            if(!confirm("Are you sure you want to cancel this receiving?")){
                return false;
            }
            this.postData('../../receives/cancelReceive', {id:this.newReceive.id},function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully canceled receiving.");
                    $("#add-modal").modal("hide");
                    vue_receives.refreshData();
                }
                else{
                    toastr.error(data.errors.toString());
                }
            });
        },
        deleteReceive:function(receive){
            this.postData('../../receives/deleteReceive', {id:this.delete_id, password: this.confirmation_password},function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully deleted receiving.");
                    $("#delete-modal").modal("hide");
                    vue_receives.confirmation_password = '';
                    vue_receives.refreshData();
                    vue_receives.delete_id = receive.id;
                }
                else{
                    toastr.error(data.errors.toString());
                }
            });

        },
        showDeleteModal:function(receive){
            this.delete_id = receive.id;
            $("#delete-modal").modal("show");
        },
        changeUnit:function(key){
            var price = 0;
            for(var x=0;x<this.getProduct(this.newReceive.items[key].product_id).product_data.product_units.length;x++){
                if(this.getProduct(this.newReceive.items[key].product_id).product_data.product_units[x].unit == this.newReceive.items[key].unit){
                    price = this.getProduct(this.newReceive.items[key].product_id).product_data.product_units[x].purchase_price;
                }
            }
            this.newReceive.items[key].unit_cost = price;
        },
        numberFormat:function(string){
            return Number(string).toLocaleString(undefined, { minimumFractionDigits: 2 });
        },
        dateFormat:function(string,format){
            return moment(string).format(format);
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
        product_search:function(){
            var count = 0;
            if(this.products.length==0){
                return [];
            }
            var s = this.search.toLowerCase();
            return this.products.filter(function(item){
                if(item.brand_name.toLowerCase().indexOf(s)!= -1 ||
                   item.product_code.toLowerCase().indexOf(s)!= -1 ||
                   item.product_description.toLowerCase().indexOf(s)!= -1 ||
                   item.product_name.toLowerCase().indexOf(s)!= -1 ||
                   s == ''
                ){
                    count++;
                    return (vue_receives.settings.product_search_length>=count);
                }
            });
        },
        total:function(){
            var total = 0;
            for(var x=0;x<this.newReceive.items.length;x++){
                total+= this.newReceive.items[x].unit_cost * this.newReceive.items[x].quantity;
            }
            this.newReceive.received_data.total_amount = total;
            return total;
        },
    },
    mounted:function(){
        this.refreshData();
        this.getAuth();
        this.getData('../../products/getProducts','products');
        setInterval(function(){
            vue_receives.getData('../../products/getProducts','products');
        },20000);  
        this.getSettings();
    }
});