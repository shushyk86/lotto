<?php
	/******************************************************
	 * @package Pav Megamenu module for Opencart 1.5.x
	 * @version 1.1
	 * @author http://www.pavothemes.com
	 * @copyright	Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
	 * @license		GNU General Public License version 2
	*******************************************************/

	require_once( DIR_TEMPLATE.$this->config->get('config_template')."/development/libs/framework.php" );
	$themeConfig = $this->config->get('themecontrol');
	$themeName =  $this->config->get('config_template');
	$helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
	$LANGUAGE_ID = $this->config->get( 'config_language_id' );
?>
<div id="fon" style="opacity:0.8; position:fixed; width:100%; height:100%; z-index:9999; background-color:#fff; display:none; top:0px; left:0px;">  </div>
<?php
if(isset($_GET['task']) && $_GET['task'] == 1){
	echo'
	<script>
	$(document).ready( function (){
	    show_dialog();
	    startTimer();
	});
	</script>

	<div class="modal-dialog1">
		<div class="modal-content clearfix">
			<div class="modal-body clearfix" style="padding:0;">
				<div class="modal-header" style="float: right; margin: 5px;padding: 0; cursor: pointer;width: 15px;height: 15px;">
					<a id="modal_close_magik" class="close">&times;</a>
				</div>
				<div class="modal_left-block-image" ><img src="/image/prizent.jpg" style="width: 100%;height: 100%;"></div>
				<form class="form_modal">
					<div style="font-size: 25px; color:#333333; text-align: center; margin: 10px 0 25px 0; line-height: 30px;"><span style="font-size: 35px; line-height: 50px;">Спасибо!</span><br>Чтобы забрать свой подарок,<br>зайдите на почту и подтвердите свой е-маil! :)</div>
					<a id="close_timer" onclick="closing2();">Закрыть (<span id="my_timer">10</span>)</a>
				</form>
			</div>

		</div>
	</div>
';
} elseif(isset($_GET['task']) && $_GET['task'] == 2) {
	echo'
	<script>
	$(document).ready( function (){
	    show_dialog();
	    startTimer();
	});
	</script>

	<div class="modal-dialog1">
		<div class="modal-content clearfix">
			<div class="modal-body clearfix" style="padding:0;">
				<div class="modal-header" style="float: right; margin: 5px;padding: 0; cursor: pointer;width: 15px;height: 15px;">
					<a id="modal_close_magik" class="close">&times;</a>
				</div>
				<div class="modal_left-block-image" ><img src="/image/prizent.jpg" style="width: 100%;height: 100%;"></div>
				<form class="form_modal">
					<div style="font-size: 25px; color:#333333; text-align: center; margin: 15px 0 45px 0; line-height: 30px;"><span style="font-size: 35px; line-height: 50px;">Поздравляем!</span><br>Ожидайте Ваш подарок<br>на почте!</div>
					<a id="close_timer" onclick="closing2();">Закрыть (<span id="my_timer">10</span>)</a>
				</form>
			</div>

		</div>
	</div>
';
}
?>


</div></div></section>
<?php
	/**
	 * Footer Top Position
	 * $ospans allow overrides width of columns base on thiers indexs. format array( 1=> 3 )[value from 1->12]
	 */
	$modules = $helper->getModulesByPosition( 'mass_bottom' );
	$ospans = array( );
	$cols   = 1;
	if( count($modules) ) {
?>
<section id="pav-mass-bottom">
	<div class="container">
		<?php $j=1;foreach ($modules as $i =>  $module) {   ?>
			<?php if( $i++%$cols == 0 || count($modules)==1 ){  $j=1;?><div class="row"><?php } ?>
			<div class="col-lg-<?php echo floor(12/$cols);?> col-md-<?php echo floor(12/$cols);?> col-sm-12 col-xs-12"><?php echo $module; ?></div>
			<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>
		<?php  $j++;  } ?>
	</div>
</section>
<?php } ?>

