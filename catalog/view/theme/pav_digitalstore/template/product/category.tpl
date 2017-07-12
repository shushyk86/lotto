<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); 
	$themeConfig = $this->config->get('themecontrol');
	$categoryConfig = array(
		'listing_products_columns'           => 0,
		'listing_products_columns_small'     => 2,
		'listing_products_columns_minismall' => 1,
		'cateogry_display_mode'              => 'grid',
		'category_pzoom'                     => 1,
		'quickview'                          => 0,
		'show_swap_image'                    => 0,
	);
	$categoryConfig     = array_merge($categoryConfig, $themeConfig );
	$DISPLAY_MODE 	    = $categoryConfig['cateogry_display_mode'];
	$MAX_ITEM_ROW       = $themeConfig['listing_products_columns']?$themeConfig['listing_products_columns']:3; 
	$MAX_ITEM_ROW_SMALL = $categoryConfig['listing_products_columns_small'] ;
	$MAX_ITEM_ROW_MINI  = $categoryConfig['listing_products_columns_minismall'];
	$categoryPzoom 	    = $categoryConfig['category_pzoom'];
	$quickview          = $categoryConfig['quickview'];
	$swapimg            = $categoryConfig['show_swap_image'];
?>
<?php echo $header; ?>
<script type="text/javascript">
var _tmr = _tmr || [];
_tmr.push({
type: 'itemView',
productid: '',
pagetype: 'category',
totalvalue: '',
list: '1' });
</script>
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?>	
 
<?php if( $SPAN[0] ): ?>
	<aside class="col-lg-<?php echo $SPAN[0];?> col-md-<?php echo $SPAN[0];?> col-sm-12 col-xs-12">
		<?php echo $column_left; ?>
	  <p id="use-filter"><span>применить фильтр</span></p>
	</aside>	
