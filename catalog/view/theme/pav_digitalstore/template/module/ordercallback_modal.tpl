<div id="spinner-modal" class="uk-modal">
    <div class="uk-modal-dialog">
        <div class="uk-text-center"><img src="./image/spinner.gif" alt=""/></div>
    </div>
</div>
<div id="ordercallback-modal" class="uk-modal">
    <div class="uk-modal-dialog">
        <button type="button" class="uk-modal-close uk-close"></button>
        <div class="uk-modal-header">
            <h2 class="header uk-h2"><?php echo $ordercallback_settings['modal_title'];?></h2>
        </div>
        <form class="uk-form" id="ordercallback-form">
            <fieldset>
                <?php if ($ordercallback_as_order) { ?>
                    <legend><?php echo $heading_title;?></legend>
                    <input name="ordercallback-product" type="hidden" value="<?php echo $heading_title; ?>">
                <?php } ?>
                <?php if ($ordercallback_settings['field_name_show']) { ?>
                    <div class="uk-form-row"><input name="ordercallback-name" type="text"<?php echo ($ordercallback_settings['field_name_required']) ? ' required' : ''; ?> placeholder="<?php echo $modal_field_name; ?>"></div>
                <?php } ?>
                <?php if ($ordercallback_settings['field_phone_show']) { ?>
                    <div class="uk-form-row"><input name="ordercallback-phone" type="text"<?php echo ($ordercallback_settings['field_phone_required']) ? ' required' : ''; ?> placeholder="<?php echo $modal_field_phone; ?>"></div>
                <?php } ?>
                <?php if ($ordercallback_settings['field_email_show']) { ?>
                    <div class="uk-form-row"><input name="ordercallback-email" type="email"<?php echo ($ordercallback_settings['field_email_required']) ? ' required' : ''; ?> placeholder="<?php echo $modal_field_email; ?>"></div>
                <?php } ?>
                <?php if ($ordercallback_settings['field_comment_show']) { ?>
                    <div class="uk-form-row"><textarea name="ordercallback-comment"<?php echo ($ordercallback_settings['field_comment_required']) ? ' required' : ''; ?> cols="" rows="3" placeholder="<?php echo $modal_field_comment; ?>"></textarea></div>
                <?php } ?>
            </fieldset>
        </form>
        <div class="uk-modal-footer uk-text-right">
            <span class="copyright"><a href="http://instup.com" target="_blank">Instup.com</a></span>
            <button type="button" class="uk-button uk-modal-close"><?php echo $button_cancel ?></button>
            <button id="ordercallback-button-send" type="button" class="uk-button uk-button-primary"><?php echo $button_send ?></button>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $('input[name="ordercallback-phone"]').mask("<?php echo isset($ordercallback_settings['field_phone_mask']) ? $ordercallback_settings['field_phone_mask'] : '(999)-999-9999';?>");

        $('#ordercallback-button-send').bind('click', function () {

            var validator = $('#ordercallback-form').validate({
                errorClass: 'uk-form-danger',
                messages: {
                    "ordercallback-name": '',
                    "ordercallback-phone": '',
                    "ordercallback-email": '',
                    "ordercallback-comment": ''
                }
            });
            if (!validator.form()) {
                return false;
            }

            var modal = UIkit.modal("#ordercallback-modal");
            if (modal.isActive()) {
                modal.hide();
            }

            modal = UIkit.modal("#spinner-modal");
            modal.options.bgclose = false;
            modal.show();

            $.ajax({
                url: 'index.php?route=module/ordercallback',
                type: 'post',
                data: $('input[name="ordercallback-name"], input[name="ordercallback-phone"], input[name="ordercallback-email"], input[name="ordercallback-product"], textarea[name="ordercallback-comment"]'),
                dataType: 'json',
                success: function(json) {
                    modal.hide();
                    $('.success, .warning, .attention, .information, .error').remove();

                    if (json['error']) {
                        $('#notification').html('<div class="warning" style="display: none;">' + json['error'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                        $('.warning').fadeIn('slow');
                    }

                    if (json['success']) {
                        $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                        $('.success').fadeIn('slow');
                    }

                    $('html, body').animate({scrollTop: 0}, 'slow');
                },
                error: function (error) {
                    modal.hide();
                    console.log(error);
                    $('.success, .warning, .attention, .information, .error').remove();
                    $('#notification').html('<div class="warning" style="display: none;"><?php echo $message_system_error;?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                    $('.warning').fadeIn('slow');
                }
            });
        });
    });
</script>