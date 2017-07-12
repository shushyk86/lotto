<?php  
class ControllerModuleSmartSlider extends Controller {

	protected function index($setting) {
		static $module = 0;
		//var_dump($setting['mobile_status']); echo '======='; return;
		
		if(isset($setting['mobile_status']) AND !$setting['mobile_status']){
			require_once DIR_APPLICATION. 'controller/module/mobile_detect.php';
			$detect = new Mobile_Detect;
			$isMobile = ($detect->isMobile() ? true : false);
			if($isMobile){ return; }
		}
		
		//$this->document->addScript('catalog/view/javascript/jquery/jquery.jcarousel.min.js');
		//$this->document->addStyle('catalog/view/theme/default/stylesheet/carousel.css');
		
		// add slider start
		list($this->data['sl_init'],  $this->data['sl_script']) = $this->creatSlider($setting['slider_id']);

		$this->data['module'] = $module++; 

		$this->template = 'default/template/module/smartslider.tpl';
		
		$this->render(); 
	}
	
	private function clearSpecChar($slider){
		//var_dump($slider['layers']);
		
		if(isset($slider['layers']) AND count($slider['layers'])){
			foreach($slider['layers'] as &$layer){
				if(!(isset($layer['sublayers']) AND count($layer['sublayers'])))continue;
				foreach($layer['sublayers'] as &$sublayer){
					$sublayer['html'] = htmlspecialchars_decode($sublayer['html']);
				}
			}
		}
		unset($layer);
		unset($sublayer);
		//htmlspecialchars_decode(
		return $slider;
	}
	
