<?php
class ModelTotalPaymentDiscounts extends Model {
    public function getTotal(&$total_data, &$total, &$taxes) {
        //print_r($this->config->get('payment_discounts_discount'));

        if (isset($this->session->data['payment_method']) and $this->cart->getSubTotal() > 0) {
            $payment_method = $this->session->data['payment_method'];
            //print_r($payment_method);

            $this->load->language('total/payment_discounts');

            $discounts = $this->config->get('payment_discounts_discount');

            if (isset($payment_method['code'])) {
                foreach ($discounts as $discount) {
                    $arr = explode('.', $payment_method['code']);
                    if (count($arr) == 1) {
                        $key = $arr[0];
                    }
                    else {
                        $key = $payment_method['code'];
                    }

                   // echo $discount['paymentmethod'].'=>'.$key;

                    if ($discount['paymentmethod'] == $key or $discount['paymentmethod'].'.'.$discount['paymentmethod'] == $key) {

                        if (isset($discount['percent_number']) and !empty($discount['percent_number'])) {
                            //echo "$total *".$discount['percent_number']."/100 ";

                            $percent_number = $total*$discount['percent_number']/100;

                            if ($discount['percent_znak'] == 1) {
                                $percent_number = -$percent_number;
                            }
                        }
                        else {
                            $percent_number = 0;
                        }

                        if (isset($discount['ed_number']) and !empty($discount['ed_number'])) {
                            $ed_number = $discount['ed_number'];

                            if ($discount['ed_znak'] == 1) {
                                $ed_number = -$ed_number;
                            }
                        }
                        else {
                            $ed_number = 0;
                        }
						
                      if (isset($discount['sum_number']) and !empty($discount['sum_number'])) {
                            $sum_number = $discount['sum_number'];
                        }
                        else {
                            $sum_number = 0;
                        } 
                        $number = $percent_number + $ed_number;
						//echo "<h1>".$text_percent."</h1>";
						//echo "<h1>".$ed_number."</h1>";
						//echo "<h1>".$percent_number."</h1>";
                        //echo "<<$number>> = $percent_number + $ed_number<br/>";
						// Сумма с учетом доставки echo $total;
						$_SESSION['sum_number']=$sum_number;
						$_SESSION['total']=$total_data[0]['value'];
						if ($total_data[0]['value']<=$sum_number){
                        if ($number >= 0) {
                            $total_data[] = array(
                                'code'       => 'payment_discounts',
                                //'title'      => (($number < 0) ? $this->language->get('text_skidka') : $this->language->get('text_nacenka')).sprintf($this->language->get('text_payment_discounts'), $payment_method['title']),
                                'title'      => (($number < 0) ? $this->language->get('text_skidka') : $this->language->get('text_nacenka')).$this->language->get('text_payment_discounts'), $payment_method['title'],
                                'text'       => $this->currency->format($number),
                                'value'      => $number,
                                'sort_order' => $this->config->get('payment_discounts_sort_order')
                            );

                            //print_r($total_data);

                            $total += $number;
                        }
                    }
					}
                }
            }
        }
    }
}
?>