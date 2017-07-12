<?php
class ControllerFeedGoogleSitemap extends Controller {
	public function index() {
		if ($this->config->get('google_sitemap_status')) {
			$output  = '<?xml version="1.0" encoding="UTF-8"?>';
			$output .= '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">';
			
			$output .= '<url>';
			$output .= '<loc>' . HTTP_SERVER . '</loc>';
			$this->load->model('design/banner');
			$lastmod = $this->model_design_banner->getLastModified();
			$output .= '<lastmod>';
			$output .= $lastmod['date_modified'] != '0000-00-00 00:00:00' ? substr($lastmod['date_modified'], 0, 10) : substr($lastmod['date_added'], 0, 10);
			$output .= '</lastmod>';
			$output .= '<changefreq>daily</changefreq>';
			$output .= '<priority>1.0</priority>';
			
			$output .= '<image:image>';
			$output .= '<image:loc>http://lotto-sport.com.ua/image/data/logolotto.png</image:loc>';
			$output .= '<image:title>Интернет-магазин lotto-sport.com.ua</image:title>';
			$output .= '</image:image>';
			
			$output .= '</url>';
			
			$this->load->model('catalog/product');
			$this->load->model('tool/image');

			$products = $this->model_catalog_product->getProducts();
			
			foreach ($products as $product) {
				$output .= '<url>';
				$output .= '<loc>' . $this->url->link('product/product', 'product_id=' . $product['product_id']) . '</loc>';
				$output .= '<lastmod>';
				$output .= $product['date_modified'] != '0000-00-00 00:00:00' ? substr($product['date_modified'], 0, 10) : substr($product['date_added'], 0, 10);
				$output .= '</lastmod>';
				$output .= '<changefreq>daily</changefreq>';
				$output .= '<priority>1.0</priority>';
				
				$attribute_groups = $this->model_catalog_product->getProductAttributes($product['product_id']);
			
				foreach($attribute_groups[0]['attribute'] as $attr) {
					if($attr['attribute_id'] == 11 && !empty($attr['text'])){
						$color = $attr['text'];
					}
				}
				
				if ($product['image']) {
					$output .= '<image:image>';
					$output .= '<image:loc>' . $this->model_tool_image->resize($product['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')) . '</image:loc>';
					$output .= '<image:title>' . $product['name'] . ' (' . $product['sku'] . ') ' .$color. '</image:title>';
					$output .= '</image:image>';
				}
				
				$output .= '</url>';
			}

			$output .= $this->getCategories(0);

			$this->load->model('catalog/manufacturer');

			$manufacturers = $this->model_catalog_manufacturer->getManufacturers();

			foreach ($manufacturers as $manufacturer) {
				$output .= '<url>';
				$output .= '<loc>' . $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $manufacturer['manufacturer_id']) . '</loc>';
				$output .= '<changefreq>weekly</changefreq>';
				$output .= '<priority>0.7</priority>';
				$output .= '</url>';

			}
			
			$this->load->model('blog/news');
			
			$output .= $this->getBlogCategories(0);
					
			$this->load->model('blog/article');

			$articles = $this->model_blog_article->getArticles();

			foreach ($articles as $article) {
				$output .= '<url>';
				$output .= '<loc>' . str_replace('&', '&amp;', str_replace('&amp;', '&', $this->url->link('blog/article', 'article_id=' . $article['article_id']))) . '</loc>';
				$output .= '<lastmod>' . substr(max($article['date_added'], $article['date_modified']), 0, 10) . '</lastmod>';
				$output .= '<changefreq>weekly</changefreq>';
				$output .= '<priority>1.0</priority>';
				$output .= '</url>';
			}

			$this->load->model('catalog/information');

			$informations = $this->model_catalog_information->getInformations();

			foreach ($informations as $information) {
				$output .= '<url>';
				$output .= '<loc>' . $this->url->link('information/information', 'information_id=' . $information['information_id']) . '</loc>';
				$output .= '<lastmod>';
				$output .= $information['date_modified'] != '0000-00-00 00:00:00' ? substr($information['date_modified'], 0, 10) : substr($information['date_added'], 0, 10);
				$output .= '</lastmod>';
				$output .= '<changefreq>daily</changefreq>';
				$output .= '<priority>0.7</priority>';
				$output .= '</url>';
			}
			
			$output .= '<url>';
			$output .= '<loc>' . $this->url->link('information/contact') . '</loc>';
			$output .= '<changefreq>monthly</changefreq>';
			$output .= '<priority>0.7</priority>';
			$output .= '</url>';
			
			$output .= '</urlset>';

			$this->response->addHeader('Content-Type: application/xml');
			$this->response->setOutput($output);
		}
	}

	protected function getCategories($parent_id, $current_path = '') {
	
		$this->load->model('catalog/category');
		
		$output = '';

		$results = $this->model_catalog_category->getCategories($parent_id);

		foreach ($results as $result) {
			if (!$current_path) {
				$new_path = $result['category_id'];
			} else {
				$new_path = $current_path . '_' . $result['category_id'];
			}

			$output .= '<url>';
			$output .= '<loc>' . $this->url->link('product/category', 'path=' . $new_path) . '</loc>';
			$output .= '<lastmod>';
			$output .= $result['date_modified'] != '0000-00-00 00:00:00' ? substr($result['date_modified'], 0, 10) : substr($result['date_added'], 0, 10);
			$output .= '</lastmod>';
			$output .= '<changefreq>daily</changefreq>';
			$output .= '<priority>0.8</priority>';
			$output .= '</url>';

			$output .= $this->getCategories($result['category_id'], $new_path);
		}

		return $output;
	}
	
	protected function getBlogCategories($parent_id, $current_path = '') {
		$output = '';

		$results = $this->model_blog_news->getCategories($parent_id);

		foreach ($results as $result) {
			if (!$current_path) {
				$new_path = $result['news_id'];
			} else {
				$new_path = $current_path . '_' . $result['news_id'];
			}

			$output .= '<url>';
			$output .= '<loc>' . str_replace('&', '&amp;', str_replace('&amp;', '&', $this->url->link('blog/news', 'blid=' . $new_path))) . '</loc>';
			$output .= '<lastmod>' . substr(max($result['date_added'], $result['date_modified']), 0, 10) . '</lastmod>';
			$output .= '<changefreq>weekly</changefreq>';
			$output .= '<priority>0.7</priority>';
			$output .= '</url>';

			$output .= $this->getBlogCategories($result['news_id'], $new_path);
		}

		return $output;
	}
}
?>