var vue_login = new Vue({
    el:'#login',
    data:{
        user:{
            email:'',
            password:''
        },
        token:undefined
    },
    methods:{
        tapLogin:function(event){
            if(event.keyCode == 13){
                this.login($("#btn-login"));
            }
        },
        login:function(button){
            var $btn = $(button.target);
            $btn.button('loading');

            $.ajax({
                url: '../../auth/login',
                method: 'POST',
                data: this.user,
                success: function (data) {
                    $.cookie("login_cookie", data.token, { path: '/', expires: 100000 });
                    window.location.href = '../../';
                },
                error:function(error){
                    console.log(error);
                    if(error.status === 400){
                        toastr.error("An error occurs, " + error.responseJSON.error);
                    }
                    $btn.button('reset');
                },
            });
        }
    },
    mounted:function(){
        this.token = $.cookie("login_cookie");

        if(this.token !== undefined){
            window.location.href = '../../';
        }
    }
});