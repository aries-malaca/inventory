import Vue from 'vue';
import Vuex from 'vuex';
import {branches} from './modules/branches';
import {products} from './modules/products';
import {suppliers} from './modules/suppliers';
import {clients} from './modules/clients';
import {levels} from './modules/levels';
import {users} from './modules/users';

Vue.use(Vuex);
export const store = new Vuex.Store({
    modules: {
        branches,
        products,
        suppliers,
        clients,
        levels,
        users,
    },
    state: {
        token: undefined,
        user: null,
        settings:null,
        menus:[],
        title: 'App',
        systems:[
            'Product Inquiry',
            'Accounting System',
        ],
        dashboards:[
            'ProductDashboard',
            'AccountingDashboard'
        ]
    },
    actions:{
        fetchAuthenticatedUser(context){
            axios.get('/api/user/getUser?token=' + context.state.token)
                .then(function (response) {
                    context.commit('updateUser', response.data.user);
                    context.commit('updateMenus', response.data.menus);
                    context.commit('updateSettings', response.data.settings);
                })
                .catch(function (error) {
                    XHRCatcher(error);
                });
        }
    },
    mutations:{
        updateToken(state, token){
            state.token = token;
        },
        updateUser(state, user){
            state.user = user;
        },
        updateSettings(state, settings){
            state.settings = settings;
        },
        updateMenus(state, menus){
            state.menus = menus;
        },
        updateTitle(state, title){
            state.title = title;
        }
    }
});