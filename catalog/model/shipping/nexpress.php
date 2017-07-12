<?php

class ModelShippingnexpress extends Model {

    function getQuote($address) {
        $this->load->language('shipping/nexpress');

        if ($this->config->get('nexpress_status')) {
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int) $this->config->get('nexpress_geo_zone_id') . "' AND country_id = '" . (int) $address['country_id'] . "' AND (zone_id = '" . (int) $address['zone_id'] . "' OR zone_id = '0')");

            if (!$this->config->get('nexpress_geo_zone_id')) {
                $status = TRUE;
            } elseif ($query->num_rows) {
                $status = TRUE;
            } else {
                $status = FALSE;
            }
        } else {
            $status = FALSE;
        }

        $method_data = array();

        if ($status) {
            $quote_data = array();

            $cost = 0.00;

            $total_data = array();
            $total = 0;
            $taxes = $this->cart->getTaxes();

            $modules = array();

            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $this->load->model('setting/extension');

                $sort_order = array();

                $results = $this->model_setting_extension->getExtensions('total');

                foreach ($results as $key => $value) {
                    $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
                }

                array_multisort($sort_order, SORT_ASC, $results);

                foreach ($results as $result) {
                    if($result['code'] == 'shipping'){
                        unset($result);
                        continue;
                    }
                    if ($this->config->get($result['code'] . '_status')) {
                        $this->load->model('total/' . $result['code']);

                        $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);

                        $modules[$result['code']] = true;
                    }
                }

                $sort_order = array();

                foreach ($total_data as $key => $value) {
                    $sort_order[$key] = $value['sort_order'];
                }

                array_multisort($sort_order, SORT_ASC, $total_data);
            }

            foreach($total_data as $total){
                if($total['code'] == 'total' && $this->config->get('nexpress_min_total_for_free_delivery') > round($total['value'])) {
                    $cost = $this->config->get('nexpress_delivery_price');
                }
            }


/*
            if ($this->config->get('nexpress_min_total_for_free_delivery') > $this->cart->getSubTotal()) {
                $cost = $this->config->get('nexpress_delivery_price');
            }
*/

            $quote_data['nexpress'] = array(
                'code' => 'nexpress.nexpress',
                'title' => $this->language->get('text_description'),
                'cost' => $cost,
                'tax_class_id' => 0,
				'text' => $this->currency->format($cost)
            );

            $method_data = array(
                'code' => 'nexpress',
                'title' => $this->language->get('text_title'),
                'quote' => $quote_data,
                'sort_order' => $this->config->get('nexpress_sort_order'),
                'error' => FALSE
            );
        }

        return $method_data;
    }

}

?>