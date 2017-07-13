<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" );

  $themeConfig = $this->config->get('themecontrol');
  $productConfig = array(
      'product_enablezoom'         => 1,
      'product_zoommode'           => 'basic',
      'product_zoomeasing'         => 1,
      'product_zoomlensshape'      => "round",
      'product_zoomlenssize'       => "150",
      'product_zoomgallery'        => 0,
      'enable_product_customtab'   => 0,
      'product_customtab_name'     => '',
      'product_customtab_content'  => '',
      'product_related_column'     => 0,
  );
  $languageID = $this->config->get('config_language_id');
  $productConfig = array_merge( $productConfig, $themeConfig ); 
?>
<?php echo $header; ?>
<?php if( $special )  { $s_pieces = explode(' ', $special); } ?>
<?php $p_pieces = explode(' ', $price); ?>
<?php if( $special )  {
		$actual_price = $s_pieces[0];
	  } else {
		$actual_price = $p_pieces[0]; 
} ?>

<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?>  
<?php if( $SPAN[0] ): ?>
	<aside class="col-lg-<?php echo $SPAN[0];?> col-md-<?php echo $SPAN[0];?> col-sm-12 col-xs-12">
		<?php echo $column_left; ?>
	</aside>	
<?php endif; ?>  
<section class="col-lg-<?php echo $SPAN[1];?> col-md-<?php echo $SPAN[1];?> col-sm-12 col-xs-12">
<p class="back-mini"><span onClick="window.history.back();">Вернуться назад</span></p>
<div id="content"><?php echo $content_top; ?>
  
 
  <div class="product-info">
	<div class="row">
    <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12" id="left-dct">
    
        <?php if ($thumb || $images) { ?>
    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 image-container">
        <?php if ($thumb) { ?>
        <div class="image">
		
        <?php if($discount) { ?>
				<div class="product-label-special label"><?php echo $discount; ?></div>
		<?php } ?>

		<?php if ($new_collection) { ?>
			<div class="product-label-new label"><?php echo $this->language->get( 'text_label_new' ); ?></div>
		<?php } ?>

		<?php if ($freeshipping) { ?>
			<div class="product-label-special-shipping label">
          
          <svg version="1.1" id="Слой_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
   viewBox="0 0 162.5 30" style="enable-background:new 0 0 162.5 30;" xml:space="preserve">
<style type="text/css">
  .st0{opacity:0.6;enable-background:new    ;}
  .st1{opacity:0.8;}
  .st2{fill:#010002;}
  .st3{fill:#FFFFFF;}
</style>
<title>Delivery</title>
<rect class="st0" width="162.5" height="30"/>
<g class="st1">
  <path class="st2" d="M150.7,14.3L148,6.1v-2h-8.5v18.2h-1.8V3.1H7v18.7v0.5v1.6l3.9,1h4.7c0-0.9,0.3-1.8,0.7-2.6h0
    c0.9-1.5,2.5-2.5,4.4-2.5c1.9,0,3.5,1,4.3,2.5h0c0.4,0.8,0.7,1.6,0.7,2.6h115.4c0-2.8,2.3-5.1,5.1-5.1c2,0,3.7,1.1,4.5,2.8
    c0.3,0.6,0.5,1.3,0.5,2c0,0.1,0,0.2,0,0.4h4.1v-8.5L150.7,14.3z M141.9,14.3V8.2h4.8l2,6.1H141.9z"/>
  <path class="st2" d="M146.3,21.1c-2.1,0-3.7,1.7-3.7,3.7c0,2.1,1.7,3.7,3.7,3.7c2.1,0,3.7-1.7,3.7-3.7
    C150.1,22.8,148.4,21.1,146.3,21.1z M146.3,26.9c-1.1,0-2-0.9-2-2c0-1.1,0.9-2,2-2c1.1,0,2,0.9,2,2C148.4,26,147.4,26.9,146.3,26.9
    z"/>
  <path class="st2" d="M20.7,21.1c-2.1,0-3.7,1.7-3.7,3.7c0,2.1,1.7,3.7,3.7,3.7c2.1,0,3.7-1.7,3.7-3.7
    C24.4,22.8,22.8,21.1,20.7,21.1z M20.7,26.9c-1.1,0-2.1-0.9-2.1-2c0-1.1,0.9-2,2.1-2c1.1,0,2,0.9,2,2C22.7,26,21.8,26.9,20.7,26.9z
    "/>
</g>
<g>
  <path class="st3" d="M18.9,14.4c0,0.9-0.2,1.6-0.7,2.1c-0.5,0.5-1.1,0.7-2,0.7H14V8.4h4.2v1.4h-2.5v2h0.5c0.9,0,1.6,0.2,2,0.6
    C18.7,12.9,18.9,13.5,18.9,14.4z M15.7,15.8h0.5c0.7,0,1.1-0.4,1.1-1.3c0-0.4-0.1-0.7-0.3-0.9c-0.2-0.2-0.5-0.3-0.9-0.3h-0.4V15.8z
    "/>
  <path class="st3" d="M24,17.2h-4V8.4h4v1.4h-2.3v2.1h2.2v1.4h-2.2v2.4H24V17.2z"/>
  <path class="st3" d="M28.2,9.7c-0.5,0-0.8,0.3-1.1,0.8c-0.3,0.6-0.4,1.3-0.4,2.3c0,2,0.5,3.1,1.6,3.1c0.5,0,1-0.1,1.5-0.4v1.5
    c-0.4,0.3-1,0.4-1.7,0.4c-1,0-1.8-0.4-2.3-1.2c-0.5-0.8-0.8-1.9-0.8-3.3s0.3-2.5,0.8-3.3s1.3-1.2,2.3-1.2c0.3,0,0.6,0,0.9,0.1
    c0.3,0.1,0.6,0.2,1,0.5l-0.5,1.3c-0.2-0.1-0.4-0.2-0.6-0.3C28.7,9.7,28.5,9.7,28.2,9.7z"/>
  <path class="st3" d="M36.5,17.2h-1.6V9.8h-2.2v7.4H31V8.4h5.4V17.2z"/>
  <path class="st3" d="M43.5,17.2h-1.6V9.8h-1.3c-0.2,2-0.4,3.7-0.5,5c-0.1,0.8-0.3,1.5-0.7,1.9s-0.7,0.6-1.3,0.6
    c-0.3,0-0.6,0-0.8-0.1v-1.4c0.1,0,0.3,0.1,0.4,0.1c0.2,0,0.4-0.2,0.5-0.5s0.3-1.1,0.4-2.4s0.3-2.8,0.5-4.6h4.4V17.2z"/>
  <path class="st3" d="M49.2,17.2L48.7,15h-2.3l-0.5,2.2h-1.6l2.2-8.9h2.2l2.2,8.9H49.2z M48.4,13.5l-0.5-2.1c0-0.1-0.1-0.4-0.2-0.9
    c-0.1-0.5-0.2-0.8-0.2-1c-0.1,0.3-0.1,0.7-0.2,1.1c-0.1,0.4-0.3,1.4-0.6,2.9H48.4z"/>
  <path class="st3" d="M53.7,17.2h-1.6V9.8h-1.7V8.4h5v1.4h-1.7V17.2z"/>
  <path class="st3" d="M61.8,17.2h-1.6v-3.9H58v3.9h-1.6V8.4H58v3.5h2.2V8.4h1.6V17.2z"/>
  <path class="st3" d="M67.5,17.2L67,15h-2.3l-0.5,2.2h-1.6l2.2-8.9H67l2.2,8.9H67.5z M66.7,13.5l-0.5-2.1c0-0.1-0.1-0.4-0.2-0.9
    c-0.1-0.5-0.2-0.8-0.2-1c-0.1,0.3-0.1,0.7-0.2,1.1s-0.3,1.4-0.6,2.9H66.7z"/>
  <path class="st3" d="M72.7,13.7l-1.4,3.4h-1.8l1.7-3.9c-0.4-0.2-0.7-0.5-0.9-0.9c-0.2-0.4-0.3-0.8-0.3-1.3c0-1.8,0.9-2.7,2.7-2.7
    H75v8.8h-1.6v-3.4H72.7z M73.3,9.8h-0.4c-0.4,0-0.6,0.1-0.8,0.3c-0.2,0.2-0.3,0.5-0.3,1c0,0.4,0.1,0.8,0.2,1
    c0.2,0.2,0.4,0.3,0.8,0.3h0.4V9.8z"/>
  <path class="st3" d="M86,19.7h-1.6v-2.5h-4v2.5h-1.6v-4h0.5c0.8-2.2,1.4-4.7,1.6-7.4h4v7.4h1V19.7z M83.3,15.7V9.8h-1
    c-0.1,1-0.3,2-0.5,3c-0.2,1.1-0.5,2-0.8,2.9H83.3z"/>
  <path class="st3" d="M93,12.8c0,1.5-0.3,2.6-0.8,3.4c-0.5,0.8-1.3,1.2-2.3,1.2c-1,0-1.8-0.4-2.4-1.2c-0.5-0.8-0.8-1.9-0.8-3.4
    c0-1.5,0.3-2.6,0.8-3.4c0.5-0.8,1.3-1.2,2.4-1.2c1,0,1.8,0.4,2.3,1.2C92.8,10.2,93,11.3,93,12.8z M88.4,12.8c0,1,0.1,1.8,0.4,2.3
    c0.3,0.5,0.6,0.8,1.1,0.8c1,0,1.5-1,1.5-3.1s-0.5-3.1-1.5-3.1c-0.5,0-0.9,0.3-1.1,0.8C88.5,11,88.4,11.7,88.4,12.8z"/>
  <path class="st3" d="M97.2,9.7c-0.5,0-0.8,0.3-1.1,0.8c-0.3,0.6-0.4,1.3-0.4,2.3c0,2,0.5,3.1,1.6,3.1c0.5,0,1-0.1,1.5-0.4v1.5
    c-0.4,0.3-1,0.4-1.7,0.4c-1,0-1.8-0.4-2.3-1.2c-0.5-0.8-0.8-1.9-0.8-3.3s0.3-2.5,0.8-3.3s1.3-1.2,2.3-1.2c0.3,0,0.6,0,0.9,0.1
    c0.3,0.1,0.6,0.2,1,0.5l-0.5,1.3c-0.2-0.1-0.4-0.2-0.6-0.3C97.7,9.7,97.5,9.7,97.2,9.7z"/>
  <path class="st3" d="M103.1,17.2h-1.6V9.8h-1.7V8.4h5v1.4h-1.7V17.2z"/>
  <path class="st3" d="M109.3,17.2l-0.5-2.2h-2.3l-0.5,2.2h-1.6l2.2-8.9h2.2l2.2,8.9H109.3z M108.5,13.5l-0.5-2.1
    c0-0.1-0.1-0.4-0.2-0.9c-0.1-0.5-0.2-0.8-0.2-1c-0.1,0.3-0.1,0.7-0.2,1.1s-0.3,1.4-0.6,2.9H108.5z"/>
  <path class="st3" d="M111.7,8.4h2.3c0.9,0,1.6,0.2,2,0.5c0.4,0.4,0.6,0.9,0.6,1.7c0,0.5-0.1,0.9-0.3,1.3s-0.5,0.6-0.9,0.6v0.1
    c0.5,0.1,0.9,0.4,1.1,0.7s0.3,0.8,0.3,1.4c0,0.8-0.2,1.4-0.6,1.9c-0.4,0.5-1,0.7-1.8,0.7h-2.7V8.4z M113.3,11.9h0.8
    c0.3,0,0.6-0.1,0.7-0.3c0.1-0.2,0.2-0.5,0.2-0.8c0-0.4-0.1-0.6-0.2-0.8c-0.2-0.2-0.4-0.2-0.8-0.2h-0.7V11.9z M113.3,13.3v2.5h0.8
    c0.3,0,0.6-0.1,0.8-0.3s0.3-0.5,0.3-1c0-0.8-0.3-1.2-1-1.2H113.3z"/>
  <path class="st3" d="M123.8,17.2h-1.8l-2.3-4.5v4.5H118V8.4h1.6v4.3l2.3-4.3h1.8l-2.4,4.2L123.8,17.2z"/>
  <path class="st3" d="M129.1,17.2l-0.5-2.2h-2.3l-0.5,2.2h-1.6l2.2-8.9h2.2l2.2,8.9H129.1z M128.3,13.5l-0.5-2.1
    c0-0.1-0.1-0.4-0.2-0.9c-0.1-0.5-0.2-0.8-0.2-1c-0.1,0.3-0.1,0.7-0.2,1.1s-0.3,1.4-0.6,2.9H128.3z"/>
</g>
</svg>

      </div>
		<?php } ?>
		
        <a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="fancybox" rel="group">
        <img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image"  data-zoom-image="<?php echo $popup; ?>" class="product-image-zoom"/></a></div>
        <?php } ?>
        <?php if ($images) { ?>
        <div class="image-additional slide carousel" id="image-additional"><div class="carousel-inner">
        <?php 
        if( $productConfig['product_zoomgallery'] == 'slider' && $thumb ) {  
          $eimages = array( 0=> array( 'popup'=>$popup,'thumb'=> $thumb )  ); 
          $images = array_merge( $eimages, $images );
        }
        $icols = 3; $i= 0;
        foreach ($images as  $image) { ?>
          <?php if( (++$i)%$icols == 1 ) { ?>
          <div class="item">
          <?php } ?>

              <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="fancybox" rel="group" data-image="<?php echo $image['popup']; ?>">
                <img src="<?php echo $image['thumb']; ?>" style="max-width:<?php echo $this->config->get('config_image_additional_width');?>px"  title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
              </a>
            <?php if( $i%$icols == 0 || $i==count($images) ) { ?>
              </div>
          <?php } ?>
        <?php } ?>
      </div>
          <div class="carousel-control left fa fa-angle-left" href="#image-additional" data-slide="prev"></div>
          <div class="carousel-control right fa fa-angle-right" href="#image-additional" data-slide="next"></div>
        </div>
          <script type="text/javascript">
            $('#image-additional .item:first').addClass('active');
            $('#image-additional').carousel({interval:false})
          </script>

        <?php } ?>
     
         </div>
    <?php } ?>
    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
		 <h1><?php echo $heading_title; ?></h1>

		<!--- additional offer timer  -->
		  <?php if($additionaloffer) { ?>
			<div id="temp_timer">
			  <p class="header"><?php echo $additionaloffer['name']; ?></p>
			  <p>До конца акции осталось:</p>
				<div class="clock"></div>
				<script type="text/javascript">
					var clock;

					$(document).ready(function() {

						// Grab the current date
						var currentDate = new Date();

						// Set some date in the future. In this case, it's always Jan 1
						var futureDate  =  new Date(<?php echo $ao_date_end;?>);

						// Calculate the difference in seconds between the future and current date
						var diff = futureDate.getTime() / 1000 - currentDate.getTime() / 1000;

						// Instantiate a coutdown FlipClock
						clock = $('.clock').FlipClock(diff, {
							clockFace: 'DailyCounter',
							countdown: true
						});
					});
				</script>
				<div class="temp_button_wrapper">
				  <a id="offer-info-link" data-toggle="modal" data-target="#offer-info"><button class="smch_call_button">Подробнее...</button></a>
				</div>
			</div>
		  <?php } ?>
		<!--- end additional offer timer  -->
			
      <div class="description">
        <?php if ($manufacturer) { ?>
        <span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br />
        <?php } ?>
        <span><?php echo $text_model; ?></span> <?php echo $sku; ?><br />
<!--
        <?php // if ($reward) { ?>
        <span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br />
        <?php // } ?>
-->
          <span><?php echo $text_stock; ?></span> <span class="style_green_color"><?php echo $stock; ?></span>
      </div>

<!--
      <?php // if ($review_status) { ?>
      <div class="review">
        <div><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');$('html, body').animate({scrollTop: $('#tab-review').offset().top}, 300);"><?php echo $text_write; ?></a></div>
      </div>
      <?php // } ?>
-->
      <?php if ($options) { ?>
      <div class="options">
        <p>Доступные размеры: <a id="size-table-link" data-toggle="modal" data-target="#myModal">таблица размеров</a></p>
        <?php foreach ($options as $option) { ?>
        <?php if ($option['type'] == 'select') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option hide">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <label><?php echo $option['name']; ?>:</label>
          <select class="form-control" name="option[<?php echo $option['product_option_id']; ?>]">
            <option value=""><?php echo $text_select; ?></option>
            <?php foreach ($option['option_value'] as $option_value) { ?>
            <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
            </option>
            <?php } ?>
          </select>
        </div>
        <?php } ?>

        <ul id="sizer-val1">
          </li><?php foreach ($option["option_value"] as $option_value) { ?>
          <li value="<?php echo $option_value["product_option_value_id"]; ?> "><?php echo $option_value["name"]; ?><?php } ?>
          </li>
        </ul>

        <?php if ($option['type'] == 'radio') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <label><?php echo $option['name']; ?>:</label>
          <?php foreach ($option['option_value'] as $option_value) { ?>
          <div class="radio"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
          <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
          </label>
          </div>
          <?php } ?>
        </div>
        <?php } ?>
        <?php if ($option['type'] == 'checkbox') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <label><?php echo $option['name']; ?>:</label>
          <?php foreach ($option['option_value'] as $option_value) { ?>
           <div class="checkbox"><input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
          <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
          </label>
          </div>
          <?php } ?>
        </div>
        <?php } ?>
        <?php if ($option['type'] == 'image') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <label><?php echo $option['name']; ?>:</label>
          <table class="option-image">
            <?php foreach ($option['option_value'] as $option_value) { ?>
            <tr>
              <td style="width: 1px;"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" /></td>
              <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
              <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                  <?php if ($option_value['price']) { ?>
                  (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                  <?php } ?>
                </label></td>
            </tr>
            <?php } ?>
          </table>
        </div>
        <?php } ?>
        <?php if ($option['type'] == 'text') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <label><?php echo $option['name']; ?>:</label>
          <input class="form-control" type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
        </div>
        <?php } ?>
        <?php if ($option['type'] == 'textarea') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <label><?php echo $option['name']; ?>:</label>
          <textarea class="form-control" name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
        </div>
        <?php } ?>
        <?php if ($option['type'] == 'file') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <label><?php echo $option['name']; ?>:</label>
          <input class="btn btn-theme-primary" type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>" class="button">
          <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
        </div>
        <?php } ?>
        <?php if ($option['type'] == 'date') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <label><?php echo $option['name']; ?>:</label>
          <input class="form-control" type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
        </div>
        <?php } ?>
        <?php if ($option['type'] == 'datetime') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <label><?php echo $option['name']; ?>:</label>
          <input class="form-control" type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
        </div>
        <?php } ?>
        <?php if ($option['type'] == 'time') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <label><?php echo $option['name']; ?>:</label>
          <input class="form-control" type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
        </div>
        <?php } ?>
        <?php } ?>
      </div>
      <?php } ?>

        <?php if ($price) { ?>
            <div class="price">
                
                <br />
                <?php if ($tax) { ?>
                    <span class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></span><br />
                <?php } ?>
                <?php if ($discounts) { ?>
                    <div class="discount">
                        <?php foreach ($discounts as $discount) { ?>
                            <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
                        <?php } ?>
                    </div>
                <?php } ?>
            </div>
        <?php } ?>
		    
        <div class="product-extra clearfix">
          <div class="quantity-adder">
          <?php echo $text_qty; ?>
          <input class="form-control" type="text" name="quantity" size="2" value="<?php echo $minimum; ?>" />
            <span class="add-up add-action">+</span> 
            <span class="add-down add-action">-</span>
          </div>
          <?php if($quantity > 0){?>
          <div class="product-action product-block">
          
          <div class="cart">
            <input type="button" value="Добавить в корзину" id="button-cart" class="button button_orange" onclick="select_transform();"/>
            <button onclick="getOCwizardModal_smch('<?php echo $product_id ?>')" class="smch_call_button">Купить в 1 клик</button>
          </div>
          <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
		   <div class="wishlist-compare pull-left">
           <!-- <span>&nbsp;&nbsp;<?php //echo $text_or; ?>&nbsp;&nbsp;</span> 
            <span class="wishlist"><a class="fa fa-heart" onclick="addToWishList('<?php echo $product_id; ?>');" data-placement="top" data-toggle="tooltip" data-original-title="<?php echo $button_wishlist; ?>"><span><?php echo $button_wishlist; ?></span></a></span>
            <span class="compare"><a class="fa fa-retweet" onclick="addToCompare('<?php echo $product_id; ?>');" data-placement="top" data-toggle="tooltip" data-original-title="<?php echo $button_compare; ?>"><span><?php echo $button_compare; ?></span></a></span>-->
        </div>
		
        </div>
        <?php }else{ echo "<p style='color: #E32725;'>Извините, к сожалению этот товар закончился.</p>";}?>
        </div>
        <?php if ($minimum > 1) { ?>
        <div class="minimum"><?php echo $text_minimum; ?></div>
        <?php } ?>
   <?php if ($profiles): ?>
      <div class="option">
          <h2><span class="required">*</span><?php echo $text_payment_profile ?></h2>
          <select class="form-control" name="profile_id">
              <option value=""><?php echo $text_select; ?></option>
              <?php foreach ($profiles as $profile): ?>
              <option value="<?php echo $profile['profile_id'] ?>"><?php echo $profile['name'] ?></option>
              <?php endforeach; ?>
          </select>
          <br />
          <span id="profile-description"></span>
          <br />
      </div>
      <?php endif; ?>

      
  
  <!-- <?php if ($tags) { ?>
  <div class="tags"><b><?php echo $text_tags; ?></b>
    <?php for ($i = 0; $i < count($tags); $i++) { ?>
    <?php if ($i < (count($tags) - 1)) { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
    <?php } else { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
    <?php } ?>
    <?php } ?>
  </div>
  <?php } ?><br/> -->
       <!--  <div class="share clearfix">
          <div class="addthis_default_style"><a class="addthis_button_compact"><?php echo $text_share; ?></a> <a class="addthis_button_email"></a><a class="addthis_button_print"></a> <a class="addthis_button_facebook"></a>  <a class="addthis_button_vk"></a>   <a class="addthis_button_odnoklassniki_ru"></a> <a class="addthis_button_twitter"></a></div>
          <script type="text/javascript" src="//s7.addthis.com/js/250/addthis_widget.js"></script> 
        </div> -->
     

    </div>
    <div class="tabs-group">
  <div id="tabs" class="htabs clearfix">
    <div class="tabs-wrap1">
      <a href="#tab-description"><?php echo $tab_description; ?></a>
      <?php if ($review_status) { ?>
      <a href="#tab-review"><?php echo $tab_review; ?></a>
      <?php } ?>
      <?php if( $productConfig['enable_product_customtab'] && isset($productConfig['product_customtab_name'][$languageID]) ) { ?>
      <!--<a href="#tab-customtab"><?php echo $productConfig['product_customtab_name'][$languageID]; ?></a>
      <?php } ?> 
      <a href="#tab-customtab2"><?php echo $tab_tab2; ?></a> -->
    </div>
  </div>
  <div id="tab-description" class="tab-content">
    <h2>Описание для <?php echo $heading_title; ?></h2>
	<?php echo $description; ?>
	<?php if ($attribute_groups) { ?>
	<table class="attribute">
	  <thead>
        <tr>
          <td colspan="2"><h2>Характеристики для <?php echo $heading_title; ?></h2></td>
        </tr>
      </thead>
      <?php foreach ($attribute_groups as $attribute_group) { ?>
      <tbody>
        <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
        <tr>
          <td><?php echo $attribute['name']; ?></td>
          <td><?php echo $attribute['text']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
      <?php } ?>
    </table>
	<?php } ?>
  </div>
  <?php if ($review_status) { ?>
  <div id="tab-review" class="tab-content">
	<h2>Отзывы о <?php echo $heading_title; ?></h2>
    <div id="review"></div>
    <p id="review-title"><?php echo $text_write; ?></p>
    <div class="form-review">
    <div class="option"><label><?php echo $entry_name; ?></label>
    <input class="form-control" type="text" name="name" value="" />
    </div>
    <div class="option">
    <label><?php echo $entry_review; ?></label>
    <textarea class="form-control" name="text" cols="40" rows="8"></textarea>
    <span style="font-size: 11px;"><?php echo $text_note; ?></span><br />
    </div>

    <div class="option">
    <label><?php echo $entry_rating; ?></label> <span><?php echo $entry_bad; ?></span>&nbsp;
    <input type="radio" name="rating" value="1" />
    &nbsp;
    <input type="radio" name="rating" value="2" />
    &nbsp;
    <input type="radio" name="rating" value="3" />
    &nbsp;
    <input type="radio" name="rating" value="4" />
    &nbsp;
    <input type="radio" name="rating" value="5" />
    &nbsp;<span><?php echo $entry_good; ?></span><br />
    </div>
    <div class=" option form-inline">
   <!-- <label><?php echo $entry_captcha; ?></label> 
    <span class="form-group"><img src="index.php?route=product/product/captcha" alt="" id="captcha" /></span>
    <span class="form-group"><input class="form-control" type="text" name="captcha" value="" /></span>-->
    </div>
      <div><a id="button-review" class="button"><?php echo $button_continue; ?></a></div>
  </div>
  <?php } ?>
  </div>
  </div>
   
      <?php if ($products) { ?>
  <?php 
  $cols = ($productConfig['product_related_column'] == 0)?3:$productConfig['product_related_column'];
  $span = 12/$cols; 
    ?>
  <div class="product-related box">
   <div class="box-heading"><span><?php echo $tab_related; ?> (<?php echo count($products); ?>)</span></div>
   <div id="related" class="slide product-grid" data-interval="0">
    <div class="carousel-controls">
      <a class="carousel-control left fa fa-angle-left" href="#related" data-slide="prev"></a>
      <a class="carousel-control right fa fa-angle-right" href="#related" data-slide="next"></a>
    </div>
    <div class="box-content products-block carousel-inner clearfix ">
        <?php foreach ($products as $i => $product) { $i=$i+1; ?>
        <?php if( $i%$cols == 1 && $cols > 1 ) { ?>
        <div class= "item <?php if($i==1) {?>active<?php } ?>">
        <div class="row products-item">
        <?php } ?>
        <div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-6 col-xs-12">
          <div class="product-block">
          <?php if ($product['thumb']) { ?>
      <div class="image">
        <?php if( $product['special'] ) {   ?>
        <span class="product-label-special label"><?php echo $this->language->get( 'text_salesale' ); ?></span>
        <?php }  else { ?><div class="product-label-new label"><?php echo $this->language->get( 'text_label_new' ); ?></div><?php } ?> 
        <a class="img" href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
        
      </div>
      <?php } ?>
          <div class="product-meta">
        <h3 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
       
        <?php if ($product['price']) { ?>
        <div class="price">
        <?php if (!$product['special']) { ?>
        <?php echo $product['price']; ?>
        <?php } else { ?>
        <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
        <?php } ?>
      </div>
        <?php } ?>
        <?php if ($product['rating']) { ?>
      <div class="rating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
      <?php } ?> 
        <div class="cart pull-left">
          <input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product_id; ?>');" class="button"  />
          <button onclick="getOCwizardModal_smch('<?php echo $product_id ?>');" class="smch_call_button">Купить в один клик</button>
        </div>
      <div class="wishlist-compare">
		<?php /*
        <span class="wishlist"><a class="fa fa-heart" onclick="addToWishList('<?php echo $product['product_id']; ?>');" data-placement="top" data-toggle="tooltip" data-original-title="<?php echo $button_wishlist; ?>"><span><?php echo $button_wishlist; ?></span></a></span>
        <span class="compare"><a class="fa fa-retweet" onclick="addToCompare('<?php echo $product['product_id']; ?>');" data-placement="top" data-toggle="tooltip" data-original-title="<?php echo $button_compare; ?>"><span><?php echo $button_compare; ?></span></a></span>
     */ ?>
      </div>
    </div>
	</div>
  </div>
  
  </div>
 </div>

        <?php if( $cols > 1  && ($i%$cols == 0 || $i==count($products)) ) { ?>
       </div>
        </div>
        <?php } ?>

        <?php } ?>
  </div>
  </div>
  </div>

  </div>
  <?php } ?>
  
  
  </div>

  <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4" id="right-dct">
	<div class="youtube-video">
		<?php if ($video) { ?> 
			<?php echo $video; ?>
		<?php } ?>
	</div>

  <?php echo $content_bottom; ?>

    <div class="chipp">
      <div class="media-body">
        <p class="shipp-heading">доставка</p>
        <div class="icon-guarantee"></div>
        <p>Бесплатная доставка от 1000 грн.</p>
        <p>при заказе до 14.00 гарантия доставки на следующий день!<br>(кроме выходных и праздничных дней)</p>
      </div>
    </div>

  </div>
  
  <div id="modal123"></div>
  <?php if( $productConfig['product_enablezoom'] ) { ?>

<script type="text/javascript" src=" catalog/view/javascript/jquery/elevatezoom/elevatezoom-min.js"></script>
<script type="text/javascript">
    if(document.documentElement.clientWidth > 767) {
         <?php if( $productConfig['product_zoomgallery'] == 'slider' ) {  ?>
          $("#image").elevateZoom({gallery:'image-additional', cursor: 'pointer', galleryActiveClass: 'active'});
          <?php } else { ?>
          var zoomCollection = '<?php echo $productConfig["product_zoomgallery"]=="basic"?".product-image-zoom":"#image";?>';
           $( zoomCollection ).elevateZoom({
              <?php if( $productConfig['product_zoommode'] != 'basic' ) { ?>
              zoomType        : "<?php echo $productConfig['product_zoommode'];?>",
              <?php } ?>
              lensShape : "<?php echo $productConfig['product_zoomlensshape'];?>",
              lensSize    : <?php echo (int)$productConfig['product_zoomlenssize'];?>,

           });
          <?php } ?>
     }
</script>
<?php } ?>
<script type="text/javascript">
function OneClickCheckout() {
    ga('ec:addProduct', {
        'id': '<?php echo $clear_sku; ?>',
        'name': '<?php echo $clear_name; ?>',
        'price': <?php echo $actual_price; ?>
    });
    ga('ec:setAction', 'add');
    ga('send', 'event', 'UX', 'click', 'add to cart');

    ga('ec:addProduct', {
        'id': '<?php echo $clear_sku; ?>',
        'name': '<?php echo $clear_name; ?>',
        'price': <?php echo $actual_price; ?>
    });
    ga('ec:setAction','checkout', {
        'step': 1
    });
    ga('send', 'event', 'Checkout', 'Start');
    fbq('track', 'AddToCart', {
        content_name: '<?php echo $clear_name; ?>',
        content_ids: ['<?php echo $clear_sku; ?>'],
        content_type: 'product',
        value: <?php echo $actual_price; ?>,
        currency: 'UAH'
    });
}

