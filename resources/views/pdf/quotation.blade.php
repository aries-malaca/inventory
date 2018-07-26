<html>
<style>
    body{
        font-size:13px;
    }
    td,th{
        border: 0.25px solid black;
        vertical-align: top;
        padding:5px;
    },
    table{
        border-collapse:collapse;
    },
    th{
        font-weight:bold;
        text-align:center;
    }
</style>
<body>
    <table style="width:100%;">
        <tr>
            <td style="width:70%;border:0px">
                <p>
                    <b>VIP Xeroxing & Stationery</b> <br/>
                    Tel.: 03-7669934		 <br/>	
                    Fax: 03-7669935			 <br/>
                    Al Ain – Al Takhtit St.		 <br/>
                    P.O Box: 14010 Al Ain – U.A.E
                </p>
            </td>
            <td style="width:30%;border:0px;text-align:right">
                <img src="{{ $logo }}" alt="" style="height:100px;"/>
            </td>
        </tr>
    </table>
    <hr/>
    <div style="text-align: center; font-weight:bold;font-size:20px;">Quotation</div>
    <table style="width:100%;">
        <tr>
            <td style="width:70%;border:0px">
                <h4>
                    Client: {{ $data->client_name }} <br/>
                    Company: {{ $data->client_company }} <br/>
                    Tax No.: {{ $data->tax_number }} <br/>
                    Address: {{ $data->client_address }} <br/>
                    Contact: {{ $data->client_phone }} <br/>
                </h4>
            </td>
            <td style="width:30%;border:0px;">
                <h4>
                    Ref. No.: {{ $data->reference_no }} <br/>
                    Date: {{ date("m/d/Y", strtotime($data->created_at)) }} <br/>
                    Notes: {{ $data->notes }}
                </h4>
            </td>
        </tr>
    </table>
    <table style="width:100%;">
        <tr>
            <th style="width:5%">Serial</th>
            @if($data->quotation_data->with_image !== true)
                <th style="width:55%">Description</th>
            @else
                <th style="width:10%">Image</th>
                <th style="width:45%">Description</th>
            @endif
            <th style="width:8%">Qty.</th>
            <th style="width:10%">Unit</th>
            <th style="width:10%">Unit Price</th>
            <th style="width:12%">Amount</th>
        </tr>
        @foreach($data->items as $key=>$item)
        <tr>
            <td>{{ $key+1 }}</td>
            @if($data->quotation_data->with_image === true)
                <td> <img src="{{ $item->image  }}" alt="" style="height:50px;"/></td>
            @endif
            <td>
                {{ $item->product->product_name }}<br/>
                @if(isset($item->unit['info']) AND $item->unit['info'] != "")
                    ({{ $item->unit['info'] }})
                @endif
            </td>
            <td style="text-align:center">{{ $item->quantity }}</td>
            <td style="text-align:center">{{ $item->unit['unit_name'] }}</td>
            <td style="text-align:right">{{ number_format($item->selling_price, 2) }}</td>
            <td style="text-align:right">{{ number_format( ($item->selling_price * $item->quantity ), 2) }}</td>
        </tr>
        @endforeach
        <tr>
            @if($data->quotation_data->with_image === true)
                <th colspan="5" style="border:0px;"></th>
            @else
                <th colspan="4" style="border:0px;"></th>
            @endif
            <th>Total:</th>
            <th style="text-align:right"> {{ number_format($total,2) }}</th>
        </tr>
        <tr>
             @if($data->quotation_data->with_image === true)
                <th colspan="5" style="border:0px;"></th>
            @else
                <th colspan="4" style="border:0px;"></th>
            @endif
            <th>Discount:</th>
            <th style="text-align:right"> {{ number_format($data->quotation_data->discount,2) }}</th>
        </tr>
        <tr>
             @if($data->quotation_data->with_image === true)
                <th colspan="5" style="border:0px;"></th>
            @else
                <th colspan="4" style="border:0px;"></th>
            @endif
            <th>V.A.T. ({{ ($data->quotation_data->vat/($total - $data->quotation_data->discount))*100 }}%):</th>
            <th style="text-align:right"> {{ number_format($data->quotation_data->vat,2) }} </th>
        </tr>
        <tr>
             @if($data->quotation_data->with_image === true)
                <th colspan="5" style="border:0px;"></th>
            @else
                <th colspan="4" style="border:0px;"></th>
            @endif
            <th>Net:</th>
            <th style="text-align:right"> {{ number_format( ($total - $data->quotation_data->discount) + $data->quotation_data->vat ,2) }} </th>
        </tr>
    </table>
    <br/><br/><br/>
    <table style="width:100%;">
        <tr>
            <th style="width:15%;border: 0px">Recipient</th>
            <th style="border: 0px"></th>
            <th style="width:15%;border: 0px">Salesman</th>
        </tr>
        <tr>
            <th style="border: 0px">________________________</th>
            <th style="border: 0px"></th>
            <th style="border: 0px">________________________</th>
        </tr>
    </table>
</body>
</html>