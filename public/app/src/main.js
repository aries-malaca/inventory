import Vue from 'vue';
import App from './components/App.vue';
import router from './router';
import {store} from './store/store';
import {mixin} from './mixin';

Vue.config.productionTip = false;
Vue.config.debug = true;
Vue.config.devtools = true;
Vue.mixin(mixin);

new Vue({
    el: '#wrapper',
    router,
    store,
    template: '<App/>',
    components: { App }
});