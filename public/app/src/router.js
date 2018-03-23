import Vue from 'vue';
import Router from 'vue-router';

import Profile from './components/Profile.vue';
import Home from './components/Home.vue';
import Transactions from './components/Transactions.vue';
import Products from './components/Products.vue';
import Suppliers from './components/Suppliers.vue';
import Clients from './components/Clients.vue';
import Reports from './components/Reports.vue';
import Settings from './components/Settings.vue';
import Branches from './components/Branches.vue';

Vue.use(Router);
export default new Router({
    routes: [
        {   path: '/profile',
            name: 'Profile',
            component: Profile
        },
        {   path: '/home',
            name: 'Home',
            component: Home
        },
        {   path: '/',
            name: 'Home',
            component: Home
        },
        {   path: '/transactions',
            name: 'Transactions',
            component: Transactions
        },
        {   path: '/products',
            name: 'Products',
            component: Products
        },
        {   path: '/suppliers',
            name: 'Suppliers',
            component: Suppliers
        },
        {   path: '/clients',
            name: 'Clients',
            component: Clients
        },
        {   path: '/reports',
            name: 'Reports',
            component: Reports
        },
        {   path: '/settings',
            name: 'Settings',
            component: Settings
        },
        {   path: '/branches',
            name: 'Branches',
            component: Branches
        }
    ]
})
