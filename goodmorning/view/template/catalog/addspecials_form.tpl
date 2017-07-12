<?php echo $header; ?>
<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    <div class="box" id="add_specials_offer">
        <div class="heading">
            <h1 id="test"><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
			<div class="buttons"><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
        </div>
		<div id="select_offer_type" style="display: none; padding: 10px 0;text-align: center; border-left: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; border-top: 1px solid #CCCCCC;">
			<div>
				<h2>Выберите тип акции:</h2>
			</div>
			<div style="margin: 0 auto">
				<input name="select_offer_type" id="offer_type_product" style="display:none;" type="radio" value="product">
				<label style="display: inline-block; padding: 15px 70px; border-radius: 7px; border: 2px solid red; font-size: 20px;" for="offer_type_product">Товар</label>
				
				<input name="select_offer_type" id="offer_type_summ" style="display:none;" type="radio" value="summ">
				<label style="display: inline-block; padding: 15px 70px; border-radius: 7px; border: 2px solid green; margin-left: 50px; font-size: 20px;" for="offer_type_summ">Сумма</label>
			</div>
			<input type="hidden" name="offer_type" value="<?php echo isset($offer_info['type']) ? $offer_info['type'] : ''; ?>">
		</div>
        <div class="content">
		<div id="additional_offer_product" style="display: none;">
            <table class="form" id="product-filter">
                <tr>
                    <td rowspan="7">
                        <?php echo $text_filtered_products;?> <span id="product-total"></span>
                        <div class="scrollbox" id="filtered-products" style="height: 330px; width: 600px;"></div>
						<div>
							<div id="check-all" style="height: 22px; cursor:pointer; float: left;"><input type="checkbox" name="change_all" id="select_all" value="true" />Выделить все товары</div>
							<div style="text-align: right; margin-top: 10px;">
								<a class="button" onclick="add_selected();">Добавить</a>
							</div>
						</div>
                    </td>
                </tr>
                <tr>
                    <td><?php echo $entry_name; ?></td>
                    <td>
                        <input type="text" name="name" value="" class="filter_data"/>
                    </td>
               </tr>
                <tr>
                    <td><?php echo $entry_model; ?></td>
                    <td>
                        <input type="text" name="model" value="" class="filter_data"/>
                    </td>
                </tr>
                <tr>
                    <td><?php echo $entry_category; ?></td>
                    <td colspan="2">
                        <select name="category_id" class="filter_data">
                            <option value="0"><?php echo $option_all; ?></option>
                            <?php foreach ($categories as $category) { ?>
                            <option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
                            <?php } ?>
                        </select>
                    </td>
                </tr>
            </table>
			<form action="<?php echo $add_additional_offer; ?>" method="post" enctype="multipart/form-data" id="add_additional_offer_product">
			<table class="form" id="selected-products">
				<tbody>
					<tr>
						<td>
							<p style="margin-bottom: 0">Товары которые участвуют в акции:</p>
							<div id="offer-product" class="scrollbox" style="width: 600px; height: 200px">							
								<?php $class = 'odd'; ?>
								<?php foreach($offer_products as $product) { ?>
								<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
								<div id="offer-product<?php echo $product['product_id']; ?>" class="<?php echo $class; ?>"><?php echo $product['sku']; ?> - <?php echo $product['name']; ?><img src="view/image/delete.png" alt="" />
									<input type="hidden" name="offer-product[]" value="<?php echo $product['product_id']; ?>" />
								</div>
								<?php } ?>
							</div>
							<div style="text-align: right; margin-top: 10px;">
								<a class="button" onclick="$('#offer-product').empty();">Очистить список</a>
							</div>
						</td>
						<td>
							<p style="margin-bottom: 0">Акционные товары для текущей акции:</p>
							<div style="height: 22px; background: #B7D7F5; cursor:pointer; width: 100%;">
								<input type="text" value="" placeholder="Введите название товара или артикул..." size="100" name="product_additional_offer[aop]" />
							</div>
							
							<div id="ao-product" class="scrollbox" style="width: 100%; height: 178px">
								<?php $class = 'odd'; ?>
								<?php foreach ($bonus_products as $ao_product) { ?>
								<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
								<div id="ao-product<?php echo $ao_product['product_id']; ?>" class="<?php echo $class; ?>"><?php echo $ao_product['sku']; ?> - <?php echo $ao_product['name']; ?><img src="view/image/delete.png" alt="" />
									<input type="hidden" name="ao_product[]" value="<?php echo $ao_product['product_id']; ?>" />
								</div>
								<?php } ?>
							</div>
							<div style="text-align: right; margin-top: 10px;">
								<a class="button" onclick="$('#ao-product').empty();">Очистить список</a>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
            <div id="additional_offer">
                <table id="additional-offers" class="list">
                <thead>
                  <tr id="offer_heading_row">
                    <td class="left"><?php echo $column_name; ?></td>
                    <td class="left"><?php echo $entry_quantity; ?></td>
                    <td class="left">
						<input type="radio" name="product_additional_offer[discount_type]" id="disc_type_price" value="price" <?php if($offer_info['discount_type'] == 'price' || empty($offer_info['discount_type'])) {?> checked<?php } ?>><label for="disc_type_price"><?php echo $entry_price; ?></label>
						<br>
						<input type="radio" name="product_additional_offer[discount_type]" id="disc_type_percent" value="percent" <?php if($offer_info['discount_type'] == 'percent'){?> checked<?php } ?>><label for="disc_type_percent">Скидка на подарок, %:</label>
					</td>
                    <td class="right"><?php echo $entry_date_start; ?></td>
                    <td class="right"><?php echo $entry_date_end; ?></td>
                    <td class="left"><?php echo $entry_image; ?></td>
                    <td class="left"><?php echo $entry_href; ?></td>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td class="left"><input type="text" name="product_additional_offer[offer_name]" value="<?php echo $offer_info['name']; ?>" size="15" /></td>
                    <td class="left"><input type="text" name="product_additional_offer[quantity]" value="<?php echo $offer_info['quantity']; ?>" size="10" /></td>
                    <td class="left" id="choose_price"><input type="text" name="product_additional_offer[price]" value="<?php echo (int)$offer_info['price']; ?>" /></td>
                    <td class="right"><input type="text" name="product_additional_offer[date_start]" value="<?php echo $offer_info['date_start']; ?>" class="date" /></td>
                    <td class="right"><input type="text" name="product_additional_offer[date_end]" value="<?php echo $offer_info['date_end']; ?>" class="date" /></td>
                    <td class="left"><div class="image"><img src="<?php echo $offer_info['thumb'] ? $offer_info['thumb'] : ''; ?>" alt="" id="thumb_ao" />
                        <input type="hidden" name="product_additional_offer[image]" value="<?php echo $offer_info['image'] ? $offer_info['image'] : ''; ?>" id="image_ao" />
                        <br />
                        <a onclick="image_upload('image_ao', 'thumb_ao');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb_ao').attr('src', ''); $('#image_ao').attr('value', '');"><?php echo $text_clear; ?></a></div>
					</td>
					<td class="left"><input type="text" name="product_additional_offer[banner_link]" value="<?php echo $offer_info['link']; ?>" size="15" /></td>
				  </tr>
                  <tr>
                    <td class="left" colspan="7">
						<p>Описание акции:</p>
                        <textarea id="ao-description" cols="100" rows="10" name="product_additional_offer[description]"><?php echo $offer_info['description']; ?></textarea>
						<div class="buttons" style="text-align: right;">
                            <a class="button submit-form" id="submit-form-product" data-form='add_additional_offer_product'><?php echo $button_additional_offer; ?></a>
                        </div>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
			</form>
        </div>
		
		<div id="additional_offer_summ" style="display: none;">
		  <form action="<?php echo $add_additional_offer; ?>" method="post" enctype="multipart/form-data" id="add_additional_offer_summ">
			<table class="form" id="selected-products">
				<tbody>
					<tr>
						<td>
							<p style="margin-bottom: 0">Акционные товары для текущей акции:</p>
							<div style="height: 22px; background: #B7D7F5; cursor:pointer; width: 100%;">
								<input type="text" value="" placeholder="Введите название товара или артикул..." size="100" name="product_additional_offer_summ[aop]" />
							</div>
							
							<div id="ao-product-summ" class="scrollbox" style="width: 100%; height: 178px">
								<?php $class = 'odd'; ?>
								<?php foreach ($bonus_products as $ao_product) { ?>
								<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
								<div id="ao-product<?php echo $ao_product['product_id']; ?>" class="<?php echo $class; ?>"><?php echo $ao_product['sku']; ?> - <?php echo $ao_product['name']; ?><img src="view/image/delete.png" alt="" />
									<input type="hidden" name="ao_product[]" value="<?php echo $ao_product['product_id']; ?>" />
								</div>
								<?php } ?>
							</div>
							<div style="text-align: right; margin-top: 10px;">
								<a class="button" onclick="$('#ao-product-summ').empty();">Очистить список</a>
							</div>
						</td>
						<td></td>
					</tr>
				</tbody>
			</table>
            <div id="additional_offer">
                <table id="additional-offers" class="list">
					<thead>
					  <tr>
						<td class="left"><?php echo $column_name; ?></td>
						<td class="left"><?php echo $entry_summ; ?></td>
						<td class="left"><?php echo $entry_price; ?></td>
						<td class="right"><?php echo $entry_date_start; ?></td>
						<td class="right"><?php echo $entry_date_end; ?></td>
						<td class="left"><?php echo $entry_image; ?></td>
						<td class="left"><?php echo $entry_href; ?></td>
					  </tr>
					</thead>
					<tbody>
					  <tr>
						<td class="left"><input type="text" name="product_additional_offer[offer_name]" value="<?php echo $offer_info['name']; ?>" size="15" /></td>
						<td class="left"><input type="text" name="product_additional_offer[quantity]" value="<?php echo $offer_info['quantity']; ?>" size="10" /></td>
						<td class="left"><input type="text" name="product_additional_offer[price]" value="<?php echo (int)$offer_info['price']; ?>" /></td>
						<td class="right"><input type="text" name="product_additional_offer[date_start]" value="<?php echo $offer_info['date_start']; ?>" class="date" /></td>
						<td class="right"><input type="text" name="product_additional_offer[date_end]" value="<?php echo $offer_info['date_end']; ?>" class="date" /></td>
						<td class="left"><div class="image"><img src="<?php echo $offer_info['thumb'] ? $offer_info['thumb'] : ''; ?>" alt="" id="thumb_ao_summ" />
							<input type="hidden" name="product_additional_offer[image]" value="<?php echo $offer_info['image'] ? $offer_info['image'] : ''; ?>" id="image_ao_summ" />
							<br />
							<a onclick="image_upload('image_ao_summ', 'thumb_ao_summ');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb_ao_summ').attr('src', ''); $('#image_ao_summ').attr('value', '');"><?php echo $text_clear; ?></a></div>
						</td>
						<td class="left"><input type="text" name="product_additional_offer[banner_link]" value="<?php echo $offer_info['link']; ?>" size="15" /></td>
					  </tr>
					  <tr>
						<td class="left" colspan="7">
							<p>Описание акции:</p>
							<textarea id="ao-description" cols="100" rows="10" name="product_additional_offer[description]"><?php echo $offer_info['description']; ?></textarea>
							<div class="buttons" style="text-align: right;">
								<a class="button submit-form" id="submit-form-summ" data-form='add_additional_offer_summ'><?php echo $button_additional_offer; ?></a>
							</div>
						</td>
					  </tr>
					</tbody>				
				</table>
              </form>
            </div>		
		</div>
		</div>
    </div>
