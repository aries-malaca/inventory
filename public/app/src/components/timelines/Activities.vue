<template>
    <ul class="timeline timeline-inverse">
        <!-- /.timeline-label -->
        <!-- timeline item -->
        <li v-for="log in logs">
            <i class="fa fa-user bg-red" v-if="log.category==='user'"></i>
            <i class="fa fa-cart-plus bg-blue" v-if="log.category==='product'"></i>
            <div class="timeline-item">
                  <span class="time">
                    <i class="fa fa-clock-o"></i> {{ moment(log.created_at).format("MM/DD/YYYY hh:mm A") }}
                  </span>
                <h3 class="timeline-header"><span v-if="default_user!==undefined">{{ default_user.name }} </span>{{ log.action }}</h3>
                <div class="timeline-body">
                    <p>{{ log.body }}</p>
                    <br/><strong>IP: {{ log.ip_address }}</strong>
                </div>
            </div>
        </li>
        <!-- END timeline item -->
    </ul>
</template>
<script>
    export default{
        name:'Activities',
        props:['default_user', 'logs'],
        methods:{
            moment:moment
        }
    }
</script>