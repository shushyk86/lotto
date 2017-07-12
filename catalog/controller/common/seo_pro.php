<?php
class ControllerCommonSeoPro extends Controller {
	private $cache_data = null;

	public function __construct($registry) {
		parent::__construct($registry);
		$this->cache_data = $this->cache->get('seo_pro');
		if (!$this->cache_data) {
			$query = $this->db->query("SELECT LOWER(`keyword`) as 'keyword', `query` FROM " . DB_PREFIX . "url_alias");
			$this->cache_data = array();
			foreach ($query->rows as $row) {
				$this->cache_data['keywords'][$row['keyword']] = $row['query'];
				$this->cache_data['queries'][$row['query']] = $row['keyword'];
			}
			$this->cache->set('seo_pro', $this->cache_data);
		}
	}

	public function index() {

		// Add rewrite to url class
		if ($this->config->get('config_seo_url')) {
			$this->url->addRewrite($this);
		} else {
			return;
		}

		// Decode URL
		if (!isset($this->request->get['_route_'])) {
			$this->validate();
		} else {
			$route_ = $route = $this->request->get['_route_'];
			unset($this->request->get['_route_']);
			$parts = explode('/', trim(utf8_strtolower($route), '/'));
			list($last_part) = explode('.', array_pop($parts));
			array_push($parts, $last_part);

			$rows = array();
			foreach ($parts as $keyword) {
				if (isset($this->cache_data['keywords'][$keyword])) {
					$rows[] = array('keyword' => $keyword, 'query' => $this->cache_data['keywords'][$keyword]);
				}
			}

			if (count($rows) == sizeof($parts)) {
				$queries = array();
				foreach ($rows as $row) {
					$queries[utf8_strtolower($row['keyword'])] = $row['query'];
				}

				reset($parts);
			
				foreach ($parts as $part) {
					$url = explode('=', $queries[$part], 2);
					if ($url[0] == 'category_id') {
						if (!isset($this->request->get['path'])) {
							$this->request->get['path'] = $url[1];
						} else {
							$this->request->get['path'] .= '_' . $url[1];
						}
					} elseif ($url[0] == 'blid') {
						if (!isset($this->request->get['blid'])) {
							$this->request->get['blid'] = $url[1];
						} else {
							$this->request->get['blid'] .= '_' . $url[1];
						}
					} elseif (count($url) > 1) {
						$this->request->get[$url[0]] = $url[1];
					}
				}
			} else {
				$this->request->get['route'] = 'error/not_found';
			}
			
			if (isset($this->request->get['product_id'])) {
				$this->request->get['route'] = 'product/product';
				if (!isset($this->request->get['path'])) {
					$path = $this->getPathByProduct($this->request->get['product_id']);
					if ($path) $this->request->get['path'] = $path;
				}
			
			//ocshop product download url fix	
				if (isset($this->request->get['download_id'])) {
					$this->request->get['route'] = 'product/product/download';
					}
			//ocshop product download url fix
							
			} elseif (isset($this->request->get['path'])) {
				$this->request->get['route'] = 'product/category';
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$this->request->get['route'] = 'product/manufacturer/info';
			} elseif (isset($this->request->get['information_id'])) {
				$this->request->get['route'] = 'information/information';
			//ocshop  blog	
			} elseif (isset($this->request->get['download_id'])) {
				$this->request->get['route'] = 'blog/article/download';
			}	
			//ocshop blog
			elseif (isset($this->request->get['article_id'])) {
				$this->request->get['route'] = 'blog/article';
				if (!isset($this->request->get['blid'])) {
					$blid = $this->getPathByArticle($this->request->get['article_id']);
					if ($blid) $this->request->get['blid'] = $blid;
				}
		
			//ocshop  blog
    		} elseif (isset($this->request->get['blid'])) {
					$this->request->get['route'] = 'blog/news';			
			} elseif(isset($this->cache_data['queries'][$route_])) {
					header($this->request->server['SERVER_PROTOCOL'] . ' 301 Moved Permanently');
					$this->response->redirect($this->cache_data['queries'][$route_]);
			} else {
				
				/** BEGIN PROCESSING TO DECORD REQUET SEO URL FOR PAVO BLOG MODULE **/
 if( isset($url) && count($url) == 2 && ( preg_match( "#pavblog#", $url[0] )) ){
 unset($this->request->get['pavblog/category']);
 unset($this->request->get['pavblog/blog']);
 unset($queries);
 $this->request->get['route'] = $url[0];
 $this->request->get['id'] = $url[1];
 } /** END OF PROCESSING TO DECORD REQUET SEO URL FOR PAVO BLOG MODULE **/
				
				if (isset($queries[$parts[0]])) {
					$this->request->get['route'] = $queries[$parts[0]];
				}
			}
	
	
			$this->validate();

			if (isset($this->request->get['route'])) {
				return $this->forward($this->request->get['route']);
			}
		}
	}

