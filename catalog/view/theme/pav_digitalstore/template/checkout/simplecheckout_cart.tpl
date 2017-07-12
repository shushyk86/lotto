<?php if ($attention) { ?>
    <div class="simplecheckout-warning-block"><?php echo $attention; ?></div>
<?php } ?>
<?php if ($error_warning) { ?>
    <div class="simplecheckout-warning-block"><?php echo $error_warning; ?></div>
<?php } ?>

    <table class="simplecheckout-cart">
        <colgroup>
            <col class="image">
            <col class="name">
            <col class="model">
            <col class="quantity">
            <col class="price">
            <col class="total">
            <col class="remove">
        </colgroup>
        <thead>
            <tr>
                <th></th>
                <th class="image"></th>
                <th class="name">Наименование</th>
                <!-- <th class="model"><?php echo $column_model; ?></th> -->
                <th class="price">Цена за единицу</th>
                <th class="quantity">Количество</th>
                <th class="total"><?php echo $column_total; ?></th>
                <th class="remove"></th>     
                <th></th>   
            </tr>
        </thead>
    <tbody>
    <?php foreach ($products as $j => $product) { ?>
        <?php if (!empty($product['recurring'])) { ?>
            <tr>
                <td class="simplecheckout-recurring-product" style="border:none;">
                <image src="catalog/view/theme/default/image/reorder.png" alt="" title="" style="float:left;" />
                <span style="float:left;line-height:18px; margin-left:10px;"> 
                    <strong><?php echo $text_recurring_item ?></strong>
                </span>
                    <?php echo $product['profile_description'] ?>
                </td>
            </tr>
        <?php } ?>
        <tr>
            <td></td>
            <td class="image">
                <?php if ($product['thumb']) { ?>
                    <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                <?php } ?>
            </td>
            <td class="name">
                <?php if ($product['thumb']) { ?>
                    <div class="image">
                        <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                    </div>
                <?php } ?>
                <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                <?php if (!$product['stock'] && ($config_stock_warning || !$config_stock_checkout)) { ?>
                    <span class="product-warning"><?php echo $text_error_stock; ?></span>
                <?php } ?>
                <div class="options">
                <?php foreach ($product['option'] as $option) { ?>
                <small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br />
                <?php } ?>
                <?php if (!empty($product['recurring'])) { ?>
                - <small><?php echo $text_payment_profile ?>: <?php echo $product['profile_name'] ?></small>
                <?php } ?>
                </div>

                <?php if (isset($modules['reward'])) { ?>
                <small><?php echo $product['reward']; ?></small>
                <?php } ?>

            </td>
            <!-- <td class="model"><?php echo $product['model']; ?></td> -->
            <td class="price"><p><?php echo $product['price']; ?></p></td>
            <td class="quantity">
            <span class="minus11" <?php if ($quantity > 1) { ?>onclick="jQuery(this).next().val(~~jQuery(this).next().val()-1);simplecheckout_reload('cart_value_decreased');"<?php } ?>> - </span>
                <input type="text" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" onchange="simplecheckout_reload('cart_value_changed');" />
                <span onclick="jQuery(this).prev().val(~~jQuery(this).prev().val()+1);simplecheckout_reload('cart_value_increased');"> + </span>
            </td>
            <td class="total"><p><?php echo $product['total']; ?></p></td>
            <td class="remove">
                <span style="cursor:pointer;" onclick="removeCartAnalytics('<?php echo $product['sku'] ?>', '<?php echo addslashes($product['name']); ?>', '<?php echo $product['clear_price']; ?>', <?php echo $j+1; ?>, <?php echo $product['quantity']; ?>); jQuery('#simplecheckout_remove').val('<?php echo $product['key']; ?>');simplecheckout_reload('product_removed');"> x </span>
            </td>  
            <td></td>      
            </tr>
            <?php } ?>
			
<!--Additional offer-->	
		
