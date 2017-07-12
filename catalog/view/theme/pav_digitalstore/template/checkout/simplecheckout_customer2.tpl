<div class="simplecheckout-block-heading" <?php echo $simple_customer_hide_if_logged ? 'style="display:none"' : '' ?>>
    <!-- <?php echo $text_checkout_customer ?> -->
    <?php if ($simple_customer_view_login) { ?>
    <!-- span class="simplecheckout-block-heading-button">
        <a href="<?php echo $default_login_link ?>" <?php if (!$is_mobile) { ?>onclick="simple_login_open();return false;"<?php } ?> id="simplecheckout_customer_login"><?php echo $text_checkout_customer_login ?></a>
    </span> -->
    <?php } ?>
    <span>данные для быстрого заказа</span>
</div>
<div class="simplecheckout-block-content2">

    <div class="simplecheckout-customer-block">
    <table class="simplecheckout-customer-one-column">
                <tr>
                    <td class="simplecheckout-customer-left">
                       <span>* Ваше имя</span>
                    </td>
                    <td class="simplecheckout-customer-right">
                        <input type="text" id="checkout_customer_main_firstname2" name="checkout_main_firstname" value="" placeholder=" * ИМЯ ">
                        <i class="fa fa-thumbs-o-up" aria-hidden="true" style=" display:none;"></i>
                    </td>
                </tr>

                <tr>
                    <td class="simplecheckout-customer-left">
                        <span>* Ваш телефон</span>
                    </td>
                    <td class="simplecheckout-customer-right">
                        <input type="text" id="checkout_customer_main_telephone2" name="checkout_main_telephone" value="" mask="+38 (999) 999-99-99" placeholder=" * ТЕЛЕФОН ">
                        <i class="fa fa-thumbs-o-up" aria-hidden="true" style=" display:none;"></i>
                    </td>
                </tr>

                <tr>
                    <td class="simplecheckout-customer-left">
                        <span>Ваш емейл</span>
                    </td>
                    <td class="simplecheckout-customer-right">
                        <span>Если хотите получить Ваш заказ на почту, укажите email: </span>
                        <br>
                        <input type="text" id="checkout_customer_main_email2" name="checkout_main_email" value="" placeholder=" * E-MAIL ">
                        <span style="display:none" class="simplecheckout-error-text field_error">Введите корректный емейл!</span>
                    </td>
                </tr>
    </table>
    </div>
</div>

<style>
    
</style>