	// function for slider
	public function creatSlider($slider_id, $store_id='') {
		
	// out data
		$sl_init = '';
		$sl_script = '';
		
	// get data sliders
		$slider = $this->getSliderFromId($slider_id);
		$slider = $this->clearSpecChar($slider);
	// get data products in slider
		$productsForSlider = $this->getProductsForSlider($slider);

		//var_dump($productsForSlider );
		
		
		$layerSkinPath = HTTP_SERVER."catalog/view/theme/default/stylesheet/smartslider/smartskins/";
		$layerLabelPath = HTTP_SERVER."catalog/view/theme/default/stylesheet/smartslider/smartlabel/";

		$imagePath = HTTP_SERVER."image/";
		//var_dump( $productsForSlider);
		
		if(!defined('NL')) {
			define("NL", "\r\n");
		}

		if(!defined('TAB')) {
			define("TAB", "\t");
		}

		$sl_script .= NL .'<script src="catalog/view/javascript/smartslider/slider_engine.js"></script>'. NL;
		$sl_script .= NL .'<script src="catalog/view/javascript/smartslider/smartslider.min.js"></script>'. NL;
		$sl_script .= NL .'<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/smartslider/smartslider.css" />'. NL;

		
		$sl_init .= NL . '<script type="text/javascript">' . NL;

		$sl_init .= NL . 'var productsForSlider 	= '.json_encode( $productsForSlider ).';'. NL;
		$sl_init .= NL . 'var getSlides			= function(){return '.json_encode( $slider ).';}'. NL;
		$sl_init .= NL . 'var mainImagePath		= "image/"'. NL;
		$sl_init .= NL . 'var layerLabelPath		= "'.$layerLabelPath .'"'. NL;
		
		$sl_init .= TAB . 'function smartSliderStart(parallax) { ' . NL;

		$sl_init .= TAB . TAB .'jQuery("#smartslider").smartSlider({ ' . NL;
		$sl_init .= TAB . TAB . TAB . 'parallaxIn : parallax,' . NL;
		$sl_init .= TAB . TAB . TAB . 'parallaxOut : parallax,' . NL;
		$sl_init .= TAB . TAB . TAB . 'width : \''.$this->layerslider_check_unit($slider['properties']['width']).'\',' . NL;
		$sl_init .= TAB . TAB . TAB . 'height : $("#smartslider").height(),'. NL; /* //(height_auto) */
		$sl_init .= TAB . TAB . TAB . 'responsive : '; $sl_init .= isset($slider['properties']['responsive']) ? 'true' : 'false'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'responsiveUnder : '; $sl_init .= !empty($slider['properties']['responsiveunder']) ? $slider['properties']['responsiveunder'] : '0'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'sublayerContainer : '; $sl_init .= !empty($slider['properties']['sublayercontainer']) ? $slider['properties']['sublayercontainer'] : '0'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'autoStart : '; $sl_init .= ( isset($slider['properties']['autostart']) && $slider['properties']['autostart'] != 'false') ? 'true' : 'false'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'pauseOnHover : '; $sl_init .= ( isset($slider['properties']['pauseonhover']) && $slider['properties']['pauseonhover'] != 'false') ? 'true' : 'false'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'firstLayer : '; $sl_init .= is_numeric($slider['properties']['firstlayer']) ? $slider['properties']['firstlayer'] : '\'random\''; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'animateFirstLayer : '; $sl_init .= ( isset($slider['properties']['animatefirstlayer']) && $slider['properties']['animatefirstlayer'] != 'false') ? 'true' : 'false'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'randomSlideshow : '; $sl_init .= ( isset($slider['properties']['randomslideshow']) && $slider['properties']['randomslideshow'] != 'false') ? 'true' : 'false'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'twoWaySlideshow : '; $sl_init .= ( isset($slider['properties']['twowayslideshow']) && $slider['properties']['twowayslideshow'] != 'false') ? 'true' : 'false'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'keybNav : '; $sl_init .= ( isset($slider['properties']['keybnav']) && $slider['properties']['keybnav'] != 'false') ? 'true' : 'false'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'touchNav : '; $sl_init .= ( isset($slider['properties']['touchnav']) && $slider['properties']['touchnav'] != 'false') ? 'true' : 'false'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'imgPreload : '; $sl_init .= ( isset($slider['properties']['imgpreload']) && $slider['properties']['imgpreload'] != 'false') ? 'true' : 'false'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'navPrevNext : '; $sl_init .= ( isset($slider['properties']['navprevnext']) && $slider['properties']['navprevnext'] != 'false') ? 'true' : 'false'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'navStartStop : ';  $sl_init .= ( isset($slider['properties']['navstartstop']) && $slider['properties']['navstartstop'] != 'false') ? 'true' : 'false'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'navButtons : '; $sl_init .= ( isset($slider['properties']['navbuttons']) && $slider['properties']['navbuttons'] != 'false') ? 'true' : 'false'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'hoverPrevNext : '; $sl_init .= ( isset($slider['properties']['hoverprevnext']) && $slider['properties']['hoverprevnext'] != 'false') ? 'true' : 'false'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'hoverBottomNav : '; $sl_init .= ( isset($slider['properties']['hoverbottomnav']) && $slider['properties']['hoverbottomnav'] != 'false') ? 'true' : 'false'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'thumbnailNavigation : \''; $sl_init .= !empty($slider['properties']['thumb_nav']) ? $slider['properties']['thumb_nav'] : 'hover'; $sl_init .= '\','. NL;
		$sl_init .= TAB . TAB . TAB . 'tnWidth : \''; $sl_init .= !empty($slider['properties']['thumb_width']) ? $slider['properties']['thumb_width'] : '100'; $sl_init .= '\','. NL;
		$sl_init .= TAB . TAB . TAB . 'tnHeight : \''; $sl_init .= !empty($slider['properties']['thumb_height']) ? $slider['properties']['thumb_height'] : '60'; $sl_init .= '\','. NL;
		$sl_init .= TAB . TAB . TAB . 'tnContainerWidth : \''; $sl_init .= !empty($slider['properties']['thumb_container_width']) ? $slider['properties']['thumb_container_width'] : '60%'; $sl_init .= '\','. NL;
		$sl_init .= TAB . TAB . TAB . 'tnActiveOpacity : '; $sl_init .= !empty($slider['properties']['thumb_active_opacity']) ? $slider['properties']['thumb_active_opacity'] : '35'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'tnInactiveOpacity : '; $sl_init .= !empty($slider['properties']['thumb_inactive_opacity']) ? $slider['properties']['thumb_inactive_opacity'] : '100'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'skin : \''; $sl_init .= $slider['properties']['skin']; $sl_init .= '\','. NL;
		$sl_init .= TAB . TAB . TAB . 'skinsPath : \''; $sl_init .= $layerSkinPath; $sl_init .= '\','. NL;

		if(!empty($slider['properties']['backgroundcolor'])) :
			$sl_init .= TAB . TAB . TAB . 'globalBGColor : \''; $sl_init .= $slider['properties']['backgroundcolor']; $sl_init .= '\','. NL;
			endif;
		if(!empty($slider['properties']['backgroundimage'])) :
			$sl_init .= TAB . TAB . TAB . 'globalBGImage : \''; $sl_init .= !empty($slider['properties']['backgroundimage']) ? $imagePath . $slider['properties']['backgroundimage'] : 'false'; $sl_init .= '\','. NL;
			endif;

		$sl_init .= TAB . TAB . TAB . 'yourLogo : '; $sl_init .= !empty($slider['properties']['yourlogo']) ? '\''. $imagePath . $slider['properties']['yourlogo'].'\'' : 'false'; $sl_init .= ','. NL;
		
		$sl_init .= TAB . TAB . TAB . 'yourLogoStyle : '; $sl_init .= !empty($slider['properties']['yourlogostyle']) ? '\''.$slider['properties']['yourlogostyle'].'\'' : '\'position: absolute; left: 10px; top: 10px; z-index: 99;\''; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'yourLogoLink : '; $sl_init .= !empty($slider['properties']['yourlogolink']) ? '\''.$slider['properties']['yourlogolink'].'\'' : 'false'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'yourLogoTarget : '; $sl_init .= !empty($slider['properties']['yourlogotarget']) ? '\''.$slider['properties']['yourlogotarget'].'\'' : '\'_self\''; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'loops : '; $sl_init .= !empty($slider['properties']['loops']) ? $slider['properties']['loops'] : 0; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'forceLoopNum : '; $sl_init .= ( isset($slider['properties']['forceloopnum']) && $slider['properties']['forceloopnum'] != 'false') ? 'true' : 'false'; $sl_init .= ','. NL;
		$sl_init .= TAB . TAB . TAB . 'autoPlayVideos : '; $sl_init .= ( isset($slider['properties']['autoplayvideos']) && $slider['properties']['autoplayvideos'] != 'false') ? 'true' : 'false'; $sl_init .= ','. NL;

	$autoPauseSlideshow = !empty($slider['properties']['autopauseslideshow']) ? $slider['properties']['autopauseslideshow'] : 'auto';

	if($autoPauseSlideshow == 'auto') {
	$autoPauseSlideshow = '\'auto\'';
	} else if($autoPauseSlideshow == 'enabled') {
	$autoPauseSlideshow = 'true';
		} else if($autoPauseSlideshow == 'disabled') {
	$autoPauseSlideshow = 'false';
		}

			$sl_init .= TAB . TAB . TAB . 'autoPauseSlideshow : '; $sl_init .= $autoPauseSlideshow; $sl_init .= ','. NL;
			$sl_init .= TAB . TAB . TAB . 'youtubePreview : '; $sl_init .= !empty($slider['properties']['youtubepreview']) ? '\''.$slider['properties']['youtubepreview'].'\'' : '\'maxresdefault.jpg\''; $sl_init .= ','. NL;

			$sl_init .= TAB . TAB . TAB . 'cbInit : '; $sl_init .= !empty($slider['properties']['cbinit']) ? stripslashes($slider['properties']['cbinit']) : 'function() {}'; $sl_init .= ','. NL;
			$sl_init .= TAB . TAB . TAB . 'cbStart : '; $sl_init .= !empty($slider['properties']['cbstart']) ? stripslashes($slider['properties']['cbstart']) : 'function() {}'; $sl_init .= ','. NL;
			$sl_init .= TAB . TAB . TAB . 'cbStop : '; $sl_init .= !empty($slider['properties']['cbstart']) ? stripslashes($slider['properties']['cbstop']) : 'function() {}'; $sl_init .= ','. NL;
			$sl_init .= TAB . TAB . TAB . 'cbPause : '; $sl_init .= !empty($slider['properties']['cbstart']) ? stripslashes($slider['properties']['cbpause']) : 'function() {}'; $sl_init .= ','. NL;
			$sl_init .= TAB . TAB . TAB . 'cbAnimStart : '; $sl_init .= !empty($slider['properties']['cbstart']) ? stripslashes($slider['properties']['cbanimstart']) : 'function() {}'; $sl_init .= ','. NL;
			$sl_init .= TAB . TAB . TAB . 'cbAnimStop : '; $sl_init .= !empty($slider['properties']['cbstart']) ? stripslashes($slider['properties']['cbanimstop']) : 'function() {}'; $sl_init .= ','. NL;
			$sl_init .= TAB . TAB . TAB . 'cbPrev : '; $sl_init .= !empty($slider['properties']['cbstart']) ? stripslashes($slider['properties']['cbprev']) : 'function() {}'; $sl_init .= ','. NL;
			$sl_init .= TAB . TAB . TAB . 'cbNext : '; $sl_init .= !empty($slider['properties']['cbstart']) ? stripslashes($slider['properties']['cbnext']) : 'function() {}'; $sl_init .= ','. NL;
			
			$sl_init .= TAB . TAB . TAB . 'youtubePreview : '; $sl_init .= '\'default.jpg\''; $sl_init .= NL;
			
		$sl_init .= TAB .TAB . '});' . NL;
		$sl_init .= TAB . '};' . NL;
		$sl_init .= '</script>' . NL ;

		
		return array($sl_init, $sl_script);
	}	
	
// ========================================additional function:		
	private function getSliderFromId($id) {
		$this->load->model('setting/setting');
		$smartSlider  = $this->model_setting_setting->getSetting('smartslider/index');
	
		foreach($smartSlider['sliders'] as $slider){
			if($slider['properties']['slider_id'] == $id) return $slider;
		}
		return false;
	}
	