<?php if(!empty($additionaloffers['offers'])) { ?>
<?php if(!$show_active) { ?>
<tr class="additionaloffer">
	<td colspan="8" style="padding-top: 15px; padding-bottom: 15px"><h2>Для Вашего заказа доступны следующие акции:</h2></td>
</tr>
<?php } ?>	
	<?php foreach($additionaloffers['offers'] as $offer_id => $offer) { ?>
		<?php if((!empty($additionaloffers['active_offer']) && $offer_id != $additionaloffers['active_offer']) || $show_active || (isset($additionaloffers['single_offer']) && $additionaloffers['single_offer'])) { ?>
		<?php } else { ?>
			<tr class="additionaloffer">
				<td colspan="8" style="padding-top: 5px; padding-bottom: 5px"><h3><?php echo $offer[0]['offer_name']; ?></h3></td>
			</tr>
			<?php foreach($offer as $k => $product) { ?>
			<?php if(!$show_active) { ?>
			<tr class="additionaloffer">
				<td></td>
				<td class="image"><?php if ($product['thumb']) { ?>
				  <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
				  <?php } ?></td>
				<td class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></td>
				<td class="price"><?php echo $product['price']; ?><?php echo $product['discount']; ?></td>
				<td class="quantity">
				<span class="minus11" <?php if ($additionaloffers['max_quantity'][$offer_id] > 1) { ?>onclick="jQuery(this).next().val(~~jQuery(this).next().val()-1);"<?php } ?>> - </span>
					<input type="text" id="<?php echo $product['product_id']; ?>" value="<?php echo $additionaloffers['max_quantity'][$offer_id]; ?>" size="1" />
					<span onclick="if(jQuery(this).prev().val() < <?php echo $additionaloffers['max_quantity'][$offer_id]; ?>) { jQuery(this).prev().val(~~jQuery(this).prev().val()+1) };"> + </span>
				</td>
				<td class="total">
				<?php if($product['options']) { ?>
				 <?php foreach ($product['options'] as $option) { ?>
				  <?php if ($option['type'] == 'select') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="option hide">
					  <select id="select<?php echo $product['product_id']; ?>" class="select_control" name="option[<?php echo $option['product_option_id']; ?>]">
						<option value=""><?php echo $text_select; ?></option>
						<?php foreach ($option['option_value'] as $option_value) { ?>
						  <option value="<?php echo $option_value['product_option_value_id']; ?>">
							<?php echo $option_value['name']; ?>
						  </option>
						<?php } ?>
					  </select>
					</div>
				  <?php } ?>
				 <?php } ?>
				<?php } ?>
				</td>
				<td class="remove">
					<input type="button" value="Добавить в корзину" id="add_bonus" data="<?php echo $product['product_id']; ?>" class="button" />
				</td>
				<td></td>
			</tr>
			<?php } ?>
			<?php } ?>
		<?php } ?>
	<?php } ?>
<?php } ?>

<!--Additional offer-->
			
            <?php foreach ($vouchers as $voucher_info) { ?>
                <tr>
                    <td class="image"></td>  
                    <td class="name"><?php echo $voucher_info['description']; ?></td>
                    <td class="model"></td>
                    <td class="quantity">1</td>
                    <td class="price"><nobr><?php echo $voucher_info['amount']; ?></nobr></td>
                    <td class="total"><nobr><?php echo $voucher_info['amount']; ?></nobr></td>
                    <td class="remove">
                    <img style="cursor:pointer;" src="<?php echo $simple->tpl_joomla_path() ?>catalog/view/image/close.png" onclick="jQuery('#simplecheckout_remove').val('<?php echo $voucher_info['key']; ?>');simplecheckout_reload('product_removed');" />
                    </td>
                </tr>
            <?php } ?>
    </tbody>
</table>

<!--Additional offer-->
<?php if($additionaloffers['banners']) { ?>
	<h2>В Вашей корзине есть товары, которые можно получить в подарок по акции!</h2>
	<?php foreach ($additionaloffers['banners'] as $banner) { ?>
	<div class="grow pic">
		<a id="offer-info-link" data-toggle="modal" data-target="#offer-info<?php echo $banner['offer_id']; ?>"><img src="<?php echo $banner['image']; ?>" /></a>
	</div>
	<?php } ?>
<?php } ?>
<!--Additional offer-->
    
