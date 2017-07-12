<?php
class ModelTotalPaymentMethodDiscounts extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {
		//print_r($this->config->get('paymentmethoddiscounts_discount'));
		//print_r($this->session->data);
		
		if(isset($this->session->data['payment_method'])){
		
			$discounts=$this->config->get('paymentmethoddiscounts_discount');
			
			$payment_method='';
			if (isset($this->session->data['payment_method'])) {
				$payment_method = $this->session->data['payment_method']['title'];
			}
			
			//$this->load->model('checkout/order');
			//$order=$this->model_checkout_order->getOrder($this->session->data['order_id']);
//print_r($order);	
		
			foreach($discounts as $discount){
			
				if ($discount['paymentmethod']==$this->session->data['payment_method']['code']) {
					$this->load->language('total/paymentmethoddiscounts');
					
					$number=0;
					
					if($discount['znak']){
						if($discount['mode']) $number = -$total*$discount['number']/100; // -%
						else  $number = -$discount['number']; // -ed
					}else{
						if($discount['mode']) $number =  $total*$discount['number']/100; // +%
						else  $number =  $discount['number']; // +ed 
					}
					
					$total_data[] = array( 
						'code'       => 'paymentmethoddiscounts',
						'title'      => ($discount['znak']?$this->language->get('text_skidka'):$this->language->get('text_nacenka')).sprintf($this->language->get('text_paymentmethoddiscounts'), $payment_method),
						'text'       => $this->currency->format($number),
						'value'      => $number,
						'sort_order' => $this->config->get('paymentmethoddiscounts_sort_order')
					);
//print_r($total_data);
					if ($discount['tax_class_id']) {
						$tax_rates = $this->tax->getRates($number, $discount['tax_class_id']);
						
						foreach ($tax_rates as $tax_rate) {
							if (!isset($taxes[$tax_rate['tax_rate_id']])) {
								$taxes[$tax_rate['tax_rate_id']] = $tax_rate['amount'];
							} else {
								$taxes[$tax_rate['tax_rate_id']] += $tax_rate['amount'];
							}
						}
					}
					
					$total += $number;
				}
			
			}
		}	
	}
}
?>