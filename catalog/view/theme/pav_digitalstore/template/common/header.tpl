<?php
/******************************************************
 * @package Pav Opencart Theme Framework for Opencart 1.5.x
 * @version 1.1
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Augus 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/


	$themeConfig = $this->config->get( 'themecontrol' );
	$themeName =  $this->config->get('config_template');
	require_once( DIR_TEMPLATE.$this->config->get('config_template')."/development/libs/framework.php" );
	$helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
	$helper->setDirection( $direction );
	/* Add scripts files */
	//$helper->addScript( 'catalog/view/javascript/jquery/jquery-1.7.1.min.js' );
	$helper->addScript( 'catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js' );
	$helper->addScript( 'catalog/view/javascript/jquery/ui/external/jquery.cookie.js' );
	$helper->addScript( 'catalog/view/javascript/common.js' );
	$helper->addScript( 'catalog/view/theme/'.$themeName.'/javascript/common.js' );
	$helper->addScript( 'catalog/view/javascript/jquery/bootstrap/bootstrap.min.js' );
	$helper->addScript( 'catalog/view/theme/'.$themeName.'/javascript/update1.js' );
	
	$helper->addScriptList( $scripts );

	$helper->addCss( 'catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css' );
	if( isset($themeConfig['customize_theme'])
		&& file_exists(DIR_TEMPLATE.$themeName.'/stylesheet/customize/'.$themeConfig['customize_theme'].'.css') ) {
		$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/customize/'.$themeConfig['customize_theme'].'.css'  );
	$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/animation.css' );
	$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/font-awesome.min.css' );
	$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/font.css' );
	$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/font.css' );
	$helper->addCssList( $styles );
	$layoutMode = $helper->getParam( 'layout' );
	}



?>
<!DOCTYPE html>
<html dir="<?php echo $helper->getDirection(); ?>" class="<?php echo $helper->getDirection(); ?>" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title><?php echo $title; ?></title>
<meta name="robots" content="noindex, nofollow" />

<meta name="viewport" content="width=device-width">
<base href="http://localhost/" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<meta name='yandex-verification' content='611bd5a2699bede2' />
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>

<link type="text/css" href="/catalog/view/theme/pav_digitalstore/stylesheet/animation.css" rel="stylesheet" />
<link type="text/css" href="/catalog/view/theme/pav_digitalstore/stylesheet/font-awesome.min.css" rel="stylesheet" />

<script src="/catalog/view/javascript/jquery/jquery-1.7.1.min.js"></script>

<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<!-- OCdev Smart Checkout : 1.0.4 -->
<link rel="stylesheet" type="text/css" href="/catalog/view/theme/default/stylesheet/ocdev_smart_checkout/stylesheet.css?v=1.0.4" />
<script type="text/javascript" src="/catalog/view/javascript/ocdev_smart_checkout/ocdev_smart_checkout.js?v=1.0.4"></script>
<script type="text/javascript" src="/catalog/view/javascript/ocdev_smart_checkout/jquery.placeholder.js?v=1.0.4"></script>
<script type="text/javascript" src="/catalog/view/theme/pav_digitalstore/javascript/mask.js"></script>
<link type="text/css" href="/catalog/view/theme/pav_digitalstore/stylesheet/sizes.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="/catalog/view/javascript/jquery/owl-carousel/owl.carousel.css" />
<link rel="stylesheet" type="text/css" href="/catalog/view/javascript/flipclock/flipclock.css" />
<!-- OCdev Smart Checkout : 1.0.4 -->
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<link rel="stylesheet" type="text/css" href="/catalog/view/javascript/jquery/fancybox/jquery.fancybox.css" media="screen" />
<?php } ?>
<?php foreach ($helper->getCssLinks() as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />

<?php } ?>

	<?php if( $themeConfig['theme_width'] &&  $themeConfig['theme_width'] != 'auto' ) { ?>
			<style> #page-container .container{max-width:<?php echo $themeConfig['theme_width'];?>; width:auto}</style>
	<?php } ?>

	<?php if( isset($themeConfig['use_custombg']) && $themeConfig['use_custombg'] ) {	?>
	<style>
		body{
			background:url( "image/<?php echo $themeConfig['bg_image'];?>") <?php echo $themeConfig['bg_repeat'];?>  <?php echo $themeConfig['bg_position'];?> !important;
		}</style>
	<?php } ?>
