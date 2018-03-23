var vue_receives = new Vue({
    el:"#receives",
    data:{
        confirmation_password:'',
        delete_id:0,
        pagination:[Filter('reference_no')],
        table:'receives',
        receives:[],
        newReceive:{
            id:0,
            items:[],
            reference_no:'',
            received_data:{
            },
            date_received:moment().format("YYYY-MM-DD"),
            notes:'',
            receive_status:'pending',
        },
        units:[],
        products:[],
        categories:[],
        auth:{},
        search:'',
        settings:{},
        sort_by:'product_name',
        add_category_id:[],
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
                    if(field == 'receives'){
                        item.received_data = JSON.parse(item.received_data);
                    }
                    vue_receives[field].push(item)
                });
            }).
            fail(function(){
                vue_receives.getData(url, field);
            });
        },
        getUnitName:function(unit_id){
            for(var x=0;x<this.units.length;x++){
                if(unit_id == this.units[x].id){
                    return this.units[x].unit_name;
                }
            }
        },
        postData:function(url, inputs, callback,complete){
            $.ajax({
                method:'post',
                url:url,
                data:inputs,
                success:callback,
                complete:complete
            });
        },
        refreshData:function(){
            this.getData('../../products/getProducts','products');
            this.getData('../../reconciliations/getReconciliations','receives');
            this.getData('../../settings/getUnits','units');
            this.getData('../../products/getCategories','categories');
        },
        searchProduct:function(search,event){
            var found = [];

            if(event.keyCode == 13){
                for(var x=0;x<this.products.length;x++){
                    for(var y=0;y<this.products[x].product_data.product_units.length;y++){
                        if(this.products[x].product_data.product_units[y].bar_code == search){
                            this.addItem(product);
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
        addItem:function(product){
            var item_exists_key = false;
            for(var x=0;x<this.newReceive.items.length;x++){
                if(this.newReceive.items[x].product_id == product.id){
                    item_exists_key = x;
                    break;
                }
            }
            
            if(item_exists_key === false){
                this.newReceive.items.push({
                    product_id:product.id,
                    product:product,
                    beginning:[],
                    actual:[],
                    difference:[],
                    beginning_retail:0,
                    actual_retail:0,
                    difference_retail:0,
                });
                var l = this.newReceive.items.length - 1;

                for(var x=0;x<product.product_data.product_units.length;x++){
                    this.newReceive.items[l].beginning.push({
                        unit:product.product_data.product_units[x].unit,
                        unit_name:this.getUnitName(product.product_data.product_units[x].unit),
                        quantity:product.product_data.product_units[x].stocks,
                        converter:product.product_data.product_units[x].quantity
                    });
                    
                    this.newReceive.items[l].actual.push({
                        unit:product.product_data.product_units[x].unit,
                        unit_name:this.getUnitName(product.product_data.product_units[x].unit),
                        quantity:"",
                        converter:product.product_data.product_units[x].quantity
                    });

                    this.newReceive.items[l].difference.push({
                        unit:product.product_data.product_units[x].unit,
                        unit_name:this.getUnitName(product.product_data.product_units[x].unit),
                        quantity:product.product_data.product_units[x].stocks,
                        converter:product.product_data.product_units[x].quantity
                    });
                }
                this.computeTotals(l);
            }
            else{
                toastr.warning("Item Exists.");
            }
        },
        computeTotals:function(key){
            var total_beg = 0;
            var total_act = 0;
            var total_dif = 0;
            var depth = 0;
            for(var x=this.newReceive.items[key].beginning.length-1;x>=0;x--){
                if(x == this.newReceive.items[key].beginning.length-1){
                    total_beg += Number(this.newReceive.items[key].beginning[x].quantity);
                    depth = 1;
                }
                else if(this.newReceive.items[key].beginning[x+1]!==undefined){
                    depth = depth*this.newReceive.items[key].beginning[x+1].converter;
                    total_beg += (depth* Number(this.newReceive.items[key].beginning[x].quantity));
                }
            }

            for(var x=this.newReceive.items[key].actual.length-1;x>=0;x--){
                this.newReceive.items[key].difference[x].quantity = this.newReceive.items[key].beginning[x].quantity - this.newReceive.items[key].actual[x].quantity; 
            }

            var depth = 0;
            for(var x=this.newReceive.items[key].actual.length-1;x>=0;x--){
                if(x == this.newReceive.items[key].actual.length-1){
                    total_act += Number(this.newReceive.items[key].actual[x].quantity);
                    depth = 1;
                }
                else if(this.newReceive.items[key].actual[x+1]!==undefined){
                    depth = depth*this.newReceive.items[key].actual[x+1].converter;
                    total_act += (depth* Number(this.newReceive.items[key].actual[x].quantity));
                }
            }

            var depth = 0;
            for(var x=this.newReceive.items[key].difference.length-1;x>=0;x--){
                if(x == this.newReceive.items[key].difference.length-1){
                    total_dif += Number(this.newReceive.items[key].difference[x].quantity);
                    depth = 1;
                }
                else if(this.newReceive.items[key].difference[x+1]!==undefined){
                    depth = depth*this.newReceive.items[key].difference[x+1].converter;
                    total_dif += (depth* Number(this.newReceive.items[key].difference[x].quantity));
                }
            }
            this.newReceive.items[key].beginning_retail = total_beg;
            this.newReceive.items[key].actual_retail = total_act;
            this.newReceive.items[key].difference_retail = total_dif;

            var rem = 0;
            for(var x=0;x<this.newReceive.items[key].difference.length;x++){

                if(x==0){
                    rem = total_dif%depth;
                    total_dif -= rem;
                    this.newReceive.items[key].difference[x].quantity = total_dif/depth;
                    total_dif = rem;
                }
                else if(x>0 && this.newReceive.items[key].difference[x+1]!==undefined){
                    rem = total_dif%this.newReceive.items[key].difference[x+1].converter;
                    total_dif -= rem;
                    this.newReceive.items[key].difference[x].quantity = total_dif/this.newReceive.items[key].difference[x+1].converter;
                    total_dif = rem;
                }
                else if(rem <= 0){
                    this.newReceive.items[key].difference[x].quantity = 0;
                }
                else{
                    this.newReceive.items[key].difference[x].quantity = total_dif;
                }

                console.log(total_dif);
            }
        },
        removeItem:function(key){
            this.newReceive.items.splice(key,1);
        },
        showAddModal:function(){
            if(this.products.length==0 || this.units.length==0){
                toastr.warning("Please wait until product list finished loading.");
                return false;
            }
            if(this.newReceive.id!=0)
                this.newReceive={
                    id:0,
                    received_data:{
                    },
                    items:[],
                    reference_no:'',
                    date_received:moment().format("YYYY-MM-DD"),
                    notes:'',
                    receive_status:'pending',
                };
            $("#add-modal").modal("show");
        },
        addReceive:function(event){
            for(var x=0;x<this.newReceive.items.length;x++){
                if(this.newReceive.items[x].quantity<1){
                    toastr.error("Positive quantity is required.");
                    return false;
                }
            }
            var $btn = $(event.target);
            $btn.button('loading');
            this.postData('../../reconciliations/addReconciliation', this.newReceive,function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully added reconciliation.");
                    $("#add-modal").modal("hide");
                    vue_receives.refreshData();
                    $btn.button('reset');
                }
                else{
                    toastr.error(data.errors.toString());
                }
            },function(){
                $btn.button('reset');
            });
        },
        viewReceive:function(receive){
            if(this.products.length==0 || this.units.length==0){
                toastr.warning("Please wait until product list finished loading.");
                return false;
            }
            this.newReceive ={
                id:receive.id,
                items:[],
                received_data:{
                },
                reference_no:receive.reference_no,
                date_received:moment(receive.date_received).format("YYYY-MM-DD"),
                notes:receive.notes,
                receive_status:receive.receive_status
            }

            for(var x=0;x<receive.items.length;x++){
                this.newReceive.items.push({
                    product_id:receive.items[x].product_id,
                    product:this.getProduct(receive.items[x].product_id),
                    beginning:[],
                    actual:[],
                    difference:[],
                    beginning_retail:0,
                    actual_retail:0,
                    difference_retail:0
                });
                
                var beginning = JSON.parse(receive.items[x].beginning);
                var actual = JSON.parse(receive.items[x].actual);
                var difference = JSON.parse(receive.items[x].difference);

                for(var y=0;y<beginning.length;y++){
                    this.newReceive.items[x].beginning.push({
                        unit:beginning[y].unit,
                        unit_name:this.getUnitName(beginning[y].unit),
                        quantity:beginning[y].quantity,
                        converter:beginning[y].converter
                    });
                    
                    this.newReceive.items[x].actual.push({
                        unit:actual[y].unit,
                        unit_name:this.getUnitName(actual[y].unit),
                        quantity:actual[y].quantity,
                        converter:actual[y].converter
                    });
                    
                    this.newReceive.items[x].difference.push({
                        unit:difference[y].unit,
                        unit_name:this.getUnitName(difference[y].unit),
                        quantity:difference[y].quantity,
                        converter:difference[y].converter
                    });
                }
                this.computeTotals(x);
            }           

            $("#add-modal").modal("show");
        },
        updateReceive:function(event){
            for(var x=0;x<this.newReceive.items.length;x++){
                if(this.newReceive.items[x].quantity<1){
                    toastr.error("Positive quantity is required.");
                    return false;
                }
            }

            if(!confirm("Are you sure you want to commit changes? ")){
                return false;
            }
            
            var $btn = $(event.target);
            $btn.button('loading');
         
            this.postData('../../reconciliations/updateReconciliation', this.newReceive,function(data){
                if(data.result == 'success'){
                    $("#add-modal").modal("hide");
                    vue_receives.refreshData();
                }
                else{
                    toastr.error(data.errors.toString());
                }
            },function(){
                    $btn.button('reset');
            });
        },
        deleteReconciliation:function(receive){
            this.postData('../../reconciliations/deleteReconciliation', {id:this.delete_id, password: this.confirmation_password},function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully deleted reconciliation.");
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
        addAll:function(){
            if(this.add_category_id.length==0){
                toastr.error("Please select Category.");
                return false;
            }
            if(!confirm("Current list will be flushed, do you want to continue?")){
                return false;
            }

            toastr.info("Previous list flushed, added all products with stocks.");
            this.newReceive.items = [];
            for(var x=0;x<this.products.length;x++){
                var y=0;
                var added = false;
                while(y<this.products[x].product_data.product_units.length && added == false){
                    if(this.products[x].product_data.product_units[y].stocks > 0 && this.add_category_id.indexOf(this.products[x].category_id) != -1){
                        this.addItem(this.products[x]);
                        added = true;
                    }
                    y++;
                }
            }
        },
        syncBeginning:function(){
            var current = [];
            for(var x=0;x<this.newReceive.items.length;x++){
                current.push(this.newReceive.items[x]);
            }
            this.newReceive.items = [];
            
            toastr.info("Beginning quantities are now synced.");
            for(var x=0;current.length;x++){
                var y=0;
                var added = false;
                while(y<this.getProduct(current[x].product_id).product_data.product_units.length && added == false){
                    this.addItem(this.getProduct(current[x].product_id));
                    added = true;
                    y++;
                }

            }
        },
        moveItem:function(fromIndex, toIndex) {
            var element = this.newReceive.items[fromIndex];
            this.newReceive.items.splice(fromIndex, 1);
            this.newReceive.items.splice(toIndex, 0, element);
        },  
        showDeleteModal:function(receive){
            this.delete_id = receive.id;
            $("#delete-modal").modal("show");
        },
        numberFormat:function(string){
            return Number(string).toLocaleString(undefined, { minimumFractionDigits: 2 });
        },
        dateFormat:function(string,format){
            return moment(string).format(format);
        },
        exportAsSales:function(event){
            
            var $btn = $(event.target);
            $btn.button('loading');
            var i = this.newReceive.id;

            this.postData('../../reconciliations/updateReconciliation', this.newReceive,function(data){
                if(data.result == 'success'){
                    var $btn = $(event.target);
                    $btn.button('loading');
                    $.get('../../reconciliations/exportAsSales/'+i, function(data2){
                        if(data2.result == 'success'){
                            toastr.success('Successfully exported as Sales. Receipt No. ' + data2.receipt_no);
                            $("#add-modal").modal("hide");
                        }
                        else{
                            toastr.error(data2.errors);
                        }
                    }).
                    fail(function(){
                        vue_receives.exportAsSales();
                    })
                    .complete(function(){
                        $btn.button('reset');
                    });
                }
                else{
                    toastr.error(data.errors.toString());
                }
            },function(){
                    $btn.button('reset');
            });
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
        setOrderBy:SetOrderBy
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