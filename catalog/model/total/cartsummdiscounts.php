<?php
class ModelTotalCartSummDiscounts extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {
		$cartsumm = $this->cart->getSubTotal();
		
		if($cartsumm){
		
			$discounts=$this->config->get('cartsummdiscounts_discount');
            array_multisort($discounts, SORT_DESC);

            $t_data=array();

			foreach($discounts as $discount){
		
				if ($discount['amount']>0&&$cartsumm>=$discount['amount']) {
					$this->load->language('total/cartsummdiscounts');
		
					$number=0;
					
					if($discount['znak']){
						if($discount['mode']) $number = -$total*$discount['number']/100; // -%
						else  $number = -$discount['number']; // -ed
					}else{
						if($discount['mode']) $number =  $total*$discount['number']/100; // +%
						else  $number =  $discount['number']; // +ed 
					}

                    $number = round($number);

					$skidka = $this->currency->format($discount['amount']);
					
					
					$t_data = array( 
						'code'       => 'cartsummdiscounts',
						'title'      => ($discount['znak']?$this->language->get('text_skidka'):$this->language->get('text_nacenka')).sprintf($this->language->get('text_cartsummdiscounts'), $skidka, $discount['number']),
						'text'       => $this->currency->format($number),
						'value'      => $number,
						'sort_order' => $this->config->get('cartsummdiscounts_sort_order')
					);

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
                    break;
				}
			}
			if($t_data){
				$total_data[]=$t_data;
			}	
		}	
	}
}
?>