<?php endif; ?> 
<section class="col-lg-<?php echo $SPAN[1];?> col-md-<?php echo $SPAN[1];?> col-sm-12 col-xs-12">
<!-- <div id="content"><?php echo $content_top; ?>
 
  <?php if ($thumb || $description) { ?>
  <div class="category-info clearfix">
    <?php if ($thumb) { ?>
    <div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div>
    <?php } ?>
    <?php if ($description) { ?>
    <div class="description"><?php echo $description; ?></div>
    <?php } ?>
  </div>
  <?php } ?> -->


  <div class="category-list clearfix">
 <!-- <h2 class="heading_title"><span><?php echo $text_refine; ?></span></h2>-->

  <?=$description;?>

  <h1 class="heading_title"><?php echo $heading_title; ?><span>:</span></h1>

	  <?php if($categ_id == 59) { ?>
		  <script src="http://megatimer.ru/s/fb73ed28e2fa9dd87bdf9630c02b5863.js"></script>
		  <script type="text/javascript">
			  $(document).ready(function() {
				  $("#timerfb73ed28e2fa9dd87bdf9630c02b5863").css('margin-right','20%');
			  });
		  </script>
	  <?php } ?>

	  <?php if ($categories) { ?>
    <?php if (count($categories) <= 5) { ?>
    <ul>
      <?php foreach ($categories as $category) { ?>
      <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
      <?php } ?>
    </ul>
    <?php } else { ?>
    <?php for ($i = 0; $i < count($categories);) { ?>
    <ul>
      <?php $j = $i + ceil(count($categories) / 4); ?>
      <?php for (; $i < $j; $i++) { ?>
      <?php if (isset($categories[$i])) { ?>
      <li><a href="<?php echo $categories[$i]['href']; ?>"><?php echo $categories[$i]['name']; ?></a></li>
      <?php } ?>
      <?php } ?>
    </ul>
    <?php } ?>
    <?php } ?>
  <?php } ?>
  </div>
  <?php if ($products) { ?>
  <div class="product-filter clearfix">
</div>
<div class="pagination-top">
<!-- оригинал!!!
    <div class="limit" id="sort-toggle">
    	<div>
    		<p>сортировать: 
	    		<span></span>
    		</p>

    		<select class="form-control hide" onchange="location = this.value;">
		        <?php /* foreach ($limits as $limits) { ?>
		        <?php if ($limits['value'] == $limit) { ?>
		        <option class="hide" value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
		        <?php } else { ?>
		        <option class="hide" value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
		        <?php } ?>
		        <?php } */ ?>
			</select>
    	</div>
    </div> 

    <div class="sort" id="limit-toggle">
		<p>показать: 
			<span id="select-val"></span> 
			<span></span>
		</p>
		<select class="form-control hide" onchange="location = this.value;">
			<?php /* foreach ($sorts as $sorts) { ?>
			<?php if ($sorts['value'] == $sort . '-' . $order) { ?>
			<option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
			<?php } else { ?>
			<option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
			<?php } ?>
			<?php } */ ?>
		</select>
    </div>
-->
	<div class="sort" id="sort-toggle">
		<p>сортировать:
			<span id="select-val"></span>
			<span></span>
		</p>
		<select class="form-control hide" onchange="location = this.value;">
			<?php foreach ($sorts as $sorts) { ?>
				<?php if ($sorts['value'] == $sort . '-' . $order) { ?>
					<option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
				<?php } else { ?>
					<option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
				<?php } ?>
			<?php } ?>
		</select>
	</div>

    <div class="pagination"><?php echo $pagination; ?></div>

</div>
 <div class="limit-block">
	<ul class="limit-list"></ul>
</div>

<div class="sort-block">
	<ul class="sort-list"></ul>
</div>
<div class="product-list"> <div class="products-block">
    <?php
	$cols = $MAX_ITEM_ROW ;
	$span = floor(12/$cols);
	$small = floor(12/$MAX_ITEM_ROW_SMALL);
	$mini = floor(12/$MAX_ITEM_ROW_MINI);
	
	foreach ($products as $i => $product) { ?>
	<?php if( $i++%$cols == 0 ) { ?>
		  <div class="row products-item">
	<?php } ?>
    <div class="col-xs-6 col-lg-<?php echo $span;?> col-sm-<?php echo $small;?> col-xs-<?php echo $mini;?>">
    	<div class="product-block clearfix ">	
	      <?php if ($product['thumb']) { ?>
	      <div class="image">

<!--Additional offer-->
			<?php if($product['ao_label']) { ?>
			<div class="product-label-action" >
				<span>акция</span>
			</div>
			<?php } ?>
<!--Additional offer-->

			<?php if($product['discount']) { ?>
				<span class="product-label-special label"><?php echo $product['discount']; ?></span>
		    <?php } ?>

		    <?php  if ($product['collection'] && $categ_id != 59) { ?>
				<span class="product-label-new label"><?php echo $this->language->get( 'text_label_new' ); ?></span>
			<?php  } ?>

		    <?php if ($product['freeshipping']) { ?>
				<span class="product-label-special-shipping label">

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

				</span>
			<?php } ?>
		    			
	    	<a class="img" href="<?php echo $product['href']; ?>" onclick="sendAnalytics('<?php echo $product['sku']; ?>', <?php echo $product['position']; ?>, '<?php echo $product['href']; ?>'); return !ga.loaded;"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $heading_title; ?> - <?php echo $product['name']; ?> (<?php echo $product['sku']; ?>)" alt="<?php echo $heading_title; ?> - <?php echo $product['name']; ?> (<?php echo $product['sku']; ?>)" /></a>
	      	<?php if( $categoryPzoom ) { $zimage = str_replace( "cache/","", preg_replace("#-\d+x\d+#", "",  $product['thumb'] ));  ?>
	      	<a href="<?php echo $zimage;?>" class="colorbox product-zoom" rel="colorbox" title="<?php echo $product['name']; ?>"><span class="fa fa-search-plus"></span></a>
	      	<?php } ?>

			<?php //#2 Start fix quickview in fw?>
			<?php if ($quickview) { ?>
			<a class="pav-colorbox hidden-sm hidden-xs" href="index.php?route=themecontrol/product&amp;product_id=<?php echo $product['product_id']; ?>"><span class='fa fa-eye'></span><?php echo $this->language->get('quick_view'); ?></a>
			<?php } ?>
			<?php //#2 End fix quickview in fw?>

			<?php 
  			if( $swapimg ){
      		$product_images = $this->model_catalog_product->getProductImages( $product['product_id'] );
			if(isset($product_images) && !empty($product_images)) {
				$thumb2 = $this->model_tool_image->resize($product_images[0]['image'],  $this->config->get('config_image_product_width'),  $this->config->get('config_image_product_height') );
			?>	
			<span class="hover-image">
				<a class="img" href="<?php echo $product['href']; ?>" onclick="sendAnalytics('<?php echo $product['sku']; ?>', <?php echo $product['position']; ?>, '<?php echo $product['href']; ?>'); return !ga.loaded;"><img src="<?php echo $thumb2; ?>" alt="<?php echo $product['name']; ?>"></a>
			</span>
			
			<?php } } ?>

	      </div>
	      <?php } ?>
		<div class="product-meta">
	      <p class="name"><a href="<?php echo $product['href']; ?>" onclick="sendAnalytics('<?php echo $product['sku']; ?>', <?php echo $product['position']; ?>, '<?php echo $product['href']; ?>'); return !ga.loaded;"><?php echo $product['name']; ?></a></p>
	      		  
	      <?php if ($product['price']) { ?>
	      <div class="price">
		    <span class="text-price">Цена: </span>
	        <?php if (!$product['special']) { ?>
	        <?php echo $product['price']; ?>
	        <?php } else { ?>
	        <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
	        <?php } ?>
	        <?php if ($product['tax']) { ?>
	        <br />
	        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
	        <?php } ?>
	      </div>
	      <?php } ?>
<!--      <div class="description"><?php echo utf8_substr( strip_tags($product['description']),0,100);?>...</div>	-->

			<?php if ($product['options']) { ?>
				<div class="options">
					<p>Доступные размеры:</p>
					<?php foreach ($product['options'] as $option) { ?>
						<ul id="sizer-val1">
							<?php foreach ($option["option_value"] as $option_value) { ?>
								<li value="<?php echo $option_value["product_option_value_id"]; ?>"><?php echo $option_value["name"]; ?></li>
							<?php } ?>
						</ul>
					<?php } ?>
				</div>
			<?php } ?>

		  <div class="price">
		  <a href="<?php echo $product['href'] . '#tab-review'; ?>" onclick="sendAnalytics('<?php echo $product['sku']; ?>', <?php echo $product['position']; ?>, '<?php echo $product['href'] . '#tab-review'; ?>'); return !ga.loaded;" style="margin-right: 20px; text-decoration: underline; font-size: 14px; color: #000;">Отзывы (<?php echo $product['reviews']; ?>)</a><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" />
		  </div>
	    
<!--	  <?php if ($product['rating']) { ?>
	      <div class="rating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
	      <?php } ?>
-->	
		  <div class="cart">
			<div class="under-color">
				<a id="details_button" href="<?php echo $product['href']; ?>" onclick="sendAnalytics('<?php echo $product['sku']; ?>', <?php echo $product['position']; ?>, '<?php echo $product['href']; ?>'); return !ga.loaded;" class="btn">
					<span>Подробнее</span>
				</a>
  			</div>
<!--		  
	          <input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" />
			  <button onclick="getOCwizardModal_smch('<?php echo $product['product_id']; ?>')" class="smch_call_button">Купить в 1 клик</button>	        
-->
		  </div>
	<?php /*	<div class="wishlist-compare">
	      <span class="wishlist"><a class="fa fa-heart" onclick="addToWishList('<?php echo $product['product_id']; ?>');"  data-placement="top" data-toggle="tooltip" data-original-title="<?php echo $button_wishlist; ?>"><span><?php echo $button_wishlist; ?></span></a></span>
	      <span class="compare"><a class="fa fa-retweet" onclick="addToCompare('<?php echo $product['product_id']; ?>');"  data-placement="top" data-toggle="tooltip" data-original-title="<?php echo $button_compare; ?>"><span><?php echo $button_compare; ?></span></a></span>
	      </div> */ ?>
	  </div>
	  </div>
	</div>
	 <?php if( $i%$cols == 0 || $i==count($products) ) { ?>
	 </div>
	 <?php } ?>
		<script>
			ga('ec:addImpression', {
				'id': '<?php echo $product['sku']; ?>',
				'list': 'Category',
				'position': <?php echo $product['position']; ?>
			});
		</script>
    <?php } ?>
  </div>
  </div>


 	<div class="pagination-bottom">
	   <div class="pagination"><?php echo $pagination; ?></div>
	</div>
    <?php if ($description_bottom) { ?>
    <div class="description_bottom short" style="background:#fff; padding:10px; border-radius: 10px; "><?php echo $description_bottom; ?></div>
    <div class="brand-description-more">
		<!--<a href="#" id="short_text_show_link"><span class="xhr arrow-link-inner">Читать полностью</span>&nbsp;→ </a>-->
	</div>
    <?php } ?>
  <?php } ?>
  <?php if (!$categories && !$products) { ?>
  <div class="content"><p class="text-empty"><?php echo $text_empty; ?></p></div>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>
    <?php if ($description_bottom) { ?>
    <div class="description_bottom short" style="background:#fff; padding:10px; border-radius: 10px; "><?php echo $description_bottom; ?></div>
    <div class="brand-description-more">
		<!--<a href="#" id="short_text_show_link"><span class="xhr arrow-link-inner">Читать полностью</span>&nbsp;→ </a>-->
	</div>
    <?php } ?>
  <?php } ?>
  <?php echo $content_bottom; ?>