	public function rewrite($link) {
		if (!$this->config->get('config_seo_url')) return $link;

		$seo_url = '';

		$component = parse_url(str_replace('&amp;', '&', $link));

		$data = array();
		parse_str($component['query'], $data);

		$route = $data['route'];
		unset($data['route']);

		switch ($route) {
			case 'product/product':
				if (isset($data['product_id'])) {
					$tmp = $data;
					$data = array();
					if ($this->config->get('config_seo_url_include_path')) {
						$data['path'] = $this->getPathByProduct($tmp['product_id']);
						if (!$data['path']) return $link;
					}
					$data['product_id'] = $tmp['product_id'];
					if (isset($tmp['tracking'])) {
						$data['tracking'] = $tmp['tracking'];
					}
					if (isset($tmp['utm_medium'])) {
						$data['utm_medium'] = $tmp['utm_medium'];
					}
					if (isset($tmp['utm_source'])) {
						$data['utm_source'] = $tmp['utm_source'];
					}
					if (isset($tmp['utm_campaign'])) {
						$data['utm_campaign'] = $tmp['utm_campaign'];
					}
					if (isset($tmp['utm_content'])) {
						$data['utm_content'] = $tmp['utm_content'];
					}
				}
				break;

			case 'product/category':
				if (isset($data['path'])) {
					$category = explode('_', $data['path']);
					$category = end($category);
					$data['path'] = $this->getPathByCategory($category);
					if (!$data['path']) return $link;
				}
				break;
			//ocshop	
			case 'blog/article':
				if (isset($data['article_id'])) {
				
					$tmp = $data;
					$data = array();
					if ($this->config->get('config_seo_url_include_path')) {
						$data['blid'] = $this->getPathByArticle($tmp['article_id']);
						if (!$data['blid']) return $link;
					}
					$data['article_id'] = $tmp['article_id'];
					}
		
			break;	
			
			case 'blog/news':
				if (isset($data['blid'])) {
				$news = explode('_', $data['blid']);
				$news = end($news);
				$data['blid'] = $this->getPathByNews($news);
				if (!$data['blid']) return $link;

			}
			break;		
			
			//ocshop
			// Nikita_SP MOD FOR PAV BLOGS
case 'pavblog/category':
break;
case 'pavblog/blog':
$isblog = 1;
break;
// END NIKITA_SP MOD
			case 'product/product/review':
			case 'product/search':
			case 'blog/article/review':
			case 'information/information/info':
				return $link;
				break;

			default:
				break;
		}

		if ($component['scheme'] == 'https') {
			$link = $this->config->get('config_ssl');
		} else {
			$link = $this->config->get('config_url');
		}

		$link .= 'index.php?route=' . $route;

		if (count($data)) {
			$link .= '&amp;' . urldecode(http_build_query($data, '', '&amp;'));
		}

		$queries = array();
		foreach ($data as $key => $value) {
			switch ($key) {
				case 'product_id':
				case 'manufacturer_id':
				case 'category_id':
				case 'information_id':
					$queries[] = $key . '=' . $value;
					unset($data[$key]);
					$postfix = 1;
					break;

				case 'path':
					$categories = explode('_', $value);
					foreach ($categories as $category) {
						$queries[] = 'category_id=' . $category;
					}
					unset($data[$key]);
					break;

					// Nikita_SP MOD FOR PAV BLOGS
case 'id':
if(isset($isblog)){
if ($this->config->get('config_seo_url_include_path')) {
$blogpath = $this->getPathByBlog($value);
if($blogpath){
$categories = explode('_', $blogpath);
foreach ($categories as $category) {
$queries[] = 'pavblog/category=' . $category;
}
}
}
$queries[] = 'pavblog/blog=' . $value;
$postfix = 1;
}else{
$category = $value;
$blogpath = $this->getPathByBlogCat($category);
if($blogpath){
$categories = explode('_', $blogpath);
foreach ($categories as $category) {
$queries[] = 'pavblog/category=' . $category;
}
}
}
unset($data[$key]);
break;
// END NIKITA_SP MOD
					
				default:
					break;
	//ocshop blog				
				case'article_id':
		
				$queries[] = $key .'='. $value;
				unset($data[ $key ]);
				$postfix = 1;
				break;		
				
				case 'news_id':
				$categories = explode('_', $value);
				foreach ($categories as $category) {
					$queries[] = 'news_id=' . $category;
				}
				unset($data[$key]);
				break;
				
     			case 'blid':
				$news = explode('_', $value);
				
				foreach ($news as $new) {
					$queries[] = 'blid=' . $new;
				}
				unset($data[$key]);
				break;
	//ocshop blog			
				
			}
		}

		if(empty($queries)) {
			$queries[] = $route;
		}

		$rows = array();
		foreach($queries as $query) {
			if(isset($this->cache_data['queries'][$query])) {
				$rows[] = array('query' => $query, 'keyword' => $this->cache_data['queries'][$query]);
			}
		}

		if(count($rows) == count($queries)) {
			$aliases = array();
			foreach($rows as $row) {
				$aliases[$row['query']] = $row['keyword'];
			}
			foreach($queries as $query) {
				$seo_url .= '/' . rawurlencode($aliases[$query]);
			}
		}

		if ($seo_url == '') return $link;

		$seo_url = trim($seo_url, '/');

		if ($component['scheme'] == 'https') {
			$seo_url = $this->config->get('config_ssl') . $seo_url;
		} else {
			$seo_url = $this->config->get('config_url') . $seo_url;
		}

//		if (isset($postfix)) {
			$seo_url .= trim($this->config->get('config_seo_url_postfix'));
//		} else {
//			$seo_url .= '/';
//		}

		if(substr($seo_url, -2) == '//') {
			$seo_url = substr($seo_url, 0, -1);
		}

		if (count($data)) {
			$seo_url .= '?' . urldecode(http_build_query($data, '', '&amp;'));
		}

		return $seo_url;
	}
	
