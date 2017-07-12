<?php
class ModelCatalogAddSpecials extends Model {    
    
    public function AddAdditionalOffer ($product_id,$product_additional_offer) {
        if (!empty($product_additional_offer)) {
        $this->db->query("INSERT INTO " . DB_PREFIX . "product_additional_offer SET product_sku = '" . $this->db->escape($product_id) . "', offer_id = '" . (int)$product_additional_offer['offer_id'] . "', type = '" . $this->db->escape($product_additional_offer['offer_type']) . "', name = '" . $this->db->escape($product_additional_offer['name']) . "', customer_group_id = '" . (int)$product_additional_offer['customer_group_id'] . "', priority = '" . (int)$product_additional_offer['priority'] . "', quantity = '" . (int)$product_additional_offer['quantity'] . "', ao_product_sku = '" . $this->db->escape($product_additional_offer['ao_product_id']) . "', price = '" . (float)$product_additional_offer['price'] . "', discount_type = '" . $this->db->escape($product_additional_offer['discount_type']) . "', date_start = '" . $this->db->escape($product_additional_offer['date_start']) . "', date_end = '" . $this->db->escape($product_additional_offer['date_end']) . "', image = '" . $this->db->escape($product_additional_offer['image']) . "', link = '" . $this->db->escape($product_additional_offer['banner_link']) . "', description = '" . $this->db->escape($product_additional_offer['description']) . "'");
        }
    }
    
    public function delete_ao($offer_id) {
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_additional_offer WHERE offer_id = '" . (int)$offer_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_additional_offer_banners WHERE offer_id = '" . (int)$offer_id . "'");
    }
    
	public function getTotalOffers() {
		$query = $this->db->query("SELECT offer_id FROM " . DB_PREFIX . "product_additional_offer GROUP BY offer_id");
		
		return $query->num_rows;
    }
	
	public function getProductIdBySku($sku) {
		$query = $this->db->query("SELECT product_id FROM " . DB_PREFIX . "product WHERE sku = '" . $this->db->escape($sku) . "'");
		return $query->row['product_id'];
    }
	
	public function getProductSkuById($product_id) {
		$query = $this->db->query("SELECT sku FROM " . DB_PREFIX . "product WHERE product_id = '" . (int)$product_id . "'");
		return $query->row['sku'];
    }
	