function sendAnalytics(sku, name, position, href){
    ga('ec:addProduct', {
        'id': sku,
        'name': name,
        'position': position
    });

    ga('ec:setAction', 'click', {
        'list': 'Related Products'
    });
    ga('send', 'event', 'UX', 'click', 'Related Products', {
        'hitCallback': function() {
            window.location.href = href;
        }
    });
}

  var winW = $(window).width();
  if(winW < 992) {

    setTimeout(function() {

      $('.tabs-group > div:not(#tabs)').addClass('collapsed11');
      $('.tabs-wrap1 a').on('click', function() {
        $('.tabs-group > div').removeClass('collapsed11');
      });
    }, 500)
  }
</script>
<script type="text/javascript">
$(document).ready(function() {
    $(".fancybox").fancybox({
        prevEffect    : 'none',
        nextEffect    : 'none',
        title : false
    });
	if(window.location.hash == '#tab-review'){
		$('a[href=\'#tab-review\']').trigger('click');
		var scrollTop = $('#tabs').offset().top;
		$(document).scrollTop(scrollTop);
	}
});
</script> 
 <script type="text/javascript"><!--

$('select[name="profile_id"], input[name="quantity"]').change(function(){
    $.ajax({
    url: 'index.php?route=product/product/getRecurringDescription',
    type: 'post',
    data: $('input[name="product_id"], input[name="quantity"], select[name="profile_id"]'),
    dataType: 'json',
        beforeSend: function() {
            $('#profile-description').html('');
        },
    success: function(json) {
      $('.success, .warning, .attention, .information, .error').remove();
            
      if (json['success']) {
                $('#profile-description').html(json['success']);
      } 
    }
  });
});
	
	$('#sizer-val1').on('click', 'li', function() {
		var liVal = $(this).val().toString();

		$("select.form-control option").each(function() {
		var oVal = $(this).val();
		if(oVal === liVal) {$(this).attr("selected", "selected")}
		})
		$(this).addClass('chosen');
		$(this).siblings().removeClass('chosen');

		$('#button-cart').on('click', function() {

			setTimeout(function() {
				popH()
				$('#modal123').hide();
			}, 1000);
		});				
	});

	function select_transform(){
	    if($("select.form-control option:selected").text() == " --- Выберите --- " && $('.sizer').length === 0){
			
	        $('#button-cart').after('<span class="error"></span><div class="sizer"><span class="title_sizer">Выберите размер</span><br/><select id="sizer_select" name="option[<?php echo $options[0]["product_option_id"]; ?>]" onchange="change_option();"><option value=""><?php echo $text_select; ?></option><?php foreach ($options[0]["option_value"] as $option_value) { ?><option value="<?php echo $option_value["product_option_value_id"]; ?>"><?php echo $option_value["name"]; ?><?php } ?></select><ul id="sizer-val"></li><?php foreach ($options[0]["option_value"] as $option_value) { ?><li value="<?php echo $option_value["product_option_value_id"]; ?>"><?php echo $option_value["name"]; ?><?php } ?></li></ul></div>');

	        change_option();

			$('#sizer-val').on('click', 'li', function() {
				var liVal = $(this).val().toString();

				$("#sizer_select option").each(function() {
					var oVal = $(this).val();
					if(oVal === liVal) {$(this).attr("selected", "selected")}
				})

				$(this).addClass('chosen');
				$(this).siblings().removeClass('chosen');
				$('#button-cart').trigger('click');

                setTimeout(function() {
					popH()
				}, 1500);
			});

		} else if($('.sizer').length !== 0) {

			setTimeout(function() {
				$('.sizer').remove();
			}, 100)
		} else if($('.options').length === 0) {
            setTimeout(function() {
                popH()
            }, 1000);
        }
	}

	function popH() {
	  	var popH = '<h2>товар добавлен в корзину</h2>',
			baseHref = location.href,
			hrefStr = baseHref.split('/')[2],
			popB ='<div class="under-color"><button id="continue-shopping11">продолжить покупки</button></div><div class="under-color"><a href=http://'+hrefStr+'/checkout>оформить заказ</a></div><?php
			if (false) { ?><div class="featprodcart"><h3 style="padding:20px;">Товары из этой коллекции</h3><?php
			foreach ($ffproducts as $key=>$prod) 
			{  ?><div style="float:left;width:110px"><a style="border:none;height:53px;" href="<?php echo htmlentities($prod["href"]); ?>"><div style="font-size: 12px;width: 145px;line-height: 18px;margin-bottom: 20px;height: 40px;width: 110px;word-break: normal;"><?php echo $prod["name"]; ?></div><img style="width:80px;margin-bottom: 70px;" src="<?php echo $prod["thumb"]; ?>"></a><?php echo $prod["price"]; ?></div><?php } ?></div><?php } ?>';
		$('.ui-dialog').removeClass('ui-corner-all');

		<?php if (false) { ?>
			$('#ixiframe .ui-dialog').css('top',$('#ixiframe .ui-dialog').css('top')-120);
			$('.smoothness_prefix.ui-widget-content').addClass("imh440");
			$('.featprodcart').css('height','130px');
			$('.ui-dialog-buttonpane').css('bottom','30px');
			$('.featprodcart,.featprodcart img').css('margin-top','20px');
		<?php } ?>

		$('#cart_dialog_div').html(popH);
		$('.ui-dialog-buttonset').html(popB);
		$('#continue-shopping11').on('click', function() {
			var closeButton = $(".ui-dialog:visible").find(".ui-dialog-titlebar-close");
			closeButton.trigger("click");
			$(".ui-widget-overlay").unbind("click", closeDialogWindowOnOverlayClick);
		});
	}
  

	function change_option(){	
		var opt = $("#sizer_select option:selected").val();
		$("select.form-control").val(opt);
	}

