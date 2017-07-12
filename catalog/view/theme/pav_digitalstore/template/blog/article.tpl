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
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?>
<?php if( $SPAN[0] ): ?>
    <aside class="col-lg-<?php echo $SPAN[0];?> col-md-<?php echo $SPAN[0];?> col-sm-12 col-xs-12">
        <?php echo $column_left; ?>
    </aside>
<?php endif; ?>
<section class="col-lg-<?php echo $SPAN[1];?> col-md-<?php echo $SPAN[1];?> col-sm-12 col-xs-12">
<div id="content"><?php echo $content_top; ?>

  <h1><?php echo $heading_title; ?></h1>

    <img src="<?php echo $thumb; ?>">
  <div class="blog-info">
	<div class="blog-description"><?php echo $description; ?></div>
      <?php if($tags) { ?>
          <div class="tags">
              <?php foreach($tags as $tag) { ?>
                  <a href="<?php echo $tag['href']; ?>"><?php echo $tag['text']; ?></a>
              <?php } ?>
          </div>
      <?php } ?>
	</div>
    <div class="blog-right">
      <div class="description">
      <?php if ($review_status) { ?>
	  <?php if ($article_review) { ?>
      <div class="review">
        <div>
		<?php for ($i = 1; $i <= 5; $i++) { ?>
              <?php if ($rating < $i) { ?>
              <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
              <?php } else { ?>
              <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
              <?php } ?>
			  <?php } ?>
		&nbsp;&nbsp;<?php echo $reviews; ?></div>
      </div>
      <?php } ?>
	   <?php } ?>
    </div>
  </div>

  <?php if ($download_status) { ?>
  <div class="blog-info">
  <?php if($downloads){ ?>
  <br />
	<?php foreach($downloads as $download){ ?>
	<a href="<?php echo $download['href']; ?>" title=""><i class="fa fa-floppy-o"></i><?php echo $download['name']; ?> <?php echo " (". $download['size'] .")";?></a><br>
	<?php } ?>
  <br />
  <?php } ?>
  </div>
  <?php } ?>
  
  <?php if ($products) { ?>
   <div class="blog-related"><?php echo $tab_related_product; ?> (<?php echo count($products); ?>)</div>
  <div class="blog-content">
    <div class="box-product">
      <?php foreach ($products as $product) { ?>
      <div>
		<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
        <?php if ($product['thumb']) { ?>
        <div class="image"><?php echo $product['sticker']; ?><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="rating">
				  <?php for ($i = 1; $i <= 5; $i++) { ?>
                  <?php if ($product['rating'] < $i) { ?>
                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                  <?php } else { ?>
                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                  <?php } ?>
                  <?php } ?>
	  </div>
	  <?php if ($product['price']) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span><br /><span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
		<div class="cart">
        <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><span><?php echo $button_cart; ?></span></a>
		</div>
		<div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart-o"></i><?php echo $button_wishlist; ?></a></div>
	  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');"><i class="fa fa-files-o"></i><?php echo $button_compare; ?></a></div>
		</div>
      <?php } ?>
    </div>
  </div>
  <?php } ?>
  <?php if ($articles) { ?>
  <div class="blog-related"><?php echo $tab_related; ?></div>
  <div class="blog-content">
    <div class="box-product box-articles">
      <?php foreach ($articles as $article) { ?>
      <div class="page_blog--product-list_wrapp-content clearfix">  
	  <div class="name"><a href="<?php echo $article['href']; ?>"><?php echo $article['name']; ?></a></div>
        <?php if ($article['thumb']) { ?>
        <div class="image"><a href="<?php echo $article['href']; ?>"><img src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" /></a></div>
        <div class=""><?php echo $article['date_added']; ?></div>
        <div class="description"><?php echo $article['description_mini']; ?></div>
        <?php } ?>
      <?php } ?>
    </div>
  </div>
  <?php } ?>
  <?php if ($review_status) { ?>
  <?php if ($article_review) { ?>
  <div class="blog-review">
     <div id="review"></div>
    <div id="rev" class="prev"><a class="button"><?php echo $text_write; ?></a></div>
	<div id="rev_add" class="visible">
    <b><?php echo $entry_name; ?></b><br />
    <input type="text" name="name" value="" />
    <br />
    <br />
    <b><?php echo $entry_review; ?></b>
    <textarea name="text" cols="40" rows="8" style="width: 98%;"></textarea>
    <span style="font-size: 11px;"><?php echo $text_note; ?></span><br />
    <br />
    <b><?php echo $entry_rating; ?></b> <span><?php echo $entry_bad; ?></span>&nbsp;
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
    <br />
    <b><?php echo $entry_captcha; ?></b><br />
    <input type="text" name="captcha" value="" />
    <br />
    <img src="index.php?route=blog/article/captcha" alt="" id="captcha" /><br />
    <br />
    <div class="buttons">
      <div class="right"><a id="button-review" class="button"><?php echo $button_continue; ?></a></div>
    </div>
	</div>
  </div>
  <?php } ?>
  <?php } ?>
  <?php echo $content_bottom; ?>
  </div>
</section>

<?php if( $SPAN[2] ): ?>
    <aside class="col-lg-<?php echo $SPAN[2];?> col-md-<?php echo $SPAN[2];?> col-sm-12 col-xs-12 title-page-blog--box-heading offcanvas-sidebar">
        <?php echo $column_right; ?>
    </aside>
<?php endif; ?>

    <script type="text/javascript">
$(document).ready(function(){

$('#rev').click(function(){
$('#rev_add').toggleClass('visible');

		});
		
});
</script>
<script type="text/javascript"><!--
$('.colorbox').colorbox({
	overlayClose: true,
	opacity: 0.5
});
//--></script> 
<script type="text/javascript"><!--
$('#button-cart').bind('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('.blog-info input[type=\'text\'], .blog-info input[type=\'hidden\'], .blog-info input[type=\'radio\']:checked, .blog-info input[type=\'checkbox\']:checked, .blog-info select, .blog-info textarea'),
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information, .error').remove();
			
			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}
				}
			} 
			
			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
				$('.success').fadeIn('slow');
					
				$('#cart-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
			}	
		}
	});
});
//--></script>
<script type="text/javascript"><!--
$('#review .pagination a').live('click', function() {
	$('#review').fadeOut('slow');
		
	$('#review').load(this.href);
	
	$('#review').fadeIn('slow');
	
	return false;
});			

$('#review').load('index.php?route=blog/article/review&article_id=<?php echo $article_id; ?>');

$('#button-review').bind('click', function() {
	$.ajax({
		url: 'index.php?route=blog/article/write&article_id=<?php echo $article_id; ?>',
		type: 'post',
		dataType: 'json',
		data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-review').attr('disabled', true);
			$('#rev').after('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-review').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(data) {
			if (data['error']) {
				$('#rev').after('<div class="warning">' + data['error'] + '</div>');
			}
			
			if (data['success']) {
				$('#rev').after('<div class="success">' + data['success'] + '</div>');
								
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
if ($.browser.msie && $.browser.version == 6) {
	$('.date, .datetime, .time').bgIframe();
}

$('.date').datepicker({dateFormat: 'yy-mm-dd'});
$('.datetime').datetimepicker({
	dateFormat: 'yy-mm-dd',
	timeFormat: 'h:m'
});
$('.time').timepicker({timeFormat: 'h:m'});
//--></script>
<?php echo $footer; ?>