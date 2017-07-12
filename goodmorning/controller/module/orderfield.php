<?php
#####################################################################################
#     OrderField module 1.05 for Opencart 1.5.0.x - 1.5.6.x  by AlexDW 				#
#####################################################################################

class ControllerModuleOrderfield extends Controller {
	
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/orderfield');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('orderfield', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$text_strings = array(
				'heading_title',
				'text_enabled',
				'text_disabled',
				'text_fieldname',
				'entry_status',
				'entry_mnf',
				'entry_sku',
				'entry_upc',
				'entry_ean',
				'entry_jan',
				'entry_isbn',
				'entry_mpn',
				'entry_loc',
				'entry_image',
				'entry_image_inf',
				'entry_image_inv',
				'entry_image_mail',
				'entry_mnf_name',
				'entry_sku_name',
				'entry_upc_name',
				'entry_ean_name',
				'entry_jan_name',
				'entry_isbn_name',
				'entry_mpn_name',
				'entry_loc_name',
				'button_save',
				'button_cancel',
				'button_add_module',
				'button_remove',
				'entry_example' //this is an example extra field added
		);
		
		foreach ($text_strings as $text) {
			$this->data[$text] = $this->language->get($text);
		}

		$config_data = array(
				'orderfield_example' //this becomes available in our view by the foreach loop just below.
		);
		
		foreach ($config_data as $conf) {
			if (isset($this->request->post[$conf])) {
				$this->data[$conf] = $this->request->post[$conf];
			} else {
				$this->data[$conf] = $this->config->get($conf);
			}
		}

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/orderfield', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/orderfield', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['orderfield_mnf_name'])) {
			$this->data['orderfield_mnf_name'] = $this->request->post['orderfield_mnf_name'];
		} else {
			$this->data['orderfield_mnf_name'] = $this->config->get('orderfield_mnf_name');
		}		
		if (isset($this->request->post['orderfield_sku_name'])) {
			$this->data['orderfield_sku_name'] = $this->request->post['orderfield_sku_name'];
		} else {
			$this->data['orderfield_sku_name'] = $this->config->get('orderfield_sku_name');
		}
		if (isset($this->request->post['orderfield_upc_name'])) {
			$this->data['orderfield_upc_name'] = $this->request->post['orderfield_upc_name'];
		} else {
			$this->data['orderfield_upc_name'] = $this->config->get('orderfield_upc_name');
		}
		if (isset($this->request->post['orderfield_ean_name'])) {
			$this->data['orderfield_ean_name'] = $this->request->post['orderfield_ean_name'];
		} else {
			$this->data['orderfield_ean_name'] = $this->config->get('orderfield_ean_name');
		}
		if (isset($this->request->post['orderfield_jan_name'])) {
			$this->data['orderfield_jan_name'] = $this->request->post['orderfield_jan_name'];
		} else {
			$this->data['orderfield_jan_name'] = $this->config->get('orderfield_jan_name');
		}
		if (isset($this->request->post['orderfield_isbn_name'])) {
			$this->data['orderfield_isbn_name'] = $this->request->post['orderfield_isbn_name'];
		} else {
			$this->data['orderfield_isbn_name'] = $this->config->get('orderfield_isbn_name');
		}
		if (isset($this->request->post['orderfield_mpn_name'])) {
			$this->data['orderfield_mpn_name'] = $this->request->post['orderfield_mpn_name'];
		} else {
			$this->data['orderfield_mpn_name'] = $this->config->get('orderfield_mpn_name');
		}
		if (isset($this->request->post['orderfield_loc_name'])) {
			$this->data['orderfield_loc_name'] = $this->request->post['orderfield_loc_name'];
		} else {
			$this->data['orderfield_loc_name'] = $this->config->get('orderfield_loc_name');
		}
		if (isset($this->request->post['orderfield_image_inf'])) {
			$this->data['orderfield_image_inf'] = $this->request->post['orderfield_image_inf'];
		} else {
			$this->data['orderfield_image_inf'] = $this->config->get('orderfield_image_inf');
		}
		if (isset($this->request->post['orderfield_image_inv'])) {
			$this->data['orderfield_image_inv'] = $this->request->post['orderfield_image_inv'];
		} else {
			$this->data['orderfield_image_inv'] = $this->config->get('orderfield_image_inv');
		}
		if (isset($this->request->post['orderfield_image_mail'])) {
			$this->data['orderfield_image_mail'] = $this->request->post['orderfield_image_mail'];
		} else {
			$this->data['orderfield_image_mail'] = $this->config->get('orderfield_image_mail');
		}
		
		$this->data['modules'] = array();
		
		if (isset($this->request->post['orderfield_module'])) {
			$this->data['modules'] = $this->request->post['orderfield_module'];
		} elseif ($this->config->get('orderfield_module')) { 
			$this->data['modules'] = $this->config->get('orderfield_module');
		}		

		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->template = 'module/orderfield.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);

		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/orderfield')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}	
	}
}
?>