</div>
    <style>
        #filtered-products div:hover{background: lightgrey;}
        #filtered-products div{height:16px;}
    </style>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
$(document).ready(function(){
	var offer_type = $('input[name="offer_type"]').val();
	if(offer_type == 'product') {
		$('#additional_offer_product').show();
		$('#select_offer_type').hide();
	}
	
	if(offer_type == 'summ') {
		$('#additional_offer_summ').show();
		$('#select_offer_type').hide();
	}
	
	if(offer_type == '') {
		$('#additional_offer_summ').hide();
		$('#additional_offer_product').hide();
		$('#select_offer_type').show();
	}
	
	$('#select_offer_type').on('click', 'input, label', function(){
		var offer_type = $(this).val();
		if (offer_type == 'product') {
			$('#additional_offer_product').show();
			$('input[name="offer_type"]').val(offer_type);
			$('#select_offer_type').hide();
		}
		if (offer_type == 'summ') {
			$('#additional_offer_summ').show();
			$('input[name="offer_type"]').val(offer_type);
			$('#select_offer_type').hide();
		}	
	});
});

function add_selected(){
	
	$('#product-filter input[name="product_to_select[]"]:checked').each(function(){
		var val = $(this).val();
		var name = $(this).parent().text();
		
		$('#offer-product').append('<div id="offer-product' + val + '">' + name + '<img src="view/image/delete.png" /><input type="hidden" name="offer-product[]" value="' + val + '" /></div>');

		$('#offer-product div:odd').attr('class', 'odd');
		$('#offer-product div:even').attr('class', 'even');

	});
}

