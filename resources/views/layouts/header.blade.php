<!-- Logo -->
<a href="{{url('home')}}" class="logo">
    <!-- mini logo for sidebar mini 50x50 pixels -->
    <span class="logo-mini">S.I.</span>
    <!-- logo for regular state and mobile devices -->
    <span class="logo-lg">Sales & Inventory App</span>
</a>

<!-- Header Navbar: style can be found in header.less -->
<nav class="navbar navbar-static-top">
    <!-- Sidebar toggle button-->
    <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
    <span class="sr-only">Toggle navigation</span>
    </a>
    <!-- Navbar Right Menu -->
    <div class="navbar-custom-menu">
    <ul class="nav navbar-nav">
        <!-- User Account: style can be found in dropdown.less -->
        <li class="dropdown user user-menu">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            <img src="{{url('images/users/' . Auth::user()->photo )}}" class="user-image" alt="User Image">
            <span class="hidden-xs">{{ Auth::user()->name }}</span>
        </a>
        <ul class="dropdown-menu">
            <!-- User image -->
            <li class="user-header">
            <img src="{{url('images/users/' . Auth::user()->photo )}}" class="img-circle" alt="User Image">

            <p>
                {{ Auth::user()->name }}
                <small>Member since {{ date('F, Y', strtotime(Auth::user()->created_at)) }}</small>
            </p>
            </li>
            <!-- Menu Footer-->
            <li class="user-footer">
            <div class="pull-left">
                <a href="{{ url('profile') }}" class="btn btn-default btn-flat">Profile</a>
            </div>
            <div class="pull-right">
                <a href="{{ url('auth/logout') }}" class="btn btn-default btn-flat">Logout</a>
            </div>
            </li>
        </ul>
        </li>
    </ul>
    </div>
</nav>