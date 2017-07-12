<?php 
class ControllerProductCategory extends Controller {  
	public function index() { 
		$this->language->load('product/category');

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

/*Additional offer*/
		$this->load->model('module/addspecials');
/*Additional offer*/

		$this->load->model('tool/image'); 

		if (isset($this->request->get['filter'])) {
			$filter = $this->request->get['filter'];
			$this->document->setRobots('noindex,follow');
		} else {
			$filter = '';
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
			$this->document->setRobots('noindex,follow');
		} else {
			$sort = 'pv.viewed';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'DESC';
		}
		
		if (isset($this->request->get['coolfilter'])) {
	        $coolfilter = $this->request->get['coolfilter'];
			$this->document->setRobots('noindex,follow');
		} else {
	        $coolfilter = '';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
			$this->document->setRobots('noindex,follow');
		} else { 
			$page = 1;
		}	

		if (isset($this->request->get['limit'])) {
			$limit = $this->request->get['limit'];
			$this->document->setRobots('noindex,follow');
		} else {
			$limit = $this->config->get('config_catalog_limit');
		}

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
			'separator' => false
		);

		if (isset($this->request->get['path'])) {
			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}	

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['coolfilter'])) {
	          $url .= '&coolfilter=' . $this->request->get['coolfilter'];
	        }

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);

			$category_id = (int)array_pop($parts);
			
			$this->data['categ_id'] = $category_id;
			
			foreach ($parts as $path_id) {
				if (!$path) {
					$path = (int)$path_id;
				} else {
					$path .= '_' . (int)$path_id;
				}

				$category_info = $this->model_catalog_category->getCategory($path_id);

				if ($category_info || $path_id == 0) {
					
					if ($path_id == 0) {
						$category_info['name'] = $this->language->get('text_all_products');
					}
					$this->data['breadcrumbs'][] = array(
						'text'      => $category_info['name'],
						'href'      => $this->url->link('product/category', 'path=' . $path . $url),
						'separator' => $this->language->get('text_separator')
					);
				}
			}
		} else {
			$category_id = 0;
		}

		$category_info = $this->model_catalog_category->getCategory($category_id);

		if ($category_info || $category_id == 0) {
					if ($category_id == 0) {
						$category_info = array('name' => $this->language->get('text_all_products'),
							'seo_title' => '',
							'meta_description' => '',
							'meta_keyword' => '',
							'seo_h1' => $this->language->get('text_all_products'),
							'image' => '',
							'description' => '');
						//india style fix	
						$this->request->get['path'] = 0;
						//india style fix							
					}
		
			if ($category_info['seo_title']) {
		  		$this->document->setTitle($category_info['seo_title']);
			} else {
		  		$this->document->setTitle($category_info['name']);
			}
			
			$this->document->setDescription($category_info['meta_description']);
			$this->document->setKeywords($category_info['meta_keyword']);
			
			if ($category_info['seo_h1']) {
				$this->data['heading_title'] = $category_info['seo_h1'];
				} else {
				$this->data['heading_title'] = $category_info['name'];
			}
			$this->data['heading_description'] = $category_info['description'];
			$this->document->addScript('/catalog/view/javascript/jquery/jquery.total-storage.min.js');
			$this->document->addScript('/catalog/view/javascript/jquery/jail/jail.min.js');



			$this->data['text_refine'] = $this->language->get('text_refine');
			$this->data['text_empty'] = $this->language->get('text_empty');			
			$this->data['text_quantity'] = $this->language->get('text_quantity');
			$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$this->data['text_model'] = $this->language->get('text_model');
			$this->data['text_price'] = $this->language->get('text_price');
			$this->data['text_tax'] = $this->language->get('text_tax');
			$this->data['text_points'] = $this->language->get('text_points');
			$this->data['text_label_new'] = $this->language->get('text_label_new');
			
			
			$this->data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
			$this->data['text_display'] = $this->language->get('text_display');
			$this->data['text_list'] = $this->language->get('text_list');
			$this->data['text_grid'] = $this->language->get('text_grid');
			$this->data['text_sort'] = $this->language->get('text_sort');
			$this->data['text_limit'] = $this->language->get('text_limit');
			$this->data['text_benefits'] = $this->language->get('text_benefits');
			$this->data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
			$this->data['button_cart'] = $this->language->get('button_cart');
			$this->data['button_wishlist'] = $this->language->get('button_wishlist');
			$this->data['button_compare'] = $this->language->get('button_compare');
			$this->data['button_continue'] = $this->language->get('button_continue');
			$this->data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
			// Set the last category breadcrumb		
			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}	

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['coolfilter'])) {
	          $url .= '&coolfilter=' . $this->request->get['coolfilter'];
	        }

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			if (isset($this->request->get['coolfilter'])) {
	          $url .= '&coolfilter=' . $this->request->get['coolfilter'];
	        }

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$this->data['breadcrumbs'][] = array(
				'text'      => $category_info['name'],
				'href'      => $this->url->link('product/category', 'path=' . $this->request->get['path']),
				'separator' => $this->language->get('text_separator')
			);

			if ($category_info['image']) {
				$this->data['thumb'] = $this->model_tool_image->resize($category_info['image'], $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
				$this->document->setOgImage($this->data['thumb']);
			} else {
				$this->data['thumb'] = '';
			}

			$this->data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');
			$this->data['description_bottom'] = html_entity_decode($category_info['description_bottom'], ENT_QUOTES, 'UTF-8');
			$this->data['compare'] = $this->url->link('product/compare');

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}	

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}	

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['coolfilter'])) {
	          $url .= '&coolfilter=' . $this->request->get['coolfilter'];
	        }

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$this->data['categories'] = array();

			$results = $this->model_catalog_category->getCategories($category_id);

			foreach ($results as $result) {
				$data = array(
					'filter_category_id'  => $result['category_id'],
					'filter_sub_category' => true,
					'coolfilter'         => $coolfilter
				);

				$product_total = $this->model_catalog_product->getTotalProducts($data);				

				$this->data['categories'][] = array(
					'name'  => $result['name'] . ($this->config->get('config_product_count') ? ' (' . $product_total . ')' : ''),
					'count' => $product_total,
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $result['category_id'] . $url)
				);
			}

			$this->data['products'] = array();
			if($category_id == 59) {
				$fsc = false;
			} else {
				$fsc = 59;
			}
			$data = array(
				'filter_category_id' => $category_id,
				'fsc' 				 => $fsc,
				'filter_filter'      => $filter,
				'sort'               => $sort,
				'order'              => $order,
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit,
				'coolfilter'         => $coolfilter
			);

			$position = (($page - 1) * $limit) + 1;

			$product_total = $this->model_catalog_product->getTotalProducts($data); 

			$results = $this->model_catalog_product->getProducts($data);

			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					$imagewidth = $this->config->get('config_image_product_width');
					$imageheight = $this->config->get('config_image_product_height');
				} else {
					$image = false;
					$imagewidth = '';
					$imageheight = '';
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

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
				} else {
					$tax = false;
				}				

				if ($this->config->get('config_review_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}			
			
				$stickers = $this->getStickers($result['product_id']) ;
				
				$options = array();

				foreach ($this->model_catalog_product->getProductOptions($result['product_id'])  as $option) {
					if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'checkbox' || $option['type'] == 'image') {
						$option_value_data = array();

						foreach ($option['option_value'] as $option_value) {
							if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {

								$option_value_data[] = array(
									'product_option_value_id' => $option_value['product_option_value_id'],
									'option_value_id'         => $option_value['option_value_id'],
									'name'                    => $option_value['name'],
									'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),
									'price'                   => '',
									'price_prefix'            => $option_value['price_prefix']
								);
							}
						}

						$options[] = array(
							'product_option_id' => $option['product_option_id'],
							'option_id'         => $option['option_id'],
							'name'              => $option['name'],
							'type'              => $option['type'],
							'option_value'      => $option_value_data,
							'required'          => $option['required']
						);
					} elseif ($option['type'] == 'text' || $option['type'] == 'textarea' || $option['type'] == 'file' || $option['type'] == 'date' || $option['type'] == 'datetime' || $option['type'] == 'time') {
						$options[] = array(
							'product_option_id' => $option['product_option_id'],
							'option_id'         => $option['option_id'],
							'name'              => $option['name'],
							'type'              => $option['type'],
							'option_value'      => $option['option_value'],
							'required'          => $option['required']
						);
					}
				}

				$attribute_groups = $this->model_catalog_product->getProductAttributes($result['product_id']);
				$new_collection = false;
				foreach ($attribute_groups as $attribute_group) {
					foreach ($attribute_group['attribute'] as $attribute) {
						if($attribute['attribute_id'] == 46 && $attribute['text'] == 'новая'){
							$new_collection = true;
						}
					}
				}

				//ocshop benefits
				$productbenefits = $this->model_catalog_product->getProductBenefitsbyProductId($result['product_id']);
				$benefits = array();
				
				foreach ($productbenefits as $benefit) {
					if ($benefit['image'] && file_exists(DIR_IMAGE . $benefit['image'])) {
						$bimage = $benefit['image'];
						if ($benefit['type']) {
							$bimage = $this->model_tool_image->resize($bimage, 25, 25);
						} else {
							$bimage = $this->model_tool_image->resize($bimage, 120, 60);
						}
					} else {
						$bimage = 'no_image.jpg';
					}

					$benefits[] = array(
						'benefit_id'      	=> $benefit['benefit_id'],
						'name'      		=> $benefit['name'],
						'description'      	=> strip_tags(html_entity_decode($benefit['description'])),
						'thumb'      		=> $bimage,
						'link'      		=> $benefit['link'],
						'type'      		=> $benefit['type']
						//'sort_order' => $benefit['sort_order']
					);
				}

				$categories = $this->model_catalog_product->getCategories($result['product_id']);

				$freeshipping = false;
				
				if ($special) {
					$pieces = explode(' ', $special); 
					if($pieces[0] > 1000) {
						$freeshipping = true;
					}
				} else {
					$pieces = explode(' ', $price); 
					if($pieces[0] > 1000) {
						$freeshipping = true;
					}
				}

				if($special){
					$percent = (($result['price'] - $result['special']) / $result['price']) * 100;
					if($percent > 57 && $percent < 60 && $category_id == 59){
						$percent = 60;
					}
					$discount = "-" . round($percent) . "%";
				} else {
					$discount = false;
				}

/*Additional offer*/
				$additionaloffer = $this->model_module_addspecials->getProductAdditionalOffer($result['product_id']);
				if(!empty($additionaloffer)) {
					$ao_label = true;
				} else {
					$ao_label = false;
				}
/*Additional offer*/

				$this->data['products'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
/*Additional offer*/
					'ao_label'    => $ao_label,
/*Additional offer*/
					'thumbwidth'  => $imagewidth,
					'thumbheight' => $imageheight,
					'name'        => $result['name'],
					'sku'        => $result['sku'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 300) . '..',
					'description_mini' => html_entity_decode ($result['description_mini']),
					'price'       => $price,
					'special'     => $special,
					'freeshipping' => $freeshipping,
					'discount' 	  => $discount,
					'tax'         => $tax,
					'rating'      => $result['rating'],
					'sticker'     => $stickers,
					'benefits'    => $benefits,
					'reviews'     => (int)$result['reviews'], //sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
					'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url),
					'options'     => $options,
					'position'	  => $position,
					'collection'  => $new_collection
				);
				$position++;
			}
