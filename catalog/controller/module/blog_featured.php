<?php
class ControllerModuleBlogFeatured extends Controller {
	protected function index($setting) {
		$this->language->load('module/blog_featured'); 

      	$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['text_views'] = $this->language->get('text_views');
		
		$this->load->model('blog/article'); 
		
		$this->load->model('tool/image');

		$this->data['articles'] = array();

        if (isset($this->request->get['path'])) {
            $parts = explode('_', (string)$this->request->get['path']);
            $category_id = (int)array_pop($parts);
        } else {
            $category_id = 0;
        }

		if (empty($setting['limit'])) {
			$setting['limit'] = 5;
		}

    	$articles = $this->model_blog_article->getArticleRelated_by_category($category_id, $setting['limit']);

        $this->data['artic'] = $articles;
        $this->data['categ'] = $category_id;

        if(!empty($articles)) {
            foreach ($articles as $article_info) {
                if ($article_info['image']) {
                    $image = $this->model_tool_image->resize($article_info['image'], $setting['image_width'], $setting['image_height']);
                } else {
                    $image = false;
                }

                if (mb_strlen($article_info['name']) > 60) {
                    $str_end = '...';
                } else {
                    $str_end = '';
                }

                $this->data['articles'][] = array(
                    'article_id' => $article_info['article_id'],
                    'thumb' => $image,
                    'name' => utf8_substr($article_info['name'], 0, 60) . $str_end,
                    //	'description' => utf8_substr(strip_tags(html_entity_decode($article_info['description'], ENT_QUOTES, 'UTF-8')), 0, $text_limit) . '',
                    //	'date_added'  => date($this->language->get('date_format_short'), strtotime($article_info['date_added'])),
                    //  'viewed'      => $article_info['viewed'],
                    //	'reviews'    => sprintf($this->language->get('text_reviews'), (int)$article_info['reviews']),
                    'href' => $this->url->link('blog/article', 'article_id=' . $article_info['article_id']),
                );
            }
        }

		if ((file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/blog_featured.tpl'))and (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/blog_featured_middle.tpl')))     {
			$this->template = $this->config->get('config_template') . '/template/module/blog_featured.tpl';
			
			if (($setting['position']=='content_top') or ($setting['position']=='content_bottom'))  {$this->template = $this->config->get('config_template') . '/template/module/blog_featured_middle.tpl';};

		} else {
			$this->template = 'default/template/module/blog_featured.tpl';
		}

		$this->render();
	}
}
?>