<?php foreach ($totals as $total) { ?>
    <div class="simplecheckout-cart-total" id="total_<?php echo $total['code']; ?>">
        <span><b><?php echo $total['title']; ?>:</b></span>
        <span class="simplecheckout-cart-total-value"><p><?php echo $total['text']; ?></p></span>
        <span class="simplecheckout-cart-total-remove">
            <?php if ($total['code'] == 'coupon') { ?>
            <img src="<?php echo $simple->tpl_joomla_path() ?>catalog/view/image/close.png" onclick="jQuery('input[name=coupon]').val('');simplecheckout_reload('coupon_removed');" id="coupon_remove" />
            <?php } ?>
            <?php if ($total['code'] == 'voucher') { ?>
            <img src="<?php echo $simple->tpl_joomla_path() ?>catalog/view/image/close.png" onclick="jQuery('input[name=voucher]').val('');simplecheckout_reload('voucher_removed');" />
            <?php } ?>
            <?php if ($total['code'] == 'reward') { ?>
            <img src="<?php echo $simple->tpl_joomla_path() ?>catalog/view/image/close.png" onclick="jQuery('input[name=reward]').val('');simplecheckout_reload('reward_removed');" />
            <?php } ?>
        </span>
    </div>
<?php } ?>

<div class="simplecheckout-cart-total pull-right col-sm-4 clearfix" id="total_sub_total" style="text-align: left;">
	<?php if (isset($modules['coupon']) && (isset($modules['reward']) && $this->customer->isLogged() && $points > 0)) { ?>
		<div class="text-left" style="padding-bottom: 10px;"><input type="radio" name="discounts_select" id="radio_coupon" value="coupon" style="margin-left: 5px"><label for="radio_coupon">Использовать промокод</label></div>
		<div class="text-left" style="padding-bottom: 10px;"><input type="radio" name="discounts_select" id="radio_reward" value="reward" style="margin-left: 5px"><label for="radio_reward">Использовать бонусные гривны</label></div>
	<?php } ?>
	
	<?php if (isset($modules['coupon'])) { ?>
    <div class="simplecheckout-cart-total pull-left" id="coupon11" <?php if (isset($modules['reward']) && $this->customer->isLogged() && $points > 0) { ?>style="display: none;"<?php } ?>>
        <input type="text" name="coupon" placeholder="использовать промокод" value="<?php echo $coupon; ?>" onchange="simplecheckout_reload('coupon_changed')"  />
        <div class="wrapp__yellow-tooltip"><span class="yellow-tooltip" href=""  data-toggle="tooltip" data-placement="top" data-html="true" title="1. Следите за нашими промокодами в соц сетях и в рассылках</br>2. Введите актуальный промокод и нажмите кнопку 'применить'</br>3. Промокодом нельзя воспользоваться при выборе способа доставки 'Самовывоз из магазина'"><i class="fa fa-question-circle" aria-hidden="true"></i></span> Где взять и как воспользоваться промокодом?</div>
    </div>
	<?php } ?>

    <?php if (isset($modules['reward']) && $this->customer->isLogged() && $points > 0) { ?>
        <div class="simplecheckout-cart-total pull-left" id="reward11" <?php if (isset($modules['coupon'])) { ?>style="display: none;"<?php } ?>>
            <span class="inputs"><input type="text" name="reward_open" value="<?php echo $reward; ?>" onchange="checkBonuses(); simplecheckout_reload('cart_changed')" /></span>
            <input type="hidden" name="reward" value="<?php echo $reward_current; ?>" />
            <div class="wrapp__yellow-tooltip">Можно использовать (не более): <?php echo $points; ?></div>
            <div class="wrapp__yellow-tooltip">Всего доступно бонусных гривен: <?php echo $user_points; ?></div>
        </div>
    <?php } ?>
