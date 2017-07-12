<?php 
$simple_page = 'simpleregister';
$j=0;
$i=0;

?>
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>
<div class="pesaha-block-wrapp clearfix">
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?> 
<?php if( $SPAN[0] ): ?>
	<aside class="col-lg-<?php echo $SPAN[0];?> col-md-<?php echo $SPAN[0];?> col-sm-12 col-xs-12">
		<?php echo $column_left; ?>
	</aside>
<?php endif; ?>

<section class="col-lg-<?php echo $SPAN[1];?> col-md-<?php echo $SPAN[1];?> col-sm-12 col-xs-12">
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>

  <div id="content" class="block-wrapp_action-1" style="background: none;"><?php echo $content_top; ?>
    <div class="block-wrapp_action clearfix">
		<div class="block-wrapp_action--content">
			<div class="block-wrapp_action--top-content clearfix"><img width="320" height="60" src="catalog/view/theme/pav_digitalstore/img/img_blog_lotto/register_logo_17.05.17.png" alt=""></div>
			<div class="block-wrapp_action--left-content clearfix">
				<img src="catalog/view/theme/pav_digitalstore/img/img_blog_lotto/register_text_17.05.17.png" alt="">
			</div>
            <div class="block-wrapp_action--right-content clearfix">
    	        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="simpleregister" class="pesaha-wrapp__form-register">
    	            <div class="simpleregister">

    	                    <div class="simpleregister-block-content">
    	                    <table class="simplecheckout-customer">
    	                        <?php foreach ($customer_fields as $field) { ?>
    	                            <?php if ($field['type'] == 'hidden') { continue; } ?>
    	                            <?php if ($j == 0 && $simple_registration_view_customer_type) { ?>
    	                                <tr>
    	                                    <td class="simplecheckout-customer-left">
    	                                        <span class="simplecheckout-required">*</span>
    	                                        <?php echo $entry_customer_type ?>
    	                                    </td>
    	                                    <td class="simplecheckout-customer-right">
    	                                        <?php if ($simple_type_of_selection_of_group == 'select') { ?>
    	                                        <select name="customer_group_id" onchange="$('#simpleregister').submit();">
    	                                            <?php foreach ($customer_groups as $id => $name) { ?>
    	                                            <option value="<?php echo $id ?>" <?php echo $id == $customer_group_id ? 'selected="selected"' : '' ?>><?php echo $name ?></option>
    	                                            <?php } ?>
    	                                        </select>
    	                                        <?php } else { ?>
    	                                            <?php foreach ($customer_groups as $id => $name) { ?>
    	                                            <label><input type="radio" name="customer_group_id" onchange="$('#simpleregister').submit();" value="<?php echo $id ?>" <?php echo $id == $customer_group_id ? 'checked="checked"' : '' ?>><?php echo $name ?></label><br>
    	                                            <?php } ?>
    	                                        <?php } ?>
    	                                    </td>
    	                                </tr>
    	                                <?php $j++; ?>
    	                            <?php } ?>
    	                            <?php $i++ ?>
    	                            <?php if ($field['type'] == 'header') { ?>
    	                            <?php if ($i == 1) { ?>
    	                                <?php continue; ?>
    	                            <?php } else { ?>
    	                            </table>
    	                            </div>
    	                            <?php echo $field['tag_open'] ?><?php echo $field['label'] ?><?php echo $field['tag_close'] ?>
    	                            <div class="simpleregister-block-content">
    	                            <table class="simplecheckout-customer">
    	                            <?php } ?>
    	                            <?php } else { ?>
    	                                <tr>
    	                                    <td class="simplecheckout-customer-left">
    	                                        <?php if ($field['required']) { ?>
    	                                            <span class="simplecheckout-required">*</span>
    	                                        <?php } ?>
    	                                        <?php echo $field['label'] ?>
    	                                    </td>
    	                                    <td class="simplecheckout-customer-right">
    	                                        <?php echo $simple->html_field($field) ?>
    	                                        <?php if (!empty($field['error']) && $simple_create_account) { ?>
    	                                            <span class="simplecheckout-error-text"><?php echo $field['error']; ?></span>
    	                                        <?php } ?>
    	                                    </td>
    	                                </tr>
    	                            <?php } ?>
    	                            <?php if ($field['id'] == 'main_email') { ?>
    	                                <?php if ($simple_registration_view_email_confirm) { ?>
    	                                <tr>
    	                                    <td class="simplecheckout-customer-left">
    	                                        <span class="simplecheckout-required">*</span>
    	                                        <?php echo $entry_email_confirm ?>
    	                                    </td>
    	                                    <td class="simplecheckout-customer-right">
    	                                        <input name="email_confirm" id="email_confirm" type="text" value="<?php echo $email_confirm ?>">
    	                                        <span class="simplecheckout-error-text" id="email_confirm_error" <?php if (!($email_confirm_error && $simple_create_account)) { ?>style="display:none;"<?php } ?>><?php echo $error_email_confirm; ?></span>
    	                                    </td>
    	                                </tr>
    	                                <?php } ?>
    	                                <tr <?php echo $simple_registration_generate_password ? 'style="display:none;"' : '' ?>>
    	                                    <td class="simplecheckout-customer-left">
    	                                        <span class="simplecheckout-required">*</span>
    	                                        <?php echo $entry_password ?>:
    	                                    </td>
    	                                    <td class="simplecheckout-customer-right">
    	                                        <input type="password" name="password" value="<?php echo $password ?>">

    	                                    </td>
    	                                </tr>
    	                                <?php if ($simple_registration_password_confirm) { ?>
    	                                <tr <?php echo $simple_registration_generate_password ? 'style="display:none;"' : '' ?>>
    	                                    <td class="simplecheckout-customer-left">
    	                                        <span class="simplecheckout-required">*</span>
    	                                        <?php echo $entry_password_confirm ?>:
    	                                    </td>
    	                                    <td class="simplecheckout-customer-right">
    	                                        <input type="password" name="password_confirm" value="<?php echo $password_confirm ?>">
    	                                        <?php if ($error_password_confirm && $simple_create_account) { ?>
    	                                            <span class="simplecheckout-error-text"><?php echo $error_password_confirm; ?></span>
    	                                        <?php } ?>
    	                                    </td>
    	                                </tr>
    	                                <?php } ?>
    	                            <?php } ?>
    	                        <?php } ?>
    	                        <?php if ($simple_registration_subscribe == 2) { ?>
    	                            <tr>
    	                              <td class="simplecheckout-customer-left">

    	                              </td>
    	                              <td class="simplecheckout-customer-right">
    	                              <label><input type="checkbox" name="subscribe" value="0" <?php if ($subscribe) { ?><?php } ?> /></label>

    	                                <span><?php echo $entry_newsletter; ?></span></td>
    	                            </tr>
    	                        <?php } ?>

    	                         <tr class="form-group_radio" style="margin-bottom: 30px;">
    	                            <td style="text-align: center;">
    	                            </td>
    	                            <td>
    	                              <input value="Male" id="radioOne" name="custom_gender" checked="" type="radio" style="display: none;">
                                      <label for="radioOne" class="radio input_label" checked="checked" style="margin-left: 0;margin-bottom: 20px;margin-top: 10px;letter-spacing: 1px;width: 48%;text-align: left; color: #fff;">Мужчина</label>
                                      <input value="Female" id="radioTwo" name="custom_gender" type="radio" style="display: none;">
                                      <label for="radioTwo" class="radio input_label" style="margin-left: 20px;margin-bottom: 20px;margin-top: 10px;letter-spacing: 1px;width: 42%;text-align: right; color: #fff;">Женщина</label>
    	                            </td>
    	                        </tr>
    	                            <tr style="margin-bottom: 30px;">
    	                                <td class="simplecheckout-customer-left"></td>
    	                                <td class="simplecheckout-customer-right text-center">
    	                                    <?php if ($simple_registration_agreement_checkbox) { ?><label><input type="checkbox" name="agree" value="1" <?php if ($agree == 1) { ?>checked="checked"<?php } ?> /><?php echo $text_agree; ?></label>&nbsp;<?php } ?>
    	                                        <div class="text-center wrapp_btn-present"><a onclick="$('#simple_create_account').val(1);$('#simpleregister').submit();" class="default btn">
    	                                            <span>Получить подарок</span>
    	                                        </a></div>
    	                                </td>
    	                            </tr>

    	                        <?php if ($simple_registration_captcha) { ?>
    	                            <tr>
    	                                <td class="simplecheckout-customer-left">
    	                                    <span class="simplecheckout-required">*</span>
    	                                    <?php echo $entry_captcha ?>:
    	                                </td>
    	                                <td class="simplecheckout-customer-right">
    	                                    <input type="text" name="captcha" value="" />
    	                                    <?php if ($error_captcha && $simple_create_account) { ?>
    	                                        <span class="simplecheckout-error-text"><?php echo $error_captcha; ?></span>
    	                                    <?php } ?>
    	                                </td>
    	                            </tr>
    	                            <tr>
    	                                  <td class="simplecheckout-customer-left"></td>
    	                                  <td class="simplecheckout-customer-right"><img src="index.php?<?php echo $simple->tpl_joomla_route() ?>route=product/product/captcha" alt="" id="captcha" /></td>
    	                            </tr>

    	                        <?php } ?>
    	                    </table>
    	                    <?php foreach ($customer_fields as $field) { ?>
    	                        <?php if ($field['type'] != 'hidden') { continue; } ?>
    	                        <?php echo $simple->html_field($field) ?>
    	                    <?php } ?>
    	                    <input type="hidden" name="simple_create_account" id="simple_create_account" value="">
    	                </div>
    	            </div>
    	        </form>
            </div>
		</div>
	</div>
  </div>
