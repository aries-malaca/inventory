<template>
    <div class="modal fade" :id="modal_id" tabindex="1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">Update Picture</h4>
                </div>
                <div class="modal-body">
                    <upload-form-croppie
                        :token="token"
                         :input_id="input_id"
                         :form_id="form_id"
                         :category="category"
                         :param_url="param_url"
                         :placeholder_image="placeholder_image"
                         @emit_host="refreshHost">
                    </upload-form-croppie>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn dark btn-outline" data-dismiss="modal">Close</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
</template>

<script>
    import UploadFormCroppie from '../components/UploadFormCroppie.vue';
    export default {
        name: 'UploadPictureModal',
        props:['token','category','param_url','placeholder_image','modal_id','form_id','input_id'],
        components: { UploadFormCroppie },
        methods:{
            refreshHost:function(){
                this.$emit('refresh_host');
                $("#"+this.modal_id).modal("hide");
            }
        }
    }
</script>