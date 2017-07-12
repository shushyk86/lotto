<?php   
class ControllerCommonHeader extends Controller {
	protected function index() {
		
		// admitad cookie set
		if(isset($this->request->get['admitad_uid']) && !isset($_COOKIE['admitad_uid'])){ 
			setcookie("admitad_uid", $this->request->get['admitad_uid'], time() + 60*60*24*30, '/');
		}
		
		$this->data['title'] = $this->document->getTitle();

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		if (isset($this->session->data['error']) && !empty($this->session->data['error'])) {
			$this->data['error'] = $this->session->data['error'];

			unset($this->session->data['error']);
		} else {
			$this->data['error'] = '';
		}
		
		$data['og_url'] = (isset($this->request->server['HTTPS']) ? HTTPS_SERVER : HTTP_SERVER) . substr($this->request->server['REQUEST_URI'], 1, (strlen($this->request->server['REQUEST_URI'])-1));
		$this->data['base'] = $server;
		$this->data['description'] = $this->document->getDescription();
		$this->data['keywords'] = $this->document->getKeywords();
		$this->data['links'] = $this->document->getLinks();
		$this->data['robots'] = $this->document->getRobots();
		$this->data['styles'] = $this->document->getStyles();
		$this->data['scripts'] = $this->document->getScripts();
		$this->data['lang'] = $this->language->get('code');
		$this->data['direction'] = $this->language->get('direction');
		$this->data['google_analytics'] = html_entity_decode($this->config->get('config_google_analytics'), ENT_QUOTES, 'UTF-8');
		$this->data['name'] = $this->config->get('config_name');
		
		if ($this->config->get('config_icon') && file_exists(DIR_IMAGE . $this->config->get('config_icon'))) {
			$this->data['icon'] = $server . 'image/' . $this->config->get('config_icon');
		} else {
			$this->data['icon'] = '';
		}

		if ($this->config->get('config_logo') && file_exists(DIR_IMAGE . $this->config->get('config_logo'))) {
			$this->data['logo'] = $server . 'image/' . $this->config->get('config_logo');
		} else {
			$this->data['logo'] = '';
		}

		$this->data['og_url'] = (isset($this->request->server['HTTPS']) ? HTTPS_SERVER : HTTP_SERVER) . ltrim ($this->request->server['REQUEST_URI'],'/');
		$this->data['og_image'] = $this->document->getOgImage();

		$this->language->load('common/header');

		$customer_first_name = $this->customer->getFirstName();
		if(mb_strlen($customer_first_name) > 11){
			$customer_first_name = mb_substr($customer_first_name, 0, 10, "UTF-8") . "...";
		}

		$this->data['text_home'] = $this->language->get('text_home');
		$this->data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
		$this->data['text_shopping_cart'] = $this->language->get('text_shopping_cart');
		$this->data['text_search'] = $this->language->get('text_search');
		$this->data['text_welcome'] = sprintf($this->language->get('text_welcome'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'));
		$this->data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', 'SSL'), $customer_first_name, $this->url->link('account/logout', '', 'SSL'));
		$this->data['text_account'] = $this->language->get('text_account');
		$this->data['text_checkout'] = $this->language->get('text_checkout');
		$this->data['text_blog'] = $this->language->get('text_blog');
		$this->data['text_special'] = $this->language->get('text_special');
		$this->data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
		$this->data['text_latest'] = $this->language->get('text_latest');
		$this->data['text_brands'] = $this->language->get('text_brands');
	$this->data['text_tochki'] = $this->language->get('text_tochki');
		$this->data['home'] = $this->url->link('common/home');
		$this->data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
		$this->data['logged'] = $this->customer->isLogged();
		$this->data['account'] = $this->url->link('account/account', '', 'SSL');
		$this->data['shopping_cart'] = $this->url->link('checkout/cart');
		$this->data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');
		$this->data['blog'] = $this->url->link('blog/latest', '', 'SSL');
		$this->data['special'] = $this->url->link('product/special');
		$this->data['latest'] = $this->url->link('product/latest');
		$this->data['brands'] = $this->url->link('product/manufacturer');
		$this->data['compare'] = $this->url->link('product/compare');

		$this->data['mini_cart_prod_amount'] = $this->cart->countProducts();
		
		$this->load->model('menu/megamenu');
		$this->data['menu_tree'] = $this->model_menu_megamenu->getTree();

		$this->data['user_points'] = false;
		if($this->customer->isLogged()){
			$this->data['user_points'] = $this->customer->getRewardPoints();
			$this->data['getresponse_customer'] = $this->customer->getEmail();
		}

		// Daniel's robot detector
		$status = true;

		if (isset($this->request->server['HTTP_USER_AGENT'])) {
			$robots = explode("\n", trim($this->config->get('config_robots')));

			foreach ($robots as $robot) {
				if ($robot && strpos($this->request->server['HTTP_USER_AGENT'], trim($robot)) !== false) {
					$status = false;

					break;
				}
			}
		}

		// A dirty hack to try to set a cookie for the multi-store feature
		$this->load->model('setting/store');

		$this->data['stores'] = array();

		if ($this->config->get('config_shared') && $status) {
			$this->data['stores'][] = $server . 'catalog/view/javascript/crossdomain.php?session_id=' . $this->session->getId();

			$stores = $this->model_setting_store->getStores();

			foreach ($stores as $store) {
				$this->data['stores'][] = $store['url'] . 'catalog/view/javascript/crossdomain.php?session_id=' . $this->session->getId();
			}
		}

		// Search		
		if (isset($this->request->get['search'])) {
			$this->data['search'] = $this->request->get['search'];
		} else {
			$this->data['search'] = '';
		}

		// Menu
		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}
		
		if ($this->config->get('config_menu_brands')) {
			$data = array();
				$this->load->model('catalog/manufacturer');
				$this->data['manufacturer'] = array();
				$manufacturers = $this->model_catalog_manufacturer->getManufacturers($data);
				if($manufacturers){
				foreach($manufacturers as $manufacturer){
					$this->data['manufacturer'][] = array(
					'name' => $manufacturer['name'],
					'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id='.$manufacturer['manufacturer_id'])
					);
				}
			}
		}

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->data['categories'] = array();

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			if ($category['top']) {
				// Level 2
				$children_data = array();

				$children = $this->model_catalog_category->getCategories($category['category_id']);

				foreach ($children as $child) {
					if ($this->config->get('config_product_count')) {
						$data = array(
							'filter_category_id'  => $child['category_id'],
							'filter_sub_category' => true
						);
						
						$product_total = $this->model_catalog_product->getTotalProducts($data);
						
					}

					//Level 3
		        $subchildren = $this->model_catalog_category->getCategories($child['category_id']);
				    $subchildren_data = array(); 
				foreach ($subchildren as $subchild) {
					if ($this->config->get('config_product_count')) {
						$data = array(
							  'filter_category_id'  => $subchild['category_id'],
							  'filter_sub_category' => true
						);
 
						$sub_total = $this->model_catalog_product->getTotalProducts($data);
					}

					$subchildren_data[] = array(
								'name'  => $subchild['name'] . ($this->config->get('config_product_count') ? ' (' . $sub_total . ')' : ''),
								'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id']. '_' . $subchild['category_id'])	
						);						
					}								
 
					$children_data[] = array(
						'name'  => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $product_total . ')' : ''),
						'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id']),					
						'subchildren' => $subchildren_data,
 
					);						
				}				
					//Level	3			
				

				// Level 1
				$this->data['categories'][] = array(
					'name'     => $category['name'],
					'children' => $children_data,
					'active'   => in_array($category['category_id'], $parts),
					'column'   => $category['column'] ? $category['column'] : 1,
					'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
				);
			}
		}
		
		

		$this->children = array(
			'module/language',
			'module/currency',
			'module/cart'
		);

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/header.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/header.tpl';
		} else {
			$this->template = 'default/template/common/header.tpl';
		}

		$this->render();
	}
	
	public function customCallBack(){
	
		if ($this->request->server['REQUEST_METHOD'] == 'POST'){
			$message = "Вам прислали запрос на обратный звонок.<br>".date('d-m-Y H:i:s', time())."<br><br>";
			$message.= "Имя покупателя: ". strip_tags($this->request->post['buyer_name'])."<br><br>";
			$message.= "Телефон: " . strip_tags($this->request->post['buyer_phone'])."<br><br>";
			
			$mail = new Mail($this->config->get('config_mail_protocol'), $this->config->get('config_smtp_host'), $this->config->get('config_smtp_username'), html_entity_decode($this->config->get('config_smtp_password')), $this->config->get('config_smtp_port'), $this->config->get('config_smtp_timeout'));
			$mail->setTo(array($this->config->get('config_email')));
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender($this->config->get('config_name'));
			$mail->setSubject("Вы получили запрос на обратный звонок");
			$mail->setHtml($message);
			$mail->send();
		}	
	
	}	
}
?>
