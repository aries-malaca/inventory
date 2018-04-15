<html>
<style>
    body{
        font-size:14px;
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
            <td style="width:18%">
                <b>Product Image</b>
            </td>
            <td style="width:32%">
                <b>Product Name </b>
            </td>
            <td style="width:32%">
                <b>Unit</b>
            </td>
        </tr>
        @foreach($products as $product)
        <tr>
            @if($request->input('show_picture'))
            <td style="width:18%">
                @if($product['pictures_data'] != "")
                <img src="{{ $product['pictures_data']  }}" alt="" style="width:100px; height:70px"/>
                @endif
            </td>
            @endif
            <td style="width:32%">
                <!-- <b>Product Code:</b><br/>
                {{ $product['product_code'] }}<br/> -->
                <br/>{{ $product['product_name'] }}<br/>
                <!-- <b>Category:</b><br/>
                {{ $product['category_name'] }}<br/> -->
            </td>
            <td style="width:50%">
                <table style="width:100%;font-size:90%">
                    @foreach($product['product_units'] as $k=> $unit)
                    <tr>
                        <th style="width:25px"><br/>{{ $unit['unit']->unit_name }}</th>
                        <th style="width:25px">
                            @if($k>0)
                            <br/>{{$unit['unit']->unit_name}} / {{ $product['product_units'][$k-1]['unit']->unit_name }} : {{ $unit['quantity_per_parent'] }}
                            @endif
                        </th>
                        <th style="width:25px;text-align:right">
                            @foreach($unit['pricing'][0]['selling'] as $s=> $selling)
                                @if($selling['price_category_id'] == $request->input('selling_price'))
                                <br/>{{ number_format($selling['selling_price'], 2) }}
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