</section>

  <?php echo $content_bottom; ?>

</div><!--End pesaha block-->
<?php include $simple->tpl_footer() ?>
<style>
	.block-wrapp_action {
		background: url("catalog/view/theme/pav_digitalstore/img/img_blog_lotto/register_bacround_17.05.17.jpg") no-repeat;
		background-size: cover;
		background-position: center center;
		padding-bottom: 100px;
	}
	.block-wrapp_action--content {
		max-width:1200px;
		margin:0 auto;
	}
	.block-wrapp_action--top-content {
		text-align: center;
		margin:60px 0 90px;
	}
	.block-wrapp_action--right-content {
		margin: 0;
	}
	.form-group_radio label.radio::after {
		opacity: 0;
		content: '';
		position: absolute;
		width: 12px;
		height: 9px;
		background: transparent;
		top: 3.5px;
		left: 5px;
		border: 3px solid #a51319;
		border-top: none;
		border-right: none;

		-webkit-transform: rotate(-45deg);
		-moz-transform: rotate(-45deg);
		-o-transform: rotate(-45deg);
		-ms-transform: rotate(-45deg);
		transform: rotate(-45deg);
	}
	.wrapp_btn-present span {
		color: #fe2c39;
		font-weight:bold;
	}
	td.simplecheckout-customer-left {
		color: #fff;
	}
	.wrapp_btn-present {
		background: #fff;
		box-shadow: 0px 0px 10px 10px rgba(232,26,37,0.90), 0 1px 2px rgba(232,26,37,0.40);
	}
	.wrapp_btn-present:hover {
		background: #fff;
		text-decoration: none;
		box-shadow:none;
	}
	.wrapp_btn-present:hover span {
		color: #fe2c39;
	}

	.simplecheckout-customer-left input[placeholder] {color:#fff;}
	.simplecheckout-customer-left input[placeholder]::-webkit-input-placeholder {color:#fff;}
	.simplecheckout-customer-left input[placeholder]::-moz-placeholder          {color:#fff;}
	.simplecheckout-customer-left input[placeholder]:-moz-placeholder           {color:#fff;}
	.simplecheckout-customer-left input[placeholder]:-ms-input-placeholder      {color:#fff;}
	.simplecheckout-customer-right input[placeholder] {color:#fff;}
	.simplecheckout-customer-right input[placeholder]::-webkit-input-placeholder {color:#fff;}
	.simplecheckout-customer-right input[placeholder]::-moz-placeholder          {color:#fff;}
	.simplecheckout-customer-right input[placeholder]:-moz-placeholder           {color:#fff;}
	.simplecheckout-customer-right input[placeholder]:-ms-input-placeholder      {color:#fff;}


	.form-group_radio input[type=radio]:checked + label:after {
		opacity: 1;
	}
	.form-group_radio input[type=radio]:checked + label.radio:before {
		background-color: #fff;
	}
    .simplecheckout-customer input[type="text"],
	.simplecheckout-customer input[type="password"],
	.simplecheckout-customer select {
		max-width: 300px;
		height: 40px;
		color: #000;
		outline: none;
		border: 1px solid #d5d5d5;
		padding-left: 10px;
		margin: 4px 0;
		z-index: 1;
	}
	.wrapp_btn-present a:active {
		box-shadow: none;
	}
	span.simplecheckout-error-text {
		color: #fff;
	}

@media screen and (max-width:1220px) {

	.block-wrapp_action--left-content {
		width: 58%;
		margin-left: 5%;
	}

}
@media screen and (max-width:992px) {

	.block-wrapp_action--left-content {
		width: 50%;
		margin-left: 10px;
		text-align: center;
		display: block;
	}

}
@media screen and (max-width:860px) {

	.block-wrapp_action--top-content {
		text-align: center;
		margin: 30px 0;
	}
	.block-wrapp_action--left-content {
		width: 100%;
		padding:0 10px;
		margin: 0 0 20px;
		text-align: center;
	}
	.block-wrapp_action--right-content {
		margin: 0 auto;
	}

}
@media screen and (max-width: 725px){

    .pesaha-block-wrapp {
        min-height: 700px;
    }
    .already-registered {
        padding-top: 15px!important;
    }
    .form-group_radio label.radio::before {
        top: 5px;
    }
    .form-group_radio label.radio::after {
        top: 10.5px;
    }

}

</style> 