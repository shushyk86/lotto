<?php
class ModelTotalReward extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {
		if (isset($this->session->data['reward'])) {
			$this->language->load('total/reward');

			$points = $this->customer->getRewardPoints();

			if ($this->session->data['reward'] <= $points) {
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

                $points_total = floor($points_total);

                if($this->session->data['reward'] <= $points_total){
                    $total_data[] = array(
                        'code'       => 'reward',
                        'title'      => sprintf($this->language->get('text_reward'), $this->session->data['reward']),
                        'text'       => $this->currency->format(-$this->session->data['reward']),
                        'value'      => -$this->session->data['reward'],
                        'sort_order' => $this->config->get('reward_sort_order')
                    );

                    $total -= $this->session->data['reward'];
                }
			} 
		}
	}

	public function confirm($order_info, $order_total) {
		$this->language->load('total/reward');

		$points = 0;

		$start = strpos($order_total['title'], '(') + 1;
		$end = strrpos($order_total['title'], ')');

		if ($start && $end) {  
			$points = substr($order_total['title'], $start, $end - $start);
		}	

		if ($points) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "customer_reward SET customer_id = '" . (int)$order_info['customer_id'] . "', description = '" . $this->db->escape(sprintf($this->language->get('text_order_id'), (int)$order_info['order_id'])) . "', points = '" . (float)-$points . "', date_added = NOW()");				
		}
	}		
}
?>