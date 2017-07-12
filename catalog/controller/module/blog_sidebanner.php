<?php  
class ControllerModuleBlogsidebanner extends Controller {
	protected function index($setting) {
		$this->language->load('module/blog_sidebanner');
		
    	$this->data['heading_title'] = $this->language->get('heading_title');
		
		if (isset($this->request->get['article_id'])) {
			$article_id = $this->request->get['article_id'];
		} else {
            $article_id = 0;
		}

		$this->load->model('blog/article');
        $this->load->model('tool/image');

		$this->data['banners'] = array();

		$banners = $this->model_blog_article->getArticleImages($article_id);

		foreach ($banners as $banner) {
            $image = $this->model_tool_image->resize($banner['image'], 200, 200);

			$this->data['banners'][] = array(
                'image'      => $image,
                'href'       => $banner['link']
			);	
		}
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/blog_sidebanner.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/blog_sidebanner.tpl';
		} else {
			$this->template = 'default/template/module/blog_sidebanner.tpl';
		}
		
		$this->render();
  	}

}
?>