/* BLOG
			$this->load->model('blog/article');

			$this->data['articles'] = $this->model_blog_article->getArticleRelated_by_category($category_id, 5);
 BLOG */
			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}
			
			if (isset($this->request->get['coolfilter'])) {
				$url .= '&coolfilter=' . $this->request->get['coolfilter'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}
			
			if (isset($this->request->get['coolfilter'])) {
				$url .= '&coolfilter=' . $this->request->get['coolfilter'];
			}

			$this->data['sorts'] = array();

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_default'),
				'value' => 'pv.viewed-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pv.viewed&order=DESC' . $url)
			);

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_name_asc'),
				'value' => 'pd.name-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=ASC' . $url)
			);

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_name_desc'),
				'value' => 'pd.name-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=DESC' . $url)
			);

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_price_asc'),
				'value' => 'p.price-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=ASC' . $url)
			); 

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_price_desc'),
				'value' => 'p.price-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=DESC' . $url)
			); 

			if ($this->config->get('config_review_status')) {
				$this->data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_desc'),
					'value' => 'rating-DESC',
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=DESC' . $url)
				); 

				$this->data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_asc'),
					'value' => 'rating-ASC',
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=ASC' . $url)
				);
			}

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_model_asc'),
				'value' => 'p.model-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=ASC' . $url)
			);

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_model_desc'),
				'value' => 'p.model-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=DESC' . $url)
			);

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}	

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
			
			if (isset($this->request->get['coolfilter'])) {
				$url .= '&coolfilter=' . $this->request->get['coolfilter'];
			}

			$this->data['limits'] = array();

			$limits = array_unique(array($this->config->get('config_catalog_limit'), 25, 50, 75, 100));

			sort($limits);

			foreach($limits as $value){
				$this->data['limits'][] = array(
					'text'  => $value,
					'value' => $value,
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=' . $value)
				);
			}

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}	

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}
			
			if (isset($this->request->get['coolfilter'])) {
				$url .= '&coolfilter=' . $this->request->get['coolfilter'];
			}

			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->text = $this->language->get('text_pagination');
			$pagination->url = $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&page={page}');

			$this->data['pagination'] = $pagination->render();

			$this->data['sort'] = $sort;
			$this->data['order'] = $order;
			$this->data['limit'] = $limit;

			$this->data['continue'] = $this->url->link('common/home');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/category.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/product/category.tpl';
			} else {
				$this->template = 'default/template/product/category.tpl';
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
		} else {
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}	

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_error'),
				'href'      => $this->url->link('product/category', $url),
				'separator' => $this->language->get('text_separator')
			);

			$this->document->setTitle($this->language->get('text_error'));

			$this->data['heading_title'] = $this->language->get('text_error');

			$this->data['text_error'] = $this->language->get('text_error');

			$this->data['button_continue'] = $this->language->get('button_continue');

			$this->data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . '/1.1 404 Not Found');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
			} else {
				$this->template = 'default/template/error/not_found.tpl';
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
