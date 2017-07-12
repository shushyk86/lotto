<?php 
class ControllerProductSearch extends Controller { 	
	public function index() { 
		$this->language->load('product/search');

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');
		
/*Additional offer*/
		$this->load->model('module/addspecials');
/*Additional offer*/

		$this->load->model('tool/image'); 

		if (isset($this->request->get['search'])) {
			$search = $this->request->get['search'];
		} else {
			$search = '';
		} 

		if (isset($this->request->get['tag'])) {
			$tag = $this->request->get['tag'];
		} elseif (isset($this->request->get['search'])) {
			$tag = $this->request->get['search'];
		} else {
			$tag = '';
		}

        if (isset($this->request->get['article_tag'])) {
            $article_tag = $this->request->get['article_tag'];
        } else {
            $article_tag = '';
        }

		if (isset($this->request->get['description'])) {
			$description = $this->request->get['description'];
		} else {
			$description = '';
		} 

		if (isset($this->request->get['category_id'])) {
			$category_id = $this->request->get['category_id'];
		} else {
			$category_id = 0;
		} 

		if (isset($this->request->get['sub_category'])) {
			$sub_category = $this->request->get['sub_category'];
		} else {
			$sub_category = '';
		} 

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'pv.viewed';
		} 

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'DESC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['limit'])) {
			$limit = $this->request->get['limit'];
		} else {
			$limit = $this->config->get('config_catalog_limit');
		}

		if (isset($this->request->get['search'])) {
			$this->document->setTitle($this->language->get('heading_title') .  ' - ' . $this->request->get['search']);
		} else {
			$this->document->setTitle($this->language->get('heading_title'));
		}
		
		$this->document->setRobots('noindex,follow');

		$this->document->addScript('catalog/view/javascript/jquery/jquery.total-storage.min.js');
		$this->document->addScript('catalog/view/javascript/jquery/jail/jail.min.js');

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
			'separator' => false
		);

		$url = '';

		if (isset($this->request->get['search'])) {
			$url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['tag'])) {
			$url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
		}

        if (isset($this->request->get['article_tag'])) {
            $url .= '&article_tag=' . urlencode(html_entity_decode($this->request->get['article_tag'], ENT_QUOTES, 'UTF-8'));
        }

		if (isset($this->request->get['description'])) {
			$url .= '&description=' . $this->request->get['description'];
		}

		if (isset($this->request->get['category_id'])) {
			$url .= '&category_id=' . $this->request->get['category_id'];
		}

		if (isset($this->request->get['sub_category'])) {
			$url .= '&sub_category=' . $this->request->get['sub_category'];
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
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('product/search', $url),
			'separator' => $this->language->get('text_separator')
		);

		if (isset($this->request->get['search'])) {
			$this->data['heading_title'] = $this->language->get('heading_title') .  ' - ' . $this->request->get['search'];
		} else {
			$this->data['heading_title'] = $this->language->get('heading_title');
		}
		
		$this->document->setRobots('noindex,follow');

		$this->data['text_empty'] = $this->language->get('text_empty');
		$this->data['text_critea'] = $this->language->get('text_critea');
		$this->data['text_search'] = $this->language->get('text_search');
		$this->data['text_keyword'] = $this->language->get('text_keyword');
		$this->data['text_category'] = $this->language->get('text_category');
		$this->data['text_sub_category'] = $this->language->get('text_sub_category');
		$this->data['text_quantity'] = $this->language->get('text_quantity');
		$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$this->data['text_model'] = $this->language->get('text_model');
		$this->data['text_price'] = $this->language->get('text_price');
		$this->data['text_tax'] = $this->language->get('text_tax');
		$this->data['text_points'] = $this->language->get('text_points');
		$this->data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
		$this->data['text_display'] = $this->language->get('text_display');
		$this->data['text_list'] = $this->language->get('text_list');
		$this->data['text_grid'] = $this->language->get('text_grid');		
		$this->data['text_sort'] = $this->language->get('text_sort');
		$this->data['text_limit'] = $this->language->get('text_limit');
		$this->data['text_benefits'] = $this->language->get('text_benefits');
		$this->data['text_sale'] = $this->language->get('text_sale');

		$this->data['entry_search'] = $this->language->get('entry_search');
		$this->data['entry_description'] = $this->language->get('entry_description');

		$this->data['button_search'] = $this->language->get('button_search');
		$this->data['button_cart'] = $this->language->get('button_cart');
		$this->data['button_wishlist'] = $this->language->get('button_wishlist');
		$this->data['button_compare'] = $this->language->get('button_compare');
		$this->data['button_continue'] = $this->language->get('button_continue');

		$this->data['compare'] = $this->url->link('product/compare');

		$this->load->model('catalog/category');

		// 3 Level Category Search
		$this->data['categories'] = array();

		$categories_1 = $this->model_catalog_category->getCategories(0);

		foreach ($categories_1 as $category_1) {
			$level_2_data = array();

			$categories_2 = $this->model_catalog_category->getCategories($category_1['category_id']);

			foreach ($categories_2 as $category_2) {
				$level_3_data = array();

				$categories_3 = $this->model_catalog_category->getCategories($category_2['category_id']);

				foreach ($categories_3 as $category_3) {
					$level_3_data[] = array(
						'category_id' => $category_3['category_id'],
						'name'        => $category_3['name'],
					);
				}

				$level_2_data[] = array(
					'category_id' => $category_2['category_id'],	
					'name'        => $category_2['name'],
					'children'    => $level_3_data
				);					
			}

			$this->data['categories'][] = array(
				'category_id' => $category_1['category_id'],
				'name'        => $category_1['name'],
				'children'    => $level_2_data
			);
		}

		$this->data['products'] = array();

		if (isset($this->request->get['search']) || isset($this->request->get['tag'])) {
			$data = array(
				'is_search'           => true,
				'filter_name'         => $search, 
				'filter_tag'          => $tag,
				'filter_description'  => $search, // $description,
				'filter_category_id'  => $category_id, 
				'filter_sub_category' => $sub_category, 
				'sort'                => $sort,
				'order'               => $order,
				'start'               => ($page - 1) * $limit,
				'limit'               => $limit
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
				

                $discount_flag = false;

				foreach($categories as $category) {
					if(array_search(59, $category)) {
                        $discount_flag = true;
					}
				}

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
                    if($percent > 57 && $percent < 60 && $discount_flag){
                        $percent = 60;
                    }
                    $discount = "-" . ceil($percent) . "%";
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

                $attribute_groups = $this->model_catalog_product->getProductAttributes($result['product_id']);
                $new_collection = false;
                foreach ($attribute_groups as $attribute_group) {
                    foreach ($attribute_group['attribute'] as $attribute) {
                        if($attribute['attribute_id'] == 46 && $attribute['text'] == 'новая'){
                            $new_collection = true;
                        }
                    }
                }

				$this->data['products'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
/*Additional offer*/
					'ao_label'    => $ao_label,
/*Additional offer*/
					'thumbwidth'  => $imagewidth,
					'thumbheight' => $imageheight,
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 300) . '..',
					'description_mini' => html_entity_decode ($result['description_mini']),
					'price'       => $price,
					'sku'         => $result['sku'],
					'special'     => $special,
					'freeshipping' => $freeshipping,
                    'discount' 	  => $discount,
					'tax'         => $tax,
					'rating'      => $result['rating'],
					'sticker'     => $stickers,
					'benefits'    => $benefits,
					'reviews'     => (int)$result['reviews'], //sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'] . $url),
					'options'     => $options,
                    'position'    => $position,
                    'collection'  => $new_collection
				);
                $position++;
			}

			$url = '';

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$this->data['sorts'] = array();

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_default'),
				'value' => 'pv.viewed-DESC',
				'href'  => $this->url->link('product/search', '&sort=pv.viewed&order=DESC' . $url)
			);

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_name_asc'),
				'value' => 'pd.name-ASC',
				'href'  => $this->url->link('product/search', 'sort=pd.name&order=ASC' . $url)
			); 

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_name_desc'),
				'value' => 'pd.name-DESC',
				'href'  => $this->url->link('product/search', 'sort=pd.name&order=DESC' . $url)
			);

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_price_asc'),
				'value' => 'p.price-ASC',
				'href'  => $this->url->link('product/search', 'sort=p.price&order=ASC' . $url)
			); 

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_price_desc'),
				'value' => 'p.price-DESC',
				'href'  => $this->url->link('product/search', 'sort=p.price&order=DESC' . $url)
			); 

			if ($this->config->get('config_review_status')) {
				$this->data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_desc'),
					'value' => 'rating-DESC',
					'href'  => $this->url->link('product/search', 'sort=rating&order=DESC' . $url)
				); 

				$this->data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_asc'),
					'value' => 'rating-ASC',
					'href'  => $this->url->link('product/search', 'sort=rating&order=ASC' . $url)
				);
			}

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_model_asc'),
				'value' => 'p.model-ASC',
				'href'  => $this->url->link('product/search', 'sort=p.model&order=ASC' . $url)
			); 

			$this->data['sorts'][] = array(
				'text'  => $this->language->get('text_model_desc'),
				'value' => 'p.model-DESC',
				'href'  => $this->url->link('product/search', 'sort=p.model&order=DESC' . $url)
			);

			$url = '';

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}	

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			$this->data['limits'] = array();

			$limits = array_unique(array($this->config->get('config_catalog_limit'), 25, 50, 75, 100));

			sort($limits);

			foreach($limits as $value){
				$this->data['limits'][] = array(
					'text'  => $value,
					'value' => $value,
					'href'  => $this->url->link('product/search', $url . '&limit=' . $value)
				);
			}

			$url = '';

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
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

			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->text = $this->language->get('text_pagination');
			$pagination->url = $this->url->link('product/search', $url . '&page={page}');

			$this->data['pagination'] = $pagination->render();

            $this->data['articles'] = array();

		} elseif(isset($this->request->get['article_tag'])) {
            $this->load->model('blog/article');

            $data = array(
                'filter_article_tag' => $this->request->get['article_tag'],
                'sort'               => $sort,
                'order'              => $order,
                'start'              => ($page - 1) * $limit,
                'limit'              => $limit
            );

            $results = $this->model_blog_article->getArticles($data);

            foreach($results as $result){
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_blog_image_related_width'), $this->config->get('config_blog_image_related_height'));
                } else {
                    $image = false;
                }

                $this->data['articles'][] = array(
                    'thumb'   	        => $image,
                    'name'    	        => $result['name'],
                    'date_added'        => $result['date_added'],
                    'description_mini'  => strip_tags($result['description_mini']),
                    'href'    	        => $this->url->link('blog/article', 'article_id=' . $result['article_id'])
                );
            }
        }

		$this->data['search'] = $search;
		$this->data['description'] = $description;
		$this->data['category_id'] = $category_id;
		$this->data['sub_category'] = $sub_category;

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;
		$this->data['limit'] = $limit;

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/search.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/product/search.tpl';
		} else {
			$this->template = 'default/template/product/search.tpl';
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