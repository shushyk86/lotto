<?php
class ControllerPaymentkaznachey extends Controller {
  private $error = array();
	public $paymentKaznacheyUrl = "http://payment.kaznachey.net/api/PaymentInterface/";

  protected function index() {
    $this->data['button_confirm'] = $this->language->get('button_confirm');
    $this->data['button_back'] = $this->language->get('button_back');

    $this->data['action'] = $this->url->link('payment/kaznachey/pay', '', 'SSL');

    $this->load->model('checkout/order');
	
    $order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
	$this->data['order_id'] = $this->session->data['order_id'];
	
	if($cc_types = $this->GetMerchnatInfo()){
		$this->data['cc_type'] = '<select name="cc_type" id="cc_type">';
		if(isset($cc_types["PaySystems"]))
		{
			foreach ($cc_types["PaySystems"] as $paysystem){
				$this->data['cc_type'] .= '<option value="'.$paysystem['Id'].'">'.$paysystem['PaySystemName'].'</option>';
			}
		}
		$this->data['cc_type'] .= '</select>';
		
		$this->data['cc_agreed'] = " <input type='checkbox' class='form-checkbox' name='cc_agreed' id='cc_agreed' checked><label for='edit-panes-payment-details-cc-agreed'><a href='$cc_types[TermToUse]'  target='_blank' >Согласен с условиями использования</a></label>";
	}
	
	$cur_code = $order_info['currency_code'];
	
    if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/kaznachey.tpl')) {
      $this->template = $this->config->get('config_template') . '/template/payment/kaznachey.tpl';
    } else {
      $this->template = 'default/template/payment/kaznachey.tpl';
    }

