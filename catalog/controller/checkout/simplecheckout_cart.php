<?php 
/*
@author    Dmitriy Kubarev
@link    http://www.simpleopencart.com
@link    http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4811
*/  

class ControllerCheckoutSimpleCheckoutCart extends Controller { 
    static $error = array();

    public function index() {

/*Additional offer*/		
		$this->load->model('module/addspecials');
		$additionaloffers = $this->model_module_addspecials->getOffers();
/*Additional offer*/
		
        $this->language->load('checkout/cart');
        $this->language->load('checkout/simplecheckout');
        
        if ($this->config->get('config_customer_price') && !$this->customer->isLogged()) {
            $this->data['attention'] = sprintf($this->language->get('text_login'), $this->url->link('account/login'), $this->url->link('account/simpleregister'));
            $this->simple->block_order = true;
            $this->simple->add_error('cart');
        } else {
            $this->data['attention'] = '';
        }
        
        $this->data['error_warning'] = '';

        if (isset(self::$error['warning'])) {
            $this->data['error_warning'] = self::$error['warning'];
        }

        if (!$this->cart->hasStock()) {
            if ($this->config->get('config_stock_warning')) {
                $this->data['error_warning'] = $this->language->get('error_stock');
            }
            if (!$this->config->get('config_stock_checkout')) {
            //    $this->data['error_warning'] = $this->language->get('error_stock');
                $this->simple->block_order = true;
                $this->simple->add_error('cart');
            }
        }

        $use_total = $this->config->get('simple_use_total');
        $min_amount = $this->config->get('simple_min_amount');
        $max_amount = $this->config->get('simple_max_amount');
        $min_quantity = $this->config->get('simple_min_quantity');
        $max_quantity = $this->config->get('simple_max_quantity');
        $min_weight = $this->config->get('simple_min_weight');
        $max_weight = $this->config->get('simple_max_weight');
       
        if (!empty($min_amount) || !empty($max_amount)) {
            if ($use_total) {
                $cart_subtotal = $this->cart->getTotal();
            } else {
                $cart_subtotal = $this->cart->getSubTotal();
            }
        }

        if (!empty($this->session->data['vouchers'])) {
            foreach ($this->session->data['vouchers'] as $key => $voucher) {
                $cart_subtotal += $voucher['amount'];
            }
        } 
		
        $cart_quantity = $this->cart->countProducts();
        $cart_weight = $this->cart->getWeight();

        $this->data['quantity'] = $cart_quantity;

        if (!empty($min_amount) && $min_amount > $cart_subtotal) {
            $this->simple->block_order = true;
            $this->simple->add_error('cart');    
            $this->data['error_warning'] = sprintf($this->language->get('error_min_amount'),$this->currency->format($min_amount));
        }
        
        if (!empty($max_amount) && $max_amount < $cart_subtotal) {
            $this->simple->block_order = true;    
            $this->simple->add_error('cart');
            $this->data['error_warning'] = sprintf($this->language->get('error_max_amount'),$this->currency->format($max_amount));
        }
            
        if (!empty($min_quantity) && $min_quantity > $cart_quantity) {
            $this->simple->block_order = true;    
            $this->simple->add_error('cart');
            $this->data['error_warning'] = sprintf($this->language->get('error_min_quantity'), $min_quantity);
        }
        
        if (!empty($max_quantity) && $max_quantity < $cart_quantity) {
            $this->simple->block_order = true;
            $this->simple->add_error('cart');    
            $this->data['error_warning'] = sprintf($this->language->get('error_max_quantity'), $max_quantity);
        }
        
        if (!empty($min_weight) && !empty($cart_weight) && $min_weight > $cart_weight) {
            $this->simple->block_order = true;    
            $this->simple->add_error('cart');
            $this->data['error_warning'] = sprintf($this->language->get('error_min_weight'), $min_weight);
        }
        
        if (!empty($max_weight) && !empty($cart_weight) && $max_weight < $cart_weight) {
            $this->simple->block_order = true;
            $this->simple->add_error('cart');    
            $this->data['error_warning'] = sprintf($this->language->get('error_max_weight'), $max_weight);
        }
        
        $this->data['action'] = $this->url->link('checkout/simplecheckout_cart');
        
        $this->load->model('tool/image');
        
        $this->load->library('encryption');
        
        $this->data['column_image']         = $this->language->get('column_image');
        $this->data['column_name']          = $this->language->get('column_name');
        $this->data['column_model']         = $this->language->get('column_model');
        $this->data['column_quantity']      = $this->language->get('column_quantity');
        $this->data['column_price']         = $this->language->get('column_price');
        $this->data['column_total']         = $this->language->get('column_total');
		
		/*Additional offer*/
		$this->data['column_ao'] = $this->language->get('column_ao');
		$this->data['text_ao_del'] = $this->language->get('text_ao_del');
		/*Additional offer*/

        $this->data['text_until_cancelled'] = $this->language->get('text_until_cancelled');
        $this->data['text_freq_day']        = $this->language->get('text_freq_day');
        $this->data['text_freq_week']       = $this->language->get('text_freq_week');
        $this->data['text_freq_month']      = $this->language->get('text_freq_month');
        $this->data['text_freq_bi_month']   = $this->language->get('text_freq_bi_month');
        $this->data['text_freq_year']       = $this->language->get('text_freq_year');
        $this->data['text_trial']           = $this->language->get('text_trial');
        $this->data['text_recurring']       = $this->language->get('text_recurring');
        $this->data['text_length']          = $this->language->get('text_length');
        $this->data['text_recurring_item']  = $this->language->get('text_recurring_item');
        $this->data['text_payment_profile'] = $this->language->get('text_payment_profile');
        $this->data['text_error_stock']     = $this->language->get('error_stock');

		$this->data['text_select'] 			= $this->language->get('text_select');

        $this->data['button_update'] = $this->language->get('button_update');
        $this->data['button_apply'] = $this->language->get('button_apply');

        $this->data['products'] = array();
        
        $this->data['config_stock_warning'] = $this->config->get('config_stock_warning');
        $this->data['config_stock_checkout'] = $this->config->get('config_stock_checkout');
        
        $products = $this->cart->getProducts();
		
/*Additional offer*/
		$this->data['additionaloffers'] = array();
/*Additional offer*/
        
        $points_total = 0;

        $version = $this->simple->opencart_version;

/*Additional offer*/
        $this->data['in_cart'] = false;
        $this->data['additionaloffers']['banners'] = false;

		$this->load->model('catalog/product');
		if(!empty($additionaloffers)){
			$this->data['additionaloffers']['active_offer'] = $additionaloffers['active_offer'];
			if(!empty($additionaloffers['banners'])){
				$this->data['additionaloffers']['banners'] = array();
				foreach($additionaloffers['banners'] as $banner) {
					$img = $this->model_tool_image->resize($banner['image'], 1200, 420);
					$this->data['additionaloffers']['banners'][] = array(
						'image'			=>	$img,
						'description'	=>	html_entity_decode($banner['description'], ENT_QUOTES, 'UTF-8'),
						'offer_id'		=>	$banner['offer_id']
					);
				}
			}
			
			foreach($additionaloffers['offers'] as $offer_id) {
				$additionaloffer = $this->model_module_addspecials->getOffer($offer_id);
				
				foreach($additionaloffer['ao_products'] as $ao_product){
					$ao_product = $this->model_catalog_product->getProduct($ao_product);

                    if($ao_product['quantity'] > 0) {

                        if ($ao_product['image']) {
                            $image_cart_width = $this->config->get('config_image_cart_width');
                            $image_cart_width = $image_cart_width ? $image_cart_width : 40;
                            $image_cart_height = $this->config->get('config_image_cart_height');
                            $image_cart_height = $image_cart_height ? $image_cart_height : 40;
                            $image_ao = $this->model_tool_image->resize($ao_product['image'], $image_cart_width, $image_cart_height);
                        } else {
                            $image_ao = '';
                        }

                        if ($additionaloffer['discount_type'] == "percent") {
                            $ao_product_real_price = $ao_product['price'];
                            $price_ao = $this->currency->format($this->tax->calculate(floor(((100 - $additionaloffer['price']) / 100) * (int)$ao_product_real_price), $ao_product['tax_class_id'], false));
                            $discount = "<p style='color: red; padding: 10px 15px; font-size: 20px;'> (-" . (int)$additionaloffer['price'] . "%)</p>";
                        } else {
                            if ($additionaloffer['price'] > 0) {
                                $price_ao = $this->currency->format($this->tax->calculate($additionaloffer['price'], $ao_product['tax_class_id'], false));
                            } else {
                                $price_ao = 0;
                            }
                        }
                        $in_cart = false;
                        if (!empty($this->data['additionaloffers']['active_offer'])) {
                            $offer_bonuses = $this->model_module_addspecials->getOfferBonuses($this->data['additionaloffers']['active_offer']);

                            foreach ($offer_bonuses as $ob) {
                                if ($this->cart->hasProduct($ob['ao_product_id']) && $ao_product['product_id'] == $ob['ao_product_id']) {
                                    $in_cart = true;
                                    $this->data['in_cart'] = true;
                                }
                            }
                        }

                        $product_options = array();

                        foreach ($this->model_catalog_product->getProductOptions($ao_product['product_id']) as $option) {
                            if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'checkbox' || $option['type'] == 'image') {
                                $option_value_data = array();

                                foreach ($option['option_value'] as $option_value) {
                                    if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
                                        if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
                                            $price = $this->currency->format($this->tax->calculate($option_value['price'], $ao_product['tax_class_id'], $this->config->get('config_tax')));
                                        } else {
                                            $price = false;
                                        }

                                        $option_value_data[] = array(
                                            'product_option_value_id' => $option_value['product_option_value_id'],
                                            'option_value_id' => $option_value['option_value_id'],
                                            'name' => $option_value['name'],
                                            'image' => $this->model_tool_image->resize($option_value['image'], 50, 50),
                                            'price' => $price,
                                            'price_prefix' => $option_value['price_prefix']
                                        );
                                    }
                                }

                                $product_options[] = array(
                                    'product_option_id' => $option['product_option_id'],
                                    'option_id' => $option['option_id'],
                                    'name' => $option['name'],
                                    'type' => $option['type'],
                                    'option_value' => $option_value_data,
                                    'required' => $option['required']
                                );
                            } elseif ($option['type'] == 'text' || $option['type'] == 'textarea' || $option['type'] == 'file' || $option['type'] == 'date' || $option['type'] == 'datetime' || $option['type'] == 'time') {
                                $product_options[] = array(
                                    'product_option_id' => $option['product_option_id'],
                                    'option_id' => $option['option_id'],
                                    'name' => $option['name'],
                                    'type' => $option['type'],
                                    'option_value' => $option['option_value'],
                                    'required' => $option['required']
                                );
                            }
                        }

                        $this->data['additionaloffers']['offers'][$offer_id][] = array(
                            'in_cart' => $in_cart,
                            'product_id' => $ao_product['product_id'],
                            'options' => $product_options,
                            'thumb' => $image_ao,
                            'name' => $ao_product['name'],
                            'price' => $price_ao,
                            'sku' => $ao_product['sku'],
                            'discount' => $discount,
                            'offer_name' => $additionaloffer['offer_name'],
                            'model' => $ao_product['model'],
                            'href' => $this->url->link('product/product', 'product_id=' . $ao_product['product_id']),
                            'key' => $ao_product['product_id'] . '::'
                        );
                    }
				}
					