<!-- распродажа -->
<?php if($_SERVER['REQUEST_URI'] != '/checkout' && !preg_match('#register#', $_SERVER['REQUEST_URI']) && $_SERVER['REQUEST_URI'] != '/index.php?route=account/success' && !$this->customer->isLogged()) { ?>
	<a href="/register">
		<div id="rasprodaza" class="block-sale clearfix">
			<div class="pesaha-block-wrapp">
				<div class="pesaha-block-wrapp--left">
					<img src="catalog/view/theme/pav_digitalstore/img/img_blog_lotto/footer_text_17.05.17.png" alt="">
				</div>
				<div class="pesaha-block-wrapp--right">
					<img src="catalog/view/theme/pav_digitalstore/img/img_blog_lotto/footer_info_foto_17.05.17.png" alt="">
				</div>
			</div>
		</div>
	</a>
<?php } ?>
<!-- END распродажа -->

<section id="footer">
	<?php
	/**
	 * Footer Top Position
	 * $ospans allow overrides width of columns base on thiers indexs. format array( 1=> 3 )[value from 1->12]
	 */
	$modules = $helper->getModulesByPosition( 'footer_top' );
	$ospans = array();

	if( count($modules) ){
	$cols = isset($themeConfig['block_footer_top'])&& $themeConfig['block_footer_top']?(int)$themeConfig['block_footer_top']:count($modules);
	//if( $cols < count($modules) ){ $cols = count($modules); }
	$class = $helper->calculateSpans( $ospans, $cols );
	?>
	<?php } ?>
	<?php
	/**
	 * Footer Center Position
	 * $ospans allow overrides width of columns base on thiers indexs. format array( 1=> 3 )[value from 1->12]
	 */
	$modules = $helper->getModulesByPosition( 'footer_center' );
	$ospans = array();

	if( count($modules) ){
	$cols = isset($themeConfig['block_footer_center'])&& $themeConfig['block_footer_center']?(int)$themeConfig['block_footer_center']:count($modules);
	$class = $helper->calculateSpans( $ospans, $cols );
	?>
	<div class="footer-center">
		<div class="container">
			<div class="container-inner">
				<?php $j=1;foreach ($modules as $i =>  $module) {  ?>
					<?php if( $i++%$cols == 0 || count($modules)==1 ){  $j=1;?><div class="row"><?php } ?>
					<div class="<?php echo $class[$j];?> column clearfix"><?php echo $module; ?></div>
					<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>
				<?php  $j++;  } ?>
			</div>
		</div>
	</div>
	<?php } elseif((isset($themeConfig['enable_footer_center'])&&$themeConfig['enable_footer_center'])) { ?>
	<div class="footer-center">
		<div class="container">
			<div class="container-inner">
			<div class="row">
		  		<?php if( isset($themeConfig['widget_contactus_data'][$LANGUAGE_ID]) ) { ?>
				<div class="column col-xs-12 col-sm-6 col-lg-3 clearfix">
					<div class="box contact-us">
						<div class="box-heading"><span><?php echo $this->language->get('text_contact_us'); ?></span></div>
						<?php echo html_entity_decode( $themeConfig['widget_contactus_data'][$LANGUAGE_ID], ENT_QUOTES, 'UTF-8' ); ?>
					</div>
				</div>
				 <?php } ?>

				<div class="column col-xs-12 col-sm-6 col-lg-2 clearfix">
					<div class="box">
						<div class="box-heading"><span><?php echo $text_service; ?></span></div>
						<ul class="list">
						  <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
						  <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
						  <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
						   <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
						  <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
						</ul>
					</div>
				</div>

				<div class="column col-xs-12 col-sm-6 col-lg-2 clearfix">
					<div class="box">
					<div class="box-heading"><span><?php echo $text_extra; ?></span></div>
					<ul class="list">
					  <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
					  <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
					  <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
					  <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
					</ul>
				  </div>
				</div>

				<div class="column col-xs-12 col-sm-6 col-lg-2 clearfix">
					<div class="box">
						<div class="box-heading"><span><?php echo $text_account; ?></span></div>
						<ul class="list">
						  <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
						  <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
						  <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
						  <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
						  <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
						</ul>
					</div>
				</div>

				<?php if( isset($themeConfig['widget_newsletter_data'][$LANGUAGE_ID]) ) {

				 ?>
				<div class="column col-xs-12 col-sm-6 col-lg-3 clearfix">
					<div class="box newsletter">
						<div class="box-heading"><span><?php echo $this->language->get('Newsletter'); ?></span></div>
						<?php echo html_entity_decode( $themeConfig['widget_newsletter_data'][$LANGUAGE_ID], ENT_QUOTES, 'UTF-8' ); ?>
					</div>
				</div>
				 <?php } ?>
				 </div>
			 </div>
		</div>
	</div>
	<?php  } ?>
	<?php
	/**
	 * Footer Bottom
	 * $ospans allow overrides width of columns base on thiers indexs. format array( 1=> 3 )[value from 1->12]
	 */
	$modules = $helper->getModulesByPosition( 'footer_bottom' );
	$ospans = array();

	if( count($modules) ){
	$cols = isset($themeConfig['block_footer_bottom'])&& $themeConfig['block_footer_bottom']?(int)$themeConfig['block_footer_bottom']:count($modules);
	$class = $helper->calculateSpans( $ospans, $cols );
	?>
	<div class="footer-bottom">
		<div class="container">
		<div class="container-inner">
		<?php $j=1;foreach ($modules as $i =>  $module) {  ?>
				<?php if( $i++%$cols == 0 || count($modules)==1 ){  $j=1;?><div class="row"><?php } ?>
				<div class="<?php echo $class[$j];?>"><?php echo $module; ?></div>
				<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>
		<?php  $j++;  } ?>
		</div>
		 </div>
	</div>
	<?php } ?>

	<div id="powered">
		<div class="container">
			<div class="container-inner">
				<div class="copyright">
					<p>дизайн разработан divotop 2015</p>
				</div>
			</div>
		</div>
	</div>

	<div class="social-fixed hide">
		<a id="fb-fix" target="_blank" href="https://www.facebook.com/Lotto.UA"></a>
		<a id="vk-fix" target="_blank" href="http://vk.com/lottoukraine"></a>
		<a id="yot-fix" target="_blank" href="https://www.youtube.com/channel/UCjmnHlOhS9ME5yB8ghfZ7oQ"></a>
		<a id="ig-fix" target="_blank" href="https://www.instagram.com/lotto.ukraine/"></a>
	</div>
