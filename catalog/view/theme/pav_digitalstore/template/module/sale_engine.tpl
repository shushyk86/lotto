<?php
$cols = 4;
$span = 12/$cols;
?>
<div class="box box-product">
    <div class="box-heading box-heading__title text-center" style="margin-top: 25px;">
        <span><?php echo $heading_title; ?></span>
    </div>
    <div class="box-content">
        <div class="box-product">
            <?php foreach ($products as $i => $product) { ?>
                <?php if( $i++%$cols == 0 ) { ?>
                    <div class="row">
                <?php } ?>
                <div class=" col-lg-<?php echo $span;?>">
                    <div class="product-block">
                        <?php if ($product['thumb']) { ?>
                            <div class="image">
                                <?php if($product['discount']) { ?>
                                    <span class="product-label-special label"><?php echo $product['discount']; ?></span>
                                <?php } ?>
                                <a class="img" href="<?php echo $product['href']; ?>" onclick="sendAnalytics('<?php echo $product['sku']; ?>', <?php echo $product['position']; ?>, '<?php echo $product['href']; ?>'); return !ga.loaded;"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
                            </div>
                        <?php } ?>
                        <div class="product-meta">
                            <h3 class="name"><a href="<?php echo $product['href']; ?>" onclick="sendAnalytics('<?php echo $product['sku']; ?>', <?php echo $product['position']; ?>, '<?php echo $product['href']; ?>'); return !ga.loaded;"><?php echo $product['name']; ?></a></h3>
                            <?php if ($product['price']) { ?>
                                <div class="price">
                                    <?php if (!$product['special']) { ?>
                                        <?php echo $product['price']; ?>
                                    <?php } else { ?>
                                        <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
                                    <?php } ?>
                                </div>
                            <?php } ?>
                            <div class="cart">
                                <div class="under-color">
                                    <a id="details_button" href="<?php echo $product['href']; ?>" onclick="sendAnalytics('<?php echo $product['sku']; ?>', <?php echo $product['position']; ?>, '<?php echo $product['href']; ?>'); return !ga.loaded;" class="btn">
                                        <span>Подробнее</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <?php if( $i%$cols == 0 || $i==count($products) ) { ?>
                    </div>
                <?php } ?>
                <script type="text/javascript">
                    ga('ec:addImpression', {
                        'id': '<?php echo $product['sku']; ?>',
                        'list': 'Sale-Engine',
                        'position': <?php echo $product['position']; ?>
                    });
                </script>
            <?php } ?>
        </div>
    </div>
    <div class="text-center">
        <div class="under-color btn-center btn-width-240">
            <a href="/sportivnaya-obuv/krossovki/krossovki-muzhchiny" id="simplecheckout_button_cart" class="btn">
                <span>Больше товаров</span>
            </a>
        </div>
    </div>
</div>
<script type="text/javascript">
    function sendAnalytics(sku, position, href){
        ga('ec:addProduct', {
            'id': sku,
            'position': position
        });

        ga('ec:setAction', 'click', {
            'list': 'Sale-Engine'
        });
        ga('send', 'event', 'UX', 'click', 'Sale-Engine', {
            'hitCallback': function() {
                document.location = href;
            }
        });
    }
</script>