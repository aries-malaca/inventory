<script>
    // CommitChart.js
    import { Pie } from 'vue-chartjs'
    export default {
        extends: Pie,
        props:["datasets", "labels"],
        methods:{
            initChart(){
                this.renderChart({
                    labels: this.labels,
                    datasets: this.datasets
                });
            }
        },
        mounted () {
            this.initChart();
        },
        watch:{
            datasets(){
                // Overwriting base render method with actual data.
                this.initChart();
            }
        }
    }
</script>