</section>
<a class="button-up"><i class="fa fa-chevron-right fa-2x"></i></a>

<?php if( isset($themeConfig['enable_paneltool']) && $themeConfig['enable_paneltool'] ){  ?>
	<?php  echo $helper->renderAddon( 'panel' );?>
<?php } ?>
</section>


<script type="text/javascript">
	$(document).ready(function() {
		callBackFClose2('#fon');
		callBackFClose2('#modal_close_magik');
	});

	function show_dialog() {
		$('.modal-dialog1').show();
		$('#fon').show();
	}

	function callBackFClose2(btn) {
		$(btn).on('click', function() {
			closing2();
		});
	}

	function closing2(){
		$('.modal-dialog1').hide();
		$('#fon').hide();
	}

	function startTimer() {
		var my_timer = document.getElementById("my_timer");
		var s = my_timer.innerHTML;
		if (s == 0) {
			closing2();
			return;
		}
		else s--;
		document.getElementById("my_timer").innerHTML = s;
		setTimeout(startTimer, 1000);
	}

	function sendForm() {
		$('#warn-text').remove();
		var name = true;
		var email = true;

		if($('.form-body input[name=\'first_name\']').val().length < 2) {
			name = false;
		}
		if($('.form-body input[name=\'email\']').val().match("^[A-Za-z0-9._%+-]+@[A-Za-z0-9-]+\.[A-Za-z]{2,6}$") == null) {
			email = false;
		}

		if(name && email) {
			$('#getresponse-form').submit();
		} else if (!name && !email) {
			$('.wrapp_btn-default').after('<p style="color: red; margin-top: 5px;" id="warn-text">Заполните, пожалуйста, все поля</p>');
		} else if (name && !email) {
			$('.wrapp_btn-default').after('<p style="color: red; margin-top: 5px;" id="warn-text">Поле e-mail заполнено неверно</p>');
		} else if (!name && email) {
			$('.wrapp_btn-default').after('<p style="color: red; margin-top: 5px;" id="warn-text">Имя должно содержать не менее двух символов</p>');
		}

	}

ga('send', 'pageview');
</script>

</body></html>