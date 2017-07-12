<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/total.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
		<table class="form">
          <tr>
            <td><?php echo $entry_sort_order; ?></td>
            <td><input type="text" name="payment_discounts_sort_order" value="<?php echo $payment_discounts_sort_order; ?>" size="1" /></td>
          </tr>
		   <tr>
		   <td><?php echo $entry_status; ?></td>
		  <td><select name="payment_discounts_status">
                <?php if ($payment_discounts_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			</tr>
        </table>
        <table id="discounts" class="list">
          <thead>
            <tr>
              <td class="left"><?php echo $entry_payment; ?></td>
			  <td class="left"><?php echo 'Бесплатная доставка от суммы:'; ?></td>
              <td class="left"><?php echo $entry_skidka; ?> - <?php echo $text_percent; ?>:</td>
              <td class="left"><?php echo $entry_skidka; ?> - <?php echo $text_ed; ?>:</td>
              <td></td>
            </tr>
          </thead>
          <?php $discount_row = 0; ?>
          <?php foreach ($payment_discounts_discount as $discount) { ?>
          <tbody id="discount-row<?php echo $discount_row; ?>">
            <tr>
              <td class="left">
               <select name="payment_discounts_discount[<?php echo $discount_row; ?>][paymentmethod]">
                  <?php foreach ($payments as $payment) { ?>
                  <?php if ($payment['payment_code'] == $discount['paymentmethod']) { ?>
                  <option value="<?php echo $payment['payment_code']; ?>" selected="selected"><?php echo $payment['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $payment['payment_code']; ?>"><?php echo $payment['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
                </td>
				<td class="left">
                    <input name="payment_discounts_discount[<?php echo $discount_row; ?>][sum_number]" value="<?php if (isset($discount['sum_number'])) echo $discount['sum_number']; ?>" />
                </td>
              <td class="left">
			   <select name="payment_discounts_discount[<?php echo $discount_row; ?>][percent_znak]">
                <option value="0" <?php if (isset($discount['percent_znak']) and (int)$discount['percent_znak'] == 0) echo 'selected="selected"'; ?> >+</option>
                <option value="1" <?php if (isset($discount['percent_znak']) and (int)$discount['percent_znak'] == 1) echo 'selected="selected"'; ?> >-</option>
              </select>
			   &nbsp;
			  <input name="payment_discounts_discount[<?php echo $discount_row; ?>][percent_number]" value="<?php if (isset($discount['percent_number'])) echo $discount['percent_number']; ?>" />
			  </td>

                <td class="left">
                    <select name="payment_discounts_discount[<?php echo $discount_row; ?>][ed_znak]">
                        <option value="0" <?php if (isset($discount['ed_znak']) and (int)$discount['ed_znak'] == 0) echo 'selected="selected"'; ?> >+</option>
                        <option value="1" <?php if (isset($discount['ed_znak']) and (int)$discount['ed_znak'] == 1) echo 'selected="selected"'; ?> >-</option>
                    </select>
                    &nbsp;
                    <input name="payment_discounts_discount[<?php echo $discount_row; ?>][ed_number]" value="<?php if (isset($discount['ed_number'])) echo $discount['ed_number']; ?>" />
                </td>

              <td class="left"><a onclick="$('#discount-row<?php echo $discount_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
            </tr>
          </tbody>
          <?php $discount_row++; ?>
          <?php } ?>
          <tfoot>
            <tr>
              <td colspan="3"></td>
              <td class="left"><a onclick="addDiscount();" class="button"><?php echo $button_add_discount; ?></a></td>
            </tr>
          </tfoot>
        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
var discount_row = <?php echo $discount_row; ?>;

function addDiscount() {
    html  = '<tbody id="discount-row' + discount_row + '">';
    html += '<tr>';
    html += '<td class="left">';
    html += '<select name="payment_discounts_discount[' + discount_row + '][paymentmethod]">';
    <?php foreach ($payments as $payment) { ?>
    html += '<option value="<?php echo $payment['payment_code']; ?>"><?php echo $payment['name']; ?></option>';
	<?php } ?>
    html += '</select>';
    html += '</td>';
    html += '<td class="left">';
	html += '<select name="payment_discounts_discount[' + discount_row + '][percent_znak]">';
    html += '<option value="0" selected="selected">+</option>';
    html += '<option value="1" >-</option>';
    html += '</select>';
	html += '&nbsp;';
	html += '<input name="payment_discounts_discount[' + discount_row + '][percent_number]" value="" />';
	html += '</td>';
    html += '<td class="left">';
    html += '<select name="payment_discounts_discount[' + discount_row + '][ed_znak]">';
    html += '<option value="0" selected="selected">+</option>';
    html += '<option value="1" >-</option>';
    html += '</select>';
    html += '&nbsp;';
    html += '<input name="payment_discounts_discount[' + discount_row + '][ed_number]" value="" />';
    html += '</td>';
	html += '<td class="left"><a onclick="$(\'#discount-row' + discount_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
    html += '</tr>';
    html += '</tbody>'; 
	
	$('#discounts tfoot').before(html);
	
	discount_row++;
}
//--></script>
<?php echo $footer; ?> 