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
<h2 style="text-align: center">Product List</h2>
<h3 style="text-align: left">Brand: {{ in_array('All', $request->input('brands')) ?'All':implode(", ",$request->input('brands')) }}</h3>
@if(!empty($categories))
    <h3 style="text-align: left">Category: {{ implode(", ",$categories) }}</h3>
@endif
<h3 style="text-align: left">Price: {{ $price_category->price_category_name }}</h3>
<table>
    <tr>
        <th style="background-color:yellow;color:red">S.N.</th>
        <th style="width:150px; text-align:center">
            <b>Brand </b>
        </th>
        <th style="width:150px; text-align:center">
            <b>Code </b>
        </th>
        <th style="width:150px; text-align:center">
            <b>Description </b>
        </th>
        <th style="width:150px; text-align:center">
            <b>Size </b>
        </th>
        <th style="width:80px;text-align:center">
            <b>Unit 1</b>
        </th>
        @if($request->input('display_purchase_price'))
            <th style="width:80px; text-align:center">
                <b>Cost</b>
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
        <th style="width:80px;text-align:center">
            <b>Unit 2</b>
        </th>
        <th style="width:110px;text-align:center">
            <b>Notes</b>
        </th>
        @if($request->input('display_purchase_price'))
            <th style="width:80px; text-align:center">
                <b>Cost</b>
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
        <th style="width:80px;text-align:center">
            <b>Unit 3</b>
        </th>
        <th style="width:110px;text-align:center">
            <b>Notes</b>
        </th>
        @if($request->input('display_purchase_price'))
            <th style="width:80px; text-align:center">
                <b>Cost</b>
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
        @foreach($products as $eee=>$group)
        <tr style="font-weight:bold">
            <td colspan="{{ $field_size+5 }}" style="border:0px"> {{ $group['category_name'] }}</td>
        </tr>
        @foreach($group['products'] as $key=>$product)
        <tr>
            <th>{{ $key+1 }}</th>
            <td>
                {{ $product['brand_name'] }}<br/>
            </td>
            <td>
                {{ $product['product_code'] }}<br/>
            </td>
            <td>
                {{ $product['product_description'] }}<br/>
            </td>
            <td>
                {{ $product['size'] }}<br/>
            </td>
            @for($x=0;$x<3;$x++)
                @if(isset($product['product_units'][$x]))
                    <td>{{ $product['product_units'][$x]['unit']->unit_name }}</td>
                    @if($x>0)
                    <td style="width:110px;text-align:right">
                        {{$product['product_units'][$x]['unit']->unit_name}} / {{ $product['product_units'][$x-1]['unit']->unit_name }} : {{ $product['product_units'][$x]['quantity_per_parent'] }}
                    </td>
                    @endif
                    @if($request->input('display_purchase_price'))
                    <td>{{ number_format($product['product_units'][0]['pricing'][0]['purchase_price'], 2) }}</td>
                    @endif
                    @if($request->input('display_vat_price'))
                    <td>
                        @foreach($product['product_units'][$x]['pricing'][0]['selling'] as $s=> $selling)
                            @if($selling['price_category_id'] == $request->input('selling_price'))
                                {{ number_format( (($selling['selling_price'] * .12) + $selling['selling_price']), 2) }}
                            @endif
                        @endforeach
                    </td>
                    @endif
                    <td style="width:80px;text-align:right">
                        @foreach($product['product_units'][$x]['pricing'][0]['selling'] as $s=> $selling)
                            @if($selling['price_category_id'] == $request->input('selling_price'))
                                {{ number_format($selling['selling_price'], 2) }}
                            @endif
                        @endforeach
                    </td>
                @endif
            @endfor
        </tr>
    @endforeach
    @endforeach
</table>
</body>
</html>