var vue_purchases = new Vue({
    el:"#purchases",
    data:{
        confirmation_password:'',
        delete_id:0,
        pagination:[Filter('reference_no')],
        table:'purchases',
        purchases:[],
        suppliers:[],
        newPurchase:{
            id:0,
            items:[],
            receipt_no:'',
            reference_no:'',
            supplier_id:0,
            date_transaction:moment().format("YYYY-MM-DD"),
            date_due:moment().format("YYYY-MM-DD"),
            notes:'',
            purchase_status:'pending',
            purchase_data:{
                vat_inclusive:0,
                vat_enabled:0,
                total_amount:0,
                discount:0,
                gross_amount:0,
                vat_amount:0,
                vat_rate:0,
                net_amount:0,
                paid_amount:0,
                balance:0,
                cash:0,
            },
            payment_data:[{method:'Cash',amount:0,details:''}]
        },
        products:[],
        auth:{},
        search:'',
        unit_search:[],
        settings:{},
        units:[],
        status_select:'all'
    },
    methods:{
        getAuth:function(){
             $.get('../../users/getAuth', function(data){
                vue_purchases.auth = data;
            }).
            fail(function(){
                vue_purchases.getAuth();
            });
        },
        getSettings:function(){
             $.get('../../settings/getSettings', function(data){
                data.forEach(function(item,i){
                    vue_purchases.settings[item.setting_name] = (item.setting_type=='string'?item.setting_value:Number(item.setting_value));
                    if(item.setting_name == 'pos_vat_enabled')
                        vue_purchases.newPurchase.purchase_data.vat_enabled = vue_purchases.settings[item.setting_name];
                    if(item.setting_name == 'default_vat_percentage')
                        vue_purchases.newPurchase.purchase_data.vat_rate = vue_purchases.settings[item.setting_name];  
                });
            }).
            fail(function(){
                vue_purchases.getSettings();
            });
        },
        getData:function(url, field){
            $.get(url, function(data){
                vue_purchases[field] = [];
                data.forEach(function(item,i){
                    if(field == 'purchases'){
                        item.purchase_data = JSON.parse(item.purchase_data);
                        item.payment_data = JSON.parse(item.payment_data);
                        item.product_items = vue_purchases.defineProducts(item.items);
                    }
                    if(field == 'products'){
                        item.units = vue_purchases.getProductUnits(item);
                    }
                    vue_purchases[field].push(item)
                });
            }).
            fail(function(){
                vue_purchases.getData(url, field);
            });
        },
        defineProducts:function(items){
            var i = [];
            for(var x=0;x<items.length;x++){
                var t= this.getProduct(items[x].product_id);
                if(t!==false){
                    i.push(t.product_name.toLowerCase());
                }
            }
            return i;
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
            this.getData('../../suppliers/getSuppliers','suppliers');
            this.getData('../../purchases/getPurchases','purchases');
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
            for(var x=0;x<this.newPurchase.items.length;x++){
                if(this.newPurchase.items[x].product_id == product.id && unit_id == this.newPurchase.items[x].unit ){
                    item_exists_key = x;
                    break;
                }
            }
            if(item_exists_key === false){
                var purchase_price = 0;
                for(var x=0; x<product.product_data.product_units.length;x++){
                    if(product.product_data.product_units[x].unit == unit_id){
                        purchase_price = product.product_data.product_units[x].purchase_price; 
                    }
                }
                var quantity = qt;
                var received_quantity = qt;
                if(!isNaN(event)){
                    quantity = 1;
                    received_quantity = 1;
                }

                this.newPurchase.items.push({
                    product_id:product.id,
                    product:product,
                    quantity:quantity,
                    unit_price:purchase_price,
                    discount:0,
                    unit:unit_id,
                    unit_name:this.getUnitName(unit_id),
                    purchase_price:purchase_price,
                    received_quantity:received_quantity
                });
            }
            else{
                this.newPurchase.items[item_exists_key].quantity ++;
                this.newPurchase.items[item_exists_key].received_quantity ++;
            }

            if(this.newPurchase.items.length>=10){
                $("#add-modal").animate({
                    scrollTop: 800
                });
                $("#scroll-table").animate({
                    scrollTop: 5000000
                });
            }
        },
        removeItem:function(key){
            this.newPurchase.items.splice(key,1);
        },
        showAddModal:function(){
            if(this.products.length==0 || this.units.length==0){
                toastr.warning("Please wait until product list finished loading.");
                return false;
            }
            if(this.newPurchase.id!=0)
                this.newPurchase={
                    id:0,
                    items:[],
                    receipt_no:'',
                    reference_no:'',
                    supplier_id:0,
                    date_transaction:moment().format("YYYY-MM-DD"),
                    date_due:moment().format("YYYY-MM-DD"),
                    notes:'',
                    purchase_status:'pending',
                    purchase_data:{
                        vat_inclusive:0,
                        vat_enabled:0,
                        total_amount:0,
                        discount:0,
                        gross_amount:0,
                        vat_amount:0,
                        vat_rate:0,
                        net_amount:0,
                        paid_amount:0,
                        balance:0,
                        cash:0,
                    },
                    payment_data:[{method:'Cash',amount:0,details:''}]
                };
            $("#add-modal").modal("show");
        },
        addPurchase:function(event){
            for(var x=0;x<this.newPurchase.items.length;x++){
                if(this.newPurchase.items[x].quantity<1){
                    toastr.error("Positive quantity is required.");
                    return false;
                }
            }

            var $btn = $(event.target);
            $btn.button('loading');

            this.postData('../../purchases/addPurchase', this.newPurchase,function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully added purchase.");
                    $("#add-modal").modal("hide");
                    vue_purchases.refreshData();
                    vue_purchases.newPurchase.id=1;
                }
                else{
                    toastr.error(data.errors.toString());
                }
            },
            function(){
                $btn.button('reset');
            });
        },
        inProductUnits:function(unit_id, product){
            var units = this.getProductUnits(product);
            for(var x=0;x<units.length;x++){
                if(unit_id == Number(units[x].unit)){
                    return true;
                }
            }
            return false;
        },
        viewPurchase:function(purchase){
            if(this.products.length==0 || this.units.length==0){
                toastr.warning("Please wait until product list finished loading.");
                return false;
            }
            this.newPurchase={
                id:purchase.id,
                items:[],
                receipt_no:purchase.receipt_no,
                reference_no:purchase.reference_no,
                supplier_id:purchase.supplier_id,
                date_transaction:moment(purchase.date_transaction).format("YYYY-MM-DD"),
                date_due:moment(purchase.date_due).format("YYYY-MM-DD"),
                notes:purchase.notes,
                purchase_status:purchase.purchase_status,
                purchase_data:{
                    vat_inclusive:purchase.purchase_data.vat_inclusive,
                    vat_enabled:purchase.purchase_data.vat_enabled,
                    total_amount:purchase.purchase_data.total_amount,
                    discount:purchase.purchase_data.discount,
                    gross_amount:purchase.purchase_data.gross_amount,
                    vat_amount:purchase.purchase_data.vat_amount,
                    vat_rate:purchase.purchase_data.vat_rate,
                    net_amount:purchase.purchase_data.net_amount,
                    paid_amount:purchase.purchase_data.paid_amount,
                    balance:purchase.purchase_data.balance,
                    cash:purchase.purchase_cash,
                },
                payment_data:[]
            };

            for(var x=0;x<purchase.items.length;x++){
                var uu = false;
                if(this.inProductUnits(Number(purchase.items[x].unit), this.getProduct(purchase.items[x].product_id)) ){
                    uu = true
                }
                this.newPurchase.items.push({
                    product_id:purchase.items[x].product_id,
                    quantity:purchase.items[x].quantity,
                    purchase_price:purchase.items[x].purchase_price,
                    unit: uu?Number(purchase.items[x].unit):0,
                    unit_name:this.getUnitName(purchase.items[x].unit),
                    product:this.getProduct(purchase.items[x].product_id),
                    discount:purchase.items[x].discount,
                    unit_price:purchase.items[x].unit_price,
                    received_quantity:purchase.items[x].received_quantity
                });
            }

            for(var x=0;x<purchase.payment_data.length;x++){
                this.newPurchase.payment_data.push(purchase.payment_data[x]);
            }

            $("#add-modal").modal("show");
        },
        approvePurchase:function(event){
            this.newPurchase.purchase_status = 'approved';
            if(!this.updatePurchase(event)){
                this.newPurchase.purchase_status = 'pending';
            }
        },
        updatePurchase:function(event){
            for(var x=0;x<this.newPurchase.items.length;x++){
                if(this.newPurchase.items[x].quantity<1){
                    toastr.error("Positive quantity is required.");
                    return false;
                }

                if(this.newPurchase.items[x].unit == 0 || this.newPurchase.items[x].unit === undefined){
                    toastr.error(this.newPurchase.items[x].product.product_name + " has no unit.");
                    return false;
                }
            }

            if(!confirm("Changes will be commited, do you want to proceed?")){
                return false;
            }

            var $btn = $(event.target);
            $btn.button('loading');

            this.postData('../../purchases/updatePurchase', this.newPurchase,function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully "+(vue_purchases.newPurchase.purchase_status=='pending'?'updated':'approved')+" purchase.");
                    $("#add-modal").modal("hide");
                    vue_purchases.refreshData();
                }
                else{
                    toastr.error(data.errors.toString());
                }
            },
            function(){
                $btn.button('reset');
            });
        },
        voidPurchase:function(event){
            if(!confirm("Are you sure you want to void this purchase? Warning:inventory will also affected.")){
                return false;
            }

            var $btn = $(event.target);
            $btn.button('loading');

            this.postData('../../purchases/voidPurchase', {id:this.newPurchase.id},function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully voided purchase.");
                    $("#add-modal").modal("hide");
                    vue_purchases.refreshData();
                }
                else{
                    toastr.error(data.errors.toString());
                }
            },
            function(){
                $btn.button('reset');
            });
        },
        cancelPurchase:function(event){
            if(!confirm("Are you sure you want to cancel this purchase?")){
                return false;
            }



            this.postData('../../purchases/cancelPurchase', {id:this.newPurchase.id},function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully canceled purchase.");
                    $("#add-modal").modal("hide");
                    vue_purchases.refreshData();
                }
                else{
                    toastr.error(data.errors.toString());
                }
            },
            function(){
                $btn.button('reset');
            });
        },
        deletePurchase:function(purchase){
            this.postData('../../purchases/deletePurchase', {id:this.delete_id, password: this.confirmation_password},function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully deleted purchase.");
                    $("#delete-modal").modal("hide");
                    vue_purchases.confirmation_password = '';
                    vue_purchases.refreshData();
                    vue_purchases.delete_id = purchase.id;
                }
                else{
                    toastr.error(data.errors.toString());
                }
            });

        },
        showDeleteModal:function(purchase){
            this.delete_id = purchase.id;
            $("#delete-modal").modal("show");
        },
        addPayment:function(){
            this.newPurchase.payment_data.push({
                method:'Cash',
                amount:0,
                details:''
            });
        },
        removePayment:function(key){
            if(this.newPurchase.payment_data.length == 1){
                toastr.error("Unable to remove all payment.");
                return false;
            }
            this.newPurchase.payment_data.splice(key,1);
        },
        changeUnit:function(key){
            var price = 0;
            for(var x=0;x<this.getProduct(this.newPurchase.items[key].product_id).product_data.product_units.length;x++){
                if(this.getProduct(this.newPurchase.items[key].product_id).product_data.product_units[x].unit == this.newPurchase.items[key].unit){
                    price = this.getProduct(this.newPurchase.items[key].product_id).product_data.product_units[x].purchase_price;
                }
            }
            this.newPurchase.items[key].purchase_price = price;
            this.newPurchase.items[key].unit_price = price;
        },
        numberFormat:function(string){
            return Number(string).toLocaleString(undefined, { minimumFractionDigits: 2 });
        },
        dateFormat:function(string,format){
            return moment(string).format(format);
        },
        getUnitName:function(unit_id){
            for(var x=0;x<this.units.length;x++){
                if(unit_id == this.units[x].id){
                    return this.units[x].unit_name;
                }
            }
        },
        findBarcode:function(barcode){
            for(var x=0;x<this.products.length;x++){
                for(var y=0;y<this.products[x].product_data.product_units.length;y++){
                    if(this.products[x].product_data.product_units[y].bar_code == barcode){
                        return true;
                    }
                }
            }
            return false;
        },
        evaluate:function(item_key, from){
            var unit_price = this.newPurchase.items[item_key].unit_price;

            if(from=='discount'){
                this.newPurchase.items[item_key].purchase_price = unit_price - (unit_price*(this.newPurchase.items[item_key].discount/100));
            }
            else{
                this.newPurchase.items[item_key].purchase_price = unit_price;
            }
        },
        checkReceivedQuantity:function(key){
            if(this.newPurchase.items[key].received_quantity==''){
                toastr.error("Received Quantity is required.");
                this.newPurchase.items[key].received_quantity = this.newPurchase.items[key].quantity;
            }
            if(this.newPurchase.items[key].quantity<this.newPurchase.items[key].received_quantity){
                toastr.error("Received Quantity must be less than or equal to the Purchase Quantity");
                this.newPurchase.items[key].received_quantity = this.newPurchase.items[key].quantity;
            }
        },   
        moveItem:function(fromIndex, toIndex) {
            var element = this.newPurchase.items[fromIndex];
            this.newPurchase.items.splice(fromIndex, 1);
            this.newPurchase.items.splice(toIndex, 0, element);
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
                    return (vue_purchases.settings.product_search_length>=count);
                }
            });
        },
        total:function(){
            var total = 0;
            for(var x=0;x<this.newPurchase.items.length;x++){
                total+= this.newPurchase.items[x].purchase_price * this.newPurchase.items[x].quantity;
            }
            this.newPurchase.purchase_data.total_amount = total;
            return total;
        },
        gross_amount:function(){
            this.newPurchase.purchase_data.gross_amount = this.total - this.newPurchase.purchase_data.discount;
            return this.newPurchase.purchase_data.gross_amount;
        },
        vat:function(){
            var vat = 0;
            if(this.newPurchase.purchase_data.vat_enabled == 1){
                vat = this.gross_amount * (this.settings.default_vat_percentage/100);
            }
            this.newPurchase.purchase_data.vat_rate = this.settings.default_vat_percentage;
            this.newPurchase.purchase_data.vat_amount = vat;
            return vat;
        },
        net_amount:function(){
            var net_amount = this.gross_amount + this.vat;
            this.newPurchase.purchase_data.net_amount = net_amount;
            return net_amount;
        },
        payment_total:function(){
            var total = 0;
            for(var x = 0;x<this.newPurchase.payment_data.length;x++){
                total+=Number(this.newPurchase.payment_data[x].amount);
            }
            return total;
        },
        total_sum:function(){
            var total=0;
            for(var x=0;x<this.purchases.length;x++){
                if(this.status_select == 'all'){
                    total+=Number(this.purchases[x].purchase_data.net_amount);
                }
                else{
                    if(this.status_select == this.purchases[x].purchase_status){
                        total+=Number(this.purchases[x].purchase_data.net_amount);
                    }
                }
            }
            return total;
        },
        filtered:Pagination,
    },
    mounted:function(){
        this.getData('../../products/getProducts','products');
        setInterval(function(){
            vue_purchases.getData('../../products/getProducts','products');
        },20000);            
        
        setInterval(function(){
            vue_purchases.getData('../../purchases/getPurchases','purchases');
        },10000);  

        this.refreshData();
        this.getAuth();
        this.getSettings();
    }
});