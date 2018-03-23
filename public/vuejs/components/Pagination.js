var Pagination = function () {
    var data = this[this["table"]];
    var t = this;
    var _pagination_index=0;

    if(data.length==0){
        return [];
    }
    var s = this.pagination[_pagination_index].search;
    var p = this.pagination[_pagination_index].per_page;
    var c = this.pagination[_pagination_index].current_page;

    var count = 0;
    var l = 0;


    var searched = data.filter(function(o){
        if((JSON.stringify(o).indexOf(s)!=-1 ||
            JSON.stringify(o).toLowerCase().indexOf(s)!=-1 ||
            s =='' ) ){
            l++;
            return true;
        }
    });

    this.pagination[_pagination_index].original_length = l;

    if(this.pagination[_pagination_index].current_page > Math.ceil(this.pagination[_pagination_index].original_length/p) ){
        this.pagination[_pagination_index].current_page = 1;
    }

    if(this.pagination[_pagination_index].sort_order==1){
        searched.sort(function(a, b) {
             if(t.pagination[_pagination_index].sort_by=='category_name'){
                var fa = (a['category_name'] > b['category_name']) ? 0 : -1;
             }
             else{
                 var fa = (a['product_name'] > b['product_name']) ? 0 : -1;
             }
             
             if(t["table"] == 'filtered_products')
                fa = -1;
             return (a[t.pagination[_pagination_index].sort_by] > b[t.pagination[_pagination_index].sort_by] ? 1 : fa) } ).slice(0, 5);
    }
    else{
        searched.sort(function(a, b) {
             if(t.pagination[_pagination_index].sort_by=='category_name'){
                var fa = (a['category_name'] < b['category_name']) ? 0 : -1;
             }
             else{
                 var fa = (a['product_name'] < b['product_name']) ? 0 : -1;
             }
            if(t["table"] == 'filtered_products')
                fa = -1;
            return (a[t.pagination[_pagination_index].sort_by] < b[t.pagination[_pagination_index].sort_by] ? 1 : fa) 
        }).slice(0, 5);
    }

    return searched.filter(function (o,key) {
        if(! (count>=p || key< ((c - 1) * p) ) ) {
            count++;
            return true;
        }
    });
};


var Pagination1 = function () {
    var data = this[this["table1"]];
    var _pagination_index=1;
    var t = this;
    if(data.length==0){
        return [];
    }
    var s = this.pagination[_pagination_index].search;
    var p = this.pagination[_pagination_index].per_page;
    var c = this.pagination[_pagination_index].current_page;
    var count = 0;
    var l = 0;

    var searched = data.filter(function(o){
        if((JSON.stringify(o).indexOf(s)!=-1 ||
            JSON.stringify(o).toLowerCase().indexOf(s)!=-1 ||
            s =='' ) ){
            l++;
            return true;
        }
    });

    this.pagination[_pagination_index].original_length = l;

    if(this.pagination[_pagination_index].current_page > Math.ceil(this.pagination[_pagination_index].original_length/p) ){
        this.pagination[_pagination_index].current_page = 1;
    }

    if(this.pagination[_pagination_index].sort_order==1){
        searched.sort(function(a, b) { return (a[t.pagination[_pagination_index].sort_by] > b[t.pagination[_pagination_index].sort_by] ? 1 : -1) } ).slice(0, 5);
    }
    else{
        searched.sort(function(a, b) { return (a[t.pagination[_pagination_index].sort_by] < b[t.pagination[_pagination_index].sort_by] ? 1 : -1) }).slice(0, 5);
    }


    return searched.filter(function (o,key) {
        if(! (count>=p || key< ((c - 1) * p) ) ) {
            count++;
            return true;
        }
    });
};


var Pagination2 = function () {
    var data = this[this["table2"]];
    var _pagination_index=2;
    var t = this;

    if(data.length==0){
        return [];
    }
    var s = this.pagination[_pagination_index].search;
    var p = this.pagination[_pagination_index].per_page;
    var c = this.pagination[_pagination_index].current_page;

    var count = 0;
    var l = 0;

    var searched = data.filter(function(o){
        if((JSON.stringify(o).indexOf(s)!=-1 ||
            JSON.stringify(o).toLowerCase().indexOf(s)!=-1 ||
            s =='' ) ){
            l++;
            return true;
        }
    });

    this.pagination[_pagination_index].original_length = l;

    if(this.pagination[_pagination_index].current_page > Math.ceil(this.pagination[_pagination_index].original_length/p) ){
        this.pagination[_pagination_index].current_page = 1;
    }

    if(this.pagination[_pagination_index].sort_order==1){
        searched.sort(function(a, b) { return (a[t.pagination[_pagination_index].sort_by] > b[t.pagination[_pagination_index].sort_by] ? 1 : -1) } ).slice(0, 5);
    }
    else{
        searched.sort(function(a, b) { return (a[t.pagination[_pagination_index].sort_by] < b[t.pagination[_pagination_index].sort_by] ? 1 : -1) }).slice(0, 5);
    }


    return searched.filter(function (o,key) {
        if(! (count>=p || key< ((c - 1) * p) ) ) {
            count++;
            return true;
        }
    });
};

var SetPage = function(number,_pagination_index){
    this.pagination[_pagination_index].current_page = number;
};

var SetOrderBy = function(field,_pagination_index){
    if(this.pagination[_pagination_index].sort_by==field && this.pagination[_pagination_index].sort_order!= -1){
        this.pagination[_pagination_index].sort_order=-1;
    }
    else{
        this.pagination[_pagination_index].sort_by=field;
        this.pagination[_pagination_index].sort_order=1;
    }
};

var Filter = function(_default){
    return ({
        search:'',
        per_page:10,
        current_page:1,
        original_length:0,
        sort_by: _default,
        sort_order:'1'
    });
};