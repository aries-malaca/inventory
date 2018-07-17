@push('plugins')
<!-- jQuery 2.2.3 -->
<script src="../../theme/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="../../theme/bootstrap/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="../../theme/plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="../../theme/dist/js/app.min.js"></script>
<!-- Sparkline -->
<script src="../../theme/plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="../../theme/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="../../theme/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- SlimScroll 1.3.0 -->
<script src="../../theme/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- ChartJS 1.0.1 -->
<script src="../../theme/plugins/chartjs/Chart.min.js"></script>

<script src="../../theme/plugins/toastr/toastr.min.js"></script>

<!-- start vue -->
<script src="../../vuejs/vue.js"></script>
<script src="../../vuejs/components/global.js"></script>
<script src="../../vuejs/instances/menu.js"></script>
<!-- end vue -->

<script src="../../moment/moment.js"></script>
@endpush

@stack('plugins')
@stack('scripts')