<script>
    // CommitChart.js
    import { Bar } from 'vue-chartjs'
    export default {
        extends: Bar,
        mounted () {
            // Overwriting base render method with actual data.
            this.renderChart({
                labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                datasets: [
                    {
                        label: 'Income',
                        backgroundColor: '#5050f8',
                        data: [20, 50, 50, 23, 44, 9, 5, 23, 39, 47, 45, 15]
                    },
                    {
                        label: 'Expenses',
                        backgroundColor: '#f85c57',
                        data: [40, 20, 12, 39, 10, 40, 39, 80, 40, 20, 12, 11]
                    }
                ]
            })
        }
    }
</script>