<!-- button -->
<?php if (isset($modules['coupon']) || isset($modules['reward']) || isset($modules['voucher'])) { ?>
    <div class="simplecheckout-cart-total simplecheckout-cart-buttons" id="coupon_button" <?php if (isset($modules['coupon']) && isset($modules['reward']) && $this->customer->isLogged() && $points > 0) { ?>style="display: none"<?php } ?>>
        <span class="inputs buttons"><div class="under-color"><a id="simplecheckout_button_cart" onclick="checkBonuses(); simplecheckout_reload('cart_changed')" class="btn"><span><?php echo $button_apply; ?></span></a></div></span>
    </div>
<?php } ?>
</div>


<!-- <?php if (isset($modules['voucher'])) { ?>
    <div class="simplecheckout-cart-total">
        <span class="inputs"><?php echo $entry_voucher; ?>&nbsp;<input type="text" name="voucher" value="<?php echo $voucher; ?>" onchange="simplecheckout_reload('voucher_changed')"  /></span>
    </div>
<?php } ?>-->
<?php if (isset($modules['coupon']) || isset($modules['reward']) || isset($modules['voucher'])) { ?>
<div class="total-block11 clearfix" style="clear:both;"></div>
<?php } ?>
    
<input type="hidden" name="remove" value="" id="simplecheckout_remove">
<div style="display:none;" id="simplecheckout_cart_total"><?php echo $cart_total ?></div>

<!--Additional offer-->
<script type="text/javascript"><!--
    function removeCartAnalytics(id, name, price, position, quantity){
        ga("ec:addProduct", {
            "id": id,
            "name": name,
            "price": price,
            "position": position,
            "quantity": quantity
        });
        ga("ec:setAction", "remove");
        ga("send", "event", "UX", "click", "remove from cart");
    }

    function checkBonuses(){
        if ($('#reward11').length > 0){
            $('input[name="reward"]').val($('input[name="reward_open"]').val());
        }
    }

    $(document).ready(function() {
        $('input[name="discounts_select"]').on('click', function(){
            if($(this).val() == 'coupon'){
                $('#coupon11').show();
                $('#reward11').hide();
                $('#coupon_button').show();
            }
            if($(this).val() == 'reward'){
                $('#reward11').show();
                $('#coupon11').hide();
                $('#coupon_button').show();
            }
        });

        $('td').on('click', '#add_bonus', function() {
		$('.error, .sizer').remove();
		var product_id = $(this).attr('data');

		if($("#select"+product_id+" option:selected").text() == " --- Выберите --- " && $('.sizer').length === 0){
			$('#modal123').show();
			$(this).parent().addClass('under-color-focus');
			$(this).after('<div class="sizer sizer-select"><span class="title_sizer">Выберите размер</span><br/><ul id="sizer-val"></ul></div>');
		
			$("#select"+product_id+" option").each(function() {
				var optionVal = $(this).val();
				var optionText = $(this).text();
				if(optionVal != ''){
					$('#sizer-val').append('<li value="'+optionVal+'">'+optionText+'</li>');
				}
			});

			$('#modal123').on('click', function() {
				$(this).hide();
				$('.sizer-select').detach();
				$('.under-color-focus').removeClass('under-color-focus');
			});
			
			$('#sizer-val').on('click', 'li', function() {
				var liVal = $(this).val().toString();

				$("#select"+product_id+" option").each(function() {
					var oVal = $(this).val();
					if(oVal === liVal) {$(this).prop("selected", true)}
				})

				$(this).addClass('chosen');
				$(this).siblings().removeClass('chosen');
					
				var bonus = product_id;
				var quantity = $('#'+bonus).val();
				var data = 'product_id=' + bonus + '&quantity=' + quantity;
				if($('#select'+bonus).length != 0){
					var option = $('#select'+bonus).attr('name');
					var option_value = $('#select'+bonus).prop('selected', true).val();
					if(option_value == ''){
						$('#select'+bonus).after('<span class="error" style="font-size: 14px;">Необходимо указать размер!</span>');
						return false;
					}
					data = 'product_id=' + bonus + '&quantity=' + quantity + '&' + option + '=' + option_value;
				}
				$.ajax({
					url: 'index.php?route=checkout/cart/add',
					type: 'post',
					data: data,
					dataType: 'json'
				});
				//simplecheckout_reload('cart_changed');
				window.location.reload();				
			});	
		} else {
			if($('.sizer').length !== 0) {
				setTimeout(function() {
					$('.sizer').remove();
				}, 100)
			}		
			var bonus = product_id;
			var quantity = $('#'+bonus).val();
			var data = 'product_id=' + bonus + '&quantity=' + quantity;
			if($('#select'+bonus).length === 0){
				$.ajax({
					url: 'index.php?route=checkout/cart/add',
					type: 'post',
					data: data,
					dataType: 'json'
				});
				//simplecheckout_reload('cart_changed');
				window.location.reload();			
			}
		} 
	});
});
//--></script>
<!--Additional offer-->