	public function updateProductIds() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_additional_offer");
		foreach($query->rows as $offer_item){
			if(!empty($offer_item['product_sku'])){
				$product_id = $this->getProductIdBySku($offer_item['product_sku']);
				$this->db->query("UPDATE " . DB_PREFIX . "product_additional_offer SET product_id = '" . (int)$product_id . "' WHERE product_additional_offer_id = '" . (int)$offer_item['product_additional_offer_id'] . "'");
			}
			$ao_product_id = $this->getProductIdBySku($offer_item['ao_product_sku']);
			if(!empty($ao_product_id)) {
				$this->db->query("UPDATE " . DB_PREFIX . "product_additional_offer SET ao_product_id = '" . (int)$ao_product_id . "' WHERE product_additional_offer_id = '" . (int)$offer_item['product_additional_offer_id'] . "'");
			} else {
				$this->db->query("DELETE FROM " . DB_PREFIX . "product_additional_offer WHERE ao_product_sku = '" . $this->db->escape($offer_item['ao_product_sku']) . "'");
			}
		}
	}	
	
	public function getOffers($data = array()) {	
		$sql = "SELECT * FROM " . DB_PREFIX . "product_additional_offer GROUP BY offer_id";

		$sort_data = array(
			'name',
			'sort_order'
		);	

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY name";	
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}					

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}	

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}				

		$query = $this->db->query($sql);

		return $query->rows;
    }
	
	public function getOffer($offer_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_additional_offer WHERE offer_id = '" . (int)$offer_id . "'");
		return $query->row;
	}
    
	public function getOfferProducts($offer_id) {
		$query = $this->db->query("SELECT DISTINCT product_id FROM " . DB_PREFIX . "product_additional_offer WHERE offer_id = '" . (int)$offer_id . "'");
		return $query->rows;
	}
	
	public function getOfferBonusProducts($offer_id) {
		$query = $this->db->query("SELECT DISTINCT ao_product_id FROM " . DB_PREFIX . "product_additional_offer WHERE offer_id = '" . (int)$offer_id . "'");
		return $query->rows;
	}
	
	public function getLastOfferId() {
		$query = $this->db->query("SELECT MAX(offer_id) as offer_id FROM " . DB_PREFIX . "product_additional_offer LIMIT 1");

		return $query->row['offer_id'];
	}
	
    public function getStores($data = array()) {
        $store_data = $this->cache->get('store-for-label');
        if (!$store_data) {
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "store ORDER BY url");
            foreach ($query->rows as $row) {$store_data[$row['store_id']] = $row;}
            $this->cache->set('store-for-label', $store_data);
        }
        return $store_data;
    }
    
    public function getProducts($data = array()) {
        $sql = "SELECT pd.name, p.product_id, p.sku FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)";

        if (!empty($data['filter_category_id'])) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";}

        if (!empty($data['filter_store_id'])) {
            $sql .= " RIGHT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id)";}

        $sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";

        if (!empty($data['filter_manufacturer_id'])) {
            $sql .= " AND manufacturer_id = " . (int)$data['filter_manufacturer_id'] . " ";}

        if (!empty($data['filter_name'])) {
            $sql .= " AND LCASE(pd.name) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";}

        if (!empty($data['filter_model'])) {
            $sql .= " AND LCASE(p.sku) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_model'])) . "%'";}

        if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
            $sql .= " AND p.status = '" . (int)$data['filter_status'] . "'";}

        if (!empty($data['filter_category_id'])) {
            if ($data['filter_sub_category']) {
                $implode_data = array();

                $implode_data[] = "category_id = '" . (int)$data['filter_category_id'] . "'";

                $this->load->model('catalog/category');

                $categories = $this->getCategories($data['filter_category_id']);

                foreach ($categories as $category) {
                    $implode_data[] = "p2c.category_id = '" . (int)$category['category_id'] . "'";
                }

                $sql .= " AND (" . implode(' OR ', $implode_data) . ")";
            } else {
                $sql .= " AND p2c.category_id = '" . (int)$data['filter_category_id'] . "'";
            }
        }

        if (!empty($data['filter_store_id'])) {
            $sql .= " AND p2s.store_id = " . (int)$data['filter_store_id'];
        }

        $sql .= " GROUP BY p.product_id";

        if (isset($data['start']) || isset($data['limit'])) {
            if ($data['start'] < 0) {
                $data['start'] = 0;
            }

            if ($data['limit'] < 1) {
                $data['limit'] = 20;
            }

            $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
        }

        $query = $this->db->query($sql);

        $product_data = array();

        $stores = $this->getStores();
        $stores[0] = array('store_id' => 0, 'name' => 'def');

        if (!empty($data['filter_store_id'])) {
            $stores = array($stores[$data['filter_store_id']]);
        }

        foreach($query->rows as $row){
            $product_data[$row['product_id']] = $row;
        }

        return $product_data;
    }
    
    public function getTotalProducts($data = array()) {
        $sql = "SELECT COUNT(DISTINCT p.product_id) AS total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)";

        if (!empty($data['filter_category_id'])) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";}
        if (!empty($data['filter_store_id'])) {
            $sql .= " RIGHT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id)";}

        $sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";

        if (!empty($data['filter_manufacturer_id'])) {
            $sql .= " AND manufacturer_id = " . (int)$data['filter_manufacturer_id'] . " ";}

        if (!empty($data['filter_name'])) {
            $sql .= " AND pd.name LIKE '" . $data['filter_name'] . "%'";}

        if (!empty($data['filter_model'])) {
            $sql .= " AND LCASE(p.model) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_model'])) . "%'";}

        if (!empty($data['filter_price'])) {
            $sql .= " AND p.price LIKE '" . $this->db->escape($data['filter_price']) . "%'";}

        if (isset($data['filter_quantity']) && !is_null($data['filter_quantity'])) {
            $sql .= " AND p.quantity = '" . $this->db->escape($data['filter_quantity']) . "'";}

        if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
            $sql .= " AND p.status = '" . (int)$data['filter_status'] . "'";}

        if (!empty($data['filter_category_id'])) {
            if ($data['filter_sub_category']) {
                $implode_data = array();

                $implode_data[] = "category_id = '" . (int)$data['filter_category_id'] . "'";

                $this->load->model('catalog/category');

                $categories = $this->getCategories($data['filter_category_id']);

                foreach ($categories as $category) {
                    $implode_data[] = "p2c.category_id = '" . (int)$category['category_id'] . "'";
                }

                $sql .= " AND (" . implode(' OR ', $implode_data) . ")";
            } else {
                $sql .= " AND p2c.category_id = '" . (int)$data['filter_category_id'] . "'";
            }
        }

        if (!empty($data['filter_store_id'])) {
            $sql .= " AND p2s.store_id = " . (int)$data['filter_store_id'];}

        $query = $this->db->query($sql);
        return $query->row['total'];
    }
}
?>