<script type="text/javascript">
	function sendAnalytics(sku, position, href){
		ga('ec:addProduct', {
			'id': sku,
			'position': position
		});

		ga('ec:setAction', 'click', {
			'list': 'Category'
		});
		ga('send', 'event', 'UX', 'click', 'Category', {
			'hitCallback': function() {
				document.location = href;
			}
		});
	}

	var filterHeading = $('#filterpro_box').find('.box-heading');
	filterHeading.html(filterHeading.html().replace(/Фильтр/, 'Фильтровать по:'));
	
	$('.limit').find('.form-control option').each(function() {
		$('.limit-list').append('<li><a href="'+$(this).attr('value')+'">'+$(this).text()+'</a></li>');
	});

	var defaultVal = $('.limit').find('.form-control option:selected').text();
	$('#select-val').text(defaultVal);

	$('.limit-list').on('click', 'li', function() {
		var optVal = $(this).text();
		$('.limit').find('.form-control option').each(function() {
			if($(this).text() === optVal) {
				$(this).attr('selected', 'selected')
			} else {
				$(this).removeAttr('selected')
			}
		});
		$('#select-val').text(optVal);
		$('.sort-block, .limit-block').slideUp(200);
	});

	$('.sort').find('.form-control option').each(function() {
		$('.sort-list').append('<li><a href="'+$(this).attr('value')+'">'+$(this).text()+'</a></li>');
	});

	$('.sort-list').on('click', 'li', function() {
		var optVal = $(this).text();
		$('.sort').find('.form-control option').each(function() {
			if($(this).text() === optVal) {
				$(this).attr('selected', 'selected')
			} else {
				$(this).removeAttr('selected')
			}
		});
		$('.sort-block, .limit-block').slideUp(200);
	});
