<?php

class ControllerPaymentPlaton extends Controller {

    protected function index() {
        $this->data['button_confirm'] = $this->language->get('button_confirm');

        $this->load->model('checkout/order');

        $order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);

        $this->data['action'] = $this->config->get('platon_gateway_url');

        $this->data['key'] = $this->config->get('platon_key');
        $this->data['order'] = $this->session->data['order_id'];

        $amount = $this->currency->format($order_info['total'], $order_info['currency_code'], $order_info['currency_value'], false);

        /* Prepare product data for coding */
        $this->data['data'] = base64_encode(
                json_encode(
                        array(
                            'amount' => sprintf("%01.2f", $amount),
                            'name' => 'Order from ' . $this->config->get('config_name'),
                            'currency' => $order_info['currency_code']
                        )
                )
        );

        $this->data['url'] = $this->url->link('checkout/success');

        /* Calculation of signature */
        $sign = md5(
                strtoupper(
                        strrev($this->data['key']) .
                        strrev($this->data['data']) .
                        strrev($this->data['url']) .
                        strrev($this->config->get('platon_password'))
                )
        );

        $this->data['sign'] = $sign;

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/platon.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/payment/platon.tpl';
        } else {
            $this->template = 'default/template/payment/platon.tpl';
        }

        $this->render();
    }

    public function callback() {
        // generate signature from callback params
        $sign = md5(
                strtoupper(
                        strrev($this->request->post['email']) .
                        $this->config->get('platon_password') .
                        $this->request->post['order'] .
                        strrev(substr($this->request->post['card'], 0, 6) . substr($this->request->post['card'], -4))
                )
        );

        // verify signature
        if ($this->request->post['sign'] !== $sign) {
            die("ERROR: Bad signature");
        }

        $this->load->model('checkout/order');

        $order_info = $this->model_checkout_order->getOrder($this->request->post['order']);
        if (!$order_info) {
            die('ERROR: Bad order ID');
        }

        switch ($this->request->post['status']) {
            case 'SALE':
                $this->model_checkout_order->confirm($this->request->post['order'], $this->config->get('platon_order_status_id'));
                break;
            case 'REFUND':
                $this->model_checkout_order->update($this->request->post['order'], $this->config->get('platon_refunded_order_status_id'), 'Refunded by customer', TRUE);
                break;
            case 'CHARGEBACK':
                break;
            default:
                die("ERROR: Invalid callback data");
        }

        exit("OK");
    }

}

?>