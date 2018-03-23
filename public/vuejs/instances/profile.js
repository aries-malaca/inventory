var vue_profile = new Vue({
    el:"#profile",
    data:{
        auth:{},
        password:{
            old:'',
            new:'',
            new2:''
        }
    },
    methods:{
        getAuth:function(){
             $.get('../../users/getAuth', function(data){
                vue_profile.auth = data;
            }).
            fail(function(){
                vue_profile.getAuth();
            });
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
        updateProfile:function(){
            this.postData('../../profile/updateProfile', this.auth,function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully updated profile.");
                }
                else{
                    toastr.error(data.errors.toString());
                }
            },
            function(){
            });
        },
        changePassword:function(){
            this.postData('../../profile/changePassword', this.password,function(data){
                if(data.result == 'success'){
                    toastr.success("Successfully changed password.");
                    $("#password-modal").modal("hide");
                    vue_profile.password = {
                        old:'',
                        new:'',
                        new2:''
                    }
                }
                else{
                    toastr.error(data.errors.toString());
                }
            },
            function(){
            });
        },
        showPasswordModal:function(){
            $("#password-modal").modal("show");
        }
    },
    mounted:function(){
        this.getAuth();
    }
});