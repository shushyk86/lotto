<?php
class ControllerModuleSmartsliderIndex extends Controller {
	private $error = array(); 
	private $success = array(); 

	public function install() {
		$this->db->query('ALTER TABLE '. DB_PREFIX .'setting CHANGE value value MEDIUMTEXT');
		
		$smartSlider = array(
			'smartslider/index_module'	=> array(), //'name'=>'', 'slider_id'=>'', 'layout_id'=>'', 'position'=>'', 'status'=>'', 'sort'=>''
			'sliders' 	=> array()
		);
		
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting('smartslider/index', $smartSlider);
	}
	
	public function uninstall(){  		//index
		// MAYBE YOU WILL NEED TO DO SAVE SETTING TO FILE "sslider_setting.txt"
		$this->load->model('setting/setting');
		$this->model_setting_setting->deleteSetting('smartslider/index');
		$this->db->query('ALTER TABLE '. DB_PREFIX .'setting CHANGE value value TEXT');
		
		// delete example product
		$this->load->model('catalog/product'); 
		$this->load->model('smartslider/slider');
		
		$products = $this->model_smartslider_slider->getExampleProduct();
		//var_dump($products);
		foreach($products as $product){
			$this->model_catalog_product->deleteProduct($product['product_id']);
		}
		
	}
	
	public function delExampleProduct() { //index - button: del_example_product
		// delete example product
		$this->load->model('catalog/product'); 
		$this->load->model('smartslider/slider');
		
		$products = $this->model_smartslider_slider->getExampleProduct();
		//var_dump($products);
		foreach($products as $product){
			$this->model_catalog_product->deleteProduct($product['product_id']);
		}
		
		$this->success['success']= 'You deleted' . count($products)  . 'products for example';
		
		$this->index();

	}
	
	public function getExample() {		//index - button: get_example_slider
		/*//get product for example slider from db in brovser windows
		$this->load->model('setting/setting');		
		$smartSlider  = $this->model_setting_setting->getSetting('smartslider/index');
		$product = array();
		foreach($smartSlider['sliders'] as $slider){
			if(!count($product)){
				$product = $this->getProductsForExample($slider);
			}else{
				$product = $product + $this->getProductsForExample($slider);
			}
		}
		//echo(count($product));
		//var_dump($product);
		var_dump(base64_encode(json_encode($product)));
		return;
		*/
		
		// get data
		$smartSliders = file_get_contents(DIR_APPLICATION.'controller/module/smartslider/files/sl_example.txt'); 
		$smartSliders = json_decode(base64_decode($smartSliders), true);
		$sliders = $smartSliders['sliders'];
		
		$this->load->model('setting/setting');
		$smartSlider  = $this->model_setting_setting->getSetting('smartslider/index');

		$id_old_to_new = $this->addExampleProduct();	// add product start
		//var_dump($id_old_to_new);
		foreach($sliders as $slider){
			$slider = $this->addFieldToSlider($slider, true);
			$example_slider = $this->replaceIdProdInSlider($slider, $id_old_to_new);
			array_push($smartSlider['sliders'], $example_slider);
		}
		
		// save sliders
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting('smartslider/index', $smartSlider);
		
		$this->redirect($this->url->link('module/smartslider/index', 'token=' . $this->session->data['token'], 'SSL'));
	}

	public function duplicateslider(){ 	//index
		if (($this->request->server['REQUEST_METHOD'] == 'GET') && $this->validate()) {
			if(isset($this->request->get['id'])){
				$id = $this->request->get['id'];
				$this->load->model('setting/setting');
				$smartSlider = $this->model_setting_setting->getSetting('smartslider/index');
				
				$new_slider 	= array();
				
				$sliders 	= $smartSlider['sliders'];
				
				foreach($sliders as $index=>$slider){
					if($slider['properties']['slider_id'] == $id){ 
						$new_slider = $slider;
						echo 1;
					}
				}
				
				$new_slider = $this->addFieldToSlider($new_slider, true);
				
				$smartSlider['sliders'][] = $new_slider;
				$this->model_setting_setting->editSetting('smartslider/index', $smartSlider);
			}else echo 0;
		}
	}
	