	// 2 функ. нижче додають до обэкта слайдер всі необхідні поля продуктів
	private function getProductsForSlider($slider) {
		//var_dump($slider['layers']);
		$products_id = array();
		$slider_products = array();
		if(isset($slider['layers']) AND count($slider['layers'])){
			foreach($slider['layers'] as $layer){
				if(!(isset($layer['sublayers']) AND count($layer['sublayers'])))continue;
				foreach($layer['sublayers'] as $sublayers){
					if(isset($sublayers['product']) AND $sublayers['product'] != ''){
						$products_id[] = $sublayers['product'];
					}
				}
			}
		}
		//var_dump($products_id);
		if(count($products_id)){
			$this->load->model('smartslider/slider');
			$this->load->model('tool/image');
			foreach($products_id as $product_id ){
				//echo $product_id . '==' ;

				$result = $this->model_smartslider_slider->getProduct($product_id);
				//var_dump($result);
				if ($result['image'] && file_exists(DIR_IMAGE . $result['image'])) {
					$http_image = defined('HTTP_CATALOG') ? HTTP_CATALOG : HTTP_SERVER;
					
					$image = $http_image .'image/'. $result['image'];
					$tumb = $this->model_tool_image->resize($result['image'], 40, 40);
				} else {
					$image = '';
					$tumb = $this->model_tool_image->resize('no_image.jpg', 40, 40);
				}
				
				$special = false;
				$product_specials = $this->getProductSpecials($product_id);
				
				foreach ($product_specials  as $product_special) {
					if (($product_special['date_start'] == '0000-00-00' || $product_special['date_start'] < date('Y-m-d')) && ($product_special['date_end'] == '0000-00-00' || $product_special['date_end'] > date('Y-m-d'))) {
						$special = $this->currency->format($product_special['price']);
						break;
					}					
				}
				//echo $product_id.'===';
				$slider_products[$product_id] = array(
					'name' 		=> $result['name'],
					'model' 		=> $result['model'],
					'image' 		=> $image,
					'tumb'		=> $tumb,
					'price' 		=> $this->currency->format($result['price']),
					'special'    	=> $special,
					'href'		=> htmlspecialchars_decode(str_replace('/index/','/', $this->url->link('product/product', 'product_id=' . $product_id )))
				);
			}
		}
		//var_dump( $slider_products);
		return $slider_products;
	}
	private function getProductSpecials($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "' ORDER BY priority, price");
		
		return $query->rows;
	}
	
	private function layerslider_check_unit($str) {

		if(strstr($str, 'px') == false && strstr($str, '%') == false) {
			return $str.'px';
		} else {
			return $str;
		}
	}
}
?>