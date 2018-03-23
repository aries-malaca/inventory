import Vue from 'vue';
import App from './components/App.vue';
import router from './router';
import {store} from './store/store';

Vue.config.productionTip = false;
Vue.config.debug = true;
Vue.config.devtools = true;


new Vue({
    el: '#wrapper',
    router,
    store,
    template: '<App/>',
    components: { App }
});