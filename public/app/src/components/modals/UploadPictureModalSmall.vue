<template>
    <div class="modal fade" :id="modal_id" tabindex="1">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">Update Picture</h4>
                </div>
                <div class="modal-body">
                    <upload-form
                            :input_id="input_id"
                            :form_id="form_id"
                            :category="category"
                            :param_url="param_url"
                            :placeholder_image="placeholder_image"
                            @emit_host="refreshHost">
                    </upload-form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn" @click="closeMe">Close</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
</template>

<script>
    import UploadForm from '../components/UploadForm.vue';
    export default {
        name: 'UploadPictureModal',
        props:['category','param_url','placeholder_image','modal_id','form_id','input_id'],
        components: { UploadForm },
        methods:{
            refreshHost:function(){
                this.$emit('refresh_host');
                $("#"+this.modal_id).modal("hide");
            },
            closeMe(){
                 $("#"+this.modal_id).modal("hide");
            }
        }
    }
</script>