$('#offer-product div img, #ao-product div img, #ao-product-summ div img').live('click', function() {
	$(this).parent().remove();
	
	$('#offer-product div:odd').attr('class', 'odd');
	$('#offer-product div:even').attr('class', 'even');	
	$('#ao-product div:odd').attr('class', 'odd');
	$('#ao-product div:even').attr('class', 'even');	
	$('#ao-product-summ div:odd').attr('class', 'odd');
	$('#ao-product-summ div:even').attr('class', 'even');	
});

$('input[name=\'product_additional_offer[aop]\']').autocomplete({
	delay: 0,
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
		$('#ao-product').append('<div id="ao-product' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" name="ao_product[]" value="' + ui.item.value + '" /></div>');

		$('#ao-product div:odd').attr('class', 'odd');
		$('#ao-product div:even').attr('class', 'even');	
		return false;
	},
	focus: function(event, ui) {
      return false;
	}
});

$('input[name=\'product_additional_offer_summ[aop]\']').autocomplete({
	delay: 0,
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
		$('#ao-product-summ').append('<div id="ao-product' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" name="ao_product[]" value="' + ui.item.value + '" /></div>');

		$('#ao-product-summ div:odd').attr('class', 'odd');
		$('#ao-product-summ div:even').attr('class', 'even');	
		return false;
	},
	focus: function(event, ui) {
      return false;
	}
});
    //--></script>
