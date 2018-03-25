var vue_products = new Vue({
    el:"#products",
    data:{
        pagination:[Filter('product_name'), Filter('category_name')],
        table:'filtered_products',
        table1:'categories',
        show_inactive:false,
        price_history:[],
        newProduct:{
            id:0,
            brand_name:'',
            product_code:'',
            product_description:'',
            size:'',
            category_id:0,
            product_data:{
                product_units:[
                    {
                        unit:0,
                        info:'',
                        purchase_price:"",
                        selling_price:[],
                        quantity:1,
                        bar_code:''
                    }
                ]
            },
            pictures_data:[],
            is_active:1
        },
        newCategory:{
            id:0,
            category_name:'',
        },
        newPriceCategory:{
            id:0,
            price_category_name:'',
            default_markup:5,
            minimum_purchase:0
        },
        products:[],
        categories:[],
        price_categories:[],
        units:[],
        auth:{},
        inventory:{
            product_name:'',
            units:[]
        },
        convertStocks:{
            product_id:0,
            from_unit:0,
            to_unit:0,
            from_quantity:0,
            to_quantity:0
        },
        filter_category:0
    },
    methods:{
        dateFormat:function(string,format){
            return moment(string).format(format);
        },
        numberFormat:function(value){
            return Number(value).toFixed(2);
        },
        checkQ:function(){
            for(var x=0;x<this.inventory.units.length;x++){
                if(this.convertStocks.from_unit == Number(this.inventory.units[x].unit)){
                    if(this.convertStocks.from_quantity>this.inventory.units[x].stocks){
                        toastr.error("Available stocks : " + this.inventory.units[x].stocks);
                        this.convertStocks.from_quantity = this.inventory.units[x].stocks;
                    }
                }
            }
        },
        viewInventory:function(product){
            this.inventory.product_name = this.product_name(product);
            this.inventory.units = [];
            for(var x=0;x<product.product_data.product_units.length;x++){
                this.inventory.units.push(product.product_data.product_units[x]);
            }
            this.convertStocks.product_id = product.id;
            $("#inventory-modal").modal("show");
        },
        proceedConvert:function(){
            if(!confirm("Do you want to proceed?")){
                return false;
            }
            this.convertStocks.to_quantity = this.outputQuantity;
            this.postData('../../products/proceedConvert', this.convertStocks, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully converted unit.");
                    vue_products.getData('../../products/getProducts','products');
                    vue_products.convertStocks = {
                        product_id:0,
                        from_unit:0,
                        to_unit:0,
                        from_quantity:0,
                        to_quantity:0
                    };
                    $("#inventory-modal").modal("hide");
                }
                else{
                    toastr.error("Failed to convert. " + data.errors.toString());
                }
            });
        },
        getAuth:function(){
             $.get('../../users/getAuth', function(data){
                vue_products.auth = data;
            }).
            fail(function(){
                vue_products.getAuth();
            });
        },
        getData:function(url, field){
            $.get(url, function(data){
                vue_products[field] = [];
                data.forEach(function(item,i){
                    vue_products[field].push(item)
                    if(field == 'unit' && i==0){
                        vue_products.newProduct.product_data.product_units[0].unit = item.id;
                    }
                });
            }).
            fail(function(){
                vue_products.getData(url,field);
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
            this.getData('../../products/getPriceCategories','price_categories');
            this.getData('../../products/getCategories','categories');
            this.getData('../../products/getProducts','products');
            this.getData('../../settings/getUnits','units');
        },
        addProduct:function(){
            if(!this.isPriceValid()){
                toastr.error("Selling price should be greather than purchase price");
                return false;
            }
            this.postData('../../products/addProduct', this.newProduct, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully added product.");
                    vue_products.getData('../../products/getProducts','products');
                    vue_products.clearProductForm();
                    $("#add-product-modal").modal("hide");
                }
                else{
                    toastr.error("Failed to add product. " + data.errors.toString());
                }
            });
        },
        updateProduct:function(){
            if(!this.isPriceValid()){
                toastr.error("Selling price should be greather than purchase price");
                return false;
            }
            this.postData('../../products/updateProduct', this.newProduct, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully updated product.");
                    vue_products.getData('../../products/getProducts','products');
                    vue_products.clearProductForm();
                    $("#add-product-modal").modal("hide");
                }
                else{
                    toastr.error("Failed to update product. " + data.errors.toString());
                }
            });
        },
        editProduct:function(product){
            this.newProduct = {
                id:product.id,
                brand_name:product.brand_name,
                product_code:product.product_code,
                product_description:product.product_description,
                size:product.size,
                category_id:product.category_id,
                product_data:{
                    product_units:[]
                },
                purchases:[],
                pictures_data:[],
                is_active:product.is_active
            };

            
            product.purchases.forEach(function(item){
                vue_products.newProduct.purchases.push(item);
            });

            product.product_data.product_units.forEach(function(item){
                var selling_price = [];
                for(var x=0;x<item.selling_price.length;x++){
                    selling_price.push(item.selling_price[x]);
                }
                vue_products.newProduct.product_data.product_units.push(
                    {
                        unit:item.unit,
                        info:item.info,
                        purchase_price:item.purchase_price,
                        selling_price:selling_price,
                        quantity:item.quantity,
                        bar_code:item.bar_code
                    }
                );
            });

            $("#add-product-modal").modal("show");
        },
        addCategory:function(){
            this.postData('../../products/addCategory', this.newCategory, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully added product category");
                    vue_products.getData('../../products/getCategories','categories');
                    vue_products.clearCategoryForm();
                    $("#add-category-modal").modal("hide");
                }
                else{
                    toastr.error("Failed to add product category. " + data.errors.toString());
                }
            });
        },
        updateCategory:function(){
            this.postData('../../products/updateCategory', this.newCategory, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully updated product category");
                    vue_products.getData('../../products/getCategories','categories');
                    vue_products.clearCategoryForm();
                    $("#add-category-modal").modal("hide");
                }
                else{
                    toastr.error("Failed to updated product category. " + data.errors.toString());
                }
            });
        },
        editCategory:function(category){
            this.newCategory = {
                category_name:category.category_name,
                id:category.id
            }
            $("#add-category-modal").modal("show");
        },
        deleteCategory:function(category){
            if(!confirm("Are you sure you want to delete this category?")){
                return false;
            }

            this.postData('../../products/deleteCategory', {id:category.id}, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully deleted product category");
                    vue_products.refreshData();
                }
                else{
                    toastr.error("Failed to delete product category. " + data.errors.toString());
                }
            });
        },
        addPriceCategory:function(){
            if(this.newPriceCategory.default_markup<0){
                toastr.error("Default markup cannot be negative value.");
                return false;
            }
            this.postData('../../products/addPriceCategory', this.newPriceCategory, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully added price category");
                    $("#add-pricecategory-modal").modal("hide");
                    vue_products.getData('../../products/getPriceCategories','price_categories');
                    vue_products.clearPriceCategoryForm();
                }
                else{
                    toastr.error("Failed to add price category. " + data.errors.toString());
                }
            });
        },
        updatePriceCategory:function(){
            if(this.newPriceCategory.default_markup<0){
                toastr.error("Default markup cannot be negative value.");
                return false;
            }
            this.postData('../../products/updatePriceCategory', this.newPriceCategory, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully updated price category");
                    vue_products.getData('../../products/getPriceCategories','price_categories');
                    vue_products.clearPriceCategoryForm();
                    $("#add-pricecategory-modal").modal("hide");
                }
                else{
                    toastr.error("Failed to update price category. " + data.errors.toString());
                }
            });
        },
        editPriceCategory:function(category){
            this.newPriceCategory ={
                id:category.id,
                price_category_name:category.price_category_name,
                default_markup:category.default_markup,
                minimum_purchase:category.minimum_purchase
            }
            $("#add-pricecategory-modal").modal("show");
        },
        deletePriceCategory:function(category){
            if(!confirm("Are you sure you want to delete this price category?")){
                return false;
            }

            this.postData('../../products/deletePriceCategory', {id:category.id}, function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully deleted price category");
                    vue_products.refreshData();
                }
                else{
                    toastr.error("Failed to delete price category. " + data.errors.toString());
                }
            });
        },
        showAddModal:function(what){
            if(what == 'product'){
                if(this.newProduct.id != 0 || this.newProduct.product_data.product_units[0].selling_price.length==0){
                    this.clearProductForm();
                }
                $("#add-product-modal").modal("show");
            }
            else if(what == 'category'){
                if(this.newCategory.id != 0){
                    this.clearCategoryForm();
                }
                $("#add-category-modal").modal("show");
            }
            else if(what == 'pricecategory'){
                if(this.newPriceCategory.id != 0){
                    this.clearPriceCategoryForm();
                }
                $("#add-pricecategory-modal").modal("show");
            }
        },
        moveUnit:function(fromIndex, toIndex) {
            var element = this.newProduct.product_data.product_units[fromIndex];
            this.newProduct.product_data.product_units.splice(fromIndex, 1);
            this.newProduct.product_data.product_units.splice(toIndex, 0, element);
            this.newProduct.product_data.product_units[0].quantity = 1;
        },
        clearProductForm:function(){
            this.newProduct = {
                id:0,
                brand_name:'',
                product_code:'',
                product_description:'',
                size:'',
                category_id:0,
                product_data:{
                    product_units:[
                        {
                            unit:this.units[0].id,
                            info:'',
                            purchase_price:0,
                            selling_price:[],
                            quantity:1,
                            bar_code:''
                        }
                    ]
                },
                pictures_data:[],
                is_active:1
            }
            $.get('../../products/getTempID',function(data){
                vue_products.newProduct.product_code = data;
            }).
            fail(function(){
                vue_products.clearProductForm();
            });

            for(var x=0;x<this.price_categories.length;x++){
                this.newProduct.product_data.product_units[0].selling_price.push(
                    {
                        id:this.price_categories[x].id,
                        value:""
                    }
                );
            }
        },
        cloneProduct:function(product){
            this.editProduct(product);
            toastr.info("You've cloned a product, Please click save after you made some changes.");
            $.get('../../products/getTempID',function(data){
                vue_products.newProduct.product_code = data;
            });
            this.newProduct.id = 0;
        },
        clearCategoryForm:function(){
            this.newCategory ={
                id:0,
                category_name:''
            }
        },
        clearPriceCategoryForm:function(){
            this.newPriceCategory ={
                id:0,
                price_category_name:'',
                default_markup:5,
                minimum_purchase:0
            }
        },
        product_name:function(product){
            return (product.brand_name==null?'':product.brand_name) + ' ' + product.product_description + ' ' + product.size;
        },
        getPrice:function(price_category_id){
            for(var x=0;x<this.price_categories.length;x++){
                if(this.price_categories[x].id == price_category_id)
                    return this.price_categories[x];
            }
        },
        evaluate:function(event, unit_key, price_key){
            if(event.target.classList[1] == 'integer'){
                this.newProduct.product_data.product_units[unit_key].selling_price[price_key].value = (Number(event.target.value) + Number(this.newProduct.product_data.product_units[unit_key].purchase_price)).toFixed(2);
            }
            if(event.target.classList[1] == 'percent'){
                var percentage = Number(event.target.value)/100;
                this.newProduct.product_data.product_units[unit_key].selling_price[price_key].value =  (Number(this.newProduct.product_data.product_units[unit_key].purchase_price) + (percentage*Number(this.newProduct.product_data.product_units[unit_key].purchase_price))).toFixed(2);
            }

        },
        applyDefaultMarkup:function(){
            this.newProduct.product_data.product_units.forEach(function(item,i){
                for(var x=0; x<vue_products.newProduct.product_data.product_units[i].selling_price.length;x++){
                    var price = vue_products.getPrice(vue_products.newProduct.product_data.product_units[i].selling_price[x].id);
                    var percentage = Number(price.default_markup)/100;
                    vue_products.newProduct.product_data.product_units[i].selling_price[x].value = (Number(vue_products.newProduct.product_data.product_units[i].purchase_price) + (percentage*Number(vue_products.newProduct.product_data.product_units[i].purchase_price))).toFixed(2);
                }
            });
        },
        isPriceValid:function(){
            return true;
        },
        getProduct:function(product_id){
            for(var x=0;x<this.products.length;x++){
                if(product_id == this.products[x].id){
                    return this.products[x];
                }
            }
            return false;
        },
        addUnit:function(){
            var available_unit = this.availableUnit();
            if(available_unit === false){
                toastr.error("No unit available.");
                return false;
            }
            this.newProduct.product_data.product_units.push({
                info:'',
                purchase_price:0,
                unit:available_unit,
                quantity:10,
                selling_price:[]
            });

            for(var x=0;x<this.price_categories.length;x++){
                this.newProduct.product_data.product_units[this.newProduct.product_data.product_units.length-1].selling_price.push(
                    {
                        id:this.price_categories[x].id,
                        value:0
                    }
                );
            }
        },
        availableUnit:function(){
            var unit = false;
            for(var x=0;x<this.units.length;x++){
                var i = false;
                for(var y=0;y<this.newProduct.product_data.product_units.length;y++){
                    if(this.units[x].id == this.newProduct.product_data.product_units[y].unit){
                        i = true;
                        break;
                    }
                }

                if(i == false){
                    return this.units[x].id;
                }
            }
            return false;
        },
        isUnitTaken:function(key, unit_id){
            for(var x=0;x<this.newProduct.product_data.product_units.length;x++){
                if (unit_id == this.newProduct.product_data.product_units[x].unit && key != x)
                    return true;
            }
            return false;
        },
        removeUnit:function(key){
            if(this.newProduct.product_data.product_units.length == 1){
                toastr.error("Unable to remove all rows.");
                return false;
            }
            this.newProduct.product_data.product_units.splice(key,1);
        },
        getUnitName:function(unit_id){
            for(var x=0;x<this.units.length;x++){
                if(unit_id == this.units[x].id){
                    return this.units[x].unit_name;
                }
            }
        },
        fillPrices:function(key){
            var current_price = this.newProduct.product_data.product_units[key].purchase_price;
            var o = key;
            while(key>0){
                key--;
                this.newProduct.product_data.product_units[key].purchase_price = this.newProduct.product_data.product_units[key+1].quantity * this.newProduct.product_data.product_units[key+1].purchase_price;
            }

            while(o<(this.newProduct.product_data.product_units.length-1)){
                o++;
                this.newProduct.product_data.product_units[o].purchase_price = this.newProduct.product_data.product_units[o-1].purchase_price / this.newProduct.product_data.product_units[o].quantity;
            }
        },
        showProductInfo:function(product){
            this.newProduct = {
                id:product.id,
                brand_name:product.brand_name,
                product_code:product.product_code,
                product_description:product.product_description,
                size:product.size,
                category_id:product.category_id,
                product_data:{
                    product_units:[]
                },
                pictures_data:[],
                purchases:[],
                is_active:product.is_active
            };
            product.purchases.forEach(function(item){
                vue_products.newProduct.purchases.push(item);
            });

            product.product_data.product_units.forEach(function(item){
                var selling_price = [];
                for(var x=0;x<item.selling_price.length;x++){
                    selling_price.push(item.selling_price[x]);
                }
                vue_products.newProduct.product_data.product_units.push(
                    {
                        unit:item.unit,
                        info:item.info,
                        purchase_price:item.purchase_price,
                        selling_price:selling_price,
                        quantity:item.quantity,
                        bar_code:item.bar_code
                    }
                );
            });
            this.getData('../../purchases/getPriceHistory/'+product.id,'price_history');
            $("#product-info-modal").modal("show");
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
        filtered1:Pagination1,
        filtered_products:function(){
            return this.products.filter(function(item){
                if(!item.is_active && !vue_products.show_inactive){
                    return false;
                }
                if(vue_products.filter_category == 0 || item.category_id == vue_products.filter_category)
                    return true;
            });
        },
        outputQuantity:function(){
            var quantity = 1;
            var from_key = false;
            var to_key = false;
            for(var x=0;x<this.inventory.units.length;x++){
                if(Number(this.inventory.units[x].unit) == this.convertStocks.from_unit){
                    from_key = x;
                }
                else if (Number(this.inventory.units[x].unit) == this.convertStocks.to_unit){
                    to_key = x;
                }
            }
            if(to_key !== false && from_key !== false){
                var t_t = to_key;
                var f_t = from_key;
                if(from_key<to_key){
                    while(from_key<to_key){
                        quantity *= this.inventory.units[to_key].quantity * this.convertStocks.from_quantity;
                        to_key--;
                    }
                }
                else if(from_key>to_key){
                    while(from_key>to_key){
                        quantity = (this.convertStocks.from_quantity/this.inventory.units[from_key].quantity);
                        from_key--;
                    }
                    if((f_t-t_t) > 1){
                        return 0;
                    }
                }
                return quantity;
            }
            return 0;
        }
    },
    mounted:function(){
        this.refreshData();
        this.getAuth();
        $.get('../../products/getTempID',function(data){
            vue_products.newProduct.product_code = data;
        });
    }
});