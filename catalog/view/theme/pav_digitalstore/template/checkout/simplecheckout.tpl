<?php if (!$ajax) { ?>
<?php
$simple_page = 'simplecheckout';
$heading_title .= $simple_show_weight ? '&nbsp;(<span id="weight">'. $weight . '</span>)' : '';
include $simple->tpl_header();
include $simple->tpl_static();
?>
    <script>var flaag = 1; </script>
<div class="simple-content">
    <?php } ?>
    <div class="simplecheckout" id="simplecheckout_form">
        <!-- simplecheckout form -->
        <?php
        $replace = array(
            '{three_column}'  => '<div class="simplecheckout-three-column">',
            '{/three_column}' => '</div>',
            '{left_column}'   => '<div class="simplecheckout-left-column">',
            '{/left_column}'  => '</div>',
            '{right_column}'  => '<div class="simplecheckout-right-column">',
            '{/right_column}' => '</div>',
            '{customer}'      => '<div class="simplecheckout-block'.($simple_customer_hide_if_logged ? ' simplecheckout-skip' : '').'" id="simplecheckout_customer"'.($simple_customer_hide_if_logged ? ' style="display:none;"' : '').'>'. $simplecheckout_customer .'</div>',
            '{cart}'          => '<div class="simplecheckout-block" id="simplecheckout_cart">' . $simplecheckout_cart . '</div>',
            '{shipping}'      => $has_shipping ? '<div class="simplecheckout-block'.($simple_shipping_methods_hide ? ' simplecheckout-skip' : '').'" id="simplecheckout_shipping"'.($simple_shipping_methods_hide ? ' style="display:none;"' : '').'>' . $simplecheckout_shipping . '</div>' : '',
            '{payment}'       => '<div class="simplecheckout-block'.($simple_payment_methods_hide ? ' simplecheckout-skip' : '').'" id="simplecheckout_payment"'.($simple_payment_methods_hide ? ' style="display:none;"' : '').'>' . $simplecheckout_payment . '</div>',
            '{agreement}'     => $simple_common_view_agreement_text ? '<div class="simplecheckout-block" id="simplecheckout_agreement"></div>' : '',
            '{help}'          => $simple_common_view_help_text ? '<div class="simplecheckout-block" id="simplecheckout_help"></div>' : '',
            '{payment_form}'  => '',
        );

        if ($simple_common_view_agreement_text && isset($information_title) && isset($information_text)) {
            $replace['{agreement}'] = '<div class="simplecheckout-block" id="simplecheckout_agreement">';
            $replace['{agreement}'] .= '<div class="simplecheckout-block-heading">' . $information_title . '</div>';
            $replace['{agreement}'] .= '<div class="simplecheckout-block-content simplecheckout-scroll">' . $information_text . '</div>';
            $replace['{agreement}'] .= '</div>';
        }

        if ($simple_common_view_help_text && isset($help_title) && isset($help_text)) {
            $replace['{help}'] = '<div class="simplecheckout-block" id="simplecheckout_help">';
            $replace['{help}'] .= '<div class="simplecheckout-block-heading">' . $help_title . '</div>';
            $replace['{help}'] .= '<div class="simplecheckout-block-content simplecheckout-scroll">' . $help_text . '</div>';
            $replace['{help}'] .= '</div>';
        }

        if ($payment_form) {
            $replace['{payment_form}'] = '<div class="simplecheckout-block" id="simplecheckout_payment_form">';
//          $replace['{payment_form}'] .= '<div class="simplecheckout-block-heading">' . $text_payment_form_title . '</div>';
            $replace['{payment_form}'] .= '<div class="simplecheckout-block-content">' . $payment_form . '</div>';
            $replace['{payment_form}'] .= '</div>';
        }

        $find = array(
            '{three_column}',
            '{/three_column}',
            '{left_column}',
            '{/left_column}',
            '{right_column}',
            '{/right_column}',
            '{customer}',
            '{cart}',
            '{shipping}',
            '{payment}',
            '{agreement}',
            '{help}',
            '{payment_form}'
        );

        if (!empty($modules)) {
            foreach ($modules as $key => $value) {
                $find[] = $key;
                $replace[$key] = $value;
            }
        }

        echo trim(str_replace($find, $replace, $simple_common_template));
        ?>
        <input type="hidden" name="simple_create_order" id="simple_create_order" value="">
        <input type="hidden" name="simple_step" id="simple_step" value="<?php echo $simple_step ?>">
        <input type="hidden" name="simple_step_next" id="simple_step_next" value="">
        <input type="hidden" name="simple_errors" id="simple_errors" value="<?php echo $simple_errors ?>">
        <span style="display:none" id="need_save_changes"><?php echo $text_need_save_changes ?></span>
        <span style="display:none" id="saving_changes"><?php echo $text_saving_changes ?></span>
        <span style="display:none" id="save_changes"><?php echo $button_save_changes ?></span>
        <span style="display:none" id="default_button"><?php echo $button_order; ?></span>
        <span style="display:none" id="payment_form_title"><?php echo $text_payment_form_title; ?></span>
        <span style="display:none" id="text_cart"><?php echo $text_cart; ?></span>
        <span style="display:none" id="button_next"><?php echo $button_next; ?></span>
        <span style="display:none" id="please_confirm"><?php echo $text_please_confirm; ?></span>

        <div style="width:100%;height:1px;clear:both;"></div>

        <div class="simplecheckout-proceed-payment" id="simplecheckout_proceed_payment" style="display:none;"><?php echo $text_proceed_payment ?></div>
        <!-- order button block -->
        <?php if ($error_warning_agree && $simple_show_errors) { ?>
            <div class="simplecheckout-warning-block agree-warning"><?php echo $error_warning_agree ?></div>
        <?php } elseif ($agree_warning) { ?>
            <div class="simplecheckout-warning-block agree-warning" style="display:none"><?php echo $agree_warning ?></div>
        <?php } ?>
        <?php if ($simple_steps) { ?>
            <div class="simplecheckout-button-block buttons" id="step_buttons">
                <div class="under-color">
                    <a class="button btn" onclick="simplecheckout_next();" id="simplecheckout_next"><span><?php echo $button_next; ?></span></a>
                </div>
                <div class="under-color">
                    <a class="button btn" onclick="simplecheckout_prev()" id="simplecheckout_prev"><span><?php echo $button_prev; ?></span></a>
                </div>
            </div>
        <?php } ?>