				$offer_bonus = $this->model_module_addspecials->getOfferBonuses($offer_id);
                $curr_quant = 0;
				foreach($offer_bonus as $ob){
					if($this->cart->hasProduct($ob['ao_product_id'])){
						$curr_quant += $this->cart->getProductQuantity($ob['ao_product_id']);
					}
				}
				
				if(($this->model_module_addspecials->getMaxAvailableItems($offer_id) - $curr_quant) > 0) {
					$quant = $this->model_module_addspecials->getMaxAvailableItems($offer_id) - $curr_quant;
				} else {
					$quant = 0;
				}
					
				$this->data['additionaloffers']['max_quantity'][$offer_id] = $quant;
				unset($quant);
				unset($key);
				unset($offer_bonus);
				unset($curr_quant);				
				unset($discount);				
			}
		}
				
		$this->data['show_active'] = false;
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

			if(isset($active_offer_max_quantity) && $active_offer_max_quantity <= $active_offer_current_quantity){
				$this->data['show_active'] = true;
			}
			
			$cart_has_bonus = $this->cart->getBonusesInCartByOffer($this->session->data['active_offer']);
			$available_bonus_items = $active_offer_max_quantity - $active_offer_current_quantity;
		}

/*Additional offer*/
        foreach ($products as $product) {
			
            $product_total = 0;
                
            foreach ($products as $product_2) {
                if ($product_2['product_id'] == $product['product_id']) {
                    $product_total += $product_2['quantity'];
                }
            }        
			
            if ($product['minimum'] > $product_total) {
                $this->data['error_warning'] = sprintf($this->language->get('error_minimum'), $product['name'], $product['minimum']);
                $this->simple->block_order = true;
                $this->simple->add_error('cart');
            }
            
            $option_data = array();

            foreach ($product['option'] as $option) {
                if ($option['type'] != 'file') {
                    $value = $option['option_value'];    
                } else {
                    $encryption = new Encryption($this->config->get('config_encryption'));
                    $option_value = $encryption->decrypt($option['option_value']);
                    $filename = substr($option_value, 0, strrpos($option_value, '.'));
                    $value = $filename;
                }
                
                $option_data[] = array(
                    'name'  => $option['name'],
                    'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
                );
            }
            
            if ($product['image']) {
                $image_cart_width = $this->config->get('config_image_cart_width');
                $image_cart_width = $image_cart_width ? $image_cart_width : 40;
                $image_cart_height = $this->config->get('config_image_cart_height');
                $image_cart_height = $image_cart_height ? $image_cart_height : 40;
                $image = $this->model_tool_image->resize($product['image'], $image_cart_width, $image_cart_height);
            } else {
                $image = '';
            }
            
            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $price = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $price = false;
            }

            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $total = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity']);
            } else {
                $total = false;
            }

