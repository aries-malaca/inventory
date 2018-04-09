<html>
    <style>
        body{
            font-size:12px;
        }
        td{
            border-collapse:collapse;
        }
    </style>
    <body>
        <h3>Sales Summary, ({{ $date_start }} @if($date_start != $date_end) - {{$date_end}} @endif )</h3>
    </body>
    <table class="table" style="width:100%;">
        <thead>
            <tr>
                <th>Receipt No.</th>
                <th style="width:200px">Client</th>
                <th>Items</th>
                <th>Transaction Date</th>
                <th>Due Date</th>
                <th>Status</th>
                <th style="width:100px">Encoder</th>
                <th style="width:80px">Net Amount</th>
            </tr>
        </thead>
        <tbody>
            @if($total =0) @endif
            @foreach($sales as $sale)
            <tr>
                <td>{{ $sale['receipt_no'] }}</td>
                <td>{{ $sale['client']->client_name }}</td>
                <td>{{ $sale['items_count'] }}</td>
                <td>{{ date('m/d/Y',strtotime($sale['date_transaction'])) }}</td>
                <td>{{ date('m/d/Y',strtotime($sale['date_due'])) }}</td>
                <td>{{ $sale['sales_status'] }}</td>
                <td>{{ $sale['name'] }}</td>
                <td style="text-align:right">{{ number_format($sale['sales_data']['net_amount'],2) }}</td>
                @if($total+=$sale['sales_data']['net_amount']) @endif
            </tr>
            @endforeach
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td style="text-align:right;font-weight:bolder">{{ number_format($total,2) }}</td>
            </tr>
        </tbody>
    </table>
</html>