<template>
    <form role="form" :id="form_id" class="form" enctype="multipart/form-data" onsubmit="return false;">
        <div class="form-group">
            <input type="file" name="file" :id="input_id"/><br/>
            <button @click="uploadPicture" type="button" class="btn btn-primary">Upload</button>
        </div>
    </form>
</template>
<script>
    export default {
        name: 'UploadForm',
        props:['category','param_url','placeholder_image','form_id','input_id'],
        methods:{
            uploadPicture:function(){
                let u = this;
                let data = new FormData();
                data.append('file', $('#'+u.input_id)[0].files[0]);

                $.ajax({
                    url:'/api/'+ this.category +'/uploadPicture?token='+this.token+'&'+this.param_url,
                    type:'POST',
                    data:data,
                    processData: false,  // tell jQuery not to process the data
                    contentType: false,  // tell jQuery not to set contentType
                    success:function(response){
                        console.log(response);
                        u.$store.commit('products/updateLastUploadedFile', response.filename);
                        u.$emit('emit_host');
                    },
                    error:function (error) {
                        XHRCatcher(error);
                    }
                });
            },
        },
        computed:{
            token(){
                return this.$store.state.token;
            }
        }
    }
</script>