<?php
class Cart {
	private $config;
	private $db;
	private $data = array();
	private $data_recurring = array();

	public function __construct($registry) {
		$this->config = $registry->get('config');
		$this->customer = $registry->get('customer');
		$this->session = $registry->get('session');
		$this->db = $registry->get('db');
		$this->tax = $registry->get('tax');
		$this->weight = $registry->get('weight');

		if (!isset($this->session->data['cart']) || !is_array($this->session->data['cart'])) {
			$this->session->data['cart'] = array();
		}
	}

	public function getProducts() {
	//	if (!$this->data) {

/*Additional offer*/		
			
			if(isset($this->session->data['active_offer'])) {
				$cart_has_bonus = $this->getBonusesInCartByOffer($this->session->data['active_offer']);
				$additionaloffers['active_offer'] = $this->session->data['active_offer'];
			}
			
			
			if(!empty($additionaloffers['active_offer'])) {
				$getMaxAvailableItems = $this->getMaxAvailableItems($additionaloffers['active_offer']);
				
				if(is_array($getMaxAvailableItems)){
					$active_offer_max_quantity = $getMaxAvailableItems['max_available_items'];
				} else {
					$active_offer_max_quantity = $getMaxAvailableItems;
				}
				$offer_bonuses = $this->getOfferBonuses($additionaloffers['active_offer']);
			
				$active_offer_current_quantity = 0;
				foreach($offer_bonuses as $ob){
					if($this->hasProduct($ob['ao_product_id'])){
						$active_offer_current_quantity += $this->getProductQuantity($ob['ao_product_id']);
					}
				}

				$available_bonus_items = $active_offer_max_quantity - $active_offer_current_quantity;
			}

			if(isset($getMaxAvailableItems) && is_array($getMaxAvailableItems) && $getMaxAvailableItems['available_bonus_items'] != 0) {
				$available_bonus_items = $getMaxAvailableItems['available_bonus_items'];
			}

/*Additional offer*/

			foreach ($this->session->data['cart'] as $key => $quantity) {
				$product = explode(':', $key);
				$product_id = $product[0];
				$stock = true;

				// Options
				if (!empty($product[1])) {
					$str = str_replace("PLUSWASHERE", "+", $product[1]);
					$str = str_replace("SLASHWASHERE", "/", $str);
					$str = str_replace("EQUALWASHERE", "=", $str);
					$str = base64_decode($str);
					$options = unserialize($str);
				} else {
					$options = array();
				} 

				// Profile

				if (!empty($product[2])) {
					$profile_id = $product[2];
				} else {
					$profile_id = 0;
				}

				$product_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.date_available <= NOW() AND p.status = '1'");

				if ($product_query->num_rows) {
					$option_price = 0;
					$option_points = 0;
					$option_weight = 0;

					$option_data = array();

					foreach ($options as $product_option_id => $option_value) {
						$option_query = $this->db->query("SELECT po.product_option_id, po.option_id, od.name, o.type FROM " . DB_PREFIX . "product_option po LEFT JOIN `" . DB_PREFIX . "option` o ON (po.option_id = o.option_id) LEFT JOIN " . DB_PREFIX . "option_description od ON (o.option_id = od.option_id) WHERE po.product_option_id = '" . (int)$product_option_id . "' AND po.product_id = '" . (int)$product_id . "' AND od.language_id = '" . (int)$this->config->get('config_language_id') . "'");

						if ($option_query->num_rows) {
							if ($option_query->row['type'] == 'select' || $option_query->row['type'] == 'radio' || $option_query->row['type'] == 'image') {
								$option_value_query = $this->db->query("SELECT pov.option_value_id, ovd.name, pov.quantity, pov.subtract, pov.price, pov.price_prefix, pov.points, pov.points_prefix, pov.weight, pov.weight_prefix FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE pov.product_option_value_id = '" . (int)$option_value . "' AND pov.product_option_id = '" . (int)$product_option_id . "' AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

								if ($option_value_query->num_rows) {
									if ($option_value_query->row['price_prefix'] == '+') {
										$option_price += $option_value_query->row['price'];
									} elseif ($option_value_query->row['price_prefix'] == '-') {
										$option_price -= $option_value_query->row['price'];
									}

									if ($option_value_query->row['points_prefix'] == '+') {
										$option_points += $option_value_query->row['points'];
									} elseif ($option_value_query->row['points_prefix'] == '-') {
										$option_points -= $option_value_query->row['points'];
									}

									if ($option_value_query->row['weight_prefix'] == '+') {
										$option_weight += $option_value_query->row['weight'];
									} elseif ($option_value_query->row['weight_prefix'] == '-') {
										$option_weight -= $option_value_query->row['weight'];
									}

									if ($option_value_query->row['subtract'] && (!$option_value_query->row['quantity'] || ($option_value_query->row['quantity'] < $quantity))) {
										$stock = false;
									}

									$option_data[] = array(
										'product_option_id'       => $product_option_id,
										'product_option_value_id' => $option_value,
										'option_id'               => $option_query->row['option_id'],
										'option_value_id'         => $option_value_query->row['option_value_id'],
										'name'                    => $option_query->row['name'],
										'option_value'            => $option_value_query->row['name'],
										'type'                    => $option_query->row['type'],
										'quantity'                => $option_value_query->row['quantity'],
										'subtract'                => $option_value_query->row['subtract'],
										'price'                   => $option_value_query->row['price'],
										'price_prefix'            => $option_value_query->row['price_prefix'],
										'points'                  => $option_value_query->row['points'],
										'points_prefix'           => $option_value_query->row['points_prefix'],									
										'weight'                  => $option_value_query->row['weight'],
										'weight_prefix'           => $option_value_query->row['weight_prefix']
									);								
								}
							} elseif ($option_query->row['type'] == 'checkbox' && is_array($option_value)) {
								foreach ($option_value as $product_option_value_id) {
									$option_value_query = $this->db->query("SELECT pov.option_value_id, ovd.name, pov.quantity, pov.subtract, pov.price, pov.price_prefix, pov.points, pov.points_prefix, pov.weight, pov.weight_prefix FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE pov.product_option_value_id = '" . (int)$product_option_value_id . "' AND pov.product_option_id = '" . (int)$product_option_id . "' AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

									if ($option_value_query->num_rows) {
										if ($option_value_query->row['price_prefix'] == '+') {
											$option_price += $option_value_query->row['price'];
										} elseif ($option_value_query->row['price_prefix'] == '-') {
											$option_price -= $option_value_query->row['price'];
										}

										if ($option_value_query->row['points_prefix'] == '+') {
											$option_points += $option_value_query->row['points'];
										} elseif ($option_value_query->row['points_prefix'] == '-') {
											$option_points -= $option_value_query->row['points'];
										}

										if ($option_value_query->row['weight_prefix'] == '+') {
											$option_weight += $option_value_query->row['weight'];
										} elseif ($option_value_query->row['weight_prefix'] == '-') {
											$option_weight -= $option_value_query->row['weight'];
										}

										if ($option_value_query->row['subtract'] && (!$option_value_query->row['quantity'] || ($option_value_query->row['quantity'] < $quantity))) {
											$stock = false;
										}

										$option_data[] = array(
											'product_option_id'       => $product_option_id,
											'product_option_value_id' => $product_option_value_id,
											'option_id'               => $option_query->row['option_id'],
											'option_value_id'         => $option_value_query->row['option_value_id'],
											'name'                    => $option_query->row['name'],
											'option_value'            => $option_value_query->row['name'],
											'type'                    => $option_query->row['type'],
											'quantity'                => $option_value_query->row['quantity'],
											'subtract'                => $option_value_query->row['subtract'],
											'price'                   => $option_value_query->row['price'],
											'price_prefix'            => $option_value_query->row['price_prefix'],
											'points'                  => $option_value_query->row['points'],
											'points_prefix'           => $option_value_query->row['points_prefix'],
											'weight'                  => $option_value_query->row['weight'],
											'weight_prefix'           => $option_value_query->row['weight_prefix']
										);								
									}
								}						
							} elseif ($option_query->row['type'] == 'text' || $option_query->row['type'] == 'textarea' || $option_query->row['type'] == 'file' || $option_query->row['type'] == 'date' || $option_query->row['type'] == 'datetime' || $option_query->row['type'] == 'time') {
								$option_data[] = array(
									'product_option_id'       => $product_option_id,
									'product_option_value_id' => '',
									'option_id'               => $option_query->row['option_id'],
									'option_value_id'         => '',
									'name'                    => $option_query->row['name'],
									'option_value'            => $option_value,
									'type'                    => $option_query->row['type'],
									'quantity'                => '',
									'subtract'                => '',
									'price'                   => '',
									'price_prefix'            => '',
									'points'                  => '',
									'points_prefix'           => '',								
									'weight'                  => '',
									'weight_prefix'           => ''
								);						
							}
						}
					} 

					if ($this->customer->isLogged()) {
						$customer_group_id = $this->customer->getCustomerGroupId();
					} else {
						$customer_group_id = $this->config->get('config_customer_group_id');
					}

					$price = $product_query->row['price'];

					// Product Discounts
					$discount_quantity = 0;

					foreach ($this->session->data['cart'] as $key_2 => $quantity_2) {
						$product_2 = explode(':', $key_2);

						if ($product_2[0] == $product_id) {
							$discount_quantity += $quantity_2;
						}
					}

					$product_discount_query = $this->db->query("SELECT price FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND quantity <= '" . (int)$discount_quantity . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY quantity DESC, priority ASC, price ASC LIMIT 1");

					if ($product_discount_query->num_rows) {
						$price = $product_discount_query->row['price'];
					}

					// Product Specials
					$product_special_query = $this->db->query("SELECT price FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC LIMIT 1");

					if ($product_special_query->num_rows) {
						$price = $product_special_query->row['price'];
					}						

					// Reward Points
					$product_reward_query = $this->db->query("SELECT points FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "'");

					if ($product_reward_query->num_rows) {	
						$reward = $product_reward_query->row['points'];
					} else {
						$reward = 0;
					}

					// Downloads		
					$download_data = array();     		

					$download_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_download p2d LEFT JOIN " . DB_PREFIX . "download d ON (p2d.download_id = d.download_id) LEFT JOIN " . DB_PREFIX . "download_description dd ON (d.download_id = dd.download_id) WHERE p2d.product_id = '" . (int)$product_id . "' AND dd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

					foreach ($download_query->rows as $download) {
						$download_data[] = array(
							'download_id' => $download['download_id'],
							'name'        => $download['name'],
							'filename'    => $download['filename'],
							'mask'        => $download['mask'],
							'remaining'   => $download['remaining']
						);
					}

					// Stock
					if (!$product_query->row['quantity'] || ($product_query->row['quantity'] < $quantity)) {
						$stock = false;
					}

					$recurring = false;
					$recurring_frequency = 0;
					$recurring_price = 0;
					$recurring_cycle = 0;
					$recurring_duration = 0;
					$recurring_trial_status = 0;
					$recurring_trial_price = 0;
					$recurring_trial_cycle = 0;
					$recurring_trial_duration = 0;
					$recurring_trial_frequency = 0;
					$profile_name = '';

					if ($profile_id) {
						$profile_info = $this->db->query("SELECT * FROM `" . DB_PREFIX . "profile` `p` JOIN `" . DB_PREFIX . "product_profile` `pp` ON `pp`.`profile_id` = `p`.`profile_id` AND `pp`.`product_id` = " . (int)$product_query->row['product_id'] . " JOIN `" . DB_PREFIX . "profile_description` `pd` ON `pd`.`profile_id` = `p`.`profile_id` AND `pd`.`language_id` = " . (int)$this->config->get('config_language_id') . " WHERE `pp`.`profile_id` = " . (int)$profile_id . " AND `status` = 1 AND `pp`.`customer_group_id` = " . (int)$customer_group_id)->row;

						if ($profile_info) {
							$profile_name = $profile_info['name'];

							$recurring = true;
							$recurring_frequency = $profile_info['frequency'];
							$recurring_price = $profile_info['price'];
							$recurring_cycle = $profile_info['cycle'];
							$recurring_duration = $profile_info['duration'];
							$recurring_trial_frequency = $profile_info['trial_frequency'];
							$recurring_trial_status = $profile_info['trial_status'];
							$recurring_trial_price = $profile_info['trial_price'];
							$recurring_trial_cycle = $profile_info['trial_cycle'];
							$recurring_trial_duration = $profile_info['trial_duration'];
						}
					}

/*Additional offer*/

					if(!empty($additionaloffers['active_offer'])) {
						foreach($offer_bonuses as $of){
							if($of['ao_product_id'] == $product_query->row['product_id']){
								$products_to_ao = $this->getProductsToAdditionalOffer($product_query->row['product_id']);
							}
						}
						if(!empty($products_to_ao)) {
							$discount_type =  $this->getOfferDiscountType($additionaloffers['active_offer']);
							if($discount_type == "percent") {
								$ao_price = (int)floor(((100 - (int)$products_to_ao[0]['price']) / 100) * (int)$product_query->row['price']);
							} else {
								$ao_price = (int)$products_to_ao[0]['price'];
							}
							
							if($available_bonus_items >= 0) {
								$tt = ($ao_price * $quantity);
							} elseif($available_bonus_items < 0 && count($cart_has_bonus) == 1) {
								$tt = ($price * (-1 * $available_bonus_items)) + ($ao_price * ($quantity + $available_bonus_items));
							} elseif($available_bonus_items < 0 && count($cart_has_bonus) > 1){
								if($cart_has_bonus[0]['key'] == $key) {
									if($cart_has_bonus[0]['quantity'] >= $active_offer_max_quantity) {
										$tt = ((($cart_has_bonus[0]['quantity'] - $active_offer_max_quantity) * $price) + ($ao_price * $active_offer_max_quantity));
									} else {
										$tt = (($ao_price * $cart_has_bonus[0]['quantity']));
									}
								} else {
									if(!isset($left_available_items)){
										$left_available_items = $active_offer_max_quantity - $cart_has_bonus[0]['quantity'];
									}
									if($left_available_items >= 0 && $left_available_items < $quantity){
										$tt = ($ao_price * $left_available_items) + (($quantity - $left_available_items) * $price);
										$left_available_items -= $quantity;
									} elseif($left_available_items >= 0 && $left_available_items >= $quantity){
										$tt = ($ao_price * $quantity);
										$left_available_items -= $quantity;
									}
								}
							}
						}
					}
			

					unset($products_to_ao);
						
					$total = ($price + $option_price) * $quantity;

					if(isset($tt)){
						$tot = $tt;
					} else {
						$tot = $total;
					}

/*Additional offer*/
					
					$this->data[$key] = array(
						'key'                       => $key,
						'product_id'                => $product_query->row['product_id'],
						'name'                      => $product_query->row['name'],
						'model'                     => $product_query->row['model'],
						'shipping'                  => $product_query->row['shipping'],
						'image'                     => $product_query->row['image'],
						'option'                    => $option_data,
						'download'                  => $download_data,
						'quantity'                  => $quantity,
						'minimum'                   => $product_query->row['minimum'],
						'subtract'                  => $product_query->row['subtract'],
						'stock'                     => $stock,
						'price'                     => ($price + $option_price),
						'ao_price'                  => $product_query->row['price'],
/*Additional offer*/
						'total'                     => $tot,
						'reward'                    => $reward * $quantity,
						'points'                    => ($product_query->row['points'] ? ($product_query->row['points'] + $option_points) * $quantity : 0),
						'tax_class_id'              => $product_query->row['tax_class_id'],
						'weight'                    => ($product_query->row['weight'] + $option_weight) * $quantity,
						'weight_class_id'           => $product_query->row['weight_class_id'],
						'length'                    => $product_query->row['length'],
						'width'                     => $product_query->row['width'],
						'height'                    => $product_query->row['height'],
						'length_class_id'           => $product_query->row['length_class_id'],
						'profile_id'                => $profile_id,
						'profile_name'              => $profile_name,
						'recurring'                 => $recurring,
						'recurring_frequency'       => $recurring_frequency,
						'recurring_price'           => $recurring_price,
						'recurring_cycle'           => $recurring_cycle,
						'recurring_duration'        => $recurring_duration,
						'recurring_trial'           => $recurring_trial_status,
						'recurring_trial_frequency' => $recurring_trial_frequency,
						'recurring_trial_price'     => $recurring_trial_price,
						'recurring_trial_cycle'     => $recurring_trial_cycle,
						'recurring_trial_duration'  => $recurring_trial_duration,
						'sku'  						=> $product_query->row['sku'],
					);
					unset($tt);
				} else {
					$this->remove($key);
				}
			}
		
//		}
		
		return $this->data;
	}
	
//needed
	public function getOfferType($offer_id) {
		if ($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getCustomerGroupId();
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}
		
		$query = $this->db->query("SELECT type FROM " . DB_PREFIX . "product_additional_offer WHERE offer_id = '" . (int)$offer_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC LIMIT 1");
		return $query->row['type'];	
	}
	
//needed
	public function getOfferProducts($offer_id) {
		if ($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getCustomerGroupId();
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}
		
		$query = $this->db->query("SELECT product_id FROM " . DB_PREFIX . "product_additional_offer WHERE offer_id = '" . (int)$offer_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC");
		return $query->rows;
	}
	
//needed
	public function getOfferSumm($offer_id) {
		if ($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getCustomerGroupId();
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}
		
		$query = $this->db->query("SELECT quantity FROM " . DB_PREFIX . "product_additional_offer WHERE offer_id = '" . (int)$offer_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC LIMIT 1");
		return $query->row['quantity'];
	}
	
//needed
	public function getMaxAvailableItems($offer_id){
		switch($this->getOfferType($offer_id)){
			case('product'):
				$max_available_items = 0;
				$ao_products = $this->getOfferProducts($offer_id);
				$ao_products = $this->unique_multidim_array($ao_products, "product_id");
				if(!empty($ao_products)){
					foreach($ao_products as $item){
						if($this->hasProduct($item['product_id'])){
							$max_available_items += $this->getProductQuantity($item['product_id']);
						}
					}					
				}
				break;
			case('summ'):
				$max_available_items = array();
				$summ = $this->getOfferSumm($offer_id);
				$temp_total = $this->getOfferSubTotal($offer_id);	
				$total = $temp_total['subtotal'];
				$max_available_items['available_bonus_items'] = $temp_total['available_bonus_items'];
				$max_available_items['max_available_items'] = $temp_total['active_offer_max_quantity'];			
				break;
		}
		
		return $max_available_items;
	}
	
//needed
	public function unique_multidim_array($array, $key) { 
			$temp_array = array(); 
			$i = 0; 
			$key_array = array(); 
			
			foreach($array as $val) { 
				if (!in_array($val[$key], $key_array)) { 
					$key_array[$i] = $val[$key]; 
					$temp_array[$i] = $val; 
				} 
				$i++; 
			} 
			return $temp_array; 
	}
	
//needed
	public function getProductsToAdditionalOffer($product_id) {
		if ($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getCustomerGroupId();
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}	
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_additional_offer WHERE ao_product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC");

		return $query->rows;		
	}
	
	public function getRecurringProducts(){
		$recurring_products = array();

		foreach ($this->getProducts() as $key => $value) {
			if ($value['recurring']) {
				$recurring_products[$key] = $value;
			}
		}

		return $recurring_products;
	}

	public function add($product_id, $qty = 1, $option, $profile_id = '') {
		$key = (int)$product_id . ':';

		if ($option) {
			$tempOption = base64_encode(serialize($option));
      		$tempOption = str_replace("+","PLUSWASHERE", $tempOption);
      		$tempOption = str_replace("/","SLASHWASHERE", $tempOption);
      		$tempOption = str_replace("=","EQUALWASHERE", $tempOption);
      		$key = (int)$product_id . ':' . $tempOption;
		}  else {
			$key .= ':';
		}

		if ($profile_id) {
			$key .= (int)$profile_id;
		}

		if ((int)$qty && ((int)$qty > 0)) {
			if (!isset($this->session->data['cart'][$key])) {
				$this->session->data['cart'][$key] = (int)$qty;
			} else {
				$this->session->data['cart'][$key] += (int)$qty;
			}
		}

		$this->data = array();
	}

	public function update($key, $qty) {
		if ((int)$qty && ((int)$qty > 0)) {
			$this->session->data['cart'][$key] = (int)$qty;
		} else {
			$this->remove($key);
		}

		$this->data = array();
	}

	public function remove($key) {
		if (isset($this->session->data['cart'][$key])) {
			unset($this->session->data['cart'][$key]);
		}

		$this->data = array();
	}

	public function clear() {
		$this->session->data['cart'] = array();
		$this->data = array();
	}

	public function getWeight() {
		$weight = 0;

		foreach ($this->getProducts() as $product) {
			if ($product['shipping']) {
				$weight += $this->weight->convert($product['weight'], $product['weight_class_id'], $this->config->get('config_weight_class_id'));
			}
		}

		return $weight;
	}

	public function getSubTotal() {
		$total = 0;

		foreach ($this->getProducts() as $product) {
			$total += $product['total'];
		}

		return $total;
	}
	
//needed
	public function getOfferBonuses($offer_id) {
		if ($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getCustomerGroupId();
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}
		
		$query = $this->db->query("SELECT ao_product_id FROM " . DB_PREFIX . "product_additional_offer WHERE offer_id = '" . (int)$offer_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) GROUP BY ao_product_id ORDER BY priority ASC, price ASC");
		return $query->rows;
	}
	
//needed
	public function getNotBonusProductsInCartByOffer($offer_id) {
		$cart_has_not_bonus_prod = array();
		$offer_bonuses = $this->getOfferBonuses($offer_id);
		foreach($offer_bonuses as $bonus){
			$b[] = $bonus['ao_product_id'];
		}
		if(isset($this->session->data['cart'])) {
			foreach($this->session->data['cart'] as $key => $quantity) {
				$product = explode(':', $key);
				$product_id = $product[0];
				if(!in_array($product_id, $b)){
					$cart_has_not_bonus_prod[$product_id] = $quantity;
				}
			}
		}
		return $cart_has_not_bonus_prod;
	}
	
//needed
	public function getOfferSubTotal($offer_id) {
		$offer_sub_total['subtotal'] = 0;
		$offer_summ = $this->getOfferSumm($offer_id);
		$offer_bonuses = $this->getOfferBonuses($offer_id);		
		$notbonus_products_in_cart = $this->getNotBonusProductsInCartByOffer($offer_id);
			
		$cart_has_bonus = $this->getBonusesInCartByOffer($offer_id);
		
		$cart_has_bonus_quantity = 0;
		foreach($cart_has_bonus as $chb){
			$cart_has_bonus_quantity += $chb['quantity'];
		}

		$active_offer_current_quantity = 0;
		foreach($offer_bonuses as $ob){
			if($this->hasProduct($ob['ao_product_id'])){
				$active_offer_current_quantity += $this->getProductQuantity($ob['ao_product_id']);
			}
		}
	
		if(isset($this->session->data['cart'])){
			foreach ($this->session->data['cart'] as $key => $quantity) {
				$product = explode(':', $key);
				$product_id = $product[0];
				if(!empty($notbonus_products_in_cart)) {	
					foreach($notbonus_products_in_cart as $pr_id => $q) {
						if($product_id == $pr_id) {
							$stock = true;

							// Options
							if (!empty($product[1])) {
								$str = str_replace("PLUSWASHERE", "+", $product[1]);
								$str = str_replace("SLASHWASHERE", "/", $str);
								$str = str_replace("EQUALWASHERE", "=", $str);
								$str = base64_decode($str);
								$options = unserialize($str);
							} else {
								$options = array();
							} 

							// Profile

							if (!empty($product[2])) {
								$profile_id = $product[2];
							} else {
								$profile_id = 0;
							}

							$product_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.date_available <= NOW() AND p.status = '1'");

							if ($product_query->num_rows) {
								$option_price = 0;
								$option_points = 0;
								$option_weight = 0;

								$option_data = array();

								foreach ($options as $product_option_id => $option_value) {
									$option_query = $this->db->query("SELECT po.product_option_id, po.option_id, od.name, o.type FROM " . DB_PREFIX . "product_option po LEFT JOIN `" . DB_PREFIX . "option` o ON (po.option_id = o.option_id) LEFT JOIN " . DB_PREFIX . "option_description od ON (o.option_id = od.option_id) WHERE po.product_option_id = '" . (int)$product_option_id . "' AND po.product_id = '" . (int)$product_id . "' AND od.language_id = '" . (int)$this->config->get('config_language_id') . "'");

									if ($option_query->num_rows) {
										if ($option_query->row['type'] == 'select' || $option_query->row['type'] == 'radio' || $option_query->row['type'] == 'image') {
											$option_value_query = $this->db->query("SELECT pov.option_value_id, ovd.name, pov.quantity, pov.subtract, pov.price, pov.price_prefix, pov.points, pov.points_prefix, pov.weight, pov.weight_prefix FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE pov.product_option_value_id = '" . (int)$option_value . "' AND pov.product_option_id = '" . (int)$product_option_id . "' AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

											if ($option_value_query->num_rows) {
												if ($option_value_query->row['price_prefix'] == '+') {
													$option_price += $option_value_query->row['price'];
												} elseif ($option_value_query->row['price_prefix'] == '-') {
													$option_price -= $option_value_query->row['price'];
												}

												if ($option_value_query->row['points_prefix'] == '+') {
													$option_points += $option_value_query->row['points'];
												} elseif ($option_value_query->row['points_prefix'] == '-') {
													$option_points -= $option_value_query->row['points'];
												}

												if ($option_value_query->row['weight_prefix'] == '+') {
													$option_weight += $option_value_query->row['weight'];
												} elseif ($option_value_query->row['weight_prefix'] == '-') {
													$option_weight -= $option_value_query->row['weight'];
												}

												if ($option_value_query->row['subtract'] && (!$option_value_query->row['quantity'] || ($option_value_query->row['quantity'] < $quantity))) {
													$stock = false;
												}

												$option_data[] = array(
													'product_option_id'       => $product_option_id,
													'product_option_value_id' => $option_value,
													'option_id'               => $option_query->row['option_id'],
													'option_value_id'         => $option_value_query->row['option_value_id'],
													'name'                    => $option_query->row['name'],
													'option_value'            => $option_value_query->row['name'],
													'type'                    => $option_query->row['type'],
													'quantity'                => $option_value_query->row['quantity'],
													'subtract'                => $option_value_query->row['subtract'],
													'price'                   => $option_value_query->row['price'],
													'price_prefix'            => $option_value_query->row['price_prefix'],
													'points'                  => $option_value_query->row['points'],
													'points_prefix'           => $option_value_query->row['points_prefix'],									
													'weight'                  => $option_value_query->row['weight'],
													'weight_prefix'           => $option_value_query->row['weight_prefix']
												);								
											}
										} elseif ($option_query->row['type'] == 'checkbox' && is_array($option_value)) {
											foreach ($option_value as $product_option_value_id) {
												$option_value_query = $this->db->query("SELECT pov.option_value_id, ovd.name, pov.quantity, pov.subtract, pov.price, pov.price_prefix, pov.points, pov.points_prefix, pov.weight, pov.weight_prefix FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE pov.product_option_value_id = '" . (int)$product_option_value_id . "' AND pov.product_option_id = '" . (int)$product_option_id . "' AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

												if ($option_value_query->num_rows) {
													if ($option_value_query->row['price_prefix'] == '+') {
														$option_price += $option_value_query->row['price'];
													} elseif ($option_value_query->row['price_prefix'] == '-') {
														$option_price -= $option_value_query->row['price'];
													}

													if ($option_value_query->row['points_prefix'] == '+') {
														$option_points += $option_value_query->row['points'];
													} elseif ($option_value_query->row['points_prefix'] == '-') {
														$option_points -= $option_value_query->row['points'];
													}

													if ($option_value_query->row['weight_prefix'] == '+') {
														$option_weight += $option_value_query->row['weight'];
													} elseif ($option_value_query->row['weight_prefix'] == '-') {
														$option_weight -= $option_value_query->row['weight'];
													}

													if ($option_value_query->row['subtract'] && (!$option_value_query->row['quantity'] || ($option_value_query->row['quantity'] < $quantity))) {
														$stock = false;
													}

													$option_data[] = array(
														'product_option_id'       => $product_option_id,
														'product_option_value_id' => $product_option_value_id,
														'option_id'               => $option_query->row['option_id'],
														'option_value_id'         => $option_value_query->row['option_value_id'],
														'name'                    => $option_query->row['name'],
														'option_value'            => $option_value_query->row['name'],
														'type'                    => $option_query->row['type'],
														'quantity'                => $option_value_query->row['quantity'],
														'subtract'                => $option_value_query->row['subtract'],
														'price'                   => $option_value_query->row['price'],
														'price_prefix'            => $option_value_query->row['price_prefix'],
														'points'                  => $option_value_query->row['points'],
														'points_prefix'           => $option_value_query->row['points_prefix'],
														'weight'                  => $option_value_query->row['weight'],
														'weight_prefix'           => $option_value_query->row['weight_prefix']
													);								
												}
											}						
										} elseif ($option_query->row['type'] == 'text' || $option_query->row['type'] == 'textarea' || $option_query->row['type'] == 'file' || $option_query->row['type'] == 'date' || $option_query->row['type'] == 'datetime' || $option_query->row['type'] == 'time') {
											$option_data[] = array(
												'product_option_id'       => $product_option_id,
												'product_option_value_id' => '',
												'option_id'               => $option_query->row['option_id'],
												'option_value_id'         => '',
												'name'                    => $option_query->row['name'],
												'option_value'            => $option_value,
												'type'                    => $option_query->row['type'],
												'quantity'                => '',
												'subtract'                => '',
												'price'                   => '',
												'price_prefix'            => '',
												'points'                  => '',
												'points_prefix'           => '',								
												'weight'                  => '',
												'weight_prefix'           => ''
											);						
										}
									}
								} 

								if ($this->customer->isLogged()) {
									$customer_group_id = $this->customer->getCustomerGroupId();
								} else {
									$customer_group_id = $this->config->get('config_customer_group_id');
								}

								$price = $product_query->row['price'];

								// Product Discounts
								$discount_quantity = 0;

								foreach ($this->session->data['cart'] as $key_2 => $quantity_2) {
									$product_2 = explode(':', $key_2);

									if ($product_2[0] == $product_id) {
										$discount_quantity += $quantity_2;
									}
								}

								$product_discount_query = $this->db->query("SELECT price FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND quantity <= '" . (int)$discount_quantity . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY quantity DESC, priority ASC, price ASC LIMIT 1");

								if ($product_discount_query->num_rows) {
									$price = $product_discount_query->row['price'];
								}

								// Product Specials
								$product_special_query = $this->db->query("SELECT price FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC LIMIT 1");

								if ($product_special_query->num_rows) {
									$price = $product_special_query->row['price'];
								}						

								// Reward Points
								$product_reward_query = $this->db->query("SELECT points FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "'");

								if ($product_reward_query->num_rows) {	
									$reward = $product_reward_query->row['points'];
								} else {
									$reward = 0;
								}

								// Downloads		
								$download_data = array();     		

								$download_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_download p2d LEFT JOIN " . DB_PREFIX . "download d ON (p2d.download_id = d.download_id) LEFT JOIN " . DB_PREFIX . "download_description dd ON (d.download_id = dd.download_id) WHERE p2d.product_id = '" . (int)$product_id . "' AND dd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

								foreach ($download_query->rows as $download) {
									$download_data[] = array(
										'download_id' => $download['download_id'],
										'name'        => $download['name'],
										'filename'    => $download['filename'],
										'mask'        => $download['mask'],
										'remaining'   => $download['remaining']
									);
								}

								// Stock
								if (!$product_query->row['quantity'] || ($product_query->row['quantity'] < $quantity)) {
									$stock = false;
								}

								$recurring = false;
								$recurring_frequency = 0;
								$recurring_price = 0;
								$recurring_cycle = 0;
								$recurring_duration = 0;
								$recurring_trial_status = 0;
								$recurring_trial_price = 0;
								$recurring_trial_cycle = 0;
								$recurring_trial_duration = 0;
								$recurring_trial_frequency = 0;
								$profile_name = '';

								if ($profile_id) {
									$profile_info = $this->db->query("SELECT * FROM `" . DB_PREFIX . "profile` `p` JOIN `" . DB_PREFIX . "product_profile` `pp` ON `pp`.`profile_id` = `p`.`profile_id` AND `pp`.`product_id` = " . (int)$product_query->row['product_id'] . " JOIN `" . DB_PREFIX . "profile_description` `pd` ON `pd`.`profile_id` = `p`.`profile_id` AND `pd`.`language_id` = " . (int)$this->config->get('config_language_id') . " WHERE `pp`.`profile_id` = " . (int)$profile_id . " AND `status` = 1 AND `pp`.`customer_group_id` = " . (int)$customer_group_id)->row;

									if ($profile_info) {
										$profile_name = $profile_info['name'];

										$recurring = true;
										$recurring_frequency = $profile_info['frequency'];
										$recurring_price = $profile_info['price'];
										$recurring_cycle = $profile_info['cycle'];
										$recurring_duration = $profile_info['duration'];
										$recurring_trial_frequency = $profile_info['trial_frequency'];
										$recurring_trial_status = $profile_info['trial_status'];
										$recurring_trial_price = $profile_info['trial_price'];
										$recurring_trial_cycle = $profile_info['trial_cycle'];
										$recurring_trial_duration = $profile_info['trial_duration'];
									}
								}
									
								$total = ($price + $option_price) * $quantity;
								
								$offer_sub_total['subtotal'] += $total;	
							}
						}
					}
				}
			}

			foreach ($this->session->data['cart'] as $key => $quantity) {
				$product = explode(':', $key);
				$product_id = $product[0];
				if(!empty($offer_bonuses)) {	
					foreach($offer_bonuses as $b) {
						if($product_id == $b['ao_product_id']) {
						
							$stock = true;

							// Options
							if (!empty($product[1])) {
								$str = str_replace("PLUSWASHERE", "+", $product[1]);
								$str = str_replace("SLASHWASHERE", "/", $str);
								$str = str_replace("EQUALWASHERE", "=", $str);
								$str = base64_decode($str);
								$options = unserialize($str);
							} else {
								$options = array();
							} 

							// Profile

							if (!empty($product[2])) {
								$profile_id = $product[2];
							} else {
								$profile_id = 0;
							}

							$product_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.date_available <= NOW() AND p.status = '1'");

							if ($product_query->num_rows) {
								$option_price = 0;
								$option_points = 0;
								$option_weight = 0;

								$option_data = array();

								foreach ($options as $product_option_id => $option_value) {
									$option_query = $this->db->query("SELECT po.product_option_id, po.option_id, od.name, o.type FROM " . DB_PREFIX . "product_option po LEFT JOIN `" . DB_PREFIX . "option` o ON (po.option_id = o.option_id) LEFT JOIN " . DB_PREFIX . "option_description od ON (o.option_id = od.option_id) WHERE po.product_option_id = '" . (int)$product_option_id . "' AND po.product_id = '" . (int)$product_id . "' AND od.language_id = '" . (int)$this->config->get('config_language_id') . "'");

									if ($option_query->num_rows) {
										if ($option_query->row['type'] == 'select' || $option_query->row['type'] == 'radio' || $option_query->row['type'] == 'image') {
											$option_value_query = $this->db->query("SELECT pov.option_value_id, ovd.name, pov.quantity, pov.subtract, pov.price, pov.price_prefix, pov.points, pov.points_prefix, pov.weight, pov.weight_prefix FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE pov.product_option_value_id = '" . (int)$option_value . "' AND pov.product_option_id = '" . (int)$product_option_id . "' AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

											if ($option_value_query->num_rows) {
												if ($option_value_query->row['price_prefix'] == '+') {
													$option_price += $option_value_query->row['price'];
												} elseif ($option_value_query->row['price_prefix'] == '-') {
													$option_price -= $option_value_query->row['price'];
												}

												if ($option_value_query->row['points_prefix'] == '+') {
													$option_points += $option_value_query->row['points'];
												} elseif ($option_value_query->row['points_prefix'] == '-') {
													$option_points -= $option_value_query->row['points'];
												}

												if ($option_value_query->row['weight_prefix'] == '+') {
													$option_weight += $option_value_query->row['weight'];
												} elseif ($option_value_query->row['weight_prefix'] == '-') {
													$option_weight -= $option_value_query->row['weight'];
												}

												if ($option_value_query->row['subtract'] && (!$option_value_query->row['quantity'] || ($option_value_query->row['quantity'] < $quantity))) {
													$stock = false;
												}

												$option_data[] = array(
													'product_option_id'       => $product_option_id,
													'product_option_value_id' => $option_value,
													'option_id'               => $option_query->row['option_id'],
													'option_value_id'         => $option_value_query->row['option_value_id'],
													'name'                    => $option_query->row['name'],
													'option_value'            => $option_value_query->row['name'],
													'type'                    => $option_query->row['type'],
													'quantity'                => $option_value_query->row['quantity'],
													'subtract'                => $option_value_query->row['subtract'],
													'price'                   => $option_value_query->row['price'],
													'price_prefix'            => $option_value_query->row['price_prefix'],
													'points'                  => $option_value_query->row['points'],
													'points_prefix'           => $option_value_query->row['points_prefix'],									
													'weight'                  => $option_value_query->row['weight'],
													'weight_prefix'           => $option_value_query->row['weight_prefix']
												);								
											}
										} elseif ($option_query->row['type'] == 'checkbox' && is_array($option_value)) {
											foreach ($option_value as $product_option_value_id) {
												$option_value_query = $this->db->query("SELECT pov.option_value_id, ovd.name, pov.quantity, pov.subtract, pov.price, pov.price_prefix, pov.points, pov.points_prefix, pov.weight, pov.weight_prefix FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE pov.product_option_value_id = '" . (int)$product_option_value_id . "' AND pov.product_option_id = '" . (int)$product_option_id . "' AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

												if ($option_value_query->num_rows) {
													if ($option_value_query->row['price_prefix'] == '+') {
														$option_price += $option_value_query->row['price'];
													} elseif ($option_value_query->row['price_prefix'] == '-') {
														$option_price -= $option_value_query->row['price'];
													}

													if ($option_value_query->row['points_prefix'] == '+') {
														$option_points += $option_value_query->row['points'];
													} elseif ($option_value_query->row['points_prefix'] == '-') {
														$option_points -= $option_value_query->row['points'];
													}

													if ($option_value_query->row['weight_prefix'] == '+') {
														$option_weight += $option_value_query->row['weight'];
													} elseif ($option_value_query->row['weight_prefix'] == '-') {
														$option_weight -= $option_value_query->row['weight'];
													}

													if ($option_value_query->row['subtract'] && (!$option_value_query->row['quantity'] || ($option_value_query->row['quantity'] < $quantity))) {
														$stock = false;
													}

													$option_data[] = array(
														'product_option_id'       => $product_option_id,
														'product_option_value_id' => $product_option_value_id,
														'option_id'               => $option_query->row['option_id'],
														'option_value_id'         => $option_value_query->row['option_value_id'],
														'name'                    => $option_query->row['name'],
														'option_value'            => $option_value_query->row['name'],
														'type'                    => $option_query->row['type'],
														'quantity'                => $option_value_query->row['quantity'],
														'subtract'                => $option_value_query->row['subtract'],
														'price'                   => $option_value_query->row['price'],
														'price_prefix'            => $option_value_query->row['price_prefix'],
														'points'                  => $option_value_query->row['points'],
														'points_prefix'           => $option_value_query->row['points_prefix'],
														'weight'                  => $option_value_query->row['weight'],
														'weight_prefix'           => $option_value_query->row['weight_prefix']
													);								
												}
											}						
										} elseif ($option_query->row['type'] == 'text' || $option_query->row['type'] == 'textarea' || $option_query->row['type'] == 'file' || $option_query->row['type'] == 'date' || $option_query->row['type'] == 'datetime' || $option_query->row['type'] == 'time') {
											$option_data[] = array(
												'product_option_id'       => $product_option_id,
												'product_option_value_id' => '',
												'option_id'               => $option_query->row['option_id'],
												'option_value_id'         => '',
												'name'                    => $option_query->row['name'],
												'option_value'            => $option_value,
												'type'                    => $option_query->row['type'],
												'quantity'                => '',
												'subtract'                => '',
												'price'                   => '',
												'price_prefix'            => '',
												'points'                  => '',
												'points_prefix'           => '',								
												'weight'                  => '',
												'weight_prefix'           => ''
											);						
										}
									}
								} 

								if ($this->customer->isLogged()) {
									$customer_group_id = $this->customer->getCustomerGroupId();
								} else {
									$customer_group_id = $this->config->get('config_customer_group_id');
								}

								$price = $product_query->row['price'];

								// Product Discounts
								$discount_quantity = 0;

								foreach ($this->session->data['cart'] as $key_2 => $quantity_2) {
									$product_2 = explode(':', $key_2);

									if ($product_2[0] == $product_id) {
										$discount_quantity += $quantity_2;
									}
								}

								$product_discount_query = $this->db->query("SELECT price FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND quantity <= '" . (int)$discount_quantity . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY quantity DESC, priority ASC, price ASC LIMIT 1");

								if ($product_discount_query->num_rows) {
									$price = $product_discount_query->row['price'];
								}

								// Product Specials
								$product_special_query = $this->db->query("SELECT price FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC LIMIT 1");

								if ($product_special_query->num_rows) {
									$price = $product_special_query->row['price'];
								}						

								// Reward Points
								$product_reward_query = $this->db->query("SELECT points FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "'");

								if ($product_reward_query->num_rows) {	
									$reward = $product_reward_query->row['points'];
								} else {
									$reward = 0;
								}

								// Downloads		
								$download_data = array();     		

								$download_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_download p2d LEFT JOIN " . DB_PREFIX . "download d ON (p2d.download_id = d.download_id) LEFT JOIN " . DB_PREFIX . "download_description dd ON (d.download_id = dd.download_id) WHERE p2d.product_id = '" . (int)$product_id . "' AND dd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

								foreach ($download_query->rows as $download) {
									$download_data[] = array(
										'download_id' => $download['download_id'],
										'name'        => $download['name'],
										'filename'    => $download['filename'],
										'mask'        => $download['mask'],
										'remaining'   => $download['remaining']
									);
								}

								// Stock
								if (!$product_query->row['quantity'] || ($product_query->row['quantity'] < $quantity)) {
									$stock = false;
								}

								$recurring = false;
								$recurring_frequency = 0;
								$recurring_price = 0;
								$recurring_cycle = 0;
								$recurring_duration = 0;
								$recurring_trial_status = 0;
								$recurring_trial_price = 0;
								$recurring_trial_cycle = 0;
								$recurring_trial_duration = 0;
								$recurring_trial_frequency = 0;
								$profile_name = '';

								if ($profile_id) {
									$profile_info = $this->db->query("SELECT * FROM `" . DB_PREFIX . "profile` `p` JOIN `" . DB_PREFIX . "product_profile` `pp` ON `pp`.`profile_id` = `p`.`profile_id` AND `pp`.`product_id` = " . (int)$product_query->row['product_id'] . " JOIN `" . DB_PREFIX . "profile_description` `pd` ON `pd`.`profile_id` = `p`.`profile_id` AND `pd`.`language_id` = " . (int)$this->config->get('config_language_id') . " WHERE `pp`.`profile_id` = " . (int)$profile_id . " AND `status` = 1 AND `pp`.`customer_group_id` = " . (int)$customer_group_id)->row;

									if ($profile_info) {
										$profile_name = $profile_info['name'];

										$recurring = true;
										$recurring_frequency = $profile_info['frequency'];
										$recurring_price = $profile_info['price'];
										$recurring_cycle = $profile_info['cycle'];
										$recurring_duration = $profile_info['duration'];
										$recurring_trial_frequency = $profile_info['trial_frequency'];
										$recurring_trial_status = $profile_info['trial_status'];
										$recurring_trial_price = $profile_info['trial_price'];
										$recurring_trial_cycle = $profile_info['trial_cycle'];
										$recurring_trial_duration = $profile_info['trial_duration'];
									}
								}
								
		

		
								$active_offer_max_quantity = 0;
								$available_bonus_items = 0;
		
								if($offer_sub_total['subtotal'] < $offer_summ){
									$subtot = $offer_sub_total['subtotal'];
									$ao_price = $this->getOfferBonusProductPrice($product_query->row['product_id']);
									for($i=0; $i < ($cart_has_bonus_quantity); $i++){
										$active_offer_max_quantity2 = (($subtot + ($price + $option_price)) / $offer_summ);			
										if((($i+1) < ($cart_has_bonus_quantity)) && (floor($active_offer_max_quantity2) > $active_offer_max_quantity)){
											$active_offer_max_quantity = floor($active_offer_max_quantity2);
											$subtot += (int)$ao_price['price'];
										} else {
											$subtot += ($price + $option_price);
										}
									}
									unset($ao_price);
									
								} else {
									$active_offer_max_quantity = floor($offer_sub_total['subtotal'] / $offer_summ);
									for($i=0; $i < ($cart_has_bonus_quantity - $active_offer_max_quantity); $i++){
										$active_offer_max_quantity2 = floor(($offer_sub_total['subtotal'] + ($price + $option_price)) / $offer_summ);
										if($active_offer_max_quantity2 > $active_offer_max_quantity) {
											if(($i+1) < ($cart_has_bonus_quantity - $active_offer_max_quantity)){
												$active_offer_max_quantity++;
											}
										}
									}
								}

							if($active_offer_max_quantity > 0){
									$ao_price = $this->getOfferBonusProductPrice($product_query->row['product_id']);
									
									$available_bonus_items = $active_offer_max_quantity - $active_offer_current_quantity;
									if($available_bonus_items >= 0) {
										$total = ($ao_price['price'] * $quantity);
									} elseif($available_bonus_items < 0 && count($cart_has_bonus) == 1) {
										$total = ($price * (-1 * $available_bonus_items)) + ($ao_price['price'] * ($quantity + $available_bonus_items));
									} elseif($available_bonus_items < 0 && count($cart_has_bonus) > 1){
										if($cart_has_bonus[0]['product_id'] == $product_query->row['product_id']) {
											if($cart_has_bonus[0]['quantity'] >= $active_offer_max_quantity) {
												$total = ((($cart_has_bonus[0]['quantity'] - $active_offer_max_quantity) * $price) + ($ao_price['price'] * $active_offer_max_quantity));
											} else {
												$total = (($ao_price['price'] * $cart_has_bonus[0]['quantity']));
											}
										} else {
											$left_available_items = $active_offer_max_quantity - $cart_has_bonus[0]['quantity'];
											if($left_available_items >= 0 && $left_available_items < $quantity){
												$total = ($ao_price['price'] * $left_available_items) + (($quantity - $left_available_items) * $price);
											}
										}
									}
								} else {
									$total = ($price + $option_price) * $quantity;
									
								}
									
								$offer_sub_total['subtotal'] += $total;	
								$offer_sub_total['active_offer_max_quantity'] = $active_offer_max_quantity;	
							}
						}
					}
				}
			}
		}
			
		$offer_sub_total['available_bonus_items'] = $available_bonus_items;
		return $offer_sub_total;
	}

//needed
	public function getBonusesInCartByOffer($offer_id) {
		$cart_has_bonus = array();
		
		if(isset($this->session->data['cart'])) {
			
			if ($this->customer->isLogged()) {
				$customer_group_id = $this->customer->getCustomerGroupId();
			} else {
				$customer_group_id = $this->config->get('config_customer_group_id');
			}
			$query = $this->db->query("SELECT ao_product_id FROM " . DB_PREFIX . "product_additional_offer WHERE offer_id = '" . (int)$offer_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC");
			
			foreach($this->session->data['cart'] as $key => $quantity) {
				$produc = explode(':', $key);
				$produc_id = $produc[0];
				foreach($query->rows as $bonus){
					if($bonus['ao_product_id'] == $produc_id) {
						$cart_has_bonus[] = array(
						'key' => $key,
						'product_id' => $produc_id,
						'quantity' => $quantity
						);
					}
				}
			}
		}
		$cart_has_bonus = $this->unique_multidim_array($cart_has_bonus, 'key');
		return $cart_has_bonus;
	}
	
//needed
	public function getOfferBonusProductPrice($product_id){
		if ($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getCustomerGroupId();
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}

		$query = $this->db->query("SELECT price FROM " . DB_PREFIX . "product_additional_offer WHERE ao_product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC");
		return $query->row;
	}
	
	public function getOfferDiscountType($offer_id){
		if ($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getCustomerGroupId();
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}

		$query = $this->db->query("SELECT discount_type FROM " . DB_PREFIX . "product_additional_offer WHERE offer_id = '" . (int)$offer_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC");
		return $query->row['discount_type'];
	}
	
	public function getTaxes() {
		$tax_data = array();

		foreach ($this->getProducts() as $product) {
			if ($product['tax_class_id']) {
				$tax_rates = $this->tax->getRates($product['price'], $product['tax_class_id']);

				foreach ($tax_rates as $tax_rate) {
					if (!isset($tax_data[$tax_rate['tax_rate_id']])) {
						$tax_data[$tax_rate['tax_rate_id']] = ($tax_rate['amount'] * $product['quantity']);
					} else {
						$tax_data[$tax_rate['tax_rate_id']] += ($tax_rate['amount'] * $product['quantity']);
					}
				}
			}
		}

		return $tax_data;
	}

	public function getTotal() {
		$total = 0;

		foreach ($this->getProducts() as $product) {
			$total += $this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity'];
		}

		return $total;
	}

	public function countProducts() {
		$product_total = 0;

		$products = $this->getProducts();

		foreach ($products as $product) {
			$product_total += $product['quantity'];
		}		

		return $product_total;
	}

	public function hasProducts() {
		return count($this->session->data['cart']);
	}

//needed
	public function hasProduct($product_id) {
		$is_in_cart = false;
		if(isset($this->session->data['cart']) && !empty($this->session->data['cart'])) {
			foreach ($this->session->data['cart'] as $key => $quantity) {
				$product = explode(':', $key);
				$cart_product_id = $product[0];
				if ($product_id == $cart_product_id) {
					$is_in_cart = true;
				}
			}
		}
		return $is_in_cart;
	}
	
//needed
	public function getProductQuantity($product_id) {
		$quantity_in_cart = 0;
		if(isset($this->session->data['cart']) && !empty($this->session->data['cart'])) {
			foreach ($this->session->data['cart'] as $key => $quantity) {
				$product = explode(':', $key);
				$cart_product_id = $product[0];
				if ($product_id == $cart_product_id) {
					$quantity_in_cart += $quantity;
				}
			}
		}
		return $quantity_in_cart;
	}
	
	public function hasRecurringProducts(){
		return count($this->getRecurringProducts());
	}

	public function hasStock() {
		$stock = true;

		foreach ($this->getProducts() as $product) {
			if (!$product['stock']) {
				$stock = false;
			}
		}

		return $stock;
	}

	public function hasShipping() {
		$shipping = false;

		foreach ($this->getProducts() as $product) {
			if ($product['shipping']) {
				$shipping = true;

				break;
			}
		}

		return $shipping;
	}

	public function hasDownload() {
		$download = false;

		foreach ($this->getProducts() as $product) {
			if ($product['download']) {
				$download = true;

				break;
			}
		}

		return $download;
	}	
}
?>
