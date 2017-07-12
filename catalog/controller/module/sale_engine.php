<?php
class ControllerModuleSaleEngine extends Controller {
	protected function index($setting) {
		$this->language->load('module/sale_engine');
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->load->model('catalog/product');
		
		$this->load->model('tool/image');
		
		$this->data['products'] = array();
		
		$data = array(
			'sort'  => 'pv.viewed',
            'filter_category_id'  => 123,
			'order' => 'DESC',
			'start' => 0,
			'limit' => $setting['limit']
		);

		$results = $this->model_catalog_product->getProducts($data);

        $position = 1;

		foreach ($results as $result) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], $setting['image_width'], $setting['image_height']);
			} else {
				$image = false;
			}
						
			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$price = false;
			}
					
			if ((float)$result['special']) {
				$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$special = false;
			}
			
			if ($this->config->get('config_review_status')) {
				$rating = $result['rating'];
			} else {
				$rating = false;
			}

            if($special){
                $percent = (($result['price'] - $result['special']) / $result['price']) * 100;
                if($percent > 57 && $percent < 60){
                    $percent = 60;
                }
                if($percent > 60 && $percent < 63){
                    $percent = 60;
                }
                $discount = "-" . round($percent) . "%";
            } else {
                $discount = false;
            }

			$stickers = $this->getStickers($result['product_id']) ;
			
			$this->data['products'][] = array(
				'product_id' => $result['product_id'],
				'thumb'   	 => $image,
				'name'    	 => $result['name'],
				'sku'    	 => $result['sku'],
				'price'   	 => $price,
				'special' 	 => $special,
                'discount'   => $discount,
				'rating'     => $rating,
                'position'	 => $position,
				'sticker'    => $stickers,
				'reviews'    => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
				'href'    	 => $this->url->link('product/product', 'product_id=' . $result['product_id']),
			);
            $position++;
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/sale_engine.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/sale_engine.tpl';
		} else {
			$this->template = 'default/template/module/sale_engine.tpl';
		}

		$this->render();
	}
	
	private function getStickers($product_id) {
	
 	$stickers = $this->model_catalog_product->getProductStickerbyProductId($product_id) ;	
		
		if (!$stickers) {
			return;
		}
		
		$this->data['stickers'] = array();
		
		foreach ($stickers as $sticker) {
			$this->data['stickers'][] = array(
				'position' => $sticker['position'],
				'image'    => HTTP_SERVER . 'image/' . $sticker['image']
			);		
		}

	
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/stickers.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/product/stickers.tpl';
		} else {
			$this->template = 'default/template/product/stickers.tpl';
		}
	
		return $this->render();
	
	}
}
?>