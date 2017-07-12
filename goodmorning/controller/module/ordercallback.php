<?php

/**
 * Opencart module: Order callback
 * For Opencart 1.5.x version
 *
 * @copyright Instup.com
 * @author LIAL (dev@instup.com)
 * @vesrion 1.0
 *
 */
class ControllerModuleOrdercallback extends Controller
{
    private $error = array();

    public function index() {

        $this->load->language('module/ordercallback');
        $this->load->model('setting/setting');

        $this->document->setTitle($this->language->get('heading_title_nolink'));

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('ordercallback', $this->request->post);
            $this->session->data['success'] = $this->language->get('text_success');
            $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->data['heading_title'] = $this->language->get('heading_title_nolink');

        $this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');
        $this->data['text_yes'] = $this->language->get('text_yes');
        $this->data['text_no'] = $this->language->get('text_no');

        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');

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
            'text'      => $this->language->get('heading_title_nolink'),
            'href'      => $this->url->link('module/ordercallback', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['action'] = $this->url->link('module/ordercallback', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['token'] = $this->session->data['token'];

        if (isset($this->request->post['ordercallback_use_module'])) {
            $this->data['ordercallback_use_module'] = $this->request->post['ordercallback_use_module'];
        } else {
            $this->data['ordercallback_use_module'] = $this->config->get('ordercallback_use_module');
        }

        if (isset($this->request->post['module_works_as'])) {
            $this->data['module_works_as'] = $this->request->post['module_works_as'];
        } elseif ($this->config->get('module_works_as')) {
            $this->data['module_works_as'] = $this->config->get('module_works_as');
        } else {
            $this->data['module_works_as'] = 'call';
        }

        if (isset($this->request->post['button_caption'])) {
            $this->data['button_caption'] = $this->request->post['button_caption'];
        } elseif ($this->config->get('button_caption')) {
            $this->data['button_caption'] = $this->config->get('button_caption');
        } else {
            $this->data['button_caption'] = $this->language->get('tab_button_default_caption');
        }

        if (isset($this->request->post['send_notification_to_email'])) {
            $this->data['send_notification_to_email'] = $this->request->post['send_notification_to_email'];
        } else {
            $this->data['send_notification_to_email'] = $this->config->get('send_notification_to_email');
        }

        if (isset($this->request->post['send_notification_to_sms'])) {
            $this->data['send_notification_to_sms'] = $this->request->post['send_notification_to_sms'];
        } else {
            $this->data['send_notification_to_sms'] = $this->config->get('send_notification_to_sms');
        }

        if (isset($this->request->post['field_name_show'])) {
            $this->data['field_name_show'] = $this->request->post['field_name_show'];
        } else {
            $this->data['field_name_show'] = $this->config->get('field_name_show');
        }
        if (isset($this->request->post['field_name_required'])) {
            $this->data['field_name_required'] = $this->request->post['field_name_required'];
        } else {
            $this->data['field_name_required'] = $this->config->get('field_name_required');
        }

        if (isset($this->request->post['field_phone_show'])) {
            $this->data['field_phone_show'] = $this->request->post['field_phone_show'];
        } else {
            $this->data['field_phone_show'] = $this->config->get('field_phone_show');
        }
        if (isset($this->request->post['field_phone_required'])) {
            $this->data['field_phone_required'] = $this->request->post['field_phone_required'];
        } else {
            $this->data['field_phone_required'] = $this->config->get('field_phone_required');
        }

        if (isset($this->request->post['field_email_show'])) {
            $this->data['field_email_show'] = $this->request->post['field_email_show'];
        } else {
            $this->data['field_email_show'] = $this->config->get('field_email_show');
        }
        if (isset($this->request->post['field_email_required'])) {
            $this->data['field_email_required'] = $this->request->post['field_email_required'];
        } else {
            $this->data['field_email_required'] = $this->config->get('field_email_required');
        }

        if (isset($this->request->post['field_comment_show'])) {
            $this->data['field_comment_show'] = $this->request->post['field_comment_show'];
        } else {
            $this->data['field_comment_show'] = $this->config->get('field_comment_show');
        }
        if (isset($this->request->post['field_comment_required'])) {
            $this->data['field_comment_required'] = $this->request->post['field_comment_required'];
        } else {
            $this->data['field_comment_required'] = $this->config->get('field_comment_required');
        }

        if (isset($this->request->post['field_phone_mask'])) {
            $this->data['field_phone_mask'] = $this->request->post['field_phone_mask'];
        } elseif ($this->config->get('field_phone_mask')) {
            $this->data['field_phone_mask'] = $this->config->get('field_phone_mask');
        } else {
            $this->data['field_phone_mask'] = '';
        }

        if (isset($this->request->post['email_text'])) {
            $this->data['email_text'] = $this->request->post['email_text'];
        } elseif ($this->config->get('email_text')) {
            $this->data['email_text'] = $this->config->get('email_text');
        } else {
            $this->data['email_text'] = '';
        }

        $this->data['tab_text_common'] = $this->language->get('tab_text_common');
        $this->data['tab_text_fields'] = $this->language->get('tab_text_fields');
        $this->data['tab_button_default_caption'] = $this->language->get('tab_button_default_caption');

        $this->data['entry_use_module'] = $this->language->get('entry_use_module');
        $this->data['entry_module_works_as'] = $this->language->get('entry_module_works_as');
        $this->data['entry_button_caption'] = $this->language->get('entry_button_caption');
        $this->data['entry_send_notification_to_email'] = $this->language->get('entry_send_notification_to_email');
        $this->data['entry_send_notification_to_sms'] = $this->language->get('entry_send_notification_to_sms');
        $this->data['entry_field_name_show'] = $this->language->get('entry_field_name_show');
        $this->data['entry_field_name_required'] = $this->language->get('entry_field_name_required');
        $this->data['entry_field_phone_show'] = $this->language->get('entry_field_phone_show');
        $this->data['entry_field_phone_required'] = $this->language->get('entry_field_phone_required');
        $this->data['entry_field_email_show'] = $this->language->get('entry_field_email_show');
        $this->data['entry_field_email_required'] = $this->language->get('entry_field_email_required');
        $this->data['entry_field_comment_show'] = $this->language->get('entry_field_comment_show');
        $this->data['entry_field_comment_required'] = $this->language->get('entry_field_comment_required');
        $this->data['entry_field_phone_mask'] = $this->language->get('entry_field_phone_mask');
        $this->data['entry_field_phone_mask_help'] = $this->language->get('entry_field_phone_mask_help');
        $this->data['entry_email_text'] = $this->language->get('entry_email_text');
        $this->data['entry_email_text_help'] = $this->language->get('entry_email_text_help');

        $this->data['text_module_works_as_call'] = $this->language->get('text_module_works_as_call');
        $this->data['text_module_works_as_order'] = $this->language->get('text_module_works_as_order');
        $this->data['entry_field_comment_required'] = $this->language->get('entry_field_comment_required');
        $this->data['entry_field_comment_required'] = $this->language->get('entry_field_comment_required');
        $this->data['entry_field_comment_required'] = $this->language->get('entry_field_comment_required');
        $this->data['entry_field_comment_required'] = $this->language->get('entry_field_comment_required');
        $this->data['entry_field_comment_required'] = $this->language->get('entry_field_comment_required');
        $this->data['entry_field_comment_required'] = $this->language->get('entry_field_comment_required');
        $this->data['entry_field_comment_required'] = $this->language->get('entry_field_comment_required');
        $this->data['entry_field_comment_required'] = $this->language->get('entry_field_comment_required');
        $this->data['entry_field_comment_required'] = $this->language->get('entry_field_comment_required');
        $this->data['entry_field_comment_required'] = $this->language->get('entry_field_comment_required');
        $this->data['entry_field_comment_required'] = $this->language->get('entry_field_comment_required');
        $this->data['entry_field_comment_required'] = $this->language->get('entry_field_comment_required');
        $this->data['entry_field_comment_required'] = $this->language->get('entry_field_comment_required');
        $this->data['entry_field_comment_required'] = $this->language->get('entry_field_comment_required');

        $this->template = 'module/ordercallback.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
    }

    public function install() {
        $this->load->model('setting/setting');
        $this->load->language('module/ordercallback');

        $settings = array(
            //Common
            'ordercallback_use_module'   => 1, //(0/1)
            'module_works_as'            => 'call', //(call|order)
            'button_caption'             => $this->language->get('tab_button_default_caption'),
            'send_notification_to_email' => 1, //(0/1)
            'send_notification_to_sms'   => 0, //(0/1)
            'email_text'                 => 'Visitor {name} of your shop, asks to call by phone {phone} or write message to email {email}.' . "\n" . 'Comment: {comment}',

            //Fields
            'field_name_show'            => 1, //(0/1)
            'field_name_required'        => 0, //(0/1)
            'field_phone_show'           => 1, //(0/1)
            'field_phone_required'       => 1, //(0/1)
            'field_email_show'           => 0, //(0/1)
            'field_email_required'       => 0, //(0/1)
            'field_comment_show'         => 1, //(0/1)
            'field_comment_required'     => 0, //(0/1)
            'field_phone_mask'           => '+7-(999)-999-9999',
        );

        $this->model_setting_setting->editSetting('ordercallback', $settings);
    }

    public function uninstall() {
        $this->load->model('setting/setting');
        $this->model_setting_setting->deleteSetting('ordercallback');
    }

    private function validate() {
        if (!$this->user->hasPermission('modify', 'module/ordercallback')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }
}