    $this->render(); 
  }
  
  public function fail() {
    $this->redirect(HTTPS_SERVER . 'index.php?route=checkout/checkout');
  }

  public function success() {
	if(isset($_GET['Result']))
	{
		$def = false;
		switch ($_GET['Result']) {
			case 'success':
				//Очистка корзины
				unset($this->session->data['cart']);
				$this->redirect(HTTPS_SERVER . 'index.php?route=checkout/success');
				break;
			case 'deferred':
				$def = true;
				break;
			case 'inprogress':
                $this->redirect(HTTPS_SERVER . 'index.php?route=checkout/simplecheckout');
			    //$def = true;
				break;
			case 'failed':
				$this->redirect(HTTPS_SERVER . 'index.php?route=checkout/error');
				break;
			default:
			   echo "";
		}

		if($def){
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/kaznachey_deferred.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/payment/kaznachey.tpl';
			} else {
				$this->template = 'default/template/payment/kaznachey_deferred.tpl';
			}
		}
		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));

	}
  }
  
   	public function callback() {
		$request_json = file_get_contents('php://input');
		$request = json_decode($request_json, true);

		$request_sign = md5($request["ErrorCode"].
			$request["OrderId"].
			$request["MerchantInternalPaymentId"]. 
			$request["MerchantInternalUserId"]. 
			number_format($request["OrderSum"],2,".",""). 
			number_format($request["Sum"],2,".",""). 
			strtoupper($request["Currency"]). 
			$request["CustomMerchantInfo"]. 
			strtoupper($this->config->get('kaznachey_secret_key')));
			
			//$this->log->write(serialize($request));
		
			if($request['SignatureEx'] == $request_sign) {
				$this->load->model('checkout/order');
				$order_info = $this->model_checkout_order->getOrder($request["MerchantInternalPaymentId"]);
				if($order_info['order_status_id'] == 0) {
					$this->model_checkout_order->confirm($request["MerchantInternalPaymentId"], $this->config->get('kaznachey_order_status_id'), 'Payed by Kaznachey');
				}
				if($order_info['order_status_id'] != $this->config->get('kaznachey_order_status_id')) {
					$this->model_checkout_order->update($request["MerchantInternalPaymentId"], $this->config->get('kaznachey_order_status_id'),'Payed by Kaznachey',TRUE);
				}
			}
	} 

	public function getmerchinfo() {
		$this->load->model('checkout/order');
		
		$json = array();
		
		if($cc_types = $this->GetMerchnatInfo()){
			$json['cc_type'] = '<tr class="cc_type_tr">
				<td colspan="2"> <select name="cc_type" id="cc_type">';
			foreach ($cc_types["PaySystems"] as $paysystem)
			{
				$json['cc_type'] .= '<option value="'.$paysystem['Id'].'">'.$paysystem['PaySystemName'].'</option>';
			}
				$json['cc_type'] .= '</select></td></tr>';
		}
		
		$this->response->setOutput(json_encode($json));
  }
  
   public function gePaySystems(){
		if($cc_types = $this->GetMerchnatInfo()){
			$html = '<select name="cc_type" id="cc_type">';
			if(isset($cc_types["PaySystems"]))
			{
				foreach ($cc_types["PaySystems"] as $paysystem){
					$html .= '<option value="'.$paysystem['Id'].'">'.$paysystem['PaySystemName'].'</option>';
				}
			}
			$html .= '</select>';
			$html .= " <input type='checkbox' class='form-checkbox' name='cc_agreed' id='cc_agreed' checked><label for='edit-panes-payment-details-cc-agreed'><a href='$cc_types[TermToUse]'  target='_blank' >Согласен с условиями использования</a></label>";
			$this->response->setOutput($html);
		}
  }

   public function pay(){
  
    if(isset($this->session->data['order_id'])){
		$order_id = $this->session->data['order_id'];
	}else {
		return false;
	}
	
	$this->load->model('checkout/order');

	$order_info = $this->model_checkout_order->getOrder($order_id);
  
	$request["MerchantGuid"] = $this->config->get('kaznachey_merchant_id');
	$request['SelectedPaySystemId'] = isset($this->request->post['cc_type']) ? $this->request->post['cc_type'] : $this->GetMerchnatInfo(false, true);
	$request['Currency'] = (isset($order_info['currency_code'])) ? $order_info['currency_code'] : 'UAH';
	$request['Language'] = $this->language->get('code');
	
	if (!$this->cart->hasProducts() || $this->cart->hasProducts() == 0) {
		$this->session->data['error'] = 'ERROR:no products in cart';
		$this->response->redirect($this->url->link('checkout/cart', '', 'SSL'));
	}

	$sum=$qty=0;
	foreach ($this->cart->getProducts() as $product) {
		$request['Products'][] = array(
			"ProductId" => $product['model'],
			"ProductName" => $product['name'],
			"ProductPrice" => $product['price'],
			"ProductItemsNum" => $product['quantity'],
			"ImageUrl" => (isset($product['image']))?'http://'.$_SERVER['HTTP_HOST'] .'/image/'. $product['image']:'',
		);
		$sum += $product['price'] * $product['quantity'];
		$qty += $product['quantity'];
	}
	
	if($sum != $order_info['total']){
		$sum += $order_info_total = (int) ($order_info['total'] - $sum);
		$request['Products'][] = array(
			"ProductId" => '1',
			"ProductName" => 'Delivery',
			"ProductPrice" => $order_info_total,
			"ProductItemsNum" => 1,
			"ImageUrl" => '',
		);
		$qty++;
	}
	
	$statusUrl = $this->url->link('payment/kaznachey/callback', '', 'SSL');
	
	if($this->config->get('copy_success_url')){
		$returnUrl = $this->config->get('copy_success_url');
	}else{
		$returnUrl = 'http://'.$_SERVER['HTTP_HOST']  . '/kaznachey_result.php';
	}

    $request['PaymentDetails'] = array(
       "MerchantInternalPaymentId"=>"$order_id",
       "MerchantInternalUserId"=>"$order_info[customer_id]",
       "EMail"=>"$order_info[email]",
       "PhoneNumber"=>"$order_info[telephone]",
       "CustomMerchantInfo"=>"",
       "StatusUrl"=>"$statusUrl",
       "ReturnUrl"=>"$returnUrl",
       "BuyerCountry"=>"$order_info[payment_country]",
       "BuyerFirstname"=>"$order_info[payment_firstname]",
       "BuyerPatronymic"=>"1",
       "BuyerLastname"=>"$order_info[payment_lastname]",
       "BuyerStreet"=>"$order_info[payment_address_1]",
       "BuyerZone"=>"$order_info[payment_zone]",
       "BuyerZip"=>"$order_info[payment_zone_id]",
       "BuyerCity"=>"$order_info[payment_city]",

       "DeliveryFirstname"=>"$order_info[shipping_firstname]",
       "DeliveryLastname"=>"$order_info[shipping_lastname]",
       "DeliveryZip"=>"$order_info[shipping_zone_id]",
       "DeliveryCountry"=>"$order_info[shipping_country]",
       "DeliveryPatronymic"=>"1",
       "DeliveryStreet"=>"$order_info[shipping_address_1]",
       "DeliveryCity"=>"$order_info[shipping_city]",
       "DeliveryZone"=>"$order_info[shipping_zone]",
    );
	
	$request["Signature"] = md5(strtoupper($request["MerchantGuid"]) .
		number_format($sum, 2, ".", "") . 
		$request["SelectedPaySystemId"] . 
		$request["PaymentDetails"]["EMail"] . 
		$request["PaymentDetails"]["PhoneNumber"] . 
		$request["PaymentDetails"]["MerchantInternalUserId"] . 
		$request["PaymentDetails"]["MerchantInternalPaymentId"] . 
		strtoupper($request["Language"]) . 
		strtoupper($request["Currency"]) . 
		strtoupper($this->config->get('kaznachey_secret_key')));
		
		$response = $this->sendRequestKaznachey(json_encode($request), "CreatePaymentEx");
		$result = json_decode($response, true);

		if($result['ErrorCode'] != 0){
			$this->session->data['error'] = 'Kaznachey payment error'.$result['ErrorCode'];
			$this->response->redirect($this->url->link('checkout/checkout', '', 'SSL'));
		}
		
		echo base64_decode($result["ExternalForm"]);

	}

	  
	public function validate() {
		$this->language->load('checkout/checkout');
		
		$json = array();
		
		$this->load->model('account/address');
	
		if ($this->customer->isLogged()) {
			$this->request->post['email'] = $this->customer->getEmail();
			$this->request->post['telephone'] = $this->customer->getTelephone();
			$json['customer']['customer_id'] = $this->customer->getId();
		}

		$this->response->setOutput(json_encode($json));
	}

	function GetMerchnatInfo($id = false, $first = false){
		$requestMerchantInfo = Array(
			"MerchantGuid"=>$this->config->get('kaznachey_merchant_id'),
			"Signature" => md5(strtoupper($this->config->get('kaznachey_merchant_id')) . strtoupper($this->config->get('kaznachey_secret_key')))
		);

		$resMerchantInfo = json_decode($this->sendRequestKaznachey(json_encode($requestMerchantInfo), 'GetMerchatInformation'),true); 
		if($first){
			return $resMerchantInfo["PaySystems"][0]['Id'];
		}elseif($id)
		{
			foreach ($resMerchantInfo["PaySystems"] as $key=>$paysystem)
			{
				if($paysystem['Id'] == $id){
					return $paysystem;
				}
			}
		}else{
			return $resMerchantInfo;
		}
	}

  	protected function sendRequestKaznachey($jsonData, $method){
		$curl = curl_init();
		if (!$curl)
			return false;

		curl_setopt($curl, CURLOPT_URL, $this->paymentKaznacheyUrl . $method);
		curl_setopt($curl, CURLOPT_POST, true);
		curl_setopt($curl, CURLOPT_HTTPHEADER,
			array("Expect: ", "Content-Type: application/json; charset=UTF-8", 'Content-Length: '
				. strlen($jsonData)));
		curl_setopt($curl, CURLOPT_POSTFIELDS, $jsonData);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, True);
		$response = curl_exec($curl);
		curl_close($curl);

		return $response;
	}
  
}
?>