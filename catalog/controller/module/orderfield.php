<?php
#####################################################################################
#     OrderField module 1.05 for Opencart 1.5.0.x - 1.5.6.x  by AlexDW 				#
#####################################################################################
?><?php

class ControllerModuleOrderfield extends Controller {
	protected function index() {

		// $this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['mnf_name'] = $this->config->get('orderfield_mnf_name');
		$this->data['sku_name'] = $this->config->get('orderfield_sku_name');
		$this->data['upc_name'] = $this->config->get('orderfield_upc_name');
		$this->data['ean_name'] = $this->config->get('orderfield_ean_name');
		$this->data['jan_name'] = $this->config->get('orderfield_jan_name');
		$this->data['isbn_name'] = $this->config->get('orderfield_isbn_name');
		$this->data['mpn_name'] = $this->config->get('orderfield_mpn_name');
		$this->data['loc_name'] = $this->config->get('orderfield_loc_name');
		$this->data['image_inf'] = $this->config->get('orderfield_image_inf');
		$this->data['image_inv'] = $this->config->get('orderfield_image_inv');
		$this->data['image_mail'] = $this->config->get('orderfield_image_mail');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/orderfield.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/orderfield.tpl';
		} else {
			$this->template = 'default/template/module/orderfield.tpl';
		}

		$this->render();
	}
}
?>