<!--        <div class="total-block11"></div>   -->
        <div class="simplecheckout-customer-block__wrapp">
            <div class="simplecheckout-button-block buttons" id="buttons" <?php if ($block_order) { ?>style="display:none;"<?php } ?>>
                <div class="pull-right">
                    <?php if ($simple_common_view_agreement_checkbox) { ?><label><input type="checkbox" id="agree" name="agree" value="1" <?php if ($agree == 1) { ?>checked="checked"<?php } ?> /><?php echo $text_agree; ?></label>&nbsp;<?php } ?>
                    <a class="btn__green" onclick="simplecheckout_submit();" id="simplecheckout_button_confirm">
                        <span><?php echo $button_order; ?></span>
                    </a>
                </div>
                <?php if ($simple_show_back) { ?>
                    <div class="">
                        <a class="button btn button_green" onclick="history.go(back_count)"><span><?php echo $button_back; ?></span></a>
                    </div>
                <?php } ?>
        </div>
      </div>
    </div>
    <?php if (!$ajax) { ?>

</div>

<script>
function startCheckoutAnalytics() {
    <?php foreach($prods as $prod) { ?>
    ga('ec:addProduct', {
        'id': '<?php echo $prod['sku']; ?>',
        'name': '<?php echo addslashes($prod['name']); ?>',
        'price': <?php echo (int)$prod['price']; ?>
    });
    <?php } ?>
    ga('ec:setAction', 'checkout', {
        'step': 1
    });
    ga('send', 'event', 'Checkout', 'Start');
}
function sendCheckoutAnalytics() {
    <?php foreach($prods as $prod) { ?>
    ga('ec:addProduct', {
        'id': '<?php echo $prod['sku']; ?>',
        'name': '<?php echo addslashes($prod['name']); ?>',
        'price': <?php echo (int)$prod['price']; ?>
    });
    <?php } ?>
    ga('ec:setAction', 'checkout', {
        'step': 2,
        'option': 'FullCheckout'
    });
    ga('send', 'event', 'Checkout', 'Option');
}
</script>

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
<?php } ?>
<?php /* <script>
 if (flaag == 1) { flaag=0;simplecheckout_reload('shipping_changed'),repl(),updt();}
</script>	*/ ?>