function fbAddToCartTrack(){
    fbq('track', 'AddToCart', {
        content_name: '<?php echo $clear_name; ?>',
        content_ids: ['<?php echo $clear_sku; ?>'],
        content_type: 'product',
        value: <?php echo $actual_price; ?>,
        currency: 'UAH'
    });
}

function googleAddToCartTrack(){
 ga('ec:addProduct', {
     'id': '<?php echo $clear_sku; ?>',
     'name': '<?php echo $clear_name; ?>',
     'price': <?php echo $actual_price; ?>
 });
 ga('ec:setAction', 'add');
 ga('send', 'event', 'UX', 'click', 'add to cart');
}

$('#button-cart').on('click', function() {
  $.ajax({
    url: 'index.php?route=checkout/cart/add',
    type: 'post',
    data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
    dataType: 'json',
    success: function(json) {
      $('.success, .warning, .attention, .information, .error').remove();
      
      if (json['error']) {
        if (json['error']['profile']) {
            $('select[name="profile_id"]').after('<span class="error">' + json['error']['profile'] + '</span>');
        }
      } 
		  
      if (json['success']) {
        $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
          
        $('.success').fadeIn('slow');
          
        $('#cart-total').html(json['total']);
        $('#cart-link').attr('class', 'full-cart');
        $('html, body').animate({ scrollTop: 0 }, 'slow');
      }
    }
  });
});

