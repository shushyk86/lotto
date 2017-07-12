
<script type="text/javascript" src="view/javascript/smartslider/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="view/javascript/smartslider/jquery-ui-1.8.16.custom.min.js"></script>

<link rel="stylesheet" type="text/css" href="view/stylesheet/smartslider/list_product.css" />
<link type="text/css" href="view/stylesheet/smartslider/jquery-ui-1.8.16.custom.css" rel="stylesheet" />

<div class="pagination"><?php echo $pagination; ?></div>
<form action="" method="post" enctype="multipart/form-data" id="form">
	<table class="list">
	  <thead>
		<tr>
		  <td width="1" style="text-align: center;"></td>
		  <td class="center"><?php echo $column_image; ?></td>
		  <td class="left"><?php if ($sort == 'pd.name') { ?>
			<a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
			<?php } else { ?>
			<a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
			<?php } ?></td>
		  <td class="left"><?php if ($sort == 'p.model') { ?>
			<a href="<?php echo $sort_model; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_model; ?></a>
			<?php } else { ?>
			<a href="<?php echo $sort_model; ?>"><?php echo $column_model; ?></a>
			<?php } ?></td>
		  <td class="left"><?php if ($sort == 'p.price') { ?>
			<a href="<?php echo $sort_price; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_price; ?></a>
			<?php } else { ?>
			<a href="<?php echo $sort_price; ?>"><?php echo $column_price; ?></a>
			<?php } ?></td>
		</tr>
	  </thead>
	  <tbody>
		<tr class="filter">
		  <td><a onclick="filter();" class="button"><?php echo $button_filter; ?></a></td>
		  <td></td>
		  <td><input type="text" name="filter_name" value="<?php echo $filter_name; ?>" /></td>
		  <td><input type="text" name="filter_model" value="<?php echo $filter_model; ?>" /></td>
		  <td align="left"><input type="text" name="filter_price" value="<?php echo $filter_price; ?>" size="8"/></td>
		</tr>
		<?php if ($products) { ?>
		<?php foreach ($products as $product) { ?>
		<tr>
		  <td style="text-align: center;">
			<input data-href="<?php echo $product['href']; ?>" type="radio" name="selected" value="<?php echo $product['product_id']; ?>" />
		  </td>
		  <td class="center"><img data-special="<?php if ($product['special']) echo $product['special']; ?>" data-image="<?php echo $product['image']; ?>" src="<?php echo $product['tumb']; ?>" alt="<?php echo $product['name']; ?>" style="padding: 1px; border: 1px solid #DDDDDD;" /></td>
		  <td class="left prod_name"><?php echo $product['name']; ?></td>
		  <td class="left"><?php echo $product['model']; ?></td>
		  <td class="left" class="prod_price"><?php if ($product['special']) { ?>
			<span class="prod_old_price" style="text-decoration: line-through;"><?php echo $product['price']; ?></span><br/>
			<span class="prod_new_price" style="color: #b00;"><?php echo $product['special']; ?></span>
			<?php } else { ?>
			<?php echo $product['price']; ?>
			<?php } ?></td>
		</tr>
		<?php } ?>
		<?php } else { ?>
		<tr>
		  <td class="center" colspan="8"><?php echo $text_no_results; ?></td>
		</tr>
		<?php } ?>
	  </tbody>
	</table>
</form>
<div class="pagination"><?php echo $pagination; ?></div>
<div>&nbsp;</div>
<script type="text/javascript"><!--
function filter() {
	url = 'index.php?route=module/smartslider/index/getproductlist&token=<?php echo $token; ?>';
	
	var filter_name = $('input[name=\'filter_name\']').attr('value');
	
	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}
	
	var filter_model = $('input[name=\'filter_model\']').attr('value');
	
	if (filter_model) {
		url += '&filter_model=' + encodeURIComponent(filter_model);
	}
	
	var filter_price = $('input[name=\'filter_price\']').attr('value');
	
	if (filter_price) {
		url += '&filter_price=' + encodeURIComponent(filter_price);
	}
	
	var filter_quantity = $('input[name=\'filter_quantity\']').attr('value');
	
	if (filter_quantity) {
		url += '&filter_quantity=' + encodeURIComponent(filter_quantity);
	}
	
	var filter_status = $('select[name=\'filter_status\']').attr('value');
	
	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}	

	location = url;
}
//--></script> 
<script type="text/javascript"><!--
$(function () { 

	$('#form input').keydown(function(e) {
		if (e.keyCode == 13) {
			filter();
		}
	});

	$('input[name=\'filter_name\']').autocomplete({
		delay: 500,
		source: function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
				dataType: 'json',
				success: function(json) {		
					response($.map(json, function(item) {
						return {
							label: item.name,
							value: item.product_id
						}
					}));
				}
			});
		}, 
		select: function(event, ui) {
			$('input[name=\'filter_name\']').val(ui.item.label);
							
			return false;
		},
		focus: function(event, ui) {
			return false;
		}
	});

	$('input[name=\'filter_model\']').autocomplete({
		delay: 500,
		source: function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_model=' +  encodeURIComponent(request.term),
				dataType: 'json',
				success: function(json) {		
					response($.map(json, function(item) {
						return {
							label: item.model,
							value: item.product_id
						}
					}));
				}
			});
		}, 
		select: function(event, ui) {
			$('input[name=\'filter_model\']').val(ui.item.label);
							
			return false;
		},
		focus: function(event, ui) {
			return false;
		}
	});

});
//--></script> 