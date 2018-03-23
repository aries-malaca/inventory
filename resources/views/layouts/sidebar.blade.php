<!-- sidebar: style can be found in sidebar.less -->
<section class="sidebar" id="menu">
    <!-- Sidebar user panel -->
    <div class="user-panel">
    <div class="pull-left image">
        <img src="{{url('images/users/' . Auth::user()->photo )}}" class="img-circle" alt="User Image">
    </div>
    <div class="pull-left info">
        <p>{{ Auth::user()->name }}</p>
        <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
    </div>
    </div>
    <!-- sidebar menu: : style can be found in sidebar.less -->
    <ul class="sidebar-menu">
        <li class="{{ (Request::segment(1)==null || Request::segment(1) == 'home') ? 'active':'' }}">
            <a href="{{ url('home') }}"><i class="fa fa-dashboard"></i> <span>Dashboard</span> </a>
        </li>
        <li class="treeview">
            <a href="#">
            <i class="fa fa-code"></i> <span>Transactions</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
            </span>
            </a>
            <ul class="treeview-menu">
                <li v-if="authorize('sales','view')"><a href="{{ url('sales') }}"><i class="fa fa-circle-o"></i> Point of Sales</a></li>
                <li v-if="authorize('purchases','view')"><a href="{{ url('purchases') }}"><i class="fa fa-circle-o"></i> Purchases</a></li>
                <li v-if="authorize('receives','view')"><a href="{{ url('receives') }}"><i class="fa fa-circle-o"></i> Receives</a></li>
                <li v-if="authorize('transfers','view')"><a href="{{ url('transfers') }}"><i class="fa fa-circle-o"></i> Transfers</a></li>
                <li v-if="authorize('reconciliations','view')"><a href="{{ url('reconciliation') }}"><i class="fa fa-circle-o"></i> Reconciliation</a></li>
                <li v-if="authorize('inventory','view')"><a href="{{ url('inventory') }}"><i class="fa fa-circle-o"></i> Inventory</a></li>
            </ul>
        </li>
        <li class="" v-if="authorize('products','view')">
            <a href="{{ url('products') }}"><i class="fa fa-cubes"></i> <span>Products</span> </a>
        </li>
        <li class="" v-if="authorize('clients','view')">
            <a href="{{ url('clients') }}"><i class="fa fa-users"></i> <span>Clients</span> </a>
        </li>
        <li class="" v-if="authorize('suppliers','view')">
            <a href="{{ url('suppliers') }}"><i class="fa fa-truck"></i> <span>Suppliers</span> </a>
        </li>
        <li class="" v-if="authorize('branches','view')">
            <a href="{{ url('branches') }}"><i class="fa fa-building"></i> <span>Branches</span> </a>
        </li>
        <li class="" v-if="authorize('reports','view')">
            <a href="{{ url('reports') }}"><i class="fa fa-folder-open"></i> <span>Reports</span> </a>
        </li>
        <li class="" v-if="authorize('users','view')">
            <a href="{{ url('users') }}">
            <i class="fa fa-smile-o"></i> <span>Users</span></a>
        </li>        
        <li class="" v-if="authorize('settings','view')">
            <a href="{{ url('settings') }}"><i class="fa fa-cog"></i> <span>Settings</span> </a>
        </li>
        <li class="">
            <a href="{{ url('auth/logout') }}"><i class="fa fa-dashboard"></i> <span>Logout</span> </a>
        </li>
    </ul>
</section>
<!-- /.sidebar -->