	public function removeslider(){ 		//index
		if (($this->request->server['REQUEST_METHOD'] == 'GET') && $this->validate()) {
			if(isset($this->request->get['id'])){
				$id = $this->request->get['id'];
				$this->load->model('setting/setting');
				$smartSlider = $this->model_setting_setting->getSetting('smartslider/index');

				$positions	= $smartSlider['smartslider/index_module'];
				$sliders 	= $smartSlider['sliders'];
				
				foreach($positions as $index=>$position){
					if($position['slider_id'] == $id){ 
						unset($positions[$index]);
					}
				}
				$smartSlider['smartslider/index_module'] = $positions;
				
				foreach($sliders as $index=>$slider){
					if($slider['properties']['slider_id'] == $id){ 
						$this->delProductFromExampleSlider($slider);
						unset($sliders[$index]);
						echo 1;
					}
				}
				$smartSlider['sliders'] = $sliders;
				$this->model_setting_setting->editSetting('smartslider/index', $smartSlider);
			}else echo 0;
		}
	}
	
	public function importall() {		//index
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$smartSlider = json_decode(base64_decode($this->request->post['import']), true);

			$this->language->load('module/smartslider/index');
			
			if(!is_array($smartSlider)) {
				$this->error['warning']=$this->language->get('text_import_error');
			}else{
				$this->success['success']=$this->language->get('text_import_success');
				
				$this->load->model('setting/setting');
				$this->model_setting_setting->editSetting('smartslider/index', $smartSlider);
			}
		}
		$this->index();
	}
	
	public function savegeneral() { 		//index
		$this->language->load('module/smartslider/index');
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			
			$this->load->model('setting/setting');
			
			$smartSlider  = $this->model_setting_setting->getSetting('smartslider/index');
			if(!isset($this->request->post['positions'])){
				$smartSlider['smartslider/index_module'] = array();
			}else{
				$smartSlider['smartslider/index_module'] = 	$this->request->post['positions'];
			}
			
			$this->model_setting_setting->editSetting('smartslider/index', $smartSlider);		

			//$this->session->data['success'] = $this->language->get('text_save_success');
			echo 1;

		}else{
			//$this->session->data['error'] = $this->language->get('text_save_error');
			echo 0;

		}
	}
	
	public function index() {   			//index
		
		$this->data = $this->language->load('module/smartslider/index');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		
		$this->document->addScript( 'view/javascript/smartslider/cookie_jq.js' );
		$this->document->addScript( 'view/javascript/smartslider/tipsy.js' );
		
		$this->document->addStyle( 'view/stylesheet/smartslider/bootstrap.css' );
		$this->document->addStyle( 'view/stylesheet/smartslider/slider.css' );
		
	// SUCCESS/ERROR
		if (isset($this->success['success'])) {
			$this->data['success'] = $this->success['success'];
		} else if(isset($this->session->data['success']))  {
			$this->data['success'] = $this->session->data['success'];
			unset ($this->session->data['success']);
		} else  {
			$this->data['success'] = '';
		}
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else if(isset($this->session->data['error']))  {
			$this->data['error'] = $this->session->data['error'];
			unset ($this->session->data['error']);
		}else {
			$this->data['error_warning'] = '';
		}
	
	// BREADCRUMBS
  		$this->data['breadcrumbs'] = array();
   		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
   		);
   		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
   		);
   		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/smartslider/index', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
   		);
		
		// get data
		$smartSlider  = $this->model_setting_setting->getSetting('smartslider/index');
	
	// DATA	
		$this->data['smartSlider'] 	= $smartSlider;
		$this->data['positions'] 		= $smartSlider['smartslider/index_module'];
		$this->data['sliders'] 		= $smartSlider['sliders'];
	// DATA		
		$this->data['token'] = $this->session->data['token'];
		
		$this->load->model('smartslider/slider');
		$products = $this->model_smartslider_slider->getExampleProduct();
		$this->data['is_example'] = count($products) ?  true : false;
		
		
	// URL
		$this->data['action'] 	= $this->url->link('module/smartslider/index', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] 	= $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['save_url'] 	= $this->url->link('module/smartslider/index/savegeneral', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['getexample_url']= $this->url->link('module/smartslider/index/getexample', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['delexampleproduct_url']= $this->url->link('module/smartslider/index/delexampleproduct', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['newslider_url']= $this->url->link('module/smartslider/index/editslider', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['editslider_url']= $this->url->link('module/smartslider/index/editslider', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['still_editslider_url']= $this->url->link('module/smartslider/index/editslider', 'token=' . $this->session->data['token'] . '&skip_error=1', 'SSL');
		$this->data['duplicateslider_url']= $this->url->link('module/smartslider/index/duplicateslider', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['removeslider_url']= $this->url->link('module/smartslider/index/removeslider', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['import_url']= $this->url->link('module/smartslider/index/importall', 'token=' . $this->session->data['token'], 'SSL');

		$this->load->model('design/layout');

		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->load->model('design/banner');

		$this->data['banners'] = $this->model_design_banner->getBanners();

		$this->template = 'module/smartslider/index.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	public function editslider(){		//edit
		$this->data = $this->language->load('module/smartslider/edit');
		
		$skip_error = isset($this->request->get['skip_error']) ? $this->request->get['skip_error'] : false;
		
		if(!isset($this->request->get['id']) OR empty($this->request->get['id'])){ 
		// new slider
		
			$slider = file_get_contents(DIR_APPLICATION.'controller/module/smartslider/files/empty.txt'); 
			$slider = unserialize($slider);
			$slider = $this->addFieldToSlider($slider, true);

			$id = $slider['properties']['slider_id'];
			
			$productsForSlider = $this->getProductsForSlider($slider);
			if(!$skip_error){
				if(!$productsForSlider['status']){
					$this->error['warning']='Error: Not found products for slider with id products:' . implode(",", $productsForSlider['data']) . '<a data-id_slider="' . $id . '" class="button still_continue_edit" style="margin: 5px 0;">Still continue</a>';
					$this->index(); return;
				}
			}
			$this->data['productsForSlider'] = $productsForSlider;

			$this->data['slider'] = $slider;

		}else{
		// edit slider
		
			$id = $this->request->get['id'];
			
			$slider = $this->getSliderFromId($id);
		
			$productsForSlider = $this->getProductsForSlider($slider);
			if(!$skip_error){
				if(!$productsForSlider['status']){
					$this->error['warning']='Error: Not found products for slider with id products:'.implode(",", $productsForSlider['data']). '<a  data-id_slider="' . $id . '"  class="button still_continue_edit" style="margin: 5px 0;">Still continue</a>';
					$this->index(); return;	
				}
			}
			$this->data['productsForSlider'] = $productsForSlider;

			$this->data['slider'] = $slider;
		}

		$this->document->addScript( 'view/javascript/smartslider/easing_1_3.js' );
		$this->document->addScript( 'view/javascript/smartslider/farbtastic.js' );
		$this->document->addScript( 'view/javascript/smartslider/smartslider.min.js' );
		
		$this->document->addScript( 'view/javascript/smartslider/slider_engine.js' );
		
		$this->document->addScript( 'view/javascript/smartslider/cookie_jq.js' );
		$this->document->addScript( 'view/javascript/smartslider/tipsy.js' );
		
		// створення селектів з картинами	
		$this->document->addStyle('view/stylesheet/smartslider/dd.css');
		$this->document->addScript('view/javascript/smartslider/jquery.dd.min.js');	
		
		$this->document->addStyle( 'view/stylesheet/smartslider/slider.css' );
		$this->document->addStyle( 'view/stylesheet/smartslider/farbtastic.css' );
		$this->document->addStyle( 'view/stylesheet/smartslider/bootstrap.css' );
	// SUCCESS/ERROR
		if (isset($this->success['success'])) {
			$this->data['success'] = $this->success['success'];
		} else if(isset($this->session->data['success']))  {
			$this->data['success'] = $this->session->data['success'];
			unset ($this->session->data['success']);
		} else  {
			$this->data['success'] = '';
		}
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else if(isset($this->session->data['error']))  {
			$this->data['error'] = $this->session->data['error'];
			unset ($this->session->data['error']);
		}else {
			$this->data['error_warning'] = '';
		}
	
	
	// BREADCRUMBS
  		$this->data['breadcrumbs'] = array();
   		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
   		);
   		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
   		);
   		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/smartslider/index/editslider&id='.$id, 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
   		);
		
	// URL
		
		$this->data['action'] 	= $this->url->link('module/smartslider/index/editslider&id='.$id, 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] 	= $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['save_url'] 	= $this->url->link('module/smartslider/index/saveslider&id='.$id, 'token=' . $this->session->data['token'], 'SSL');	
		
		$this->data['product_url'] = $this->url->link('module/smartslider/index/getproductlist', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['backToList_url'] = $this->url->link('module/smartslider/index', 'token=' . $this->session->data['token'], 'SSL');
		
	//DATA	
		$this->data['labels']			= $this->getLabelData();
		//var_dump($this->getLabelData());
		$this->data['mainImagePath']		= HTTP_CATALOG.'image/';
		$this->data['sliderImagePath']	= HTTP_CATALOG.'image/';
		$this->data['layerSkinDir'] 		= DIR_CATALOG.'view/theme/default/stylesheet/smartslider/smartskins';
		$this->data['token'] 				= $this->session->data['token'];

		$this->template = 'module/smartslider/edit.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}
	
	public function saveslider() {		//edit
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$slider_id = $this->request->get['id'];
			
			if(isset($this->request->post['posted_edit'])){	// properties	
				$properties = $this->request->post['smartslider-slides']['properties'];

				$slider = $this->getSliderFromId($slider_id); 
				
				if(!$slider) {	
				//case for new slider
					$properties['slider_id'] = $slider_id;
					$new_slider = array(
						'properties' => $properties,
						'layers'	=> array()
					);
					$slider = $this->addFieldToSlider($new_slider);
				}else{	
				//case for edit slider
					$properties['slider_id'] = $slider_id;
					$slider['properties'] = $properties;
					$slider = $this->addFieldToSlider($slider);
					$slider['layers'] = array();
				}
				
				$this->saveSliderFromId($slider_id, $slider);
				
			}else if(isset($this->request->post['layerkey'])){	// layer	
				$layerkey = $this->request->post['layerkey'];
				
				$layer = $this->request->post['smartslider-slides']['layers'][$layerkey ];
				
				$slider = $this->getSliderFromId($slider_id); 

				$slider['layers'][] = $layer;
				
				//var_dump($layer);

				$this->saveSliderFromId($slider_id, $slider);
			}
		}
	}

	public function getproductlist() {		//edit
		$this->language->load('catalog/product');
		$this->load->model('catalog/product');
		
		if (isset($this->request->get['filter_name'])) {
			$filter_name = $this->request->get['filter_name'];
		} else {
			$filter_name = null;
		}

		if (isset($this->request->get['filter_model'])) {
			$filter_model = $this->request->get['filter_model'];
		} else {
			$filter_model = null;
		}
		
		if (isset($this->request->get['filter_price'])) {
			$filter_price = $this->request->get['filter_price'];
		} else {
			$filter_price = null;
		}


		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'pd.name';
		}
		
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
						
		$url = '';
						
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}
		
		if (isset($this->request->get['filter_model'])) {
			$url .= '&filter_model=' . urlencode(html_entity_decode($this->request->get['filter_model'], ENT_QUOTES, 'UTF-8'));
		}
		
		if (isset($this->request->get['filter_price'])) {
			$url .= '&filter_price=' . $this->request->get['filter_price'];
		}
						
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$this->data['products'] = array();

		$data = array(
			'filter_name'	  => $filter_name, 
			'filter_model'	  => $filter_model,
			'filter_price'	  => $filter_price,
			'sort'            => $sort,
			'order'           => $order,
			'start'           => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'           => $this->config->get('config_admin_limit')
		);
		
		$this->load->model('tool/image');
		
		$product_total = $this->model_catalog_product->getTotalProducts($data);
			
		$results = $this->model_catalog_product->getProducts($data);
				    	
		foreach ($results as $result) {
			
			if ($result['image'] && file_exists(DIR_IMAGE . $result['image'])) {
				$image = HTTP_CATALOG . 'image/'.$result['image'];
				$tumb   = $this->model_tool_image->resize($result['image'], 40, 40);
			} else {
				$image = '';
				$tumb   = $this->model_tool_image->resize('no_image.jpg', 40, 40);
			}
	
			$special = false;
			
			$product_specials = $this->model_catalog_product->getProductSpecials($result['product_id']);
			
			foreach ($product_specials  as $product_special) {
				if (($product_special['date_start'] == '0000-00-00' || $product_special['date_start'] < date('Y-m-d')) && ($product_special['date_end'] == '0000-00-00' || $product_special['date_end'] > date('Y-m-d'))) {
					$special = $this->currency->format($product_special['price']);
					break;
				}					
			}
	
      		$this->data['products'][] = array(
				'product_id' => $result['product_id'],
				'name'       	=> $result['name'],
				'model'      	=> $result['model'],
				'price'      	=> $this->currency->format($result['price']),
				'special'    	=> $special,
				'tumb'      	=> $tumb,
				'image'		=> $image,
				'selected'   => isset($this->request->post['selected']) && in_array($result['product_id'], $this->request->post['selected']),
				'href'		=> str_replace('/index/','/', $this->url->link('product/product', 'product_id=' . $result['product_id'] ))

			);
    	}
		$this->data['text_no_results'] = $this->language->get('text_no_results');		
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');		
			
		$this->data['column_image'] = $this->language->get('column_image');		
		$this->data['column_name'] = $this->language->get('column_name');		
		$this->data['column_model'] = $this->language->get('column_model');		
		$this->data['column_price'] = $this->language->get('column_price');		
		$this->data['button_filter'] = $this->language->get('button_filter');
		 
 		$this->data['token'] = $this->session->data['token'];
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}
		
		if (isset($this->request->get['filter_model'])) {
			$url .= '&filter_model=' . urlencode(html_entity_decode($this->request->get['filter_model'], ENT_QUOTES, 'UTF-8'));
		}
		
		if (isset($this->request->get['filter_price'])) {
			$url .= '&filter_price=' . $this->request->get['filter_price'];
		}
		
		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
					
		$this->data['sort_name'] = $this->url->link('module/smartslider/index/getproductlist', 'token=' . $this->session->data['token'] . '&sort=pd.name' . $url, 'SSL');
		$this->data['sort_model'] = $this->url->link('module/smartslider/index/getproductlist', 'token=' . $this->session->data['token'] . '&sort=p.model' . $url, 'SSL');
		$this->data['sort_price'] = $this->url->link('module/smartslider/index/getproductlist', 'token=' . $this->session->data['token'] . '&sort=p.price' . $url, 'SSL');
		$this->data['sort_order'] = $this->url->link('module/smartslider/index/getproductlist', 'token=' . $this->session->data['token'] . '&sort=p.sort_order' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}
		
		if (isset($this->request->get['filter_model'])) {
			$url .= '&filter_model=' . urlencode(html_entity_decode($this->request->get['filter_model'], ENT_QUOTES, 'UTF-8'));
		}
		
		if (isset($this->request->get['filter_price'])) {
			$url .= '&filter_price=' . $this->request->get['filter_price'];
		}
		
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
				
		$pagination = new Pagination();
		$pagination->total = $product_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('module/smartslider/index/getproductlist', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();
	
		$this->data['filter_name'] = $filter_name;
		$this->data['filter_model'] = $filter_model;
		$this->data['filter_price'] = $filter_price;
		
		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'module/smartslider/product_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
  	}

	
// additional function:
	// work with label for product
	private function getLabelData(){
	
		$data = array();
		
		$dirImage  		= DIR_CATALOG."view/theme/default/stylesheet/smartslider/smartlabel/";
		$pathImage 		= HTTP_CATALOG."catalog/view/theme/default/stylesheet/smartslider/smartlabel/";
	
		// search labels type (1)
		$labels_type = $this->getDirs($dirImage);
		
		// search
		
		foreach($labels_type as $lable){
			// search label colors
			$colors = $this->getDirs($dirImage.$lable);
			
			// search label files
			$files	= $this->getFiles($dirImage.$lable.'/'.$colors[0]);
			
			// set data
			$data [] = array (
				'name'		=>  ucfirst(str_replace('_', ' ', $lable)),
				'colors'	=> $colors,
				'files'		=> $files,	
				'path'		=> $pathImage.$lable.'/',
				'type'		=> $lable
			);
		}
		
		$sort_numcie = array();
		foreach($data as $key => $val) {
			$sort_numcie[] = $val['name'];
		}
		array_multisort($sort_numcie, SORT_ASC, $data);
			
		$labels = array(
			'data' => $data,
			'image_null' => $pathImage.'empty.png'
		);
		return $labels;
	}
	
	private function getFiles($dir, $path='') {
		$files = array();
		if ($handle = opendir($dir)) {
			while (false !== ($file = readdir($handle))) { 
				if ($file != "." && $file != "..") { 
					if(preg_match("/\.(?:jp(?:e?g|e|2)|gif|png|tiff?|ttf|bmp|ico)$/i ",$file) ){
					
						$name = ucfirst(str_replace ('_',' ',$file));
						$pos = strrpos($file, '.');
						if ($pos !== false) {
							$name = ucfirst(str_replace ('_',' ',substr($file, 0, $pos)));
						}
						if($path!=''){
							$files[] = array(
								"name" 	=> $name,
								"file" 	=> $file,
								"url"	=> $path.$file
							);
						}else{
							$files[] = array(
								"name" 	=> $name,
								"file" 	=> $file
							);
						}
					}
				} 
			}
			closedir($handle); 
		}
		$sort_numcie = array();
		foreach($files as $key => $val) {
			$sort_numcie[] = $val['name'];
		}
		array_multisort($sort_numcie, SORT_ASC, $files);

		return $files;
	}
	private function getDirs($dir) {
		$dirs = array();
		if ($handle = opendir($dir)) {
			while (false !== ($dir_ = readdir($handle))) { 
				//echo '=='.$dir_.'==';
				if (!is_file($dir_) && $dir_!='.' && $dir_!='..' && $dir_!='') {
					if(is_dir($dir.'/'.$dir_))
					$dirs[] = (string)$dir_;

				}
			}
		}
		sort($dirs, SORT_STRING );
		return $dirs;
	}
	

	// =============== add new slider to array sliders in object:smartSlider
	private function addSlider($newSlider,$store_id=0) {	//array()
			$status = true;
			if(!is_array($newSlider)) {
				$status = false;
			}else{
	
				$this->load->model('setting/setting');
				
				$smartSlider  = $this->model_setting_setting->getSetting('smartslider/index', $store_id);
				
				// TODO SLIDER_ID - ВІН ПОВИНЕН ЗВІДКИСЬ БРАТИСЯ
				
				$smartSlider['sliders'][] = $newSlider;
				
				$this->model_setting_setting->editSetting('smartslider/index', $smartSlider, $store_id);
			}
		return $status;
	}
	
	
	// =============== $all - true/false - замінити або доповнити поля date_c та slider_id
	private function addFieldToSlider($slider, $all=false, $store_id=0) {
		$id = true;
			if(!is_array($slider)) {
				$id = false;
			}else{
				if($all){
					$id = $this->generateRandomString();
					$slider['properties']['date_c'] 			= date("Y-m-d H:i:s", time());
					$slider['properties']['date_m'] 			= date("Y-m-d H:i:s", time());
					$slider['properties']['slider_id'] 	= $id;
				
				}else{
					if(!isset($slider['properties']['date_c'])){
						$slider['properties']['date_c'] 			= date("Y-m-d H:i:s", time());
					}
					$slider['properties']['date_m'] 			= date("Y-m-d H:i:s", time());
					if(!isset($slider['properties']['slider_id'])){
						$id = $this->generateRandomString();
						$slider['properties']['slider_id'] 	= $id;
					}
				}
			}
		return $slider;
	}
	
	private function getSliderFromId($id) {
		$this->load->model('setting/setting');
		$smartSlider  = $this->model_setting_setting->getSetting('smartslider/index');
	
		foreach($smartSlider['sliders'] as $slider){
			if($slider['properties']['slider_id'] == $id) return $slider;
		}
		return false;
	}
	
	private function saveSliderFromId($id, $new_slider) {
		$this->load->model('setting/setting');
		$smartSlider  = $this->model_setting_setting->getSetting('smartslider/index');
		
		$create = true;
		
		foreach($smartSlider['sliders'] as $index => $slider){
			if($slider['properties']['slider_id'] == $id) {
				$smartSlider['sliders'][$index] =  $new_slider;
				$create =  false;
			}
		}
		
		if($create)$smartSlider['sliders'][]=  $new_slider;
		
		$this->model_setting_setting->editSetting('smartslider/index', $smartSlider);
	}	
	
	private function generateRandomString($length = 5) {
		return substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyz"), 0, $length);
	}	
	
	private function delProductFromExampleSlider($slider) {
		$products_id = array();
		
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
		
		if(count($products_id)){
			$this->load->model('catalog/product');
				
			foreach($products_id as $product_id ){
				$product = $this->model_catalog_product->getProduct($product_id);
				if($product['model'] == 'sl_example' OR $product['sku'] == 'sl_example')
					$this->model_catalog_product->deleteProduct($product_id );
			}
		}
	}
	
	
	// =============== 2 функ. нижче додають до обэкта слайдер всі необхідні поля продуктів
	private function getProductsForSlider($slider) {
		//var_dump($slider['layers']);
		$products_id = array();
		$slider_products = array();
		$no_product_list_id = array();
		
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
		if(count($products_id)){
			$this->load->model('catalog/product');
			$this->load->model('tool/image');

			foreach($products_id as $product_id ){
				
				$result = $this->model_catalog_product->getProduct($product_id);
				
				if(!count($result)) {
					$no_product_list_id[] = $product_id ;
					continue;
				}
				
				if ($result['image'] && file_exists(DIR_IMAGE . $result['image'])) {
					$http_image = defined('HTTP_CATALOG') ? HTTP_CATALOG : HTTP_SERVER;
					
					$image = $http_image .'image/'. $result['image'];
					$tumb = $this->model_tool_image->resize($result['image'], 40, 40);
				} else {
					$image = '';
					$tumb = $this->model_tool_image->resize('no_image.jpg', 40, 40);
				}
				
				$special = false;
				$product_specials = $this->getProductSpecials($result['product_id']);
				
				foreach ($product_specials  as $product_special) {
					if (($product_special['date_start'] == '0000-00-00' || $product_special['date_start'] < date('Y-m-d')) && ($product_special['date_end'] == '0000-00-00' || $product_special['date_end'] > date('Y-m-d'))) {
						$special = $this->currency->format($product_special['price']);
						break;
					}					
				}

				$slider_products[$result['product_id']] = array(
					'name' 		=> $result['name'],
					'model' 		=> $result['model'],
					'image' 		=> $image,
					'tumb'		=> $tumb,
					'price' 		=> $this->currency->format($result['price']),
					'special'    	=> $special,
					'href'		=> str_replace('/index/','/', $this->url->link('product/product', 'product_id=' . $result['product_id'] ))
				);
			}
		}
		//var_dump( $slider_products);
		if(count($no_product_list_id))return array('status' => false, 'data' => $no_product_list_id);
		return array('status' => true,'data' =>$slider_products);
	}
	private function getProductSpecials($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "' ORDER BY priority, price");
		
		return $query->rows;
	}
	
	
	// =============== 2 функ. нижче додають есперементальні товари до бд
	private function getProductsForExample($slider) {
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
		if(count($products_id)){
			$this->load->model('catalog/product');
			$this->load->model('tool/image');
			foreach($products_id as $product_id ){
				
				$result = $this->model_catalog_product->getProduct($product_id);

				if ($result['image'] && file_exists(DIR_IMAGE . $result['image'])) {
					$http_image = defined('HTTP_CATALOG') ? HTTP_CATALOG : HTTP_SERVER;
					
					$image =  $result['image'];
					$tumb = $this->model_tool_image->resize($result['image'], 40, 40);
				} else {
					$image = '';
					$tumb = $this->model_tool_image->resize('no_image.jpg', 40, 40);
				}
				
				$special = false;
				$product_specials = $this->getProductSpecials($result['product_id']);
				
				foreach ($product_specials  as $product_special) {
					if (($product_special['date_start'] == '0000-00-00' || $product_special['date_start'] < date('Y-m-d')) && ($product_special['date_end'] == '0000-00-00' || $product_special['date_end'] > date('Y-m-d'))) {
						$special = $product_special['price'];
						break;
					}					
				}

				$slider_products[$result['product_id']] = array(
					'name' 		=> $result['name'],
					'model' 		=> $result['model'],
					'image' 		=> $image,
					'tumb'		=> $tumb,
					'price' 		=> $result['price'],
					'special'    	=> $special,
					'href'		=> str_replace('/index/','/', $this->url->link('product/product', 'product_id=' . $result['product_id'] ))
				);
			}
		}
		//var_dump( $slider_products);
		return $slider_products;
	}

	private function addExampleProduct() {
		$products = file_get_contents(DIR_APPLICATION.'controller/module/smartslider/files/sl_product_example.txt'); 
		$products =  json_decode(base64_decode($products), true);
		$this->load->model('smartslider/slider');
		
		$id_old_to_new = array();
		
		foreach($products as $product_id => $product){
			$language_id = $this->config->get('config_language_id');

			if(isset($id_old_to_new[$product_id]) ) continue; // перевірка на дубляж

			$data = array(
				'model' 	=> 'sl_example','sku' => 'sl_example', 'upc' => '', 'location' => '', 'quantity' => '100',	'minimum' => '1', 'subtract' => '1', 'stock_status_id' 	=> '7', 'date_available' => 'NOW()','manufacturer_id' => 0, 'shipping' => 1,
				'price' 	=> $product['price'],
				'points' => 0,'weight' => 0,'weight_class_id' => 1,	'length' => 0,'width' => 0, 'height' => 0,'length_class_id' => 1,	'status' =>1, 'tax_class_id' => 0, 'sort_order' => 0, 'image' => $product['image'],
				'product_description' 		=> array(
									$language_id => array(
										'name' 				=> $product['name'],
										'meta_keyword' 		=> '',
										'meta_description' 	=> '',
										'description'		=> ''
										)
								),
				'keyword' => '',
				'product_store' => array((int)$this->config->get('config_store_id'))
			);
			if($product['special']){
			$data['product_special'] = array(
										array(
											'customer_group_id'	=> '1',
											'priority'			=> '0',
											'price'				=> 88,
											'date_start'		=> '0000-00-00',
											'date_end'			=> '2033-03-03'
										)
									);
			}
			//echo $product_id.'==';
			$id_old_to_new[$product_id] = $this->model_smartslider_slider->addProduct($data);
		}
		return $id_old_to_new;
	}
	
	private function replaceIdProdInSlider($slider, $id_old_to_new) {
		//var_dump($slider['layers']);
		if(isset($slider['layers']) AND count($slider['layers'])){
			foreach($slider['layers'] as &$layer){
				if(!(isset($layer['sublayers']) AND count($layer['sublayers'])))continue;
				foreach($layer['sublayers'] as &$sublayers){
					if(isset($sublayers['product']) AND $sublayers['product'] != ''){
						foreach($id_old_to_new as $id_old => $id_new){
							if($sublayers['product'] == $id_old)$sublayers['product'] = $id_new;
						}
					}
				}
			}
		}
		unset($layer);
		unset($sublayers);
		return $slider;
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/carousel')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (isset($this->request->post['carousel_module'])) {
			foreach ($this->request->post['carousel_module'] as $key => $value) {				
				if (!$value['width'] || !$value['height']) {
					$this->error['image'][$key] = $this->language->get('error_image');
				}
			}
		}	

		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>