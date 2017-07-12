<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>

<?php if( $SPAN[0] ): ?>
<aside class="col-lg-<?php echo $SPAN[0];?> col-sm-<?php echo $SPAN[0];?> col-xs-12">
	<?php echo $column_left; ?>
</aside>
<?php endif; ?>

<section class="col-lg-<?php echo $SPAN[1];?> col-sm-<?php echo $SPAN[1];?> col-xs-12">
    <?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?>
    <div id="content">
        <?php echo $content_top; ?>
        <!-- <h1><?php echo $heading_title; ?></h1>     -->
        <div class="wrapp-confirmation-of-registration" style="padding: 10px;">
        <!-- <?php echo $text_message; ?> -->
        	<div class="wrapp-confirmation-of-registration_foto">
        		<img src="/catalog/view/theme/pav_digitalstore/img/img_blog_lotto/wrapp-confirmation-of-registration_foto.jpg" alt="">
        	</div>
        	
        	<div class="buttons">
	            <div class="center">
	            	<a href="/instruktsyja-bonusnye-grivny" class="button"><?php echo $button_continue; ?></a>
	            </div>
	        </div>
        </div>
        
        <?php echo $content_bottom; ?>
    </div>
</section>

<?php if( $SPAN[2] ): ?>
<aside class="col-lg-<?php echo $SPAN[2];?> col-sm-<?php echo $SPAN[2];?> col-xs-12">	
	<?php echo $column_right; ?>
</aside>
<?php endif; ?>

<?php echo $footer; ?>