/*	оригинал
	function toggleSelection(but, el1, el2) {
		$(but).on('click', function() {
			$(el1).slideToggle(200);
			$(el2).slideUp(200);
		});
	};
*/
//	переделаная
	function toggleSelection(but, el1) {
		$(but).on('click', function() {
			$(el1).slideToggle(200);
		});
	};

	toggleSelection('#limit-toggle', '.limit-block', '.sort-block');
	toggleSelection('#sort-toggle', '.sort-block', '.limit-block');

	// $('#limit-toggle').on('click', function() {
	// 	$('span').css({
 //            transform:'rotate(-90deg)'
 //        });
 //        $('span').css({
 //            transform:'rotate(-45deg)'
 //        });
	// });

$("#limit-toggle").click(function(){
		$(".overlay").addClass(".span-rotate");
	},function(){
		$(".overlay").removeClass(".span-rotate");
	})	


</script>
<?php if( $categoryPzoom ) {  ?>
<?php } ?>
</section> 

<?php if( $SPAN[2] ): ?>
	<aside class="col-lg-<?php echo $SPAN[2];?> col-md-<?php echo $SPAN[2];?> col-sm-12 col-xs-12">	
		<?php echo $column_right; ?>
	</aside>
<?php endif; ?>

<script type="text/javascript">
	winW = $(window).width();
	if(winW > 992) {
		setInterval(function() {
			var le = $('.offcanvas-sidebar').height(),
				ri = $('.main-column').height();
			if(le < ri) {
				$('.offcanvas-sidebar').height(ri);
			} else if (le > ri) {
				$('.offcanvas-sidebar').css('height', 'auto');
			}
		}, 1000);
	};
