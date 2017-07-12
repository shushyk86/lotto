<?php if (count($products) > 0) { ?>
<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
    <div class="box-product" id="view_carousel_1">
      <?php foreach ($products as $product) { ?>
      <div>
        <?php if ($product['thumb']) { ?>
        <div class="image"><?php echo $product['sticker']; ?><a href="<?php echo $product['href']; ?>" onclick="sendViewedAnalytics('<?php echo $product['sku']; ?>', <?php echo $product['position']; ?>, '<?php echo $product['href']; ?>'); return !ga.loaded;"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>" onclick="sendViewedAnalytics('<?php echo $product['sku']; ?>', <?php echo $product['position']; ?>, '<?php echo $product['href']; ?>'); return !ga.loaded;"><?php echo $product['name']; ?></a></div>
        <?php if ($product['price']) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
        <div class="cart"><a href="<?php echo $product['href']; ?>" onclick="sendViewedAnalytics('<?php echo $product['sku']; ?>', <?php echo $product['position']; ?>, '<?php echo $product['href']; ?>'); return !ga.loaded;" class="button"><span><?php echo $button_cart; ?></span></a></div>
      </div>
      <?php } ?>
    </div>
  </div>
</div>

<?php foreach ($products as $product) { ?>
    <script type="text/javascript">
        ga('ec:addImpression', {
            'id': '<?php echo $product['sku']; ?>',
            'list': 'Viewed',
            'position': <?php echo $product['position']; ?>
        });
    </script>
<?php } ?>

<?php } ?>
<script type="text/javascript">
    $('#view_carousel_1').owlCarousel({
        items: 5,
        loop:true,
//        autoPlay: 2000,
        autoPlay: false,
        singleItem: true,
        navigation: true,
        navigationText: ['<i class="fa fa-chevron-left star"></i>', '<i class="fa fa-chevron-right star"></i>'],
        pagination: false
    });

    function sendViewedAnalytics(sku, position, href){
        ga('ec:addProduct', {
            'id': sku,
            'position': position
        });

        ga('ec:setAction', 'click', {
            'list': 'Viewed'
        });
        ga('send', 'event', 'UX', 'click', 'Viewed', {
            'hitCallback': function() {
                document.location = href;
            }
        });
    }
</script>
<style>
  #view_carousel_1 .owl-buttons i {
    opacity:1;
    color: #000;
    font-size:15px!important;
  }
  .owl-carousel .owl-buttons div {
    opacity:1;
  }
  #view_carousel_1 .owl-item {
    padding: 0 10px;
  }
  #view_carousel_1 .image,
  #view_carousel_1 .cart {
    text-align: center;
  }
  #view_carousel_1 .cart {
    margin-top:20px;
  }
  #view_carousel_1 .price-old {
     text-decoration: line-through;
    padding-right:10px;
  }
</style>