<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>App | {{ $title }}</title>
<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

@push('styles')
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="../../theme/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="../../fa/css/font-awesome.min.css">
<!-- jvectormap -->
<link rel="stylesheet" href="../../theme/plugins/jvectormap/jquery-jvectormap-1.2.2.css">
<!-- Theme style -->
<link rel="stylesheet" href="../../theme/dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
    folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="../../theme/dist/css/skins/_all-skins.min.css">
<link rel="stylesheet" href="../../theme/plugins/toastr/toastr.min.css">
@endpush

@stack('styles')
<style>
    [v-cloak]{
        display:none;
    }
    .pos-price{
        padding:4px; 
        font-size: 102%;
        text-align:right
    }
    .pos-container{
        font-size:102% !important;
    }
</style>
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->