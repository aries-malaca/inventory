var vue_reports = new Vue({
    el:"#reports",
    data:{
        report_types:[
            {
             name:'sales_summary',
             title: 'Sales Summary',
             type:'sales'
            },
            {
             name:'sales_detailed',
             title: 'Sales Detailed',
             type:'sales'
            }
        ],
        newSalesReport:{
            date_start:moment().format("YYYY-MM-DD"),
            date_end:moment().format("YYYY-MM-DD"),
            report_type:'sales_summary',
            generated_link:'',
            generated_success:false
        }
    },
    methods:{
        generateSalesReport:function(){
            this.newSalesReport.generated_success = false;
            $.ajax({
                method:'post',
                url:'../../reports/generateSalesReport',
                data:this.newSalesReport,
                success:function(data){
                    if(data.result=='success'){
                        vue_reports.newSalesReport.generated_success = true;
                        vue_reports.newSalesReport.generated_link = data.link;
                        window.open(data.link);
                    }
                }
            });
        },
    }
});