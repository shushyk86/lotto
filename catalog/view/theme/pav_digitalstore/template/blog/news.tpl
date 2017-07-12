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

<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?>

<?php if( $SPAN[0] ): ?>
    <aside class="col-lg-<?php echo $SPAN[0];?> col-md-<?php echo $SPAN[0];?> col-sm-12 col-xs-12">   
        <?php echo $column_left; ?>
    </aside>
<?php endif; ?>
    <section class="col-lg-<?php echo $SPAN[1];?> col-md-<?php echo $SPAN[1];?> col-sm-12 col-xs-12">

<div id="content">

<?php echo $content_top; ?>

    <h1 class="title-page-blog"><?php echo $heading_title; ?></h1>

<!-- тут будет слайдер с последними статьями -->
<?php if (!empty($latest_articles)) { ?>
    <div id="slideshow" class="owl-carousel page_blog--carousel" style="opacity: 1;">
        <?php foreach ($latest_articles as $banner) { ?>
            <div class="item page_blog--carousel_item clearfix">
                <?php if ($banner['href']) { ?>
                    <a class="page_blog--carousel_block-img col-md-5 " href="<?php echo $banner['href']; ?>"><img src="<?php echo $banner['thumb_gallery']; ?>" alt="<?php echo $banner['name']; ?>" class="img-responsive" /></a>
                <?php } ?>
                <div class="page_blog--carousel_block-reviews col-md-7 ">
                    <h2 class="page_blog--carousel_block-reviews--title"><?php echo $banner['name']; ?></h2> <!-- Заголовок статьи -->
                    <p class="page_blog--carousel_block-reviews--date"><i class="fa fa-clock-o"></i><?php echo $banner['date_added']; ?></p> <!-- Дата добавления -->
                    <p class="page_blog--carousel_block-reviews--description"><?php echo (!empty($banner['description_mini']) ? $banner['description_mini'] : $banner['description']); ?></p>
                </div>
                <div class="under-color page_blog--carousel_block-reviews--btn"><a class="button button-more" href="<?php echo $banner['href']; ?>">подробнее</a></div>
            </div>
        <?php } ?>
    </div>
    <script type="text/javascript"><!--
        $('#slideshow').owlCarousel({
            items: <?php echo count($latest_articles); ?>,
            autoPlay: false,
            singleItem: true,
            navigation: true,
            navigationText: ['<i class="fa fa-chevron-left"></i>','<i class="fa fa-chevron-right"></i>'],
            autoHeight:true,
            pagination: false
        });
--></script>
<?php } ?>
<!-- тут будет слайдер с последними статьями -->

        <!-- ocshop <?php if ($thumb || $description) { ?>
<div class="category-info">
<?php if ($thumb) { ?>
<div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div>
<?php } ?>
<?php if ($description) { ?>
<?php echo $description; ?>
<?php } ?>
</div>
<?php } ?>
-->
<?php if ($categories) { ?>
    <?php if ($news_id != 0) { ?>
        <h2><?php echo $text_refine; ?></h2>
        <div class="category-list">
            <?php if (count($categories) <= 5) { ?>
                <ul>
                    <?php foreach ($categories as $news) { ?>
                        <li><a href="<?php echo $news['href']; ?>"><?php echo $news['name']; ?></a></li>
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
        </div>
    <?php } ?>
<?php } ?>
<?php if ($articles) { ?>

    <div class="pagination-top">

        <div class="limit" id="sort-toggle">
            <div>
                <p>сортировать:
                    <span></span>
                </p>

                <select class="form-control hide" onchange="location = this.value;">
                    <?php foreach ($limits as $limits) { ?>
                        <?php if ($limits['value'] == $limit) { ?>
                            <option class="hide" value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
                        <?php } else { ?>
                            <option class="hide" value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
                        <?php } ?>
                    <?php } ?>
                </select>
            </div>
        </div>

        <div class="sort" id="limit-toggle">
            <p>показать:
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


    <!-- ocshop -->
    <div class="product-list page_blog--product-list">
        <?php foreach ($articles as $article) { ?>
            <div class="page_blog--product-list_wrapp-content clearfix ">
                <?php if ($article['thumb']) { ?>
                    <div class="image col-md-5 clearfix "><a href="<?php echo $article['href']; ?>"><img src="<?php echo $article['thumb']; ?>" title="<?php echo $article['name']; ?>" alt="<?php echo $article['name']; ?>" /></a>

                    </div>
                <?php } ?>
                <div class="page_blog--product-list_wrapp-content--text col-md-7">
                    <div class="name"><a href="<?php echo $article['href']; ?>"><?php echo $article['name']; ?></a><div class="added-viewed"><i class="fa fa-clock-o"></i> <?php echo $article["date_added"];?>&nbsp;&nbsp;&nbsp;<i class="fa fa-eye"></i> <?php echo $text_views; ?> <?php echo $article["viewed"];?></div></div>
                    <div class="description"><?php echo $article['description']; ?></div>
                    <div class="under-color page_blog--carousel_block-reviews--btn"><a class="button_1 button-more" href="<?php echo $article['href']; ?>"><?php echo $button_more; ?></a></div>
                    
                    <div class="rating brating">
                        <?php for ($i = 1; $i <= 5; $i++) { ?>
                            <?php if ($article['rating'] < $i) { ?>
                                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                            <?php } else { ?>
                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                            <?php } ?>
                        <?php } ?>
                    </div>
                </div>
            </div>
        <?php } ?>
    </div>
    <div class="pagination"><?php echo $pagination; ?></div>
<?php } ?>

<?php if (!$categories && !$articles) { ?>
    <div class="content"><?php echo $text_empty; ?></div>
    <div class="buttons">
        <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
    </div>
<?php } ?>
<?php echo $content_bottom; ?></div>
<!-- ocshop -->
<?php if ($thumb || $description) { ?>
<div class="category-info">
    <?php if ($thumb) { ?>
        <div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div>
    <?php } ?>
    <?php if ($description) { ?>
        <?php echo $description; ?>
    <?php } ?>
</div>
<?php } ?>

<?php echo $content_bottom; ?>

</section>

<?php if( $SPAN[2] ): ?>
        <aside class="col-lg-<?php echo $SPAN[2];?> col-md-<?php echo $SPAN[2];?> col-sm-12 col-xs-12 title-page-blog--box-heading">
            <?php echo $column_right; ?>
        </aside>
<?php endif; ?>

    <script type="text/javascript">
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

    function toggleSelection(but, el1, el2) {
    $(but).on('click', function() {
    $(el1).slideToggle(200);
    $(el2).slideUp(200);
    });
    };

    toggleSelection('#limit-toggle', '.limit-block', '.sort-block');
    toggleSelection('#sort-toggle', '.sort-block', '.limit-block');
    $("#limit-toggle").click(function(){
    $(".overlay").addClass(".span-rotate");
    },function(){
    $(".overlay").removeClass(".span-rotate");
    })


    </script>

<?php echo $footer; ?>