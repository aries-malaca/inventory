<template>
    <section class="sidebar" id="menu">
        <!-- Sidebar user panel -->
        <div class="user-panel">
            <div class="pull-left image">
                <img :src="'images/users/' + user.photo" class="img-circle" alt="User Image">
            </div>
            <div class="pull-left info">
                <p>{{ user.name}}</p>
                <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
        </div>
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <li :class=" title==='Home'?'active':''">
                <a href="/#/home"><i class="fa fa-dashboard"></i> <span>Dashboard</span> </a>
            </li>
            <li v-for="m in menus" :class=" title=== m.menu_title?'active':''">
                <a :href="'/#/' + m.menu_url ">
                    <i :class="'fa ' + m.menu_icon"></i>
                    <span>{{ m.menu_title }}</span>
                </a>
            </li>
            <li class="">
                <a @click="logout" href="#"><i class="fa fa-sign-out"></i> <span>Logout</span> </a>
            </li>
        </ul>
    </section>
</template>

<script>
    export default {
        name:'SidebarLayout',
        methods:{
            logout: function() {
                this.$emit('logout')
            }
        },
        computed:{
            user(){
                return this.$store.state.user;
            },
            menus(){
                return this.$store.state.menus;
            },
            title(){
                return this.$store.state.title;
            }
        }
    }
</script>