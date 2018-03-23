<template>
    <div style="background-color: #222d32">
        <header class="main-header" v-if="user !== null">
            <header-layout @logout="logout"></header-layout>
        </header>
        <!-- Left side column. contains the logo and sidebar -->
        <aside class="main-sidebar" v-if="user !== null">
            <sidebar-layout @logout="logout"></sidebar-layout>
        </aside>

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content" v-if="user !== null">
                <router-view></router-view>
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->
    </div>
</template>

<script>
    import HeaderLayout from './layouts/HeaderLayout.vue';
    import SidebarLayout from './layouts/SidebarLayout.vue';

    export default {
        name: 'App',
        components: { HeaderLayout, SidebarLayout },
        data(){
            return{
            }
        },
        methods:{
            logout(){
                if(this.token !== undefined){
                    axios.patch(API_URL + '/api/user/destroyToken', { token : this.token, user_id : this.user.id})
                        .then(function () {
                            $.removeCookie('login_cookie');
                            window.location.href = '../../login';
                        })
                        .catch(function (error) {
                            XHRCatcher(error);
                        });
                }
                else{
                    $.removeCookie('login_cookie');
                    window.location.href = '../../login';
                }
            },
        },
        mounted(){
            this.$store.commit('updateToken', $.cookie("login_cookie"));
            if(this.token === undefined)
                this.logout();

            this.$store.dispatch('fetchAuthenticatedUser');
            this.$store.dispatch('clients/fetchClients');
            this.$store.dispatch('products/fetchProducts');
            this.$store.dispatch('products/fetchPrices');
            this.$store.dispatch('products/fetchCategories');
            this.$store.dispatch('suppliers/fetchSuppliers');
        },
        computed:{
            title(){
                return this.$store.state.title;
            },
            token(){
                return this.$store.state.token;
            },
            user(){
                return this.$store.state.user;
            },
            menus(){
                return this.$store.state.menus;
            }
        },
        watch:{
            title(){
                window.document.title = 'App | ' + this.title;
            }
        }
    }
</script>