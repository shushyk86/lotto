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
    public function index() {

        $json = array();
        $this->language->load('module/ordercallback');

        if ($this->config->get('ordercallback_use_module')) {
            $data = $this->request->post;

            if (isset($data['ordercallback-phone']) && !empty($data['ordercallback-phone'])) {

                $phone = $data['ordercallback-phone'];

                if ($this->config->get('send_notification_to_email')) {

                    if ($this->config->get('module_works_as') == 'call') {
                        $subject = $this->language->get('ordercallback_email_subject_call');
                    } else {
                        $subject = $this->language->get('ordercallback_email_subject_order');
                    }

                    $message = '';

                    if ($this->config->get('email_text')) {
                        $message .= $this->config->get('email_text') . "\n\n";
                    }

                    $name = $email = $comment = $product = '';

                    if (isset($data['ordercallback-name']) && !empty($data['ordercallback-name'])) {
                        $name = $data['ordercallback-name'];
                    }
                    if (isset($data['ordercallback-email']) && !empty($data['ordercallback-email'])) {
                        $email = $data['ordercallback-email'];
                    }
                    if (isset($data['ordercallback-comment']) && !empty($data['ordercallback-comment'])) {
                        $comment = $data['ordercallback-comment'];
                    }

                    $message = str_replace('{phone}', $phone,
                        str_replace('{name}', $name,
                            str_replace('{email}', $email,
                                str_replace('{comment}', $comment, $message))));

                    if (isset($data['ordercallback-product']) && !empty($data['ordercallback-product'])) {
                        $message .= "\n" . $this->language->get('modal_field_product') . ': ' . $data['ordercallback-product'];
                    }

                    try {
                        $mail = new Mail();
                        $mail->protocol = $this->config->get('config_mail_protocol');
                        $mail->parameter = $this->config->get('config_mail_parameter');
                        $mail->hostname = $this->config->get('config_smtp_host');
                        $mail->username = $this->config->get('config_smtp_username');
                        $mail->password = $this->config->get('config_smtp_password');
                        $mail->port = $this->config->get('config_smtp_port');
                        $mail->timeout = $this->config->get('config_smtp_timeout');
                        $mail->setTo($this->config->get('config_email'));
                        $mail->setFrom($this->config->get('config_email'));
                        $mail->setSender($this->config->get('config_name'));
                        $mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
                        $mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
                        $mail->send();

                        if ($this->config->get('config_alert_emails')) {
                            $emails = explode(',', $this->config->get('config_alert_emails'));
                            foreach ($emails as $email) {
                                $mail->setTo(trim($email));
                                $mail->send();
                                $json['email'][] = $email;
                            }
                        }

                        if ($this->config->get('module_works_as') == 'call') {
                            $json['success'] = $this->language->get('message_success_call');
                        } else {
                            $json['success'] = $this->language->get('message_success_order');
                        }

                    } catch (Exception $e) {
                        $json['error'] = $e->getMessage();
                    }
                }
            } else {
                $json['error'] = $this->language->get('message_phone_required');
            }
        } else {
            $json['error'] = $this->language->get('message_module_disabled');
        }

        $this->response->setOutput(json_encode($json));
    }
}