/*Additional offer*/
			
			if(!empty($this->data['additionaloffers']['active_offer'])) {
				$additionaloffer = $this->model_module_addspecials->getOffer($this->data['additionaloffers']['active_offer']);
				foreach($offer_bonuses as $of){
					if($of['ao_product_id'] == $product['product_id']){
						$products_to_ao = $this->model_module_addspecials->getProductsToAdditionalOffer($product['product_id']);
					}
				}
				if(!empty($products_to_ao)) {
				
					$ao_product = $this->model_catalog_product->getProduct($product['product_id']);
					if ($additionaloffer['discount_type'] == "percent") {
						$ao_product_real_price = $ao_product['price'];
						$ao_price = floor(((100 - $additionaloffer['price']) / 100) * (int)$ao_product_real_price);
					} else {
						if ($additionaloffer['price'] > 0) {
							$ao_price = $additionaloffer['price'];
						} else {
							$ao_price = 0;
						}
					}

					if($available_bonus_items >= 0) {
						$tt = ($ao_price * $product['quantity']);
                        $ao_points = 0;
					} elseif($available_bonus_items < 0 && count($cart_has_bonus) == 1) {
						$tt = ($price * (-1 * $available_bonus_items)) + ($ao_price * ($product['quantity'] + $available_bonus_items));
                        $ao_points = ($price * (-1 * $available_bonus_items));
					} elseif($available_bonus_items < 0 && count($cart_has_bonus) > 1){
						if($cart_has_bonus[0]['key'] == $product['key']) {
							if($cart_has_bonus[0]['quantity'] >= $active_offer_max_quantity) {
								$tt = ((($cart_has_bonus[0]['quantity'] - $active_offer_max_quantity) * $price) + ($ao_price * $active_offer_max_quantity));
                                $ao_points = (($cart_has_bonus[0]['quantity'] - $active_offer_max_quantity) * $price);
							} else {
								$tt = (($ao_price * $cart_has_bonus[0]['quantity']));
                                $ao_points = 0;
							}
						} else {							
							if(!isset($left_available_items)){
								$left_available_items = $active_offer_max_quantity - $cart_has_bonus[0]['quantity'];
							}
							if($left_available_items >= 0 && $left_available_items < $product['quantity']){
								$tt = ($ao_price * $left_available_items) + (($product['quantity'] - $left_available_items) * $price);

                                $ao_points = ($product['quantity'] - $left_available_items) * $price;

								$left_available_items -= $product['quantity'];
							} elseif($left_available_items >= 0 && $left_available_items >= $product['quantity']){
								$tt = ($ao_price * $product['quantity']);
                                $ao_points = 0;
								$left_available_items -= $product['quantity'];
							}
						}
					}
				}
			}
			unset($products_to_ao);
			
			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				if(isset($tt)) {
					$tt = $this->currency->format($this->tax->calculate($tt, $product['tax_class_id'], $this->config->get('config_tax')));
				}
			}
	
