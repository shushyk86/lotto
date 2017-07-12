<div class="simplecheckout-customer-block__wrapp" style="padding-left: 0;"><span class="simplecheckout-customer-block__wrapp--title">Выберите способ оплаты</span></div>
<?php if ($simple_show_errors && $error_warning) { ?>
    <div class="simplecheckout-warning-block"><?php echo $error_warning ?></div>
<?php } ?>  
<div class="simplecheckout-block-content">
    <div class="simplecheckout-customer-block__wrapp">
        <?php if (!empty($disabled_methods)) { ?>
            <div class="simplecheckout-methods-table" style="margin-bottom:0px;">
                <?php foreach ($disabled_methods as $key => $value) { ?>
                    <div class="column__left">
                        <span class="code">
                            <input type="radio" name="disabled_payment_method" disabled="disabled" value="<?php echo $key; ?>" id="<?php echo $key; ?>" />
                        </span>
                        <span class="title">
                            <label for="<?php echo $key; ?>">
                                <?php echo $value['title']; ?>
                            </label>
                        </span>
                        <span class="quote">
                        </span>
                    </div>
                    <?php if (!empty($value['description'])) { ?>
                        <div  class="column__right">
                            <span class="code">
                            </span>
                            <span class="title">
                                <label for="<?php echo $key; ?>"><?php echo $value['description']; ?></label>
                            </span>
                            <span class="quote">
                            </span>
                        </div>
                    <?php } ?>
                <?php } ?>
            </div>
        <?php } ?>

        <?php if (!empty($payment_methods)) { ?>
            <div class="simplecheckout-methods-table">
                <?php foreach ($payment_methods as $payment_method) { ?>
                    <div  class="column__left">
                        <span class="code">
                            <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" <?php if ($payment_method['code'] == $code) { ?>checked="checked"<?php } ?> onchange="simplecheckout_reload('payment_changed'), repl()" />
                        </span>
                        <span class="title">
                            <label for="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></label>
                        </span>
    <!--
                        <td class="quote"><label for="<?php // echo $payment_method['code']; ?>"><?php
                        // if (($payment_method['code']=='cod')&& ($sub_total>500)) {$quote[$payment_method['code']]['sum'] = ' 0 грн.'; }
                        // echo $quote[$payment_method['code']]['sum']?$quote[$payment_method['code']]['sum'] : ' 0 грн.'; ?></label>
                        </td>
    -->
                    </div>
                    <?php if (!empty($payment_method['description'])) { ?>
                        <div class="column__right">
                            <span class="code">
                            </span>
                            <span class="title">
                                <label for="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['description']; ?></label>
                            </span>
                            <span class="quote"><label for="<?php echo $payment_method['code']; ?>"><?php
                            if (($payment_method['code']=='cod')&& ($sub_total>500)) {$quote[$payment_method['code']]['sum'] = ' 0 грн.'; }
                            echo $quote[$payment_method['code']]['sum']?$quote[$payment_method['code']]['sum']:' 0 грн.'; ?></label>
                            </span>
                        </div>
                    <?php } ?>
                <?php } ?>
            </div>
            <input type="hidden" name="payment_method_current" value="<?php echo $code ?>" />
            <input type="hidden" name="payment_method_checked" value="<?php echo $checked_code ?>" />
        <?php } ?>
        <?php if (empty($payment_methods) && $address_empty && $simple_payment_view_address_empty) { ?>
            <div class="simplecheckout-warning-text"><?php echo $text_payment_address; ?></div>
        <?php } ?>
        <?php if (empty($payment_methods) && !$address_empty) { ?>
            <div class="simplecheckout-warning-text"><?php echo $error_no_payment; ?></div>
        <?php } ?>
    </div>
</div>
<?php /* <div class="total-block11"></div> */ ?>
<?php if ($simple_debug) print_r($address); ?>
<?php /* var_dump($quote);   var_dump($total_sum); var_dump($results); var_dump($sub_total); */ ?>
