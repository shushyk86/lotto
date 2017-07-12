<?php
class ControllerCheckoutSuccess extends Controller { 
	public function index() { 	
	
		if ( isset($this->session->data['order_id']) && ( ! empty($this->session->data['order_id']))  ) {
			$this->session->data['last_order_id'] = $this->session->data['order_id'];
		}
		
		$this->load->model('checkout/order');
		$this->load->model('catalog/product');
		$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
		$order_products = $this->model_checkout_order->getOrderProducts($this->session->data['order_id']);
		$product_info = $this->model_catalog_product->getProduct($order_info['product_id']);		
		
		$this->data['order_info'] = $order_info;
		$all_price = 0;

		if($this->cart->getProducts()){
			foreach ($this->cart->getProducts() as $product) {
				//admitad data
				$this->data['items'][] = array(
				'sku'      		=> $product['sku'],
				'quantity'      => $product['quantity'],
				'price'     	=> $product['price'],
				'admitad_uid'  	=> (isset($_COOKIE['admitad_uid'])) ? $_COOKIE['admitad_uid'] : '',
				'customer_id'  	=> (isset($this->session->data['customer_id']) && $this->session->data['customer_id'] != 0) ? $this->session->data['customer_id'] : '',
				'coupon'  		=> ($this->session->data['coupon'] != '') ? 1 : 0,
				'old_customer'	=> (isset($this->session->data['customer_id'])) ? 1 : 0
				);
				
				$all_price += $product['price'] * $product['quantity'];
			}
		} else {
			//admitad data
			$this->data['items'][] = array(
				'sku'      		=> $product_info['sku'],
				'quantity'      => $order_info['product_quantity'],
				'price'     	=> (int)$order_info['product_price'],
				'admitad_uid'  	=> (isset($_COOKIE['admitad_uid'])) ? $_COOKIE['admitad_uid'] : '',
				'customer_id'  	=> (isset($this->session->data['customer_id']) && $this->session->data['customer_id'] != 0) ? $this->session->data['customer_id'] : '',
				'coupon'  		=> (isset($this->session->data['coupon']) && !empty($this->session->data['coupon'])) ? 1 : 0,
				'old_customer'	=> (isset($this->session->data['customer_id'])) ? 1 : 0
				);
			
			$all_price += $order_info['product_price'] * $order_info['product_quantity'];
		}

		foreach($order_products as $product){
			$prod_info = $this->model_catalog_product->getProduct($product['product_id']);
			$this->data['order_products'][] = array(
				'id' => $prod_info['sku'],
				'name' => addslashes($product['name']),
				'price' => (int)$product['price'],
				'quantity' => $product['quantity']
			);
		}

		if ( isset($this->session->data['order_id'])){
			$this->data['transaction'] = array(
				'order_id' => $this->session->data['order_id'],
				'total_price' => $all_price,
				'shipping' => (isset($this->session->data['shipping_method']['cost']) ? $this->session->data['shipping_method']['cost'] : 0)
			);

			$this->data['order_id'] = $this->session->data['order_id'];
			$this->data['all_price'] = $all_price;
		}

		//echo '<pre>';var_dump($products);echo '</pre>';
		if (isset($this->session->data['order_id'])) {
			$this->cart->clear();

			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['guest']);
			unset($this->session->data['comment']);
			unset($this->session->data['order_id']);	
			unset($this->session->data['coupon']);
			unset($this->session->data['reward']);
			unset($this->session->data['voucher']);
			unset($this->session->data['vouchers']);
			unset($this->session->data['totals']);
		}	

		$this->language->load('checkout/success');

		if (! empty($this->session->data['last_order_id']) ) {
			$this->document->setTitle(sprintf($this->language->get('heading_title_customer'), $this->session->data['last_order_id']));
		} else {
			$this->document->setTitle($this->language->get('heading_title'));
		}

		$this->data['breadcrumbs'] = array(); 

		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('common/home'),
			'text'      => $this->language->get('text_home'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('checkout/cart'),
			'text'      => $this->language->get('text_basket'),
			'separator' => $this->language->get('text_separator')
		);

		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('checkout/checkout', '', 'SSL'),
			'text'      => $this->language->get('text_checkout'),
			'separator' => $this->language->get('text_separator')
		);	

		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('checkout/success'),
			'text'      => $this->language->get('text_success'),
			'separator' => $this->language->get('text_separator')
		);

		if (! empty($this->session->data['last_order_id']) ) {
			$this->data['heading_title'] = sprintf($this->language->get('heading_title_customer'), $this->session->data['last_order_id']);
		} else {
			$this->data['heading_title'] = $this->language->get('heading_title');
		}
		
		if ($this->customer->isLogged()) {
			$this->data['text_message'] = sprintf($this->language->get('text_customer'), $this->customer->getFirstName().' '.$this->customer->getLastName(), $this->url->link('account/account', '', 'SSL'), $this->url->link('account/order', '', 'SSL'), $this->url->link('information/contact'), $this->url->link('product/special'), $this->session->data['last_order_id'], $this->url->link('account/download', '', 'SSL'));
		} else {
			$this->data['text_message'] = sprintf($this->language->get('text_guest'), $this->url->link('information/contact'), $this->session->data['last_order_id']);
		}

		$this->data['button_continue'] = $this->language->get('button_continue');

		$this->data['continue'] = $this->url->link('common/home');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/success.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/success.tpl';
		} else {
			$this->template = 'default/template/common/success.tpl';
		}

		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'			
		);

		$this->response->setOutput($this->render());
	}
}
?>