/*Additional offer*/
			
            if ($version >= 156) {
                $profile_description = '';
                    
                if ($product['recurring']) {
                    $frequencies = array(
                        'day'        => $this->language->get('text_day'),
                        'week'       => $this->language->get('text_week'),
                        'semi_month' => $this->language->get('text_semi_month'),
                        'month'      => $this->language->get('text_month'),
                        'year'       => $this->language->get('text_year'),
                    );

                    if ($product['recurring_trial']) {
                        $recurring_price = $this->currency->format($this->tax->calculate($product['recurring_trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')));
                        $profile_description = sprintf($this->language->get('text_trial_description'), $recurring_price, $product['recurring_trial_cycle'], $frequencies[$product['recurring_trial_frequency']], $product['recurring_trial_duration']) . ' ';
                    }

                    $recurring_price = $this->currency->format($this->tax->calculate($product['recurring_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')));

                    if ($product['recurring_duration']) {
                        $profile_description .= sprintf($this->language->get('text_payment_description'), $recurring_price, $product['recurring_cycle'], $frequencies[$product['recurring_frequency']], $product['recurring_duration']);
                    } else {
                        $profile_description .= sprintf($this->language->get('text_payment_until_canceled_description'), $recurring_price, $product['recurring_cycle'], $frequencies[$product['recurring_frequency']], $product['recurring_duration']);
                    }
                }

                if(isset($tt)){
                    $tot = $tt;
                } else {
                    $tot = $total;
                }

                $this->data['products'][] = array(
                    'key'                 => $product['key'],
                    'thumb'               => $image,
                    'name'                => $product['name'],
                    'model'               => $product['model'],
                    'sku'                 => $product['sku'],
                    'option'              => $option_data,
                    'quantity'            => $product['quantity'],
                    'stock'               => $product['stock'],
                    'reward'              => sprintf($this->language->get('text_reward'), round((int)$price * $product['quantity'] * 0.05)),
                    'price'               => $price,
                    'clear_price'         => $product['price'],
/*Additional offer*/
			                  'total'               => $tot,
                    'href'                => $this->url->link('product/product', 'product_id=' . $product['product_id']),
                    'recurring'           => $product['recurring'],
                    'profile_name'        => $product['profile_name'],
                    'profile_description' => $profile_description,
                );
            } else {
                $this->data['products'][] = array(
                    'key'      => $product['key'],
                    'thumb'    => $image,
                    'name'     => $product['name'],
                    'model'    => $product['model'],
                    'sku'      => $product['sku'],
                    'option'   => $option_data,
                    'quantity' => $product['quantity'],
                    'stock'    => $product['stock'],
                    'reward'   => ($product['reward'] ? sprintf($this->language->get('text_reward'), $product['reward']) : ''),
                    'price'    => $price,
                    'clear_price'  => $product['price'],
/*Additional offer*/
			                    'total'    => ($tt ? $tt : $total),
                    'href'     => $this->url->link('product/product', 'product_id=' . $product['product_id'])
                );
            }

            if(!$this->model_catalog_product->hasSaleCategory($product['product_id'])){
                if(!isset($ao_points)){
                    $points_total += ($product['price'] * 0.1)*$product['quantity'];
                } else {
                    $points_total += $ao_points * 0.1;
                    unset($ao_points);
                }
            }