<?php
	if( isset($themeConfig['enable_customfont']) && $themeConfig['enable_customfont'] ){
	$css=array();
	$link = array();
	for( $i=1; $i<=3; $i++ ){
		if( trim($themeConfig['google_url'.$i]) && $themeConfig['type_fonts'.$i] == 'google' ){
			$link[] = '<link rel="stylesheet" type="text/css" href="'.trim($themeConfig['google_url'.$i]) .'"/>';
			$themeConfig['normal_fonts'.$i] = $themeConfig['google_family'.$i];
		}
		if( trim($themeConfig['body_selector'.$i]) && trim($themeConfig['normal_fonts'.$i]) ){
			$css[]= trim($themeConfig['body_selector'.$i])." {font-family:".str_replace("'",'"',htmlspecialchars_decode(trim($themeConfig['normal_fonts'.$i])))."}\r\n"	;
		}
	}
	echo implode( "\r\n",$link );
?>
<style>
	<?php echo implode("\r\n",$css);?>
</style>
<?php } else { ?>
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800&amp;subset=latin,cyrillic-ext' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Open+Sans+Condensed:300,300italic,700&amp;subset=latin,cyrillic-ext' rel='stylesheet' type='text/css'>
<?php } ?>
<?php foreach( $helper->getScriptFiles() as $script )  { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>

<?php if( isset($themeConfig['custom_javascript'])  && !empty($themeConfig['custom_javascript']) ){ ?>
	<script type="text/javascript"><!--
		$(document).ready(function() {
			<?php echo html_entity_decode(trim( $themeConfig['custom_javascript']) ); ?>
		});
//--></script>
<?php }	?>

<!--[if lt IE 9]>
<?php if( isset($themeConfig['load_live_html5'])  && $themeConfig['load_live_html5'] ) { ?>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<?php } else { ?>
<script src="catalog/view/javascript/html5.js"></script>
<?php } ?>
<script src="catalog/view/javascript/respond.min.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/<?php echo $themeName;?>/stylesheet/ie8.css" />
<![endif]-->

<?php if ( isset($stores) && $stores ) { ?>
<script type="text/javascript"><!--
$(document).ready(function() {
<?php foreach ($stores as $store) { ?>
$('body').prepend('<iframe src="<?php echo $store; ?>" style="display: none;"></iframe>');
<?php } ?>
});
//--></script>
<?php } ?>

<script type="text/javascript" src="/catalog/view/javascript/jquery/fancybox/jquery.fancybox.pack.js"></script>

<link type="text/css" href="/catalog/view/theme/pav_digitalstore/stylesheet/blog.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="/catalog/view/theme/pav_digitalstore/stylesheet/template-responsive.css" />
<script type="text/javascript" src="/catalog/view/javascript/modernizr-custom.js"></script>
<script type="text/javascript" src="catalog/view/javascript/ajax_product_loader.js"></script>

    <!-- test analytics -->
    <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-102072981-1', 'auto');
        ga('send', 'pageview');

    </script>
    <!-- test analytics -->

</head>
<body id="offcanvas-container" class="offcanvas-container layout-<?php if(isset($layoutMode)) {echo $layoutMode;} ?> fs<?php echo $themeConfig['fontsize'];?> <?php echo $helper->getPageClass();?> <?php echo $helper->getParam('body_pattern','');?>">
<!-- верхняя плашка с информацией на праздники -->
<!-- <div class="holiday-text">Дорогие и любимые девушки, поздравляем Вас с 8 Марта и сообщаем, что интернет-магазин работает 8.03 до 14:00 </div> -->
<!-- END верхняя плашка с информацией на праздники -->
<p class="shows visible-xs visible-sm"><i class="fa fa-bars"></i>фильтр товаров</p>

<div class="modal2f"></div>

<section id="page" class="offcanvas-pusher clearfix" role="main">

<section id="topbar" class="hidden-sm hidden-xs">
	<div class="container">
		<div class="row">
<!-- for desktop PC -->
			<div class="col-lg-4 col-md-4 ">
				<ul class="links pull-left">
					<li><a class="first" href="<?php echo $home; ?>"><?php echo $text_home; ?></a></li>
					<li><a class="delivery" href="/delivery"><?php echo 'оплата и доставка' ?></a></li>
					<li><a class="contacts" href="/contacts"><?php echo 'Точки продаж' ?></a></li>
				</ul>

			</div>
<!-- блок телефонов в шапке -->
			<div class="col-lg-4  hidden-sm hidden-xs pull-left header-block-phone">
				<div class="quick-user top-center">
					<div class="inner-toggle">
						<div class="tel_in_header ringo-href">
							<div class="ringo-phone" style="display: inline;">
								<span>&nbsp;
									<img alt="kyivstar" src="/image/data/icon/iconkyivstar.png"/>&nbsp;
								</span>
									<a style="color:#fff; vertical-align:middle;" href="tel:0984047878"><b>(098)</b> 404 78 78</a>
								<span>&nbsp;&nbsp;
									<img alt="life" src="/image/data/icon/icon_life.png"/>&nbsp;
								</span>
									<a style="color:#fff; vertical-align:middle;" href="tel:0934147878"><b>(093)</b> 414 78 78</a>
								<span>&nbsp;&nbsp;
									<img alt="mts" src="/image/data/icon/mts.png"/>&nbsp;
								</span>
									<a style="color:#fff; vertical-align:middle;" href="tel:0994347878"><b>(099)</b> 434 78 78</a>
							</div>
						</div>
					</div>
				</div>
			</div>
  			<div class="col-lg-4 col-md-5 hidden-xs last11">
				<?php echo $cart; ?>
				<div class="welcome pull-right">
					<?php if (!$logged) { ?>
					    <?php echo '<a href="/register">Регистрация</a><a href="/index.php?route=account/login">Вход</a>' ?>
					<?php } else { ?>
                        <?php echo 'БОНУСНЫЕ ГРИВНЫ: '.($user_points > 0 ? $user_points : 0); ?>
                        <?php echo $text_logged; ?>
					<?php } ?>
				</div>
			</div>
     </div>   <!-- end row -->
	</div>  <!-- end container -->
</section>
<!-- for TABLET -->
<section id="topbar" class="clearfix hidden-lg hidden-md hidden-xs">
	<div class="container">
		<div class="row">

<!-- top bar header -->
			<div class="col-sm-12 hidden-xs clearfix last11">
				<ul class="links pull-left">
					<li><a class="first" href="<?php echo $home; ?>"><?php echo $text_home; ?></a></li>
					<li><a class="delivery" href="/delivery"><?php echo 'оплата и доставка' ?></a></li>
					<li><a class="contacts" href="/contacts"><?php echo 'Точки продаж' ?></a></li>

          <?php if (!$logged) { ?>
          <li><a class="contacts" href="/register"><?php echo 'Регистрация' ?></a></li>
          <li><a class="contacts" href="/index.php?route=account/login"><?php echo 'Вход' ?></a></li>
          <?php } else { ?>
          <li><a class="contacts" href="#"><?php echo $text_logged; ?></a></li>
          <?php } ?>
				</ul>
		      <?php echo $cart; ?>
			</div>
     </div>   <!-- end row -->
	</div>  <!-- end container -->
</section>
</section>

<!-- main center header -->

<section id="header" class="hidden-lg hidden-md hidden-xs clearfix">
  <div class="container">
    <div class="row">
        <div class="col-sm-4 fix_paddingLR15">
          <div id="logo_position">
                <?php if ($logo) { ?>
                <div id="logo_wrapper"><div id="logo"><img src="<?php echo $logo; ?>" title="Интернет-магазин спортивной одежды - Лотто Спорт" alt="Интернет-магазин Lotto-Sport" /></div></div>
                <?php } ?>
          </div><!-- end col header logo-->
        </div>
        <div class="col-sm-8 fix_paddingLR15 ">
          <div class="col-sm-12 fix_paddingLR15">
            <div id="sm_block_tel" class="ringo-href">
              <ul class="ringo-phone">
                <li><img alt="kyivstar" src="/image/data/icon/sm_kiev.png"/>&nbsp;<a href="tel:0984047878"><b>(098)</b> 404 78 78</a></li>
                <li><img alt="life" src="/image/data/icon/sm_lifecell.png"/>&nbsp;<a href="tel:0934147878"><b>(093)</b> 414 78 78</a></li>
                <li><img alt="mts" src="/image/data/icon/sm_mts.jpg"/>&nbsp;<a href="tel:0994347878"><b>(099)</b> 434 78 78</a></li>
              </ul>
            </div>
          </div>
          <div class="col-sm-12 fix_paddingLR15">
            <!-- SM search input icon -->
            <div id="search_in_header" >
              <div class="menu-icon-search ">
                <form class="form-inline">
                  <div class="form-group">
                        <div class="input-group">
                            <input class="form-control" type="text" name="search" placeholder="Поиск по сайту" value="<?php echo $search; ?>" />
                            <div class="input-group-addon"><div class="button_search"><i class="fa fa-search" aria-hidden="true"></i></div></div>
                      </div>
                    </div>
                  </form>
              </div>
            </div>
          </div>
        </div>
    </div><!--  end  row -->
    <!-- SM main menu -->
    <div class="row">
    <div id="pav-mainnav" class="col-sm-12 fix_paddingLR15">
        <div class="mainnav-wrap">
          <div class="navbar navbar-inverse ">
            <nav id="mainmenutop" class="pav-megamenu" role="navigation">
              <?php
              /**
               * Main Menu modules: as default if do not put megamenu, the theme will use categories menu for main menu
               */
              $modules = $helper->getModulesByPosition( 'mainmenu' );
              if( count($modules) && !empty($modules) ){
              ?>
                <?php foreach ($modules as $module) { ?>
                  <?php echo $module; ?>
                <?php } ?>
              <?php } elseif ($categories) {  ?>
              <!-- dell was here -->
              <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                </button>
              </div>
              <div class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav">
                  <li><a href="<?php echo $home; ?>" title="<?php echo $this->language->get('text_home');?>"><?php echo $this->language->get('text_home');?></a></li>
                  <?php foreach ($categories as $category) { ?>

                  <?php if ($category['children']) { ?>
                  <li class="parent dropdown deeper "><a href="<?php echo $category['href'];?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?></a>
                  <?php } else { ?>
                  <li ><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
                  <?php } ?>
                  <?php if ($category['children']) { ?>
                    <ul class="dropdown-menu">
                    <?php for ($i = 0; $i < count($category['children']);) { ?>

                      <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
                      <?php for (; $i < $j; $i++) { ?>
                      <?php if (isset($category['children'][$i])) { ?>
                      <li><a href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a></li>
                      <?php } ?>
                      <?php } ?>
                    <?php } ?>
                  </ul>
                    <?php } ?>
                  </li>
                  <?php } ?>
                  </ul>
              </div>
              <?php } ?>
            </nav>
          </div>
        </div>
    </div><!-- end col main menu-->
  </div><!-- end row main menu-->
  </div><!--  end  container -->
</section>
<!--  end  Tablet -->
<!-- * * * * * * * * * * * * * *  -->
<!-- XS Mobile -->
<section class="visible-xs hidden-sm hidden-md hidden-lg">
  <div class="container">
    <div class="row">
      <div id="xs_top_menu" class="col-xs-12 fix_paddingLR15 clearfix">
        <div id="xs_top_bar1" class="pull-left"><i class="fa fa-bars" aria-hidden="true"></i></div>
        <div id="xs_top_bar" class="pull-left"><i class="fa fa-share-alt" aria-hidden="true"></i></div>
<!-- fa-share-alt -->
        <div id="xs_cart" class="pull-left"><a href="/checkout"><i class="fa fa-shopping-cart" aria-hidden="true"></i></a>
            <div id="cart_index"><?php echo $mini_cart_prod_amount; ?></div>
        </div>
        <div id="xs_search" >
          <form class="form-inline">
            <div class="form-group">
                  <div class="input-group">
                      <input class="form-control" type="text" name="search1" placeholder="Поиск ..." value="<?php echo $search; ?>" />
                      <div class="input-group-addon">
                        <div class="button_search"><i class="fa fa-search" aria-hidden="true"></i></div>
                      </div>
                </div>
              </div>
            </form>
        </div>
      </div><!-- end col-xs-12 -->
      <div id = "xs_header">
        <div id="xs_logo">

            <?php if ($logo) { ?>
              <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="Интернет-магазин спортивной одежды - Лотто Спорт" alt="Интернет-магазин Lotto-Sport" /></a>
            <?php } ?>
          </div>

          <div id="xs_block_tel" class="ringo-href">
            <ul class="ringo-phone">
			  <li><img alt="kyivstar" src="/image/data/icon/xs_kiev.png"/>&nbsp;<a href="tel:0984047878"><b>(098)</b> 404 78 78</a></li>
			  <li><img alt="life" src="/image/data/icon/xs_lifecell.png"/>&nbsp;<a href="tel:0934147878"><b>(093)</b> 414 78 78</a></li>
              <li><img alt="mts" src="/image/data/icon/xs_mts.png"/>&nbsp;<a href="tel:0994347878"><b>(099)</b> 434 78 78</a></li>
            </ul>
          </div>

      </div>
      <!--  -->
    </div><!-- end row XS -->
  </div><!-- end container XS -->
</section><!-- end Section XS -->
<!-- toggle menu -->
<div id="xs_toggle_menu" style="display:none;">
  <ul >
    <li><a href="<?php echo $home; ?>"><?php echo $text_home; ?></a></li>
    <li><a href="/delivery"><?php echo 'оплата и<br>доставка' ?></a></li>
    <li><a href="/contacts"><?php echo 'Точки<br>продаж' ?></a></li>
    <?php if (!$logged) { ?>
    <li><a href="=/register"><?php echo 'Регистрация' ?></a></li>
    <li><a href="/index.php?route=account/login"><?php echo 'Вход' ?></a></li>
    <?php } else { ?>
    <li><a href="#"><?php echo $text_logged; ?></a></li>
    <?php } ?>
  </ul>
</div>

<!-- LG MD middle header  block -->
<section id="header" class="hidden-sm hidden-xs">
	<div class="container">
    <!--  -->
      <div class="row">
        <div id="logo_position" class="col-lg-3 col-md-2 hidden-xs hidden-sm" style="z-index: 1;">
              <?php if ($logo) { ?>
                  <?php if ($og_url == $home) { ?>
                    <div id="logo_wrapper"><div id="logo"><img src="<?php echo $logo; ?>" title="Интернет-магазин спортивной одежды - Лотто Спорт" alt="Интернет-магазин Lotto-Sport" /></div></div>
                  <?php } else { ?>
                    <div id="logo_wrapper"><div id="logo"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="Интернет-магазин спортивной одежды - Лотто Спорт" alt="Интернет-магазин Lotto-Sport" /></a></div></div>
                  <?php } ?>
              <?php } ?>
        </div><!-- end col header logo-->
       <div class="col-lg-9 col-md-10 fix_paddingLR15 clearfix">
        <div class="col-lg-3 col-lg-offset-9 col-md-3 col-md-offset-9 hidden-xs hidden-sm fix_paddingLR15 clearfix">
          <!-- search input icon -->
          <div id="search_in_header2" >
            <div class="menu-icon-search pull-right">
              <form class="form-inline">
                <div class="form-group">
                      <div class="input-group">
                          <input class="form-control" type="text" name="search2" placeholder="Поиск по сайту" value="<?php echo $search; ?>" />
                          <div class="input-group-addon"><div id="button_search"><i class="fa fa-search" aria-hidden="true"></i></div></div>
                    </div>
                  </div>
                </form>
            </div>
          </div>
        </div><!-- end col search-->
        <div class="clearfix"></div>
        <div id="pav-mainnav" class="col-lg-12 col-md-12 fix_paddingLR15">
  					<div class="mainnav-wrap">
  						<div class="navbar navbar-inverse ">
  							<nav id="mainmenutop" class="pav-megamenu" role="navigation">
  								<?php
  								/**
  								 * Main Menu modules: as default if do not put megamenu, the theme will use categories menu for main menu
  								 */
  								$modules = $helper->getModulesByPosition( 'mainmenu' );
  								if( count($modules) && !empty($modules) ){
  								?>
  									<?php foreach ($modules as $module) { ?>
  										<?php echo $module; ?>
  									<?php } ?>
  								<?php } elseif ($categories) {  ?>
  									<div class="navbar-header">
  										<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
  										<span class="sr-only">Toggle navigation</span>
  										<span class="icon-bar"></span>
  										<span class="icon-bar"></span>
  										<span class="icon-bar"></span>
  										</button>
  									</div>
  									<div class="collapse navbar-collapse navbar-ex1-collapse">
  											  <ul class="nav navbar-nav">
  											<li><a href="<?php echo $home; ?>" title="<?php echo $this->language->get('text_home');?>"><?php echo $this->language->get('text_home');?></a></li>
  											<?php foreach ($categories as $category) { ?>

  											<?php if ($category['children']) { ?>
  											<li class="parent dropdown deeper "><a href="<?php echo $category['href'];?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?></a>
  											<?php } else { ?>
  											<li ><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
  											<?php } ?>
  											<?php if ($category['children']) { ?>
  											  <ul class="dropdown-menu">
  												<?php for ($i = 0; $i < count($category['children']);) { ?>

  												  <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
  												  <?php for (; $i < $j; $i++) { ?>
  												  <?php if (isset($category['children'][$i])) { ?>
  												  <li><a href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a></li>
  												  <?php } ?>
  												  <?php } ?>
  												<?php } ?>
  											</ul>
  											  <?php } ?>
  											</li>
  											<?php } ?>
  										  </ul>
  									</div>
  								<?php } ?>
  							</nav>
  						</div>
  					</div>
  			</div><!-- end col main menu-->
      </div><!-- end col search + col main menu-->
    </div><!-- end row -->
	</div><!-- end container -->
</section>

<!-- XS accordeon -->
<section id="xs_akordeon" style="display:none;">
  <div class="xs_wrapper">
  <?php echo $menu_tree; ?>
  </div><!-- end wrapper akordeon -->
</section><!-- end id akordeon -->

<script>
    $(window).scroll(function(){
        if ($(this).scrollTop() > 40) {
            $('#topbar').addClass('navbar-fixed-top');
        }
        else {
            $('#topbar').removeClass('navbar-fixed-top');
        }
    });
</script>



<?php
/**
 * Slideshow modules
 */
$modules = $helper->getModulesByPosition( 'slideshow' );
if( $modules ){
?>
<section id="pav-slideshow" class="pav-slideshow">
		<?php foreach ($modules as $module) { ?>
			<?php echo $module; ?>
		<?php } ?>
</section>
<?php } ?>

<?php
/**
 * Promotion modules
 * $ospans allow overrides width of columns base on thiers indexs. format array( column-index=>span number ), example array( 1=> 3 )[value from 1->12]
 */
$modules = $helper->getModulesByPosition( 'showcase' );
$ospans = array();

if( count($modules) ){
$cols = isset($config['block_showcase'])&& $config['block_showcase']?(int)$config['block_showcase']:count($modules);
$class = $helper->calculateSpans( $ospans, $cols );
?>
<section class="pav-showcase" id="pavo-showcase">
	<div class="container">
	<?php $j=1;foreach ($modules as $i =>  $module) {  ?>
			<?php if(  $i++%$cols == 0 || count($modules)==1  ){  $j=1;?><div class="row"><?php } ?>
			<div class="<?php echo $class[$j];?>"><?php echo $module; ?></div>
			<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>
	<?php  $j++;  } ?>
	</div>
</section>
<?php } ?>
<?php
/**
 * Promotion modules
 * $ospans allow overrides width of columns base on thiers indexs. format array( 1=> 3 )[value from 1->12]
 */
$modules = $helper->getModulesByPosition( 'promotion' );
$ospans = array();

if( count($modules) ){
$cols = isset($config['block_promotion'])&& $config['block_promotion']?(int)$config['block_promotion']:count($modules);
$class = $helper->calculateSpans( $ospans, $cols );
?>
<section class="pav-promotion" id="pav-promotion">
	<div class="container">
	<?php $j=1;foreach ($modules as $i =>  $module) {  ?>
			<?php if( $i++%$cols == 0 || count($modules)==1 ){  $j=1;?><div class="row"><?php } ?>
			<div class="<?php echo $class[$j];?>"><?php echo $module; ?></div>
			<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>
	<?php  $j++;  } ?>
	</div>
</section>
<?php } ?>
<section id="sys-notification">
	<div class="container">

		<?php if ($error) { ?>
    		<div class="warning"><?php echo $error ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
    	<?php } ?>

		<div id="notification"></div>
	</div>
</section>



	<?php if( isset($themeConfig['enable_offsidebars']) && $themeConfig['enable_offsidebars'] ) { ?>
	<section id="columns" class="offcanvas-siderbars"><div class="container">
	<div class="row visible-xs"><div class="container">
		<div class="offcanvas-sidebars-buttons">
			<button type="button" data-for="column-left" class="pull-left btn btn-danger"><i class="glyphicon glyphicon-indent-left"></i> <?php echo $this->language->get('text_sidebar_left'); ?></button>

			<button type="button" data-for="column-right" class="pull-right btn btn-danger"><?php echo $this->language->get('text_sidebar_right'); ?> <i class="glyphicon glyphicon-indent-right"></i></button>
		</div>
	</div></div>
	<?php }else { ?>
	<section id="columns"><div class="container">
	<?php } ?>
	<div class="row">
