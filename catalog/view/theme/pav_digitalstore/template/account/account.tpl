<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?>  

<?php if( $SPAN[0] ): ?>
<aside class="col-lg-<?php echo $SPAN[0];?> col-md-<?php echo $SPAN[0];?> col-sm-12 col-xs-12">
	<?php echo $column_left; ?>
	</aside>
<?php endif; ?>

<section class="col-lg-<?php echo $SPAN[1];?> col-md-<?php echo $SPAN[1];?> col-sm-12 col-xs-12 clearfix">
			<?php if ($success) { ?>
		<div class="success"><?php echo $success; ?></div>
		<?php } ?>
			<div id="content" class="col-md-4"><?php echo $content_top; ?>
			  
			  <h1><?php echo $heading_title; ?></h1>
			  <h2><?php echo $text_my_account; ?></h2>
			  <div class="content">
				<ul>
				  <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
				  <li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
				  <li><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>
				  <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
				</ul>
			  </div>
			  <h2><?php echo $text_my_orders; ?></h2>
			  <div class="content">
				<ul>
				  <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
				 <!-- <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>-->
				  <?php if ($reward) { ?>
				  <li><a href="<?php echo $reward; ?>"><?php echo $text_reward; ?></a></li>
				  <?php } ?>
				  <!-- <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
				  <li><a href="<?php echo $recurring; ?>"><?php echo $text_recurring; ?></a></li>-->

				</ul>
			  </div>
<!--
			  <h2><?php echo $text_my_newsletter; ?></h2>
			  <div class="content">
				<ul>
				  <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
				</ul>
			  </div>
-->
			  <?php echo $content_bottom; ?>
			
		</div>  
		 <div class="container_info_bal_foto  col-md-8">
			 <!-- <div class="row">
			 	<img src="catalog/view/theme/pav_digitalstore/img/img_blog_lotto/container_info_bal_foto.jpg" alt="info-foto">
			 </div>	 -->
			 <!------------------------------раскоментировать 24,04,17---------------------------------->
			 <div>
			 	<img src="catalog/view/theme/pav_digitalstore/img/img_blog_lotto/Subscription-lotto-foto_1.jpg" alt="info-foto">
			 </div> 	
		</div> 
</section>
 
	<?php if( $SPAN[2] ): ?>
<aside class="col-lg-<?php echo $SPAN[2];?> col-md-<?php echo $SPAN[2];?> col-sm-12 col-xs-12">	
		<?php echo $column_right; ?>
	</aside>
	<?php endif; ?>
	
<?php echo $footer; ?> 
<style>
@media screen and (max-width: 992px){
	#content {
		min-height: auto;
	}
}	
</style>
