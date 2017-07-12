<?php
class ModelModuleAddspecials extends Model {
    
	public function getProductAdditionalOffer($product_id) {
		if ($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getCustomerGroupId();
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}	
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_additional_offer WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC");

		return $query->rows;		
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
 
	public function getProductsWithBonusInCart() {
		$cart_has_prod_with_bonus = array();
		if(isset($this->session->data['cart'])) {
			foreach($this->session->data['cart'] as $key => $quantity) {
				$produc = explode(':', $key);
				$produc_id = $produc[0];
				if ($this->customer->isLogged()) {
					$customer_group_id = $this->customer->getCustomerGroupId();
				} else {
					$customer_group_id = $this->config->get('config_customer_group_id');
				}
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_additional_offer WHERE product_id = '" . (int)$produc_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC");
				if($query->rows) {
					$cart_has_prod_with_bonus[] = array(
					'product_id' => $produc_id,
					'quantity' => $quantity
					);
				}
			}
		}
		return $cart_has_prod_with_bonus;
	}
	
//needed
	public function getBonusesInCart() {
		$cart_has_bonus = array();
		if(isset($this->session->data['cart'])) {
			foreach($this->session->data['cart'] as $key => $quantity) {
				$produc = explode(':', $key);
				$produc_id = $produc[0];
				if ($this->customer->isLogged()) {
					$customer_group_id = $this->customer->getCustomerGroupId();
				} else {
					$customer_group_id = $this->config->get('config_customer_group_id');
				}
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_additional_offer WHERE ao_product_id = '" . (int)$produc_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC");
				if($query->rows) {
					$cart_has_bonus[] = array(
					'product_id' => $produc_id,
					'quantity' => $quantity
					);
				}
			}
		}
		return $cart_has_bonus;
	}
	
	public function getValidOffersInCart(){
		$valid_offers_in_cart = array();
		$bonuses_in_cart = $this->getBonusesInCart();
		if(!empty($bonuses_in_cart)) {
			foreach($bonuses_in_cart as $product){
				$offers_to_bonus_product = $this->getOfferIdByBonusProductId($product['product_id']);
				foreach($offers_to_bonus_product as $offer_id){
					switch($this->getOfferType($offer_id)){
						case('product'):
							$ao_products = $this->getOfferProducts($offer_id);
							if(!empty($ao_products)){
								foreach($ao_products as $item){
									if($this->cart->hasProduct($item)){
										$valid_offers_in_cart[] = $offer_id;
									}
								}
							}
							break;
						case('summ'):
							$summ = $this->getOfferSumm($offer_id);
							$total = $this->cart->getSubTotal();
							if($total >= $summ){
								$valid_offers_in_cart[] = $offer_id;
							}
							break;
					}	
				}
			}
			$valid_offers_in_cart = array_unique($valid_offers_in_cart);
		}
		return $valid_offers_in_cart;
	}

//needed	
	public function getValidBonusesInCart(){
		$valid_bonuses_in_cart = array();
		$bonuses_in_cart = $this->getBonusesInCart();
		if(!empty($bonuses_in_cart)) {
			foreach($bonuses_in_cart as $product){
			    $otbp = $this->getOfferIdByBonusProductId($product['product_id']);
				$offers_to_bonus_product = array_unique($otbp);
				foreach($offers_to_bonus_product as $offer_id){
					switch($this->getOfferType($offer_id)){
						case('product'):
							$ao_products = $this->getOfferProducts($offer_id);
							if(!empty($ao_products)){
								foreach($ao_products as $item){
									if($this->cart->hasProduct($item['product_id'])){
										$valid_bonuses_in_cart[] = $product['product_id'];
									}
								}
							}
							break;
						case('summ'):
							$summ = $this->getOfferSumm($offer_id);
							$total = $this->cart->getOfferSubTotal($offer_id);
							$total = $total['subtotal'];
							if($total >= $summ){
								$valid_bonuses_in_cart[] = $product['product_id'];
							}
							break;
					}	
				}
			}
			$valid_bonuses_in_cart = array_unique($valid_bonuses_in_cart);
		}
		return $valid_bonuses_in_cart;
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
	public function getOffersTypeSumm(){
		if ($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getCustomerGroupId();
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}
		
		$offers_type_summ = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_additional_offer WHERE type = 'summ' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC");
		if($query->rows){
			foreach($query->rows as $offer){
				$offers_type_summ[] = array(
				'offer_id' => $offer['offer_id'],
				'summ' => $offer['quantity']
				);
			}
		}
		return $offers_type_summ;
	}

//needed
	public function getOfferIdByBonusProductId($product_id){
		$offers = array();

	    if ($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getCustomerGroupId();
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}

		$query = $this->db->query("SELECT offer_id FROM " . DB_PREFIX . "product_additional_offer WHERE ao_product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC");

		foreach($query->rows as $offer){
            $offers[] = $offer['offer_id'];
        }

		return $offers;
	}

//needed	
	public function getAvailableOffers() {		
		if ($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getCustomerGroupId();
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}

		$offers = array();
		if(isset($this->session->data['cart'])) {
			foreach($this->session->data['cart'] as $key => $quantity) {
				$product = explode(':', $key);
				$product_id = $product[0];
				$query = $this->db->query("SELECT offer_id FROM " . DB_PREFIX . "product_additional_offer WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC");
				
				if($query->rows){
					foreach($query->rows as $row){
						$offers[] = $row['offer_id'];
					}
				}
			}
			foreach($this->getOffersTypeSumm() as $offer){
				$subtotal = $this->cart->getOfferSubTotal($offer['offer_id']);
				$subtotal = $subtotal['subtotal'];
				if($subtotal >= $offer['summ']){
					$offers[] = $offer['offer_id'];
				}
			}
			
		}	
		$offers = array_unique($offers);	
		return $offers;
	}
	
	
//needed
	public function getOffer($offer_id) {
		if ($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getCustomerGroupId();
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_additional_offer WHERE offer_id = '" . (int)$offer_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC");
		
		$offer = array();
		$offer['offer_id'] = $offer_id;
		$offer['offer_description'] = $query->row['description'];
		$offer['discount_type'] = $query->row['discount_type'];
		$offer['type'] = $query->row['type'];
		$offer['quantity'] = $query->row['quantity'];
		$offer['price'] = $query->row['price'];
		$offer['offer_name'] = $query->row['name'];
		foreach($query->rows as $row){
			$offer['products'][] = $row['product_id'];
			$offer['ao_products'][] = $row['ao_product_id'];
		}
		$offer['ao_products'] = array_unique($offer['ao_products']);
		
		return $offer;
	}
	
//needed
	public function getOffers(){
		$this->load->model('catalog/product');
		$offers_to_show = array();
		$offers = $this->getAvailableOffers();
		$valid_bonuses_in_cart = $this->getValidBonusesInCart();
		$bonuses_in_cart = $this->getBonusesInCart();
		if(!empty($offers)){
			if(count($offers) > 1){
				if(!empty($valid_bonuses_in_cart)){		
					$bonuses_max_price = 0;
					foreach($valid_bonuses_in_cart as $product){
						$product_info = $this->model_catalog_product->getProduct($product);	
						if ($product_info) {
							if($product_info['special'] > 0){
								if($product_info['special'] > $bonuses_max_price){
									$bonuses_max_price = $product_info['special'];
									$active_offer_product_id = $product_info['product_id'];
								}
							} else {
								if($product_info['price'] > $bonuses_max_price){
									$bonuses_max_price = $product_info['price'];
									$active_offer_product_id = $product_info['product_id'];
								}
							}
						}	
					}
					if ($this->customer->isLogged()) {
						$customer_group_id = $this->customer->getCustomerGroupId();
					} else {
						$customer_group_id = $this->config->get('config_customer_group_id');
					}
					$query = $this->db->query("SELECT offer_id FROM " . DB_PREFIX . "product_additional_offer WHERE ao_product_id = '" . (int)$active_offer_product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC LIMIT 1");
					$offers_to_show['offers'] = $offers;
					$offers_to_show['active_offer'] = $query->row['offer_id'];
				} else {
					$offers_to_show['offers'] = $offers;
				}
			} else {	
				$offers_to_show['offers'] = $offers;
				foreach($offers as $o){
					$offers_to_show['active_offer'] = $o;
					$offer_bonuses = $this->getOfferBonuses($o);
				}
				$notbonus_products_in_cart = $this->cart->getNotBonusProductsInCartByOffer($offers_to_show['active_offer']);
				if(empty($notbonus_products_in_cart)){
					unset($offers_to_show['offers']);
				}
			}
		} else {
			if(!empty($bonuses_in_cart)){
				foreach($bonuses_in_cart as $product){
					$banner = $this->getBanner($product['product_id']);
					if(!empty($banner)){
						$offers_to_show['banners'][] = $banner;
					}
				}
				$offers_to_show['banners'] = $this->unique_multidim_array($offers_to_show['banners'], 'image');
			}
		}
		if(isset($offers_to_show['active_offer'])){
			$this->session->data['active_offer'] = $offers_to_show['active_offer'];
		} else {
			if(isset($this->session->data['active_offer'])){
				unset($this->session->data['active_offer']);
			}
		}
		return $offers_to_show;
	}
	
//needed
	public function getBanner($product_id) {
		$offers = $this->getOfferIdByBonusProductId($product_id);
		$offers = array_unique($offers);
		foreach($offers as $offer){
			$query = $this->db->query("SELECT image, offer_id, description FROM " . DB_PREFIX . "product_additional_offer WHERE offer_id = '" . (int)$offer['offer_id'] . "'");
			$temp = array_unique($query->rows);
			foreach($temp as $ban){
				if(!empty($ban['image'])) {
					$banner = array(
						'image' 		=> $ban['image'],
						'description'  	=> $ban['description'],
						'offer_id' 		=> $ban['offer_id']
					);
				}
			}
			
		}
		return $banner;
	}
	
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
	public function getMaxAvailableItems($offer_id){
		$max_available_items = 0;
		switch($this->getOfferType($offer_id)){
			case('product'):
				$ao_products = $this->getOfferProducts($offer_id);
				$ao_products = $this->unique_multidim_array($ao_products, "product_id");
				if(!empty($ao_products)){
					foreach($ao_products as $item){
						if($this->cart->hasProduct($item['product_id'])){
							$max_available_items += $this->cart->getProductQuantity($item['product_id']);
						}
					}					
				}
				break;
			case('summ'):
				$summ = $this->getOfferSumm($offer_id);
				$total = $this->cart->getSubTotal();
				if($total >= $summ){
					$max_available_items += floor($total / $summ);
				}
				break;
		}
		return $max_available_items;
	}
}
?>