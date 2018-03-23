<template>
    <form role="form" :id="form_id" class="form" enctype="multipart/form-data" onsubmit="return false;">
        <div class="form-group">
            <div class="fileinput fileinput-new" data-provides="fileinput">
                <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                    <img :src="placeholder_image" alt="" /> </div>
                <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"> </div>
                <div>
                    <span class="btn default btn-file">
                        <span class="fileinput-new"> Select image </span>
                        <span class="fileinput-exists"> Change </span>
                        <input type="file" name="file" :id="input_id">
                    </span>
                    <a href="javascript:;" class="btn red fileinput-exists" data-dismiss="fileinput"> Remove </a>
                    <button @click="uploadPicture" type="button" class="btn btn-primary">Upload</button>
                </div>
            </div>
        </div>
    </form>
</template>
<script>
    export default {
        name: 'UploadForm',
        props:['token','category','param_url','placeholder_image','form_id','input_id'],
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
                    success:function(){
                        u.$emit('emit_host');
                    },
                    error:function (error) {
                        XHRCatcher(error);
                    }
                });
            },
        }
    }
</script>