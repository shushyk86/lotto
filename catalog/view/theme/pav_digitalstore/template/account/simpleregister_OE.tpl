<?php 
$simple_page = 'simpleregister';
?>
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>
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
<div class="login-content2">
    <div id="content" class="col-lg-5 col-md-5 col-sm-12 col-xs-12"><?php echo $content_top; ?>
    <div class="simple-content">
        <!-- <p class="simpleregister-have-account"><?php echo $text_account_already; ?></p> -->
        <h2>регистрация</h2>
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="simpleregister">
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
                                        <span class="simplecheckout-error-text" id="$password_error" <?php if (!($password_error)) { ?>style="display:none;"<?php } ?>><?php echo $error_email_confirm; ?></span>
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
                                <!-- <label><input type="radio" name="subscribe" value="0" <?php if (!$subscribe) { ?>checked="checked"<?php } ?> /><?php echo $text_no; ?></label> -->
                                <span><?php echo $entry_newsletter; ?></span></td>
                            </tr>
                        <?php } ?>
                            <tr>
                                <td class="simplecheckout-customer-left"></td>
                                <td class="simplecheckout-customer-right">
                                    <?php if ($simple_registration_agreement_checkbox) { ?><label><input type="checkbox" name="agree" value="1" <?php if ($agree == 1) { ?>checked="checked"<?php } ?> /><?php echo $text_agree; ?></label>&nbsp;<?php } ?>
                                        <a onclick="$('#simple_create_account').val(1);$('#simpleregister').submit();" class="button btn">
                                            <span>создать учетную запись</span>
                                        </a>
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
    <div class="col-lg-7 col-md-7 col-sm-12 col-xs-12" id="info2">

    <div class="inner">

        <h2>создание учетной записи поможет</h2>

        <div class="content">
            <p>делать следующие покупки быстрее (не надо будет снова вводить адрес и контактную информацию), </p>
            <p>первому узнать о приходе новых коллекций, </p>
            <p>видеть заказы, сделанные ранее,</p>
            <p>стать участником еженедельных ЗАКРЫТЫХ распродаж,</p>
            <p>получить дополнительную скидку 5% на распродажу недели.</p>
        </div>

    </div>
</div>
</div>
  <?php echo $content_bottom; ?></div>

<!-- ReTag -->
<script type="text/javascript">
    window._retag_data = {
    };
    window._retag = window._retag || [];
    window._retag.push({code: "9ce88868d8"});
    (function () {
        var id = "admitad-retag";
        if (document.getElementById(id)) {return;}
        var s = document.createElement("script");
        s.async = true; s.id = id;
        var r = (new Date).getDate();
        s.src = (document.location.protocol == "https:" ? "https:" : "http:") + "//cdn.trmit.com/static/js/retag.min.js?r="+r;
        var a = document.getElementsByTagName("script")[0]
        a.parentNode.insertBefore(s, a);
    })()
</script>
<!-- End ReTag -->

<?php include $simple->tpl_footer() ?>
