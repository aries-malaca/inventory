<html>
<style>
    body{
        font-size:13px;
    }
    td,th{
        border-collapse:collapse;
        border-bottom: 0.25px solid black;
        vertical-align: top;
    }
</style>
<body>
    <table style="width:100%">
        <tr>
            @if($request->input('show_picture'))
            <td style="width:18%; text-align:center">
                <b>Product Image</b>
            </td>
            <td style="width:32%; text-align:center">
            @else
            <td style="width:50%; text-align:center">
            @endif    
                <b>Product Name </b>
            </td>
            <td style="width:60%; text-align:center">
                <b>Unit</b>
            </td>
        </tr>
        @foreach($products as $key=>$product)
        <tr>
            @if($request->input('show_picture'))
            <td style="width:18%">
                @if($product['pictures_data'] != "")
                <img src="{{ $product['pictures_data']  }}" alt="" style="width:100px; height:70px"/>
                @endif
            </td>
            <td style="width:32%">
            @else
            <td style="width:40%">
            @endif
                <br/>{{ $product['product_name'] }}<br/>
            </td>
            <td style="width:60%">
                <table style="width:100%">
                    @foreach($product['product_units'] as $k=> $unit)
                    <tr>
                        <th style="width:20px"><br/>{{ $unit['unit']->unit_name }}</th>
                        <th style="width:30px">
                            @if($k>0)
                            <br/>{{$unit['unit']->unit_name}} / {{ $product['product_units'][$k-1]['unit']->unit_name }} : {{ $unit['quantity_per_parent'] }}
                            @endif
                        </th>
                        <th style="width:20px;text-align:right">
                            @if($request->input('display_purchase_price'))
                                <br/>
                                PP: {{ number_format($unit['pricing'][0]['purchase_price'], 2) }}
                            @endif
                            @if($request->input('display_vat_price'))
                                @foreach($unit['pricing'][0]['selling'] as $s=> $selling)
                                    @if($selling['price_category_id'] == $request->input('selling_price'))
                                    <br/>
                                    
                                    VP: {{ number_format( (($selling['selling_price'] * .12) + $selling['selling_price']), 2) }}
                                    @endif
                                @endforeach
                            @endif
                        </th>
                        <th style="width:20px;text-align:right">
                            @foreach($unit['pricing'][0]['selling'] as $s=> $selling)
                                @if($selling['price_category_id'] == $request->input('selling_price'))
                                <br/>
                                
                                SP: {{ number_format($selling['selling_price'], 2) }}
                                @endif
                            @endforeach
                        </th>
                    </tr>
                    @endforeach
                </table>
            </td>
        </tr>
        @endforeach
    </table>
</body>
</html>