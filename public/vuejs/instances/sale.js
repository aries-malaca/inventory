var vue_sales = new Vue({
    el:"#sales",
    data:{
        lock_price:true,
        confirmation_password:'',
        delete_id:0,
        pagination:[Filter('reference_no')],
        table:'sales',
        sales:[],
        clients:[],
        price_categories:[],
        newSale:{
            id:0,
            items:[],
            receipt_no:'',
            price_category_id:0,
            client_id:0,
            date_transaction:moment().format("YYYY-MM-DD"),
            date_due:moment().format("YYYY-MM-DD"),
            notes:'',
            sale_status:'sold',
            payment_data:[{method:'Cash',amount:0,details:''}],
            sale_data:{
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
                recent_sales_id:0
            }
        },
        products:[],
        auth:{},
        search:'',
        settings:{},
        units:[],
        status_select:'all'
    },
    methods:{
        getAuth:function(){
             $.get('../../users/getAuth', function(data){
                vue_sales.auth = data;
                vue_sales.newSale.to_branch_id = data.branch_id;
            }).
            fail(function(){
                vue_sales.getAuth();
            });
        },
        getSettings:function(){
             $.get('../../settings/getSettings', function(data){
                data.forEach(function(item,i){
                    vue_sales.settings[item.setting_name] = (item.setting_type=='string'?item.setting_value:Number(item.setting_value));
                });
                if(vue_sales.settings.auto_launch_sales_form == 1){
                    $("#add-modal").modal("show");
                }
            }).
            fail(function(){
                vue_sales.getSettings();
            });
        },
        getData:function(url, field){
            $.get(url, function(data){
                vue_sales[field] = [];
                data.forEach(function(item,i){
                    if(field == 'sales'){
                        item.sales_data = JSON.parse(item.sales_data);
                        item.payment_data = JSON.parse(item.payment_data);
                    }
                    if(field == 'products'){
                        item.units = vue_sales.getProductUnits(item);
                    }
                    vue_sales[field].push(item)
                });
            }).
            fail(function(){
                vue_sales.getData(url, field);
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
        postData:function(url, inputs, callback){
            $.ajax({
                method:'post',
                url:url,
                data:inputs,
                success:callback
            });
        },
        refreshData:function(){
            this.getData('../../clients/getClients','clients');
            this.getData('../../sales/getSales','sales');
            this.getData('../../products/getPriceCategories','price_categories');
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
        },
        getPurchasePrice:function(product,unit_id){
            var units = [];
            for(var x=0;x<product.product_data.product_units.length;x++){
                if(product.product_data.product_units[x].unit == unit_id){
                    return Number(product.product_data.product_units[x].purchase_price);
                }
            }
            return 0;
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

            if(this.newSale.price_category_id <= 0 || this.newSale.price_category_id == undefined){
                toastr.error("Please select price category.");
                return;
            }

            var item_exists_key = false;
            for(var x=0;x<this.newSale.items.length;x++){
                if(this.newSale.items[x].product_id == product.id && unit_id == this.newSale.items[x].unit ){
                    item_exists_key = x;
                    break;
                }
            }
            if(item_exists_key === false){
                var selling_price = 0;
                for(var x=0; x<product.product_data.product_units.length;x++){
                    if(product.product_data.product_units[x].unit == unit_id){
                        if(product.product_data.product_units[x].stocks <qt){
                            toastr.error("Not enough stocks.");
                            return false;
                        }

                        for(var y=0;y<product.product_data.product_units[x].selling_price.length;y++){
                            if(this.newSale.price_category_id ==  product.product_data.product_units[x].selling_price[y].id){
                                selling_price = product.product_data.product_units[x].selling_price[y].value; 
                            }
                        }
                    }
                }
                var quantity = qt;
                var sold_quantity = qt;
                if(!isNaN(event)){
                    quantity = 1;
                    sold_quantity = 1;
                }
                this.newSale.items.push({
                    product_id:product.id,
                    quantity:quantity,
                    product:product,
                    original_price:selling_price,
                    discount:0,
                    unit:unit_id,
                    purchase_price:this.getPurchasePrice(product,unit_id),
                    unit_name:this.getUnitName(unit_id),
                    selling_price:selling_price,
                    sold_quantity:sold_quantity
                });
            }
            else{
                for(var x=0; x<product.product_data.product_units.length;x++){
                    if(product.product_data.product_units[x].unit == unit_id){
                        if(product.product_data.product_units[x].stocks <= this.newSale.items[item_exists_key].quantity ){
                            toastr.error("Not enough stocks.");
                            return false;
                        }
                    }
                }

                this.newSale.items[item_exists_key].quantity ++;
                this.newSale.items[item_exists_key].sold_quantity ++;
            } 
        },
        removeItem:function(key){
            this.newSale.items.splice(key,1);
        },
        showAddModal:function(){
            if(this.products.length==0 || this.units.length==0){
                toastr.warning("Please wait until product list finished loading.");
                return false;
            }
            if(this.newSale.id!=0){
                this.newSale={
                    id:0,
                    items:[],
                    receipt_no:'',
                    price_category_id:0,
                    client_id:0,
                    branch_id:0,
                    date_transaction:moment().format("YYYY-MM-DD"),
                    date_due:moment().format("YYYY-MM-DD"),
                    notes:'',
                    sale_status:'sold',
                    payment_data:[{method:'Cash',amount:0,details:''}],
                    sale_data:{
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
                        recent_sales_id:0
                    }
                };
            }
            this.newSale.client_id = vue_sales.settings.default_client_id;
            this.changeClient();
            
            $("#add-modal").modal("show");
            $.get('../../sales/getTempID',function(data){
                vue_sales.newSale.receipt_no = data;
            });
        },
        checkoutSale:function(){
            for(var x=0;x<this.newSale.items.length;x++){
                if(this.newSale.items[x].quantity<1){
                    toastr.error("Positive quantity is required.");
                    return false;
                }
                if(!this.checkStocks(x)){
                    return false;
                }
            }
            if(this.newSale.id != 0)
                this.newSale.sale_status = 'sold';
            
            this.postData('../../sales/checkoutSale', this.newSale,function(data){
                if(data.result == 'success'){
                    vue_sales.refreshData();
                    toastr.success("Successfully added sale.");
                    if(vue_sales.newSale.sale_status == 'sold'){
                        if(confirm("Do you want to print receipt?")){
                            window.open('../../sales/printReceipt/'+data.id);
                        }
                    }
                    vue_sales.newSale.id=1;
                    $("#add-modal").modal("hide");
                }
                else{
                    toastr.error(data.errors.toString());
                }
            });
        },

        updateSale:function(){
            for(var x=0;x<this.newSale.items.length;x++){
                if(this.newSale.items[x].quantity<1){
                    toastr.error("Positive quantity is required.");
                    return false;
                }
            }

            if(!confirm("Changes will be commited, do you want to proceed?")){
                return false;
            }
            this.postData('../../sales/checkoutSale', this.newSale,function(data){
                if(data.result == 'success'){
                    vue_sales.refreshData();
                    toastr.success("Successfully updated sale.");
                    $("#add-modal").modal("hide");
                }
                else{
                    toastr.error(data.errors.toString());
                }
            });
        },
        viewSale:function(sale){
            if(this.products.length==0 || this.units.length==0){
                toastr.warning("Please wait until product list finished loading.");
                return false;
            }
            this.newSale ={
                id:sale.id,
                items:[],
                receipt_no:sale.receipt_no,
                client_id:sale.client_id,
                branch_id:sale.branch_id,
                price_category_id:sale.price_category_id,
                date_transaction:moment(sale.date_transaction).format("YYYY-MM-DD"),
                date_due:moment(sale.date_due).format("YYYY-MM-DD"),
                notes:sale.notes,
                sale_status:sale.sales_status,
                payment_data:[],
                sale_data:{
                    vat_inclusive:sale.sales_data.vat_inclusive,
                    vat_enabled:sale.sales_data.vat_enabled,
                    total_amount:sale.sales_data.total_amount,
                    discount:sale.sales_data.discount,
                    gross_amount:sale.sales_data.gross_amount,
                    vat_amount:sale.sales_data.vat_amount,
                    vat_rate:sale.sales_data.vat_rate,
                    net_amount:sale.sales_data.net_amount,
                    paid_amount:sale.sales_data.paid_amount,
                    balance:sale.sales_data.balance,
                    cash:sale.sales_data.cash,
                    recent_sales_id:0
                }
            }

            for(var x=0;x<sale.items.length;x++){
                this.newSale.items.push({
                    product_id:sale.items[x].product_id,
                    quantity:sale.items[x].quantity,
                    original_price:sale.items[x].original_price,
                    unit:sale.items[x].unit,
                    unit_name:this.getUnitName(sale.items[x].unit),
                    product:this.getProduct(sale.items[x].product_id),
                    discount:sale.items[x].discount,
                    selling_price:sale.items[x].selling_price,
                    sold_quantity:sale.items[x].sold_quantity,
                    purchase_price:this.getPurchasePrice(this.getProduct(sale.items[x].product_id),sale.items[x].unit),
                });
            }

            for(var x=0;x<sale.payment_data.length;x++){
                this.newSale.payment_data.push(sale.payment_data[x]);
            }


            $("#add-modal").modal("show");
        },
        voidSale:function(){
            if(!confirm("Are you sure you want to void this sale? Warning:inventory will also affected.")){
                return false;
            }
            this.postData('../../sales/voidSale', {id:this.newSale.id},function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully voided sale.");
                    $("#add-modal").modal("hide");
                    vue_sales.refreshData();
                }
                else{
                    toastr.error(data.errors.toString());
                }
            });
        },
        cancelSale:function(){
            if(!confirm("Are you sure you want to cancel this sale?")){
                return false;
            }
            this.postData('../../sales/cancelSale', {id:this.newSale.id},function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully canceled sale.");
                    $("#add-modal").modal("hide");
                    vue_sales.refreshData();
                }
                else{
                    toastr.error(data.errors.toString());
                }
            });
        },
        deleteSale:function(sale){
            this.postData('../../sales/deleteSale', {id:this.delete_id, password: this.confirmation_password},function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully deleted sales.");
                    $("#delete-modal").modal("hide");
                    vue_sales.confirmation_password = '';
                    vue_sales.refreshData();
                    vue_sales.delete_id = sale.id;
                }
                else{
                    toastr.error(data.errors.toString());
                }
            });

        },
        lockPrice:function(){
            this.lock_price = true;
        },
        showUnlockModal:function(){
            $("#unlock-modal").modal("show");
        },
        unlockPrice:function(){
            if(this.confirmation_password == this.settings.transaction_password){
                $("#unlock-modal").modal("hide");
                this.lock_price=false;
                this.confirmation_password = '';
            }
            else{
                toastr.error('Invalid password.');
            }
        },
        showDeleteModal:function(sale){
            this.delete_id = sale.id;
            $("#delete-modal").modal("show");
        },
        numberFormat:function(string){
            return Number(string).toLocaleString(undefined, { minimumFractionDigits: 2 });
        },
        dateFormat:function(string,format){
            return moment(string).format(format);
        },
        addPayment:function(){
            this.newSale.payment_data.push({
                method:'Cash',
                amount:0,
                details:''
            });
        },
        removePayment:function(key){
            if(this.newSale.payment_data.length == 1){
                toastr.error("Unable to remove all payment.");
                return false;
            }
            this.newSale.payment_data.splice(key,1);
        },
        changeClient:function(){
            for(var x=0;x<this.clients.length;x++){
                if(this.newSale.client_id == this.clients[x].id){
                    this.newSale.price_category_id = this.clients[x].price_category_id;
                }
            }        
        },
        changePrice:function(){
            for(var x=0;x<this.newSale.items.length;x++){
                for(var y=0;y<this.getProduct(this.newSale.items[x].product_id).product_data.product_units.length;y++){
                    if(this.getProduct(this.newSale.items[x].product_id).product_data.product_units[y].unit == this.newSale.items[x].unit){
                        for(var z=0;z<this.getProduct(this.newSale.items[x].product_id).product_data.product_units[y].selling_price.length;z++){
                            if(this.getProduct(this.newSale.items[x].product_id).product_data.product_units[y].selling_price[z].id== this.newSale.price_category_id){
                                this.newSale.items[x].original_price = this.getProduct(this.newSale.items[x].product_id).product_data.product_units[y].selling_price[z].value;
                                this.newSale.items[x].selling_price = this.getProduct(this.newSale.items[x].product_id).product_data.product_units[y].selling_price[z].value;
                            }
                        }
                    }
                }
            }    
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
        changeUnit:function(key){
            var price = 0;
            var purchase_price = 0;
            for(var x=0;x<this.getProduct(this.newSale.items[key].product_id).product_data.product_units.length;x++){
                if(this.getProduct(this.newSale.items[key].product_id).product_data.product_units[x].unit == this.newSale.items[key].unit){
                    purchase_price = Number(this.getProduct(this.newSale.items[key].product_id).product_data.product_units[x].purchase_price);
                    for(var y =0; y<this.getProduct(this.newSale.items[key].product_id).product_data.product_units[x].selling_price.length;y++){
                        if(this.newSale.price_category_id == this.getProduct(this.newSale.items[key].product_id).product_data.product_units[x].selling_price[y].id)
                            price = this.getProduct(this.newSale.items[key].product_id).product_data.product_units[x].selling_price[y].value;
                    }
                }
            }
            this.newSale.items[key].selling_price = price;
            this.newSale.items[key].original_price = price;
            this.newSale.items[key].purchase_price = purchase_price;
        },
        checkStocks:function(key){
            for(var x=0;x<this.getProduct(this.newSale.items[key].product_id).product_data.product_units.length;x++){
                if(this.getProduct(this.newSale.items[key].product_id).product_data.product_units[x].unit == this.newSale.items[key].unit){
                    if(this.getProduct(this.newSale.items[key].product_id).product_data.product_units[x].stocks<this.newSale.items[key].quantity){
                        toastr.error("Not enough quantity");
                        this.newSale.items[key].quantity = this.getProduct(this.newSale.items[key].product_id).product_data.product_units[x].stocks;
                        return false;
                    }
                }
            }
            this.newSale.items[key].sold_quantity = this.newSale.items[key].quantity;
            return true;
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
        printReceipt:function(){
            window.open('../../sales/printReceipt/'+this.newSale.id);
        },        
        setPage: SetPage,
        setOrderBy:SetOrderBy,
    },
    computed:{
        product_search:function(){
            var count = 0;
            if(this.products.lenghh==0){
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
                    return (vue_sales.settings.product_search_length>=count);
                }
            });
        },
        total:function(){
            var total = 0;
            for(var x=0;x<this.newSale.items.length;x++){
                total+= this.newSale.items[x].selling_price * this.newSale.items[x].quantity;
            }
            this.newSale.sale_data.total_amount = total;
            return total;
        },
        gross_amount:function(){
            this.newSale.sale_data.gross_amount = this.total - this.newSale.sale_data.discount;
            return this.newSale.sale_data.gross_amount;
        },
        vat:function(){
            var vat = 0;
            if(this.newSale.sale_data.vat_enabled == 1){
                vat = this.gross_amount * (this.settings.default_vat_percentage/100);
            }
            this.newSale.sale_data.vat_rate = this.settings.default_vat_percentage;
            this.newSale.sale_data.vat_amount = vat;
            return vat;
        },
        net_amount:function(){
            var net_amount = this.gross_amount + this.vat;
            this.newSale.sale_data.net_amount = net_amount;
            return net_amount;
        },
        payment_total:function(){
            var total = 0;
            for(var x = 0;x<this.newSale.payment_data.length;x++){
                total+=Number(this.newSale.payment_data[x].amount);
            }
            return total;
        },
        total_sum:function(){
            var total=0;
            for(var x=0;x<this.sales.length;x++){
                if(this.status_select == 'all'){
                    total+=Number(this.sales[x].sales_data.net_amount);
                }
                else{
                    if(this.status_select == this.sales[x].sales_status){
                        total+=Number(this.sales[x].sales_data.net_amount);
                    }
                }
            }
            return total;
        },
        filtered:Pagination,
    },
    mounted:function(){
        this.refreshData();
        this.getAuth();
        this.getSettings();
        $.get('../../sales/getTempID',function(data){
            vue_sales.newSale.receipt_no = data;
        });
        this.getData('../../products/getProducts','products');
        setInterval(function(){
            vue_sales.getData('../../products/getProducts','products');
        },20000);  
    }
});