//--></script>
<?php if ($options) { ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'file') { ?>
<script type="text/javascript"><!--
new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
  action: 'index.php?route=product/product/upload',
  name: 'file',
  autoSubmit: true,
  responseType: 'json',
  onSubmit: function(file, extension) {
    $('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
    $('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
  },
  onComplete: function(file, json) {
    $('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);
    
    $('.error').remove();
    
    if (json['success']) {
      alert(json['success']);
      
      $('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
    }
    
    if (json['error']) {
      $('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
    }
    
    $('.loading').remove(); 
  }
});
//--></script>
<?php } ?>
<?php } ?>
<?php } ?>
<script type="text/javascript"><!--
$('#review .pagination a').live('click', function() {
  $('#review').fadeOut('slow');
    
  $('#review').load(this.href);
  
  $('#review').fadeIn('slow');
  
  return false;
});     

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').bind('click', function() {
  $.ajax({
    url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
    type: 'post',
    dataType: 'json',
    data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
    beforeSend: function() {
      $('.success, .warning').remove();
      $('#button-review').attr('disabled', true);
      $('#review-title').after('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
    },
    complete: function() {
      $('#button-review').attr('disabled', false);
      $('.attention').remove();
    },
    success: function(data) {
      if (data['error']) {
        $('#review-title').after('<div class="warning">' + data['error'] + '</div>');
      }
      
      if (data['success']) {
        $('#review-title').after('<div class="success">' + data['success'] + '</div>');
                
        $('input[name=\'name\']').val('');
        $('textarea[name=\'text\']').val('');
        $('input[name=\'rating\']:checked').attr('checked', '');
        $('input[name=\'captcha\']').val('');
      }
    }
  });
});
//--></script> 
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script> 
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
$(document).ready(function() {
  if ($.browser.msie && $.browser.version == 6) {
    $('.date, .datetime, .time').bgIframe();
  }

  $('.date').datepicker({dateFormat: 'yy-mm-dd'});
  $('.datetime').datetimepicker({
    dateFormat: 'yy-mm-dd',
    timeFormat: 'h:m'
  });
  $('.time').timepicker({timeFormat: 'h:m'});
});
//--></script> 
	<script type="text/javascript" src="catalog/view/javascript/modalEffects.js"></script>
		<script  type="text/javascript" src="catalog/view/javascript/classie.js"></script>