	// Nikita_SP MOD FOR PAV BLOG
private function getPathByBlog($blog_id) {
$blog_id = (int)$blog_id;
if ($blog_id < 1) return false;
 
static $path = null;
if (!is_array($path)) {
$path = $this->cache->get('blog.seopath');
if (!is_array($path)) $path = array();
}
 
if (!isset($path[$blog_id])) {
$query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "pavblog_blog WHERE blog_id = '" . $blog_id . "' ORDER BY category_id DESC LIMIT 1");
 
$path[$blog_id] = $this->getPathByBlogCat($query->num_rows ? (int)$query->row['category_id'] : 0);
 
$this->cache->set('blog.seopath', $path);
}
 
return $path[$blog_id];
}
 
private function getPathByBlogCat($category_id) {
$category_id = (int)$category_id;
if ($category_id < 1) return false;
 
static $path = null;
if (!is_array($path)) {
$path = $this->cache->get('blogcat.seopath');
if (!is_array($path)) $path = array();
}
 
if (!isset($path[$category_id])) {
$max_level = 2;
 
$sql = "SELECT CONCAT_WS('_'";
for ($i = $max_level-1; $i >= 0; --$i) {
$sql .= ",t$i.category_id";
}
$sql .= ") AS path FROM " . DB_PREFIX . "pavblog_category t0";
for ($i = 1; $i < $max_level; ++$i) {
$sql .= " LEFT JOIN " . DB_PREFIX . "pavblog_category t$i ON (t$i.category_id = t" . ($i-1) . ".parent_id)";
}
$sql .= " WHERE t0.category_id = '" . $category_id . "'";
 
$query = $this->db->query($sql);
 
$path[$category_id] = $query->num_rows ? $query->row['path'] : false;
 
$this->cache->set('blogcat.seopath', $path);
}
 
return $path[$category_id];
}
// END NIKITA_SP MOD

	private function getPathByProduct($product_id) {
		$product_id = (int)$product_id;
		if ($product_id < 1) return false;

		static $path = null;
		if (!is_array($path)) {
			$path = $this->cache->get('product.seopath');
			if (!is_array($path)) $path = array();
		}

		if (!isset($path[$product_id])) {
			$query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . $product_id . "' ORDER BY main_category DESC LIMIT 1");

			$path[$product_id] = $this->getPathByCategory($query->num_rows ? (int)$query->row['category_id'] : 0);

			$this->cache->set('product.seopath', $path);
		}

		return $path[$product_id];
	}

	private function getPathByCategory($category_id) {
		$category_id = (int)$category_id;
		if ($category_id < 1) return false;

		static $path = null;
		if (!is_array($path)) {
			$path = $this->cache->get('category.seopath');
			if (!is_array($path)) $path = array();
		}

		if (!isset($path[$category_id])) {
			$max_level = 10;

			$sql = "SELECT CONCAT_WS('_'";
			for ($i = $max_level-1; $i >= 0; --$i) {
				$sql .= ",t$i.category_id";
			}
			$sql .= ") AS path FROM " . DB_PREFIX . "category t0";
			for ($i = 1; $i < $max_level; ++$i) {
				$sql .= " LEFT JOIN " . DB_PREFIX . "category t$i ON (t$i.category_id = t" . ($i-1) . ".parent_id)";
			}
			$sql .= " WHERE t0.category_id = '" . $category_id . "'";

			$query = $this->db->query($sql);

			$path[$category_id] = $query->num_rows ? $query->row['path'] : false;

			$this->cache->set('category.seopath', $path);
		}

		return $path[$category_id];
	}
	
	private function getPathByNews($news_id) {
		$news_id = (int)$news_id;
		if ($news_id < 1) return false;

		static $path = null;
		if (!is_array($path)) {
			$path = $this->cache->get('category.newspath');
			if (!is_array($path)) $path = array();
		}

		if (!isset($path[$news_id])) {
			$max_level = 10;

			$sql = "SELECT CONCAT_WS('_'";
			for ($i = $max_level-1; $i >= 0; --$i) {
				$sql .= ",t$i.news_id";
			}
			$sql .= ") AS blid FROM " . DB_PREFIX . "news t0";
			for ($i = 1; $i < $max_level; ++$i) {
				$sql .= " LEFT JOIN " . DB_PREFIX . "news t$i ON (t$i.news_id = t" . ($i-1) . ".parent_id)";
			}
			$sql .= " WHERE t0.news_id = '" . $news_id . "'";

			$query = $this->db->query($sql);

			$path[$news_id] = $query->num_rows ? $query->row['blid'] : false;

			$this->cache->set('category.newspath', $path);
		}

		return $path[$news_id];
	}
	
	private function getPathByArticle($article_id) {
		$article_id = (int)$article_id;
		if ($article_id < 1) return false;


		static $blid = null;
		if (!is_array($blid)) {
			$blid = $this->cache->get('article.seopath');
			if (!is_array($blid)) $path = array();
		}


		if (!isset($blid[$article_id])) {
			$query = $this->db->query("SELECT news_id FROM " . DB_PREFIX . "article_to_news WHERE article_id = '" . $article_id . "' ORDER BY main_news DESC LIMIT 1");

			$blid[$article_id] = $this->getPathByNews($query->num_rows ? (int)$query->row['news_id'] : 0);

		$this->cache->set('article.seopath', $blid);
		}

		return $blid[$article_id];
	}
	

	private function validate() {
		if (isset($this->request->get['route']) && $this->request->get['route'] == 'error/not_found') {
			return;
		}
		if(empty($this->request->get['route'])) {
			$this->request->get['route'] = 'common/home';
		}

		if (isset($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
			return;
		}

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$config_ssl = substr($this->config->get('config_ssl'), 0, $this->strpos_offset('/', $this->config->get('config_ssl'), 3) + 1);
			$url = str_replace('&amp;', '&', $config_ssl . ltrim($this->request->server['REQUEST_URI'], '/'));
			$seo = str_replace('&amp;', '&', $this->url->link($this->request->get['route'], $this->getQueryString(array('route')), 'SSL'));
		} else {
			$config_url = substr($this->config->get('config_url'), 0, $this->strpos_offset('/', $this->config->get('config_url'), 3) + 1);
			$url = str_replace('&amp;', '&', $config_url . ltrim($this->request->server['REQUEST_URI'], '/'));
			$seo = str_replace('&amp;', '&', $this->url->link($this->request->get['route'], $this->getQueryString(array('route')), 'NONSSL'));
		}

		if (rawurldecode($url) != rawurldecode($seo)) {
			header($this->request->server['SERVER_PROTOCOL'] . ' 301 Moved Permanently');

			$this->response->redirect($seo);
		}
	}

	private function strpos_offset($needle, $haystack, $occurrence) {
		// explode the haystack
		$arr = explode($needle, $haystack);
		// check the needle is not out of bounds
		switch($occurrence) {
			case $occurrence == 0:
				return false;
			case $occurrence > max(array_keys($arr)):
				return false;
			default:
				return strlen(implode($needle, array_slice($arr, 0, $occurrence)));
		}
	}

	private function getQueryString($exclude = array()) {
		if (!is_array($exclude)) {
			$exclude = array();
			}

		return urldecode(http_build_query(array_diff_key($this->request->get, array_flip($exclude))));
		}
	}
?>