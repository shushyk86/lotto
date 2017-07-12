<?php 
class ControllerModuleCart extends Controller {
	public function index() {
		$this->language->load('module/cart');

		if (isset($this->request->get['remove'])) {
			$this->cart->remove($this->request->get['remove']);

			unset($this->session->data['vouchers'][$this->request->get['remove']]);
		}
		
/*Additional offer*/
		$this->load->model('module/addspecials');
		$additionaloffers = $this->model_module_addspecials->getOffers();

        if(isset($additionaloffers['active_offer'])){
            $this->data['additionaloffers']['active_offer'] = $additionaloffers['active_offer'];
        }
		
		if(!empty($this->data['additionaloffers']['active_offer'])) {
			$getMaxAvailableItems = $this->cart->getMaxAvailableItems($this->data['additionaloffers']['active_offer']);

			if(is_array($getMaxAvailableItems)){
				$active_offer_max_quantity = $getMaxAvailableItems['max_available_items'];
			} else {
				$active_offer_max_quantity = $getMaxAvailableItems;
			}
			
			$offer_bonuses = $this->model_module_addspecials->getOfferBonuses($this->data['additionaloffers']['active_offer']);
			$active_offer_current_quantity = 0;
			
			foreach($offer_bonuses as $ob){
				if($this->cart->hasProduct($ob['ao_product_id'])){
					$active_offer_current_quantity += $this->cart->getProductQuantity($ob['ao_product_id']);
				}
			}

			$cart_has_bonus = $this->cart->getBonusesInCartByOffer($this->session->data['active_offer']);
			$available_bonus_items = $active_offer_max_quantity - $active_offer_current_quantity;
		}
		
/*Additional offer*/
		
		// Totals
		$this->load->model('setting/extension');

		$total_data = array();					
		$total = 0;
		$taxes = $this->cart->getTaxes();

		// Display prices
		if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
			$sort_order = array(); 

			$results = $this->model_setting_extension->getExtensions('total');

			foreach ($results as $key => $value) {
				$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
			}

			array_multisort($sort_order, SORT_ASC, $results);

			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('total/' . $result['code']);

					$this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
				}

				$sort_order = array(); 

				foreach ($total_data as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}

				array_multisort($sort_order, SORT_ASC, $total_data);			
			}		
		}

		$this->data['totals'] = $total_data;

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_items'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));
		$this->data['text_empty'] = $this->language->get('text_empty');
		$this->data['text_continue'] = $this->language->get('text_continue');
		$this->data['text_checkout'] = $this->language->get('text_checkout');
		$this->data['text_payment_profile'] = $this->language->get('text_payment_profile');

		$this->data['button_remove'] = $this->language->get('button_remove');

		$this->load->model('tool/image');

		$this->data['products'] = array();

		foreach ($this->cart->getProducts() as $product) {
			if ($product['image']) {
				$image = $this->model_tool_image->resize($product['image'], $this->config->get('config_image_cart_width'), $this->config->get('config_image_cart_height'));
			} else {
				$image = '';
			}

			$option_data = array();

			foreach ($product['option'] as $option) {
				if ($option['type'] != 'file') {
					$value = $option['option_value'];	
				} else {
					$filename = $this->encryption->decrypt($option['option_value']);

					$value = utf8_substr($filename, 0, utf8_strrpos($filename, '.'));
				}				

				$option_data[] = array(								   
					'name'  => $option['name'],
					'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value),
					'type'  => $option['type']
				);
			}

			// Display prices
			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$price = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$price = false;
			}

			// Display prices
			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$total = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity']);
			} else {
				$total = false;
			}

/*Additional offer*/
			if(!empty($this->data['additionaloffers']['active_offer'])) {
				foreach($offer_bonuses as $of){
					if($of['ao_product_id'] == $product['product_id']){
						$products_to_ao = $this->model_module_addspecials->getProductsToAdditionalOffer($product['product_id']);
					}
				}
				if(!empty($products_to_ao)) {
					$ao_price = (int)$products_to_ao[0]['price'];
					if($available_bonus_items >= 0) {
						$tt = ($ao_price * $product['quantity']);
					} elseif($available_bonus_items < 0 && count($cart_has_bonus) == 1) {
						$tt = ($price * (-1 * $available_bonus_items)) + ($ao_price * ($product['quantity'] + $available_bonus_items));
					} elseif($available_bonus_items < 0 && count($cart_has_bonus) > 1){
						if($cart_has_bonus[0]['product_id'] == $product['product_id']) {
							if($cart_has_bonus[0]['quantity'] >= $active_offer_max_quantity) {
								$tt = ((($cart_has_bonus[0]['quantity'] - $active_offer_max_quantity) * $price) + ($ao_price * $active_offer_max_quantity));
							} else {
								$tt = (($ao_price * $cart_has_bonus[0]['quantity']));
							}
						} else {
							$left_available_items = $active_offer_max_quantity - $cart_has_bonus[0]['quantity'];
							if($left_available_items >= 0 && $left_available_items < $product['quantity']){
								$tt = ($ao_price * $left_available_items) + (($product['quantity'] - $left_available_items) * $price);
							}
						}
					}
				}
			}
			unset($products_to_ao);

			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				if(isset($tt)) {
					$tt = $this->currency->format($this->tax->calculate($tt, $product['tax_class_id'], $this->config->get('config_tax')));
				} else {
                    $tt = false;
                }
			}
			
/*Additional offer*/			
			
			$this->data['products'][] = array(
				'key'       => $product['key'],
				'thumb'     => $image,
				'name'      => $product['name'],
				'model'     => $product['model'], 
				'option'    => $option_data,
				'quantity'  => $product['quantity'],
				'price'     => $price,
/*Additional offer*/				
			    'total'               => ($tt ? $tt : $total),
/*Additional offer*/
				'href'      => $this->url->link('product/product', 'product_id=' . $product['product_id']),
				'recurring' => $product['recurring'],
				'profile'   => $product['profile_name'],
			);
		}

		// Gift Voucher
		$this->data['vouchers'] = array();

		if (!empty($this->session->data['vouchers'])) {
			foreach ($this->session->data['vouchers'] as $key => $voucher) {
				$this->data['vouchers'][] = array(
					'key'         => $key,
					'description' => $voucher['description'],
					'amount'      => $this->currency->format($voucher['amount'])
				);
			}
		}

		$this->data['cart'] = $this->url->link('checkout/cart');
		
		if(isset($this->data['products']) && count($this->data['products']) > 0) {
			$this->data['cart_class'] = "full-cart";
		} else {
			$this->data['cart_class'] = "empty-cart";
		}
		
		$this->data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/cart.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/cart.tpl';
		} else {
			$this->template = 'default/template/module/cart.tpl';
		}

		$this->response->setOutput($this->render());		
	}
}
?>