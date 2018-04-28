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
    <h2 style="text-align: center">Product List</h2>
    <h4>
        Brand: {{ in_array('All', $request->input('brands')) ?'All':implode(", ",$request->input('brands')) }} <br/>
        @if(!empty($categories))
            Category: {{ implode(", ",$categories) }}<br/>
        @endif
        Price: {{ $price_category->price_category_name }}
    </h4>
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
        @foreach($products as $eee=>$group)
            <tr style="font-weight:bold">
                <td colspan="{{ $field_size+5 }}" style="border:0px">=== {{ $group['category_name'] }} ===</td>
            </tr>
            @foreach($group['products'] as $key=>$product)
            <tr>
                @if($request->input('show_picture'))
                <td style="padding-left:4px;">
                    @if($product['pictures_data'] != "")
                    <img src="{{ $product['pictures_data']  }}" alt="" style="height:70px;"/>
                    @endif
                </td>
                <td>
                @else
                <td>
                @endif
                    <br/>{{ $product['product_name'] }}<br/>
                </td>
                <td colspan="{{ $field_size+3 }}">
                    <table style="width:100%">
                        @foreach($product['product_units'] as $k=> $unit)
                            <tr>
                                <td style="width:80px;">{{ $unit['unit']->unit_name }}</td>
                                <td  style="width:110px;">
                                    @if($k>0)
                                        {{$unit['unit']->unit_name}} / {{ $product['product_units'][$k-1]['unit']->unit_name }} : {{ $unit['quantity_per_parent'] }}
                                    @endif
                                </td>
                                @if($request->input('display_purchase_price'))
                                    <td style="width:80px;text-align:right">
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
        @endforeach
    </table>
</body>
</html>