$(function(){
	$('input.button').on('click', '.under-color', function(){
		setTimeout(function() {
            var popH = '<h2>товар добавлен в корзину</h2>',
              baseHref = location.href,
              hrefStr = baseHref.split('/')[2],
              popB ='<div class="under-color"><button id="continue-shopping11">продолжить покупки</button></div><div class="under-color"><a href=http://'+hrefStr+'/checkout>оформить заказ</a></div><?php
              if (isset($ffproducts) && $ffproducts) { ?><div class="featprodcart"><h3 style="padding:20px;">Товары из новой коллекции</h3><?php
		foreach ($ffproducts as $key=>$prod) 
			{  ?><div style="float:left;width:110px"><a style="border:none;height:53px;" href="<?php echo htmlentities($prod["href"]); ?>"><div style="font-size: 12px;width: 145px;line-height: 18px;margin-bottom: 20px;height: 40px;width: 110px;word-break: normal;"><?php echo $prod["name"]; ?></div><img style="width:80px;margin-bottom: 70px;" src="<?php echo $prod["thumb"]; ?>"></a><?php echo $prod["price"]; ?></div><?php } ?></div><?php } ?>';
            $('.ui-dialog').removeClass('ui-corner-all');
            <?php if (isset($ffproducts) && $ffproducts) { ?>
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
          }, 2000);
 	});
});
</script>

<!-- ReTag -->
<script type="text/javascript">
    window.ad_category = "<?php echo $categ_id?>";   // required

    window._retag = window._retag || [];
    window._retag.push({code: "9ce88868a4", level: 1});
    (function () {
        var id = "admitad-retag";
        if (document.getElementById(id)) {return;}
        var s=document.createElement("script");
        s.async = true; s.id = id;
        var r = (new Date).getDate();
        s.src = (document.location.protocol == "https:" ? "https:" : "http:") + "//cdn.trmit.com/static/js/retag.min.js?r="+r;
        var a = document.getElementsByTagName("script")[0]
        a.parentNode.insertBefore(s, a);
    })()
</script>
<!-- End ReTag -->

<?php echo $footer; ?>
