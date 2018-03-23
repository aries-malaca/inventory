var vue_settings = new Vue({
    el:"#settings",
    data:{
        settings:[],
        newUnit:{
            unit_name:'',
            id:0
        },
        units:[]
    },
    methods:{
        getData:function(url, field){
            $.get(url, function(data){
                vue_settings[field] = [];
                data.forEach(function(item,i){
                    vue_settings[field].push(item)
                });
            }).
            fail(function(){
                vue_settings.getData(url, field);
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
        getSettings:function(){
            this.getData('../../settings/getSettings','settings');
        },
        getUnits:function(){
            this.getData('../../settings/getUnits','units');
        },
        updateSettings:function(){
            this.postData('../../settings/updateSettings', {data:this.settings}, function(){
                toastr.success("Successfully updated settings.");
                vue_settings.getSettings();
            });
        },
        showAddModal:function(){
            if(this.newUnit.id != 0){
                this.newUnit = {
                    id:0,
                    unit_name:''
                }
            }
            $("#add-modal").modal("show");
        },
        addUnit:function(){
            this.postData('../../settings/addUnit', this.newUnit, function(){
                toastr.success("Successfully added unit.");
                vue_settings.getUnits();

                vue_settings.newUnit = {
                    id:0,
                    unit_name:''
                }
                $("#add-modal").modal("hide");
            });
        },
        updateUnit:function(){
            this.postData('../../settings/updateUnit', this.newUnit, function(){
                toastr.success("Successfully updated unit.");
                vue_settings.getUnits();
                vue_settings.newUnit = {
                    id:0,
                    unit_name:''
                }
                $("#add-modal").modal("hide");
            });
        },
        editUnit:function(unit){
            this.newUnit = {
                id:unit.id,
                unit_name:unit.unit_name
            }
            $("#add-modal").modal("show");
        },
        deleteUnit:function(unit){
            if(!confirm("Are you sure you want to delete this unit?")){
                return false;
            }
            
            this.postData('../../settings/deleteUnit', {id:unit.id}, function(){
                toastr.success("Successfully deleted unit.");
                vue_settings.getUnits();
            });
        }
    },
    mounted:function(){
        this.getSettings();
        this.getUnits();
    }
});