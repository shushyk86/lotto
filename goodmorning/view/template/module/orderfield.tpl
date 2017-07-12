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
    <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table id="module" class="list">
        <thead>
          <tr>
            <td class="left" width="200px"><?php echo $entry_status; ?></td>
			<td ><?php echo $entry_image; ?></td>
			<td ><?php echo $entry_image_inf; ?></td>
			<td ><?php echo $entry_image_inv; ?></td>
			<td ><?php echo $entry_image_mail; ?></td>

          </tr>
        </thead>
		<tr>

            	 <td class="left"><select name="<?php echo ('orderfield_status'); ?>" >
                 <?php if (($this->config->get('orderfield_status')) > 0) { ?>
                 <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                 <option value="0"><?php echo $text_disabled; ?></option>
                 <?php } else { ?>
                 <option value="1"><?php echo $text_enabled; ?></option>
                 <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                 <?php } ?>
              	 </select></td>

            	 <td ><select name="<?php echo ('orderfield_image'); ?>" >
                 <?php if (($this->config->get('orderfield_image')) > 0) { ?>
                 <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                 <option value="0"><?php echo $text_disabled; ?></option>
                 <?php } else { ?>
                 <option value="1"><?php echo $text_enabled; ?></option>
                 <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                 <?php } ?>
              	 </select></td>
				 
				 <td class="left"><input type="text" size="5" name="<?php echo ('orderfield_image_inf'); ?>" value="<?php echo (isset($orderfield_image_inf) ? $orderfield_image_inf: '60') ; ?>" />
				 
				 <td class="left"><input type="text" size="5" name="<?php echo ('orderfield_image_inv'); ?>" value="<?php echo (isset($orderfield_image_inv) ? $orderfield_image_inv: '60') ; ?>" />
				 
				 <td class="left"><input type="text" size="5" name="<?php echo ('orderfield_image_mail'); ?>" value="<?php echo (isset($orderfield_image_mail) ? $orderfield_image_mail: '60') ; ?>" />

		</tr>
		</table>

      <table id="module" class="list">
        <thead>
          <tr>
			<td class="left" ><?php echo $entry_mnf; ?></td>
            <td class="left" ><?php echo $entry_sku; ?></td>
			<td class="left" ><?php echo $entry_upc; ?></td>
			<td class="left" ><?php echo $entry_ean; ?></td>
			<td class="left" ><?php echo $entry_jan; ?></td>
			<td class="left" ><?php echo $entry_isbn; ?></td>
			<td class="left" ><?php echo $entry_mpn; ?></td>
			<td class="left" ><?php echo $entry_loc; ?></td>
			
          </tr>
        </thead>
		<tr>
				<td class="left"><select name="<?php echo ('orderfield_mnf'); ?>" >
                 <?php if (($this->config->get('orderfield_mnf')) > 0) { ?>
                 <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                 <option value="0"><?php echo $text_disabled; ?></option>
                 <?php } else { ?>
                 <option value="1"><?php echo $text_enabled; ?></option>
                 <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                 <?php } ?>
              	 </select></td>
				 
				<td class="left"><select name="<?php echo ('orderfield_sku'); ?>" >
                 <?php if (($this->config->get('orderfield_sku')) > 0) { ?>
                 <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                 <option value="0"><?php echo $text_disabled; ?></option>
                 <?php } else { ?>
                 <option value="1"><?php echo $text_enabled; ?></option>
                 <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                 <?php } ?>
              	 </select></td>

				<td class="left"><select name="<?php echo ('orderfield_upc'); ?>" >
                 <?php if (($this->config->get('orderfield_upc')) > 0) { ?>
                 <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                 <option value="0"><?php echo $text_disabled; ?></option>
                 <?php } else { ?>
                 <option value="1"><?php echo $text_enabled; ?></option>
                 <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                 <?php } ?>
              	 </select></td>

				<td class="left"><select name="<?php echo ('orderfield_ean'); ?>" >
                 <?php if (($this->config->get('orderfield_ean')) > 0) { ?>
                 <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                 <option value="0"><?php echo $text_disabled; ?></option>
                 <?php } else { ?>
                 <option value="1"><?php echo $text_enabled; ?></option>
                 <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                 <?php } ?>
              	 </select></td>

				<td class="left"><select name="<?php echo ('orderfield_jan'); ?>" >
                 <?php if (($this->config->get('orderfield_jan')) > 0) { ?>
                 <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                 <option value="0"><?php echo $text_disabled; ?></option>
                 <?php } else { ?>
                 <option value="1"><?php echo $text_enabled; ?></option>
                 <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                 <?php } ?>
              	 </select></td>

				<td class="left"><select name="<?php echo ('orderfield_isbn'); ?>" >
                 <?php if (($this->config->get('orderfield_isbn')) > 0) { ?>
                 <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                 <option value="0"><?php echo $text_disabled; ?></option>
                 <?php } else { ?>
                 <option value="1"><?php echo $text_enabled; ?></option>
                 <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                 <?php } ?>
              	 </select></td>

				<td class="left"><select name="<?php echo ('orderfield_mpn'); ?>" >
                 <?php if (($this->config->get('orderfield_mpn')) > 0) { ?>
                 <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                 <option value="0"><?php echo $text_disabled; ?></option>
                 <?php } else { ?>
                 <option value="1"><?php echo $text_enabled; ?></option>
                 <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                 <?php } ?>
              	 </select></td>
				 
				<td class="left"><select name="<?php echo ('orderfield_loc'); ?>" >
                 <?php if (($this->config->get('orderfield_loc')) > 0) { ?>
                 <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                 <option value="0"><?php echo $text_disabled; ?></option>
                 <?php } else { ?>
                 <option value="1"><?php echo $text_enabled; ?></option>
                 <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                 <?php } ?>
              	 </select></td>
		</tr>
		
		<thead>
          <tr>
            <td class="left" ><?php echo $entry_mnf_name; ?></td>
			<td class="left" ><?php echo $entry_sku_name; ?></td>
			<td class="left" ><?php echo $entry_upc_name; ?></td>
			<td class="left" ><?php echo $entry_ean_name; ?></td>
			<td class="left" ><?php echo $entry_jan_name; ?></td>
			<td class="left" ><?php echo $entry_isbn_name; ?></td>
			<td class="left" ><?php echo $entry_mpn_name; ?></td>
			<td class="left" ><?php echo $entry_loc_name; ?></td>
			
          </tr>
        </thead>
		  <tr>
			<td class="left"><input type="text" size="12" name="<?php echo ('orderfield_mnf_name'); ?>" value="<?php echo (isset($orderfield_mnf_name) ? $orderfield_mnf_name: 'Manufacturer') ; ?>" /></td>
			<td class="left"><input type="text" size="12" name="<?php echo ('orderfield_sku_name'); ?>" value="<?php echo (isset($orderfield_sku_name) ? $orderfield_sku_name: 'SKU') ; ?>" /></td>
			<td class="left"><input type="text" size="12" name="<?php echo ('orderfield_upc_name'); ?>" value="<?php echo (isset($orderfield_upc_name) ? $orderfield_upc_name: 'UPC') ; ?>" /></td>
			<td class="left"><input type="text" size="12" name="<?php echo ('orderfield_ean_name'); ?>" value="<?php echo (isset($orderfield_ean_name) ? $orderfield_ean_name: 'EAN') ; ?>" /></td>
			<td class="left"><input type="text" size="12" name="<?php echo ('orderfield_jan_name'); ?>" value="<?php echo (isset($orderfield_jan_name) ? $orderfield_jan_name: 'JAN') ; ?>" /></td>
			<td class="left"><input type="text" size="12" name="<?php echo ('orderfield_isbn_name'); ?>" value="<?php echo (isset($orderfield_isbn_name) ? $orderfield_isbn_name: 'ISBN') ; ?>" /></td>
			<td class="left"><input type="text" size="12" name="<?php echo ('orderfield_mpn_name'); ?>" value="<?php echo (isset($orderfield_mpn_name) ? $orderfield_mpn_name: 'MPN') ; ?>" /></td>
			<td class="left"><input type="text" size="12" name="<?php echo ('orderfield_loc_name'); ?>" value="<?php echo (isset($orderfield_loc_name) ? $orderfield_loc_name: 'Location') ; ?>" /></td>
		  </tr>
		</table>
		
		
    </form>

  </div>
</div>

<?php echo $footer; ?>