</section> 

<?php if( $SPAN[2] ): ?>
	<aside class="col-lg-<?php echo $SPAN[2];?> col-md-<?php echo $SPAN[2];?> col-sm-12 col-xs-12">	
		<?php echo $column_right; ?>
	</aside>
<?php endif; ?>

<!-- ReTag -->
<script type="text/javascript">
    // required object
    window.ad_product = {
        "id": "<?php echo $clear_sku; ?>",   // required
        "vendor": "LOTTO",
        "price": "<?php echo $actual_price; ?>",
        "url": "<?php echo 'http://lotto-sport.com.ua'.$_SERVER['REQUEST_URI']; ?>",
        "picture": "<?php echo $popup; ?>",
        "name": "<?php echo $clear_name; ?>",
        "category": "<?php echo $categ_id; ?>"
    };

    window._retag = window._retag || [];
    window._retag.push({code: "9ce88868a5", level: 2});
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

<?php echo $footer; ?>
<?php /* <div id="sizestab"><div class="close_button" title="Нажмите, чтобы закрыть окно">X</div></div> */ ?>

<div id="myModal" class="modal fade in" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">

        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
          <p class="modal-title" id="myModalLabel">Размеры</p>
        </div>
        <div class="modal-body">
          <?php echo html_entity_decode($tab_sizetype); ?> </div>

      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<!-- AddOffer information modal -->  
<div id="offer-info" class="modal fade in" style="text-align: center;" tabindex="-1" role="dialog" aria-labelledby="offerInfoLabel" aria-hidden="false">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">

        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
          <p class="modal-title" id="offerInfoLabel">Информация об акции</p>
        </div>
        <div class="modal-body">
          <?php echo $additionaloffer['text']; ?>
		   <button type="button" class="smch_call_button" data-dismiss="modal" aria-hidden="true">закрыть</button>
		</div>

      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<!-- End AddOffer information modal -->