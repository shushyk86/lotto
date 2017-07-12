<?php  
class ControllerCatalogAddSpecials extends Controller {
    private $product_filter = array();
    private $label_messege = array("type" => "success", "message" => array());
    
    
	public function index() {
        $this->load->language('catalog/addspecials');
		$this->load->model('catalog/manufacturer');
        $this->load->model('catalog/category');
        $this->load->model('setting/store');
        $this->load->model('catalog/addspecials');
		
		$this->document->setTitle($this->language->get('heading_title'));

		$this->getList();
		
	}
	
	protected function getList() {
		$this->load->model('catalog/addspecials');
		$this->load->model('catalog/suppler');
		$this->load->language('catalog/addspecials');
		
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'name';
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

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
	
		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('catalog/addspecials', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

		$this->data['insert'] = $this->url->link('catalog/addspecials/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->data['offers'] = array();

		$data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit' => $this->config->get('config_admin_limit')
		);

		$offers_total = $this->model_catalog_addspecials->getTotalOffers();

		$results = $this->model_catalog_addspecials->getOffers($data);

		foreach ($results as $result) {
			$action = array();

			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('catalog/addspecials/update', 'token=' . $this->session->data['token'] . '&offer_id=' . $result['offer_id'] . $url, 'SSL')
			);
			
			$action[] = array(
				'text' => $this->language->get('text_del'),
				'class' => 'submit_delete',
				'href' => $this->url->link('catalog/addspecials/delete_ao', 'token=' . $this->session->data['token'] . '&offer_id=' . $result['offer_id'] . $url, 'SSL')
			);

			if($result['type'] == "product"){
				$type = $this->language->get('text_type_product');
			} elseif($result['type'] == "summ"){
				$type = $this->language->get('text_type_summ');
			} else {
				$type = $this->language->get('text_invalid_offer_type');
			}
			
			if($result['type'] == "summ"){
				$summ = $result['quantity'];
			} else {
				$summ = "";
			}
			$this->data['offers'][] = array(
				'offer_id' 		  => $result['offer_id'],
				'name'            => $result['name'],
				'date_start'      => $result['date_start'],
				'date_end'        => $result['date_end'],
				'discount_type'   => $result['discount_type'],
				'type'       	  => $type,
				'summ'       	  => $summ,
				'action'          => $action
			);
		}	

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_confirm'] = $this->language->get('text_confirm');

		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_type'] = $this->language->get('column_type');
		$this->data['column_action'] = $this->language->get('column_action');		
		$this->data['column_date_start'] = $this->language->get('column_date_start');		
		$this->data['column_date_end'] = $this->language->get('column_date_end');		

		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_delete'] = $this->language->get('button_delete');

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

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$this->data['sort_name'] = $this->url->link('catalog/addspecials', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $offers_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('catalog/addspecials', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$this->data['pagination'] = $pagination->render();

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'catalog/addspecials_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}
	
	public function insert() {
		$this->language->load('catalog/addspecials');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/manufacturer');

		$this->getForm();
	}
	
	public function update() {
		$this->language->load('catalog/addspecials');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/manufacturer');
		
		if(isset($this->request->get['offer_id'])){
			$this->getForm((int)$this->request->get['offer_id']);
		}
	}
	
	public function delete_ao() {
		$this->language->load('catalog/addspecials');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/addspecials');

		if (isset($this->request->get['offer_id']) && !empty($this->request->get['offer_id'])) {
			$this->model_catalog_addspecials->delete_ao($this->request->get['offer_id']);
			
			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->redirect($this->url->link('catalog/addspecials', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
		
		$this->getList();
	}
	
    public function productFilter(){
        $data = array();
        $json = array();
        
        $this->product_filter["name"] = "";
        if (isset($this->request->post['name'])) {
            $this->product_filter["name"] = $this->request->post['name'];
            $data['filter_name'] = $this->product_filter["name"];
        }

        $this->product_filter["model"] = "";
        if (isset($this->request->post['model'])) {
            $this->product_filter["model"] = $this->request->post['model'];
            $data['filter_model'] = $this->product_filter["model"];
        }

        $this->product_filter["change_all"] = false;
        if (isset($this->request->post['change_all'])) {
            $this->product_filter["change_all"] = true;
        }

        $this->product_filter["change_ids"] = array();
        if (isset($this->request->post['product_to_change'])) {
            $this->product_filter["change_ids"] = $this->request->post['product_to_change'];
        }

        if (isset($this->request->get['product_list'])) {
            $this->product_filter["start"] = 0;
            $this->product_filter["limit"] = 30;
            if (isset($this->request->get['start'])) {
                $this->product_filter["start"] = $this->request->get['start'];
                $data['start'] = $this->product_filter["start"];
            }
            if (isset($this->request->get['limit'])) {
                $this->product_filter["limit"] = $this->request->get['limit'];
                $data['limit'] = $this->product_filter["limit"];
            }
        }

        $this->product_filter["store_id"] = -1;
        if (isset($this->request->post['store_id'])) {
            if ($this->request->post['store_id'] >= 0){
                $this->product_filter["store_id"] = $this->request->post['store_id'];
                $data['filter_store_id'] = $this->product_filter["store_id"];
            }
        }

        $this->product_filter["manufacturer_id"] = 0;
        if (isset($this->request->post['manufacturer_id'])) {
            $this->product_filter["manufacturer_id"] = $this->request->post['manufacturer_id'];
            $data['filter_manufacturer_id'] = $this->product_filter["manufacturer_id"];
        }

        $this->product_filter["category_id"] = 0;
        if (isset($this->request->post['category_id'])) {
            $this->product_filter["category_id"] = $this->request->post['category_id'];
            $data['filter_category_id'] = $this->product_filter["category_id"];
        }

        $this->product_filter["filter_sub_category"] = false;
        $data["filter_sub_category"] = false;
        if (isset($this->request->post['filter_sub_category'])) {
            $this->product_filter["filter_sub_category"] = true;
            $data["filter_sub_category"] = true;
        }
        
        $this->load->model('catalog/addspecials');
        
        $json['products'] = $this->model_catalog_addspecials->getProducts($data);

        $json['total'] = $this->model_catalog_addspecials->getTotalProducts($data);

        $this->response->setOutput(json_encode($json));
    }
    
	protected function getForm($offer_id = 0) {

			$this->load->language('catalog/addspecials');
			$this->load->model('catalog/addspecials');
			$this->load->model('catalog/manufacturer');
			$this->load->model('catalog/product');
			$this->load->model('catalog/category');
			$this->load->model('setting/store');
			
			$this->data['breadcrumbs'] = array();

			$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => false
			);

			$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('heading_title'),
				'href'      => $this->url->link('catalog/addspecials', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' :: '
			);

			$this->document->setTitle($this->language->get('heading_title'));
			$this->data['heading_title'] = $this->language->get('heading_title');
			
			$this->data['text_image_manager'] = $this->language->get('text_image_manager');
			$this->data['text_browse'] = $this->language->get('text_browse');
			$this->data['text_clear'] = $this->language->get('text_clear');
			
			$this->data['entry_manufacturer'] = $this->language->get('entry_manufacturer');
			$this->data['entry_category'] = $this->language->get('entry_category');
			$this->data['entry_model'] = $this->language->get('entry_model');
			$this->data['entry_name'] = $this->language->get('entry_name');
			$this->data['entry_subcategory'] = $this->language->get('entry_subcategory');
			$this->data['store_default'] = $this->language->get('store_default');
			$this->data['entry_customer_group'] = $this->language->get('entry_customer_group');
			$this->data['entry_quantity'] = $this->language->get('entry_quantity');
			$this->data['entry_priority'] = $this->language->get('entry_priority');
			$this->data['entry_price'] = $this->language->get('entry_price');
			$this->data['entry_summ'] = $this->language->get('entry_summ');
			$this->data['entry_date_start'] = $this->language->get('entry_date_start');
			$this->data['entry_date_end'] = $this->language->get('entry_date_end');
			$this->data['entry_image'] = $this->language->get('entry_image');
			$this->data['entry_href'] = $this->language->get('entry_href');
			$this->data['entry_name'] = $this->language->get('entry_name');
			$this->data['column_name'] = $this->language->get('column_name');
			
			$this->data['tab_del'] = $this->language->get('tab_del');
			
			$this->data['button_additional_offer'] = $this->language->get('button_additional_offer');
			$this->data['button_del'] = $this->language->get('button_del');
			$this->data['button_cancel'] = $this->language->get('button_cancel');

			$this->data['text_filtered_products'] = $this->language->get('text_filtered_products');
			$this->data['text_all'] = $this->language->get('text_all');

			$this->data['option_none'] = $this->language->get('option_none');
			$this->data['option_all'] = $this->language->get('option_all');

			$this->data['token'] = $this->session->data['token'];
			
			$this->data['manufacturers'] = $this->model_catalog_manufacturer->getManufacturers();

			$data = array();

			$this->data['categories'] = $this->model_catalog_category->getCategories($data);
			
			$this->load->model('tool/image');
			
			if ($offer_id == 0) {
				$this->data['add_additional_offer'] = $this->url->link('catalog/addspecials/add_additional_offer', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$this->data['add_additional_offer'] = $this->url->link('catalog/addspecials/add_additional_offer', 'token=' . $this->session->data['token'] . '&offer_id=' . $offer_id, 'SSL');
			}
			
			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->data['cancel'] = $this->url->link('catalog/addspecials', 'token=' . $this->session->data['token'] . $url, 'SSL');

			if ($offer_id > 0 && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
				$this->data['button_additional_offer'] = $this->language->get('button_additional_offer_save');
				
				$this->load->model('tool/image');
				
				$offer_info = $this->model_catalog_addspecials->getOffer($offer_id);
				
				if($offer_info['type'] == 'product'){
					$this->data['offer_products'] = array();
					$offer_products = $this->model_catalog_addspecials->getOfferProducts($offer_id);
					foreach($offer_products as $product){
						$product = $this->model_catalog_product->getProduct($product['product_id']);
						$this->data['offer_products'][] = array(
							'product_id' => $product['product_id'],
							'name'		 => $product['name'],
							'sku'		 => $product['sku']
						);
					}
				}
				
				$bonus_products = $this->model_catalog_addspecials->getOfferBonusProducts($offer_id);
				$this->data['bonus_products'] = array();
				
				foreach($bonus_products as $product){
					$product = $this->model_catalog_product->getProduct($product['ao_product_id']);
					$this->data['bonus_products'][] = array(
						'product_id' => $product['product_id'],
						'name'		 => $product['name'],
						'sku'		 => $product['sku']
					);
				}
				$offer_info['thumb'] = $this->model_tool_image->resize($offer_info['image'], 100, 100);
				$this->data['offer_info'] = $offer_info;
			}
			
			$this->template = 'catalog/addspecials_form.tpl';
			$this->children = array(
				'common/header',
				'common/footer'
			);
					
			$this->response->setOutput($this->render());
	}
	
    public function add_additional_offer() {
        $this->load->language('catalog/addspecials');
        $this->load->model('catalog/addspecials');
        $this->load->model('catalog/product');
        $json = array();
		if(isset($this->request->get['offer_id'])){
			$offer_info = $this->model_catalog_addspecials->getOffer($this->request->get['offer_id']);
			$offer_type = $offer_info['type'];
		} elseif(isset($this->request->post['offer_type'])){
			$offer_type = $this->request->post['offer_type'];
		}
		
		if($offer_type){
			$product_additional_offer = array();
			
			if($offer_type == 'product') {
				if(isset($this->request->post['offer-product'])) {
					$offer_products = $this->request->post['offer-product'];
				} else {
					$json['error'] = $this->language->get('text_noproduct');
				}
			} elseif ($offer_type == 'summ'){
				if(isset($this->request->post['product_additional_offer']['quantity']) && !empty($this->request->post['product_additional_offer']['quantity'])) {
					$product_additional_offer['quantity'] = $this->request->post['product_additional_offer']['quantity'];
				} else {
					$json['error'] = $this->language->get('text_nosumm');
				}
			}		
		
			if(isset($this->request->post['ao_product'])){
				$bonus_products = $this->request->post['ao_product'];
			} else {
				$json['error'] = $this->language->get('text_no_bonus_product');
			}
		
			if(!$json['error']){
				
				if($offer_type == 'product') {
					$products = array();
					foreach($offer_products as $product_id){
						$products[] = $this->model_catalog_product->getProduct($product_id);
					}
					
					$product_additional_offer['quantity'] = 1;
					if(isset($this->request->post['product_additional_offer']['quantity']) && !empty($this->request->post['product_additional_offer']['quantity'])) {
						$product_additional_offer['quantity'] = $this->request->post['product_additional_offer']['quantity'];
					}
				}
				
				$ao_products = array();

				foreach($bonus_products as $product_id){
					$ao_products[] = $this->model_catalog_product->getProduct($product_id);
				}
			
				if(isset($this->request->post['product_additional_offer'])) {
					$product_additional_offer['discount_type'] = "price";
					if(isset($this->request->post['product_additional_offer']['discount_type']) && !empty($this->request->post['product_additional_offer']['discount_type'])) {
						$product_additional_offer['discount_type'] = $this->request->post['product_additional_offer']['discount_type'];
					}
					
					$product_additional_offer['customer_group_id'] = 1;
					if(isset($this->request->post['product_additional_offer']['customer_group_id']) && !empty($this->request->post['product_additional_offer']['customer_group_id'])) {
						$product_additional_offer['customer_group_id'] = $this->request->post['product_additional_offer']['customer_group_id'];
					}
					
					$product_additional_offer['priority'] = 1;
					if(isset($this->request->post['product_additional_offer']['priority']) && !empty($this->request->post['product_additional_offer']['priority'])) {
						$product_additional_offer['priority'] = $this->request->post['product_additional_offer']['priority'];
					}
					
					$product_additional_offer['name'] = "Без имени";
					if(isset($this->request->post['product_additional_offer']['offer_name']) && !empty($this->request->post['product_additional_offer']['offer_name'])) {
						$product_additional_offer['name'] = $this->request->post['product_additional_offer']['offer_name'];
					}
					
					$product_additional_offer['price'] = 0;
					if(isset($this->request->post['product_additional_offer']['price']) && !empty($this->request->post['product_additional_offer']['price'])) {
						$product_additional_offer['price'] = $this->request->post['product_additional_offer']['price'];
					}
					
					$product_additional_offer['date_start'] = date('Y-m-d');
					if(isset($this->request->post['product_additional_offer']['date_start']) && !empty($this->request->post['product_additional_offer']['date_start'])) {
						$product_additional_offer['date_start'] = $this->request->post['product_additional_offer']['date_start'];
					}
					
					$product_additional_offer['date_end'] = date('Y-m-d');
					if(isset($this->request->post['product_additional_offer']['date_end']) && !empty($this->request->post['product_additional_offer']['date_end'])) {
						$product_additional_offer['date_end'] = $this->request->post['product_additional_offer']['date_end'];
					}
					
					$product_additional_offer['image'] = '';
					if(isset($this->request->post['product_additional_offer']['image']) && !empty($this->request->post['product_additional_offer']['image'])) {
						$product_additional_offer['image'] = $this->request->post['product_additional_offer']['image'];
					}
					
					$product_additional_offer['banner_link'] = '';
					if(isset($this->request->post['product_additional_offer']['banner_link']) && !empty($this->request->post['product_additional_offer']['banner_link'])) {
						$product_additional_offer['banner_link'] = $this->request->post['product_additional_offer']['banner_link'];
					}
					
					$product_additional_offer['description'] = '';
					if(isset($this->request->post['product_additional_offer']['description'])) {
						$product_additional_offer['description'] = $this->request->post['product_additional_offer']['description'];
					}
				}
				
				$product_additional_offer['offer_type'] = $offer_type;
				
				if(isset($this->request->get['offer_id'])){
					$product_additional_offer['offer_id'] = $this->request->get['offer_id'];
					$this->model_catalog_addspecials->delete_ao($product_additional_offer['offer_id']);
					if($offer_type == 'product'){
						foreach($products as $product) {
							$offer_product_sku = $this->model_catalog_addspecials->getProductSkuById($product['product_id']);
							foreach($ao_products as $aop){
								$ao_product_sku = $this->model_catalog_addspecials->getProductSkuById($aop['product_id']);
								$product_additional_offer['ao_product_id'] = $ao_product_sku;
								$this->model_catalog_addspecials->AddAdditionalOffer($offer_product_sku, $product_additional_offer);
							}
						}
					} elseif ($offer_type == 'summ'){
						foreach($ao_products as $aop){
							$ao_product_sku = $this->model_catalog_addspecials->getProductSkuById($aop['product_id']);
							$product_additional_offer['ao_product_id'] = $ao_product_sku;
							$this->model_catalog_addspecials->AddAdditionalOffer('', $product_additional_offer);
						}
					}	
				} else {
					$product_additional_offer['offer_id'] = $this->model_catalog_addspecials->getLastOfferId();
					$product_additional_offer['offer_id']++;
					if($offer_type == 'product'){
						foreach($products as $product) {
							$offer_product_sku = $this->model_catalog_addspecials->getProductSkuById($product['product_id']);
							foreach($ao_products as $aop){
								$ao_product_sku = $this->model_catalog_addspecials->getProductSkuById($aop['product_id']);
								$product_additional_offer['ao_product_id'] = $ao_product_sku;
								$this->model_catalog_addspecials->AddAdditionalOffer($offer_product_sku, $product_additional_offer);
							}
						}						
					} elseif ($offer_type == 'summ'){
						foreach($ao_products as $aop){
							$ao_product_sku = $this->model_catalog_addspecials->getProductSkuById($aop['product_id']);
							$product_additional_offer['ao_product_id'] = $ao_product_sku;
							$this->model_catalog_addspecials->AddAdditionalOffer('', $product_additional_offer);
						}
					}
				}
				
				$json['message']['type'] = 'success';
				$json['message']['message'] = $this->language->get('success_add_specials');
				
			}		
		} else{
			$json['error'] = "Неизвестный тип акции";
		}
		$this->model_catalog_addspecials->updateProductIds();
        $this->response->setOutput(json_encode($json));
    }   
}
?>