<script type="text/javascript"><!--
$(function(){
	$("#submit-form-product, #submit-form-summ").live('click', function(){
		$.ajax({
			url: $('#' + $(this).data('form')).attr('action'),
			type: 'post',
			data: $('#' + $(this).data('form') + ' input[type="text"], #' + $(this).data('form') + ' input[type="radio"]:checked, #' + $(this).data('form') + ' input[type="hidden"], #' + $(this).data('form') + ' input[type="checkbox"]:checked, #' + $(this).data('form') + ' select, #' + $(this).data('form') + ' textarea').add('#select_offer_type input[name="offer_type"]'),
			dataType: 'json',
			success: function(json) {
				if(json['error']){
					alert(json['error']);
				} else {
					alert(json['message']['message']);
					location.href="index.php?route=catalog/addspecials&token=<?php echo $token; ?>";
				}
			}
		});
	})
});
//--></script>
<script type="text/javascript"><!--
    var productTotal = 0;
    
    function load_products(start, limit){
        $.ajax({
            url: 'index.php?route=catalog/addspecials/productFilter&product_list=1&start=' + start + '&limit=' + limit + '&token=<?php echo $token; ?>',
            type: 'post',
            data: $('#product-filter .filter_data, #product-filter input[type="checkbox"]:checked'),
            dataType: 'json',
            success: function(json) {
                productTotal = parseInt(json['total']);
                $('#product-total').html(json['total']);
                html= '';
                index = 0;
                products = json['products'];
                check_all = $('input', '#check-all').prop('checked') ? 'checked="checked"' : '';
                for (product in products){
                    if (index % 2 == 0){
                        html += '<div class="odd" style="cursor:pointer;">';
                    }else{
                        html += '<div class="even" style="cursor:pointer;">';
                    }
                    html += '<input type="checkbox" ' + check_all + ' name="product_to_select[]" value="'+json['products'][product]['product_id']+'" />' + json['products'][product]['sku'] + ' - ' + json['products'][product]['name'];
                    
                    html += '</div>';
                    index++;
                }
                $('#filtered-products').append(html);
            }
        });
    }

    $('div', '#filtered-products').live('click', function(e){
        if (e.target.tagName != "INPUT"){
            $('input', $(this)).prop('checked', !$('input', $(this)).prop('checked'));
        }
    });

    $('#check-all').live('click', function(e){
        if (e.target.tagName != "INPUT"){
            $('input', $(this)).prop('checked', !$('input', $(this)).prop('checked'));
        }
        if ($('input', $(this)).prop('checked')){   $('input', '#filtered-products').prop('checked',true);
        }else{                                      $('input', '#filtered-products').prop('checked',false);}
    });

    start = 30;
    limit = 30;
	load_products(0, limit);
	
    $('.filter_data, #product-filter input[type="checkbox"]').on('change', function(){
           $('#filtered-products').html('');
            start = 30;
            limit = 30;
            load_products(0, limit);
    });
	
	$('input[name="name"]').on('keyup', function(){
        $('#filtered-products').html('');
        start = 30;
        limit = 30;
        load_products(0, limit);
    });
	
	$('input[name="model"]').on('keyup', function(){
        $('#filtered-products').html('');
        start = 30;
        limit = 30;
        load_products(0, limit);
    });

    $('#filtered-products').bind('scroll',function(){
        productCount = $('#filtered-products div').size();
        scrollTop = (productCount - 15) * 22;
        if ($(this).scrollTop() == scrollTop && start <= productTotal){
            load_products(start, limit);
            start += limit;
        }
    })
    //--></script>
    <script type="text/javascript"><!--
    $('.date').datepicker({dateFormat: 'yy-mm-dd'});
     //--></script>
<script type="text/javascript"><!--
function image_upload(field, thumb) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
					dataType: 'text',
					success: function(text) {
						$('#' + thumb).replaceWith('<img src="' + text + '" alt="" id="' + thumb + '" />');
					}
				});
			}
		},	
		bgiframe: false,
		width: 800,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script> 
<?php echo $footer; ?>