/*Additional offer*/	
			unset($tt);
/*Additional offer*/
			
        }

/*Additional offer*/
        if(!empty($additionaloffers)) {
            foreach ($this->data['additionaloffers']['offers'] as $offer_id => $offer_products) {
                $summ = $this->model_module_addspecials->getOfferSumm($offer_id);
                if ($summ > $this->cart->getSubTotal()) {
                    unset($this->data['additionaloffers']['offers'][$offer_id]);
                }
            }
        }
/*Additional offer*/

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
        
        $total_data = array();
        $total = 0;
        $taxes = $this->cart->getTaxes();
        
        $this->data['modules'] = array();
        
        if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {                         
            $this->load->model('setting/extension');
            
            $sort_order = array(); 
            
            $results = $this->model_setting_extension->getExtensions('total');
            
            foreach ($results as $key => $value) {
                $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
            }
            
            array_multisort($sort_order, SORT_ASC, $results);
            
            foreach ($results as $result) {
                if($result['code'] == 'cartsummdiscounts' && (isset($this->session->data['coupon']) && !empty($this->session->data['coupon'])) || $result['code'] == 'cartsummdiscounts' && (isset($this->session->data['reward']) && !empty($this->session->data['reward'])) || $result['code'] == 'coupon' && (isset($this->session->data['reward']) && !empty($this->session->data['reward'])) || $result['code'] == 'reward' && (isset($this->session->data['coupon']) && !empty($this->session->data['coupon']))){
                    unset($result);
                    continue;
                }
                if ($this->config->get($result['code'] . '_status')) {
                    $this->load->model('total/' . $result['code']);
    
                    $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
                    
                    $this->data['modules'][$result['code']] = true;
                }
            }
            
            $sort_order = array(); 
          
            foreach ($total_data as $key => $value) {
                $sort_order[$key] = $value['sort_order'];
            }

            array_multisort($sort_order, SORT_ASC, $total_data);
        }

        $this->data['totals'] = $total_data;
        
        $this->data['entry_coupon'] = $this->language->get('entry_coupon');
        $this->data['entry_voucher'] = $this->language->get('entry_voucher');

        $points = $this->customer->getRewardPoints();
        $this->data['user_points'] = $points;
        $points_to_use = floor($points > $points_total ? $points_total : $points);
        $this->data['points'] = $points_to_use;

        $this->data['entry_reward'] = sprintf($this->language->get('entry_reward'), $points_to_use);

        $this->data['reward'] = isset($this->session->data['reward']) ? $this->session->data['reward'] : $points_to_use;
        $this->data['reward_current'] = isset($this->session->data['reward']) ? $this->session->data['reward'] : '';
        $this->data['voucher'] = isset($this->session->data['voucher']) ? $this->session->data['voucher'] : '';
        $this->data['coupon'] = isset($this->session->data['coupon']) ? $this->session->data['coupon'] : '';
         
        $this->data['simple_show_weight'] = $this->config->get('simple_show_weight');
        
        $this->data['simple'] = $this->simple;

        if ($this->data['simple_show_weight']) {
            $this->data['weight'] = $this->weight->format($this->cart->getWeight(), $this->config->get('config_weight_class_id'), $this->language->get('decimal_point'), $this->language->get('thousand_point'));
        }

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/simplecheckout_cart.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/checkout/simplecheckout_cart.tpl';
            $this->data['template'] = $this->config->get('config_template');
        } else {
            $this->template = 'default/template/checkout/simplecheckout_cart.tpl';
            $this->data['template'] = 'default';
        }
        
        $current_theme = $this->config->get('config_template');
        
        if ($current_theme == 'shoppica' || $current_theme == 'shoppica2') {
            $this->data['cart_total'] = $this->currency->format($total);
        } else {
            $this->data['cart_total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));
        }
        
		$this->data['prod_amount'] = $this->cart->countProducts();
		
        if ($this->simple->get_simple_steps() && $this->simple->get_simple_steps_summary()) {
            $this->set_summary_info();
        }

        $this->response->setOutput($this->render());  
    }
	
    private function set_summary_info() {
        $this->data['text_summary_comment']          = $this->language->get('text_summary_comment');
        $this->data['text_summary_shipping_address'] = $this->language->get('text_summary_shipping_address');
        $this->data['text_summary_payment_address']  = $this->language->get('text_summary_payment_address');

        $payment_address_format = $this->simple->payment_address['address_format'];

        if (!empty($payment_address_format)) {
            $format = $payment_address_format;
        } else {
            $format = '{firstname} {lastname}' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city} {postcode}' . "\n" . '{zone}' . "\n" . '{country}';
        }
        
        $find = array(
            '{firstname}',
            '{lastname}',
            '{company}',
            '{address_1}',
            '{address_2}',
            '{city}',
            '{postcode}',
            '{zone}',
            '{zone_code}',
            '{country}'
        );
        
        $replace = array(
            'firstname' => $this->simple->payment_address['firstname'],
            'lastname'  => $this->simple->payment_address['lastname'],
            'company'   => $this->simple->payment_address['company'],
            'address_1' => $this->simple->payment_address['address_1'],
            'address_2' => $this->simple->payment_address['address_2'],
            'city'      => $this->simple->payment_address['city'],
            'postcode'  => $this->simple->payment_address['postcode'],
            'zone'      => $this->simple->payment_address['zone'],
            'zone_code' => $this->simple->payment_address['zone_code'],
            'country'   => $this->simple->payment_address['country']  
        );
        
        $this->data['summary_payment_address'] = trim(str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format)))));                     
        
        $this->data['summary_shipping_address'] = '';

        if ($this->cart->hasShipping()) {
            $shipping_address_format = $this->simple->shipping_address['address_format'];

            if (!empty($shipping_address_format)) {
                $format = $shipping_address_format;
            } else {
                $format = '{firstname} {lastname}' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city} {postcode}' . "\n" . '{zone}' . "\n" . '{country}';
            }
            
            $find = array(
                '{firstname}',
                '{lastname}',
                '{company}',
                '{address_1}',
                '{address_2}',
                '{city}',
                '{postcode}',
                '{zone}',
                '{zone_code}',
                '{country}'
            );
            
            $replace = array(
                'firstname' => $this->simple->shipping_address['firstname'],
                'lastname'  => $this->simple->shipping_address['lastname'],
                'company'   => $this->simple->shipping_address['company'],
                'address_1' => $this->simple->shipping_address['address_1'],
                'address_2' => $this->simple->shipping_address['address_2'],
                'city'      => $this->simple->shipping_address['city'],
                'postcode'  => $this->simple->shipping_address['postcode'],
                'zone'      => $this->simple->shipping_address['zone'],
                'zone_code' => $this->simple->shipping_address['zone_code'],
                'country'   => $this->simple->shipping_address['country']  
            );
            
            $this->data['summary_shipping_address'] = trim(str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format)))));                     
        }
        
        $this->data['summary_comment']               = $this->simple->comment;
    }
	
    public function update() {
        if (!isset($this->session->data['vouchers'])) {
            $this->session->data['vouchers'] = array();
        }
        
        // Update
        if (!empty($this->request->post['quantity'])) {
            $keys =  isset($this->session->data['cart']) ? $this->session->data['cart'] : array();
            foreach ($this->request->post['quantity'] as $key => $value) {
                if (!empty($keys) && array_key_exists($key, $keys)) {
                    $this->cart->update($key, $value);
                }
            }
        }
        
        // Remove
        if (!empty($this->request->post['remove'])) {
            $this->cart->remove($this->request->post['remove']);			
            unset($this->session->data['vouchers'][$this->request->post['remove']]);
        }
        
        // Coupon    
        if (isset($this->request->post['coupon']) && $this->validateCoupon()) { 
            $this->session->data['coupon'] = $this->request->post['coupon'];
        }
        
        // Voucher
        if (isset($this->request->post['voucher']) && $this->validateVoucher()) { 
            $this->session->data['voucher'] = $this->request->post['voucher'];
        }

        if (!empty($this->request->post['quantity']) || !empty($this->request->post['remove']) || !empty($this->request->post['voucher'])) {
            unset($this->session->data['reward']);
        }

        // Reward
        if (isset($this->request->post['reward']) && $this->validateReward()) {
            $this->session->data['reward'] = $this->request->post['reward'];
        }

        if (!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) {
            if (!isset($this->request->server['HTTP_X_REQUESTED_WITH']) || $this->request->server['HTTP_X_REQUESTED_WITH'] != 'XMLHttpRequest') {
                $this->redirect($this->url->link('checkout/simplecheckout', '', 'SSL'));                
            } else {
                $this->simple->redirect = $this->url->link('checkout/simplecheckout', '', 'SSL');    
            }
        }
    }
    
    private function validateCoupon() {
        $this->load->model('checkout/coupon');

        $error = false;
                
        if (!empty($this->request->post['coupon'])) {
            $coupon_info = $this->model_checkout_coupon->getCoupon($this->request->post['coupon']);            
            
            if (!$coupon_info) {            
                self::$error['warning'] = $this->language->get('error_coupon');
                $error = true;
            }
        }
        
        return !$error;
    }
    
    private function validateVoucher() {
        $this->load->model('checkout/voucher');

        $error = false;
            
        if (!empty($this->request->post['voucher'])) {
            $voucher_info = $this->model_checkout_voucher->getVoucher($this->request->post['voucher']);            
            
            if (!$voucher_info) {            
                self::$error['warning'] = $this->language->get('error_voucher');
                $error = true;
            }
        }
        
        return !$error;      
    }

    private function validateReward() {
        $error = false;

        if (!empty($this->request->post['reward'])) {
            $this->load->model('catalog/product');

            /*Additional offer*/
            $this->load->model('module/addspecials');
            $additionaloffers = $this->model_module_addspecials->getOffers();

            if(!empty($additionaloffers['active_offer'])) {
                $getMaxAvailableItems = $this->cart->getMaxAvailableItems($additionaloffers['active_offer']);

                if(is_array($getMaxAvailableItems)){
                    $active_offer_max_quantity = $getMaxAvailableItems['max_available_items'];
                } else {
                    $active_offer_max_quantity = $getMaxAvailableItems;
                }

                $offer_bonuses = $this->model_module_addspecials->getOfferBonuses($additionaloffers['active_offer']);
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

            $points = $this->customer->getRewardPoints();

            $points_total = 0;

            foreach ($this->cart->getProducts() as $product) {
                if(!empty($additionaloffers['active_offer'])) {
                    foreach($offer_bonuses as $of){
                        if($of['ao_product_id'] == $product['product_id']){
                            $products_to_ao = $this->model_module_addspecials->getProductsToAdditionalOffer($product['product_id']);
                        }
                    }

                    if(!empty($products_to_ao)) {
                        if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                            $price = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')));
                        } else {
                            $price = false;
                        }

                        if ($available_bonus_items >= 0) {
                            $ao_points = 0;
                        } elseif ($available_bonus_items < 0 && count($cart_has_bonus) == 1) {
                            $ao_points = ($price * (-1 * $available_bonus_items));
                        } elseif ($available_bonus_items < 0 && count($cart_has_bonus) > 1) {
                            if ($cart_has_bonus[0]['key'] == $product['key']) {
                                if ($cart_has_bonus[0]['quantity'] >= $active_offer_max_quantity) {
                                    $ao_points = (($cart_has_bonus[0]['quantity'] - $active_offer_max_quantity) * $price);
                                } else {
                                    $ao_points = 0;
                                }
                            } else {
                                if (!isset($left_available_items)) {
                                    $left_available_items = $active_offer_max_quantity - $cart_has_bonus[0]['quantity'];
                                }
                                if ($left_available_items >= 0 && $left_available_items < $product['quantity']) {
                                    $ao_points = ($product['quantity'] - $left_available_items) * $price;
                                    $left_available_items -= $product['quantity'];
                                } elseif ($left_available_items >= 0 && $left_available_items >= $product['quantity']) {
                                    $ao_points = 0;
                                    $left_available_items -= $product['quantity'];
                                }
                            }
                        }

                    }
                    unset($products_to_ao);
                }

                if(!$this->model_catalog_product->hasSaleCategory($product['product_id'])){
                    if(!isset($ao_points)){
                        $points_total += ($product['price'] * 0.1)*$product['quantity'];
                    } else {
                        $points_total += $ao_points * 0.1;
                        unset($ao_points);
                    }
                }
            }

            if ($this->request->post['reward'] > $points) {
                self::$error['warning'] = sprintf($this->language->get('error_points'), $this->request->post['reward']);
                $error = true;
            }

            if ($this->request->post['reward'] > floor($points_total)) {
                self::$error['warning'] = sprintf($this->language->get('error_maximum'), floor($points_total));
                $error = true;
            }
        } else {
            $error = true;
        }

        return !$error;
    }
}
?>