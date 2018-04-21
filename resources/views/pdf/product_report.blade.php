<html>
<style>
    body{
        font-size:12px;
    }
    td,th{
        border-collapse:collapse;
        border-bottom: 0.25px solid black;
        vertical-align: top;
    }
</style>
<body>
    <table>
        <thead>
        <tr>
            @if($request->input('show_picture'))
            <th style="width:130px; text-align:center">
                <b>Product Image</b>
            </th>
            @endif
            <th style="width:150px; text-align:center">
                <b>Product Name </b>
            </th>
            <td style="width:80px;text-align:center">
                <b>Unit</b>
            </td>
            <th style="width:110px;text-align:center">
                <b>Notes</b>
            </th>
            @if($request->input('display_purchase_price'))
                <th style="width:80px; text-align:center">
                    <b>Purchase Price</b>
                </th>
            @endif
            @if($request->input('display_vat_price'))
                <th style="width:80px; text-align:center">
                    <b>Selling Price (VAT)</b>
                </th>
            @endif
            <th style="width:80px;text-align:center">
                <b>Selling Price</b>
            </th>
        </tr>
        </thead>
        @foreach($products as $key=>$product)
        <tr>
            @if($request->input('show_picture'))
            <td>
                @if($product['pictures_data'] != "")
                <img src="{{ $product['pictures_data']  }}" alt="" style="width:100px;"/>
                @endif
            </td>
            <td>
            @else
            <td>
            @endif
                <br/>{{ $product['product_name'] }}<br/>
            </td>
            <td colspan="5">
                <table style="width:100%">
                    @foreach($product['product_units'] as $k=> $unit)
                        <tr>
                            <td style="width:80px;">{{ $unit['unit']->unit_name }}</td>
                            <td  style="width:110px;text-align:right">
                                @if($k>0)
                                    {{$unit['unit']->unit_name}} / {{ $product['product_units'][$k-1]['unit']->unit_name }} : {{ $unit['quantity_per_parent'] }}
                                @endif
                            </td>
                            @if($request->input('display_purchase_price'))
                                <td style="width:80px">
                                {{ number_format($unit['pricing'][0]['purchase_price'], 2) }}
                                <td>
                            @endif
                            @if($request->input('display_vat_price'))
                                <td style="width:80px;text-align:right">
                                    @foreach($unit['pricing'][0]['selling'] as $s=> $selling)
                                        @if($selling['price_category_id'] == $request->input('selling_price'))
                                            {{ number_format( (($selling['selling_price'] * .12) + $selling['selling_price']), 2) }}
                                        @endif
                                    @endforeach
                                </td>
                            @endif
                            <td style="width:80px;text-align:right">
                                @foreach($unit['pricing'][0]['selling'] as $s=> $selling)
                                    @if($selling['price_category_id'] == $request->input('selling_price'))
                                        {{ number_format($selling['selling_price'], 2) }}
                                    @endif
                                @endforeach
                            </td>
                        </tr>
                    @endforeach
                </table>
            </td>
        </tr>
        @endforeach
    </table>
</body>
</html>