<script type="text/javascript">
    jQuery(function(){
        jQuery('#cart_total').html('<?php echo $cart_total ?>');
        jQuery('#cart-total').html('<?php echo $cart_total ?>');
        jQuery('#cart_menu .s_grand_total').html('<?php echo $cart_total ?>');
        <?php if ($simple_show_weight) { ?>
        jQuery('#weight').text('<?php echo $weight ?>');
        <?php } ?>
        <?php if ($template == 'shoppica2') { ?>
        jQuery('#cart_menu div.s_cart_holder').html('');
        $.getJSON('index.php?<?php echo $simple->tpl_joomla_route() ?>route=tb/cartCallback', function(json) {
            if (json['html']) {
                jQuery('#cart_menu span.s_grand_total').html(json['total_sum']);
                jQuery('#cart_menu div.s_cart_holder').html(json['html']);
            }
        });
        <?php } ?>
        <?php if ($template == 'shoppica') { ?>
            jQuery('#cart_menu div.s_cart_holder').html('');
            jQuery.getJSON('index.php?<?php echo $simple->tpl_joomla_route() ?>route=module/shoppica/cartCallback', function(json) {
                if (json['output']) {
                    jQuery('#cart_menu span.s_grand_total').html(json['total_sum']);
                    jQuery('#cart_menu div.s_cart_holder').html(json['output']);
                }
            });
        <?php } ?>
    });
</script>
<?php if ($simple->get_simple_steps() && $simple->get_simple_steps_summary()) { ?>
<div id="simple_summary" style="display: none;margin-bottom:15px;">
    <table class="simplecheckout-cart">
        <colgroup>
            <col class="image">
            <col class="name">
            <col class="model">
            <col class="quantity">
            <col class="price">
            <col class="total">
        </colgroup>
        <thead>
            <tr>
                <th class="image"><?php echo $column_image; ?></th>
                <th class="name"><?php echo $column_name; ?></th>
                <th class="model"><?php echo $column_model; ?></th>
                <th class="quantity"><?php echo $column_quantity; ?></th>
                <th class="price"><?php echo $column_price; ?></th>
                <th class="total"><?php echo $column_total; ?></th>
            </tr>
        </thead>
    <tbody>
    <?php foreach ($products as $product) { ?>
        <tr>
            <td class="image">
                <?php if ($product['thumb']) { ?>
                    <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                <?php } ?>
            </td> 
            <td class="name">
                <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                <?php if (!$product['stock'] && ($config_stock_warning || !$config_stock_checkout)) { ?>
                    <span class="product-warning"><?php echo $text_error_stock; ?></span>
                <?php } ?>
                <div class="options">
                <?php foreach ($product['option'] as $option) { ?>
                &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br />
                <?php } ?>
                </div>
                <?php if ($product['reward']) { ?>
                <small><?php echo $product['reward']; ?></small>
                <?php } ?>
            </td>
            <td class="model"><?php echo $product['model']; ?></td>
            <td class="quantity"><?php echo $product['quantity']; ?></td>
            <td class="price"><nobr><?php echo $product['price']; ?></nobr></td>
            <td class="total"><nobr><?php echo $product['total']; ?></nobr></td>
            </tr>
            <?php } ?>
            <?php foreach ($vouchers as $voucher_info) { ?>
                <tr>
                    <td class="image"></td>  
                    <td class="name"><?php echo $voucher_info['description']; ?></td>
                    <td class="model"></td>
                    <td class="quantity">1</td>
                    <td class="price"><nobr><?php echo $voucher_info['amount']; ?></nobr></td>
                    <td class="total"><nobr><?php echo $voucher_info['amount']; ?></nobr></td>
                </tr>
            <?php } ?>
        </tbody>
    </table>
        
    <?php foreach ($totals as $total) { ?>
        <div class="simplecheckout-cart-total" id="total_<?php echo $total['code']; ?>">
            <span><b><?php echo $total['title']; ?>:</b></span>
            <span class="simplecheckout-cart-total-value"><nobr><?php echo $total['text']; ?></nobr></span>
        </div>
    <?php } ?>

    <?php if ($summary_comment) { ?>
    <table class="simplecheckout-cart simplecheckout-summary-info">
      <thead>
        <tr>
          <th class="name"><?php echo $text_summary_comment; ?></th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><?php echo $summary_comment; ?></td>
        </tr>
      </tbody>
    </table>
    <?php } ?>
    <?php if ($summary_payment_address || $summary_shipping_address) { ?>
    <table class="simplecheckout-cart simplecheckout-summary-info">
      <thead>
        <tr>
          <th class="name"><?php echo $text_summary_payment_address; ?></th>
          <?php if ($summary_shipping_address) { ?>
          <th class="name"><?php echo $text_summary_shipping_address; ?></th>
          <?php } ?>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><?php echo $summary_payment_address; ?></td>
          <?php if ($summary_shipping_address) { ?>
          <td><?php echo $summary_shipping_address; ?></td>
          <?php } ?>
        </tr>
      </tbody>
    </table>
    <?php } ?>
</div>
<?php } ?>
<div id="modal123"></div>
<script type="text/javascript">
    $("b, p").each(function() {
    var text = $(this).html().replace(/грн./ig, '<small>грн.</small>');
    $(this).html(text);

    $('.simplecheckout-customer-right').each(function() {
        var holder = $(this).siblings('.simplecheckout-customer-left').text().replace(/\s+/g, ' ').toUpperCase();
        $(this).find('input').attr('placeholder', holder)
    });

    //var nameC = $('#checkout_customer_main_firstname').parent().parent()
   // $('#checkout_customer_main_lastname').parent().parent().detach().insertAfter(nameC);

    $('#checkout_customer_main_country_id option:first').text('НАСЕЛЕННЫЙ ПУНКТ');
    $('#checkout_customer_main_zone_id option:first').text('№ ОТДЕЛЕНИЯ НОВОЙ ПОЧТЫ');

}); 

</script>

<!-- AddOffer information modal -->
<?php if(isset($additionaloffers['banners']) && $additionaloffers['banners']) { ?>
<?php foreach ($additionaloffers['banners'] as $banner) { ?>
<div id="offer-info<?php echo $banner['offer_id']; ?>" class="modal fade in" style="text-align: center;" tabindex="-1" role="dialog" aria-labelledby="offerInfoLabel" aria-hidden="false">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
          <h4 class="modal-title" id="offerInfoLabel">Информация об акции</h4>
        </div>
        <div class="modal-body">
          <?php echo $banner['description']; ?>
		   <button type="button" class="smch_call_button" data-dismiss="modal" aria-hidden="true">закрыть</button>
		</div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<?php } ?>
<?php } ?>
<!-- End AddOffer information modal -->
<?php /* var_dump($totals); */ ?>
