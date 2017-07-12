<?php 
class ControllerPaymentPlaton extends Controller {
	private $error = array();
        private $gw_url = 'https://secure.platononline.com/payment/auth';

	public function index() {
		$this->language->load('payment/platon');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('platon', $this->request->post);				
			
			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		
		$this->data['entry_key'] = $this->language->get('entry_key');
		$this->data['entry_password'] = $this->language->get('entry_password');
		$this->data['entry_gateway_url'] = $this->language->get('entry_gateway_url');
		$this->data['entry_order_status'] = $this->language->get('entry_order_status');		
		$this->data['entry_refunded_order_status'] = $this->language->get('entry_refunded_order_status');		
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		 
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->error['key'])) {
			$this->data['error_key'] = $this->error['key'];
		} else {
			$this->data['error_key'] = '';
		}	
		
		if (isset($this->error['password'])) {
			$this->data['error_password'] = $this->error['password'];
		} else {
			$this->data['error_password'] = '';
		}	
		
		if (isset($this->error['gw_url'])) {
			$this->data['error_gw_url'] = $this->error['gw_url'];
		} else {
			$this->data['error_gw_url'] = '';
		}	
		
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),       		
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_payment'),
			'href'      => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('payment/platon', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
				
		$this->data['action'] = $this->url->link('payment/platon', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');
		
		if (isset($this->request->post['platon_key'])) {
			$this->data['platon_key'] = $this->request->post['platon_key'];
		} else {
			$this->data['platon_key'] = $this->config->get('platon_key');
		}

		if (isset($this->request->post['platon_password'])) {
			$this->data['platon_password'] = $this->request->post['platon_password'];
		} else {
			$this->data['platon_password'] = $this->config->get('platon_password');
		}
		
		if (isset($this->request->post['platon_gateway_url'])) {
			$this->data['platon_gateway_url'] = $this->request->post['platon_gateway_url'];
		} else {
                    $cfg_gw_url = $this->config->get('platon_gateway_url');
			$this->data['platon_gateway_url'] = empty($cfg_gw_url) ? 
                                $this->gw_url : 
                            $cfg_gw_url; 
		}
                
		if (isset($this->request->post['platon_order_status_id'])) {
			$this->data['platon_order_status_id'] = $this->request->post['platon_order_status_id'];
		} else {
			$this->data['platon_order_status_id'] = $this->config->get('platon_order_status_id'); 
		}
                
		if (isset($this->request->post['platon_refunded_order_status_id'])) {
			$this->data['platon_refunded_order_status_id'] = $this->request->post['platon_refunded_order_status_id'];
		} else {
			$this->data['platon_refunded_order_status_id'] = $this->config->get('platon_refunded_order_status_id'); 
		}
		
		$this->load->model('localisation/order_status');
		
		$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
		
		if (isset($this->request->post['platon_status'])) {
			$this->data['platon_status'] = $this->request->post['platon_status'];
		} else {
			$this->data['platon_status'] = $this->config->get('platon_status');
		}
		
		if (isset($this->request->post['platon_sort_order'])) {
			$this->data['platon_sort_order'] = $this->request->post['platon_sort_order'];
		} else {
			$this->data['platon_sort_order'] = $this->config->get('platon_sort_order');
		}

		$this->template = 'payment/platon.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'payment/platon')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->request->post['platon_key']) {
			$this->error['account'] = $this->language->get('error_key');
		}

		if (!$this->request->post['platon_password']) {
			$this->error['secret'] = $this->language->get('error_password');
		}

		if (!$this->request->post['platon_gateway_url']) {
			$this->error['gw_url'] = $this->language->get('error_gw_url');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>