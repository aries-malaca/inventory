var vue_menu = new Vue({
    el:"#menu",
    data:{
        auth:{},
    },
    methods:{
        getAuth:function(){
             $.get('../../users/getAuth', function(data){
                data.level_data = JSON.parse(data.level_data);
                vue_menu.auth = data;
            }).
            fail(function(){
                vue_menu.getAuth();
            });
        },
        authorize:function(page, permission){
            if(this.auth.level_data === undefined){
                return false;
            }
            for(var x=0;x<this.auth.level_data.permissions.length;x++){
                if(page == this.auth.level_data.permissions[x].page){
                    for(var y=0;y<this.auth.level_data.permissions[x].permission.length;y++) {
                        if(this.auth.level_data.permissions[x].permission[y].action == permission && this.auth.level_data.permissions[x].permission[y].value == "true"){
                            return true;
                        }
                    }
                }
            }
            return false;
        }
    },
    mounted:function(){
        this.getAuth();
    }
});