<?php

// @category  : OpenCart
// @module    : Smart Checkout
// @author    : OCdevWizard <ocdevwizard@gmail.com> 
// @copyright : Copyright (c) 2014, OCdevWizard
// @license   : http://license.ocdevwizard.com/Licensing_Policy.pdf

class ControllerModuleOCdevSmartCheckout extends Controller {
    
    static $_module_version = '1.0.5';
    static $_module_name    = 'ocdev_smart_checkout';

    public function index() {

        // started magic ... 0%

        // connect models array

        $models = array( 'catalog/product', 'catalog/information', 'tool/image', 'setting/extension', 'account/address', 'account/customer', 'localisation/country' );
        foreach ($models as $model) {
            $this->load->model($model);
        }
        
        // get @product_id

        if ( isset( $this->request->request['product_id'] ) ) {
            $product_id = (int) $this->request->request['product_id'];
        } else {
            die();
        }
        
        $this->document->addScript('catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js');

        $this->data = array_merge( $this->data, $this->language->load( 'module/' . self::$_module_name ), $this->config->get( self::$_module_name . '_text_data' ), $this->config->get( self::$_module_name . '_form_data' ) );

        $text_data  = (array) $this->config->get( self::$_module_name . '_text_data' );
        $form_data  = (array) $this->config->get( self::$_module_name . '_form_data' );
        $field_data = (array) $this->config->get( self::$_module_name . '_field_data' );

        $product_info = $this->model_catalog_product->getProduct( $product_id );

		if ( isset( $this->request->request['quantity'] ) ) {
            $quant = (int) $this->request->request['quantity'];
        } else {
            $quant = 1;
        }

        $this->data['product_id']       = $product_id;
        $this->data['product_sku']      = $product_info['sku'];
        $this->data['product_quant']    = $quant;
        $this->data['admitad_uid']      = (isset($_COOKIE['admitad_uid'])) ? $_COOKIE['admitad_uid'] : '';   
        $this->data['product_name']     = $product_info['name'];    
        $this->data['product_model']    = $product_info['model'];
        $this->data['product_ean']      = $product_info['ean'];
        $this->data['product_jan']      = $product_info['jan'];
        $this->data['product_isbn']     = $product_info['isbn'];
        $this->data['product_mpn']      = $product_info['mpn'];
        $this->data['product_location'] = $product_info['location'];
        $this->data['product_description'] = html_entity_decode( $product_info['description'], ENT_QUOTES, 'UTF-8' );
        $this->data['attribute_groups'] = $this->model_catalog_product->getProductAttributes( $product_id );

        $language_code = $this->session->data['language'];
        $zone_data     = $this->getZoneId();

        if ( isset( $text_data[$language_code] ) ) {
            $this->data['text_' . self::$_module_name . '_heading'] = $text_data[$language_code]['heading'];
            $this->data['text_' . self::$_module_name . '_informer'] = !empty( $text_data[$language_code]['informer'] ) ? html_entity_decode( $text_data[$language_code]['informer'], ENT_QUOTES, 'UTF-8' ) : '';
            $this->data['text_' . self::$_module_name . '_success_text'] = html_entity_decode( $text_data[$language_code]['success_text'], ENT_QUOTES, 'UTF-8' );
        }    

        $this->data['thumb'] = ( $product_info['image'] ) ? $this->model_tool_image->resize( $product_info['image'], $form_data['main_image_width'], $form_data['main_image_height'] ) : $this->model_tool_image->resize( "no_image.jpg", $form_data['main_image_width'], $form_data['main_image_height'] );
        
        $this->data['main_thumb'] = ( $product_info['image'] ) ? $this->model_tool_image->resize( $product_info['image'], $form_data['sub_images_width'], $form_data['sub_images_height'] ) : $this->model_tool_image->resize( "no_image.jpg", $form_data['sub_images_width'], $form_data['sub_images_height'] );
        
        $this->data['main_popup'] = ( $product_info['image'] ) ? $this->model_tool_image->resize( $product_info['image'], $form_data['main_image_width'], $form_data['main_image_height'] ) : $this->model_tool_image->resize( "no_image.jpg", $form_data['main_image_width'], $form_data['main_image_height'] );

        $this->data['images'] = array();
        $images_array = (array) $this->model_catalog_product->getProductImages( $product_id );
        $images_new_array = array_splice( $images_array, 0, $form_data['count_sub_images'], true );

        foreach ( $images_new_array as $sub_image ) {
            $this->data['images'][] = array(
                'popup' => ( $sub_image['image'] ) ? $this->model_tool_image->resize( $sub_image['image'], $form_data['main_image_width'], $form_data['main_image_height'] ) : $this->model_tool_image->resize( "no_image.jpg", $form_data['main_image_width'], $form_data['main_image_height'] ),
                'thumb' => ( $sub_image['image'] ) ? $this->model_tool_image->resize( $sub_image['image'], $form_data['sub_images_width'], $form_data['sub_images_height'] ) : $this->model_tool_image->resize( "no_image.jpg", $form_data['sub_images_width'], $form_data['sub_images_height'] )
            );
        }

        // checkout terms

        $this->data['informations'] = array();

        if ( isset( $form_data['require_information'] ) ) {
            $informations = $this->model_catalog_information->getInformation( (int) $form_data['require_information'] );
            $this->data['informations'] = sprintf( $this->language->get( 'text_require_information' ), $this->url->link( 'information/information', 'information_id=' . $form_data['require_information'] ), $informations['title'] );
        }

        // product price

        if ( ( $this->config->get( 'config_customer_price' ) && $this->customer->isLogged() ) || !$this->config->get( 'config_customer_price' ) ) {
            $this->data['price'] = $this->currency->format( $this->tax->calculate( $product_info['price'], $product_info['tax_class_id'], $this->config->get( 'config_tax' ) ) );
        } else {
            $this->data['price'] = false;
        }

        // product special

        if ( (float) $product_info['special'] ) {
            $this->data['special'] = $this->currency->format( $this->tax->calculate( $product_info['special'], $product_info['tax_class_id'], $this->config->get( 'config_tax' ) ) );
        } else {
            $this->data['special'] = false;
        }
		
		// product price without currency
		
		 if($this->data['special'])  { 
			$s_pieces = explode(' ', $this->data['special']);
			$this->data['actual_price'] = $s_pieces[0];
			$actual_price = $s_pieces[0];
		 } else {
			$p_pieces = explode(' ', $this->data['price']);
			$this->data['actual_price'] = $p_pieces[0];
			$actual_price = $p_pieces[0];
		 }

        // product tax

        if ( $this->config->get( 'config_tax' ) ) {
            $this->data['tax'] = $this->currency->format( (float) $product_info['special'] ? $product_info['special'] : $product_info['price'] );
        } else {
            $this->data['tax'] = false;
        }

        // product discount
  
        $this->data['discounts'] = array(); 

        foreach ( (array) $this->model_catalog_product->getProductDiscounts( $product_id ) as $discount ) {
            $this->data['discounts'][] = array(
                'quantity' => $discount['quantity'],
                'price'    => $this->currency->format( $this->tax->calculate( $discount['price'], $product_info['tax_class_id'], $this->config->get( 'config_tax' ) ) )
            );
        }

        // product options data

        $this->data['options'] = array();

        foreach ( (array) $this->model_catalog_product->getProductOptions( $product_id ) as $option ) { 
            
            if ( in_array( $option['option_id'], $form_data['product_options'] ) ) {
                if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'checkbox' || $option['type'] == 'image') { 
                    $option_value_data = array();

                    foreach ( $option['option_value'] as $option_value ) {
                        if ( !$option_value['subtract'] || ( $option_value['quantity'] > 0 ) ) {
                            if ( ( ( $this->config->get( 'config_customer_price' ) && $this->customer->isLogged() ) || !$this->config->get( 'config_customer_price' ) ) && (float) $option_value['price'] ) {
                                $price = $this->currency->format( $this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get( 'config_tax' ) ) );
                            } else {
                                $price = false;
                            }

                            $option_image_width = !empty( $form_data['option_images_width'] ) ? $form_data['option_images_width'] : 50;
                            $option_image_height = !empty( $form_data['option_images_height'] ) ? $form_data['option_images_height'] : 50;

                            $option_value_data[] = array(
                                'product_option_value_id' => $option_value['product_option_value_id'],
                                'option_value_id'         => $option_value['option_value_id'],
                                'name'                    => $option_value['name'],
                                'image'                   => $this->model_tool_image->resize( $option_value['image'], $option_image_width, $option_image_height ),
                                'price'                   => $price,
                                'price_prefix'            => $option_value['price_prefix']
                            );
                        }
                    }

                    $this->data['options'][] = array(
                        'product_option_id' => $option['product_option_id'],
                        'option_id'         => $option['option_id'],
                        'name'              => $option['name'],
                        'type'              => $option['type'],
                        'option_value'      => $option_value_data,
                        'required'          => $option['required']
                    );                  

                } elseif ( $option['type'] == 'text' || $option['type'] == 'textarea' 
                    // || $option['type'] == 'file' 
                    || $option['type'] == 'date' || $option['type'] == 'datetime' || $option['type'] == 'time' 
                    ) {
                    $this->data['options'][] = array(
                        'product_option_id' => $option['product_option_id'],
                        'option_id'         => $option['option_id'],
                        'name'              => $option['name'],
                        'type'              => $option['type'],
                        'option_value'      => $option['option_value'],
                        'required'          => $option['required']
                    );                      
                }
            }
        }

        // shipping methods

        if ( isset( $form_data['shipping_code'] ) ) {

            $quote_data = array();
           
            foreach ( (array) $form_data['shipping_code'] as $result ) {
                if ( $this->config->get( $result . '_status' ) ) {
                    
                    $this->load->model( 'shipping/' . $result );

                    if ( isset( $this->request->request['country_id'] ) && isset( $zone_data[0] ) ) {
                        $quote = $this->{'model_shipping_' . $result}->getQuote( 
                            array( 
                                'country_id' => $this->request->request['country_id'], 
                                'zone_id' => $zone_data[0]
                            )
                        );
                    } else {
                        $quote = $this->{'model_shipping_' . $result}->getQuote( array( 'country_id' => 0, 'zone_id' => 0 ) );
                    }
                    
                    if ( $quote ) {
                        $quote_data[$result] = $quote;
                    }
                }
            }

            $sort_order = array();

            foreach ( $quote_data as $key => $value ) {
                $sort_order[$key] = $value['sort_order'];
            }

            array_multisort( $sort_order, SORT_ASC, $quote_data );
        }

        // payment methods

        if ( isset( $form_data['payment_code'] ) ) {

            $method_data = array();

            foreach ( (array) $form_data['payment_code'] as $result ) {
                if ( $this->config->get( $result . '_status' ) ) {
                    
                    $this->load->model( 'payment/' . $result );
                    
                    if ( isset( $this->request->request['country_id'] ) && isset( $zone_data[0] ) ) {
                        $method = $this->{'model_payment_' . $result}->getMethod(
                            array( 
                                'country_id' => $this->request->request['country_id'], 
                                'zone_id' => $zone_data[0]
                            ), 20000
                        ); 
                    } else {
                        $method = $this->{'model_payment_' . $result}->getMethod( array( 'country_id' => 0, 'zone_id' => 0 ), 20000 );
                    }

                    if ( $method ) {
                        $method_data[$result] = $method;
                    }
                }
            }

            $sort_order = array(); 

            foreach ( $method_data as $key => $value ) {
                $sort_order[$key] = $value['sort_order'];
            }

            array_multisort( $sort_order, SORT_ASC, $method_data );
        }

        $product_countries = ( isset( $form_data['product_countries'] ) ) ? $form_data['product_countries'] : '';

        $this->data['countries'] = array();

        if ( $product_countries ) {
            foreach ( $this->model_localisation_country->getCountries() as $country ) {
                if ( in_array( $country['country_id'], $product_countries ) ) {
                    $this->data['countries'][] = $this->model_localisation_country->getCountry( $country['country_id'] );
                }
            }
        }

        if ( isset( $this->session->data['payment_country_id'] ) ) {
            $this->data[self::$_module_name .'_country_id'] = $this->session->data['payment_country_id']; 
            $this->session->data['payment_country_id'] = $this->session->data['payment_country_id'];       
        } elseif( isset( $this->request->request['country_id'] ) ) {
            $this->data[self::$_module_name .'_country_id'] = $this->request->request['country_id']; 
            $this->session->data['payment_country_id'] = $this->request->request['country_id'];      
        } else {
            $this->data[self::$_module_name .'_country_id'] = $this->config->get('config_country_id');
            $this->session->data['payment_country_id'] = $this->config->get('config_country_id');
        }
                
        if ( isset( $this->session->data['payment_zone_id'] ) ) {
            $this->data[self::$_module_name .'_zone_id'] = $this->session->data['payment_zone_id'];      
            $this->session->data['payment_zone_id'] = $this->session->data['payment_zone_id']; 
        } elseif( isset( $this->request->request['zone_id'] ) ) {
            $this->data[self::$_module_name .'_zone_id'] = $zone_data[0];      
            $this->session->data['payment_zone_id'] = $zone_data[0]; 
        } else {
            $this->data[self::$_module_name .'_zone_id'] = "";
            $this->session->data['payment_zone_id'] = ""; 
        }

        if ( isset( $quote_data ) ) {
            $this->data['shipping_methods'] = $quote_data;
            $this->session->data['shipping_methods'] = $quote_data;
        } else {
            $this->data['shipping_methods'] = array();
        }

        if ( isset( $method_data ) ) {
            $this->data['payment_methods'] = $method_data; 
            $this->session->data['payment_methods'] = $method_data;
        } else {
            $this->data['payment_methods'] = array();
        }

        $this->session->data['smch_product_weight'] = $this->getProductWeight();
        $this->session->data['smch_product_sut_total'] = $this->getProductSubTotal();

        $customer_info = ( $this->customer->isLogged() ) ? $this->model_account_customer->getCustomer( $this->customer->getId() ) : FALSE;

        $customer_info_data = array( 'firstname', 'lastname', 'email', 'telephone', 'fax' );

        $this->data['fields_data'] = array();

        foreach ( $this->getActiveField() as $field ) {

            switch ( $field['position'] ) {
                case '1': $position = "left"; break;
                case '2': $position = "right"; break;
                case '3': $position = "center"; break;
            }

            $this->data['fields_data'][] = array(
                'activate'    => $field['activate'],
                'title'       => $field['title'][$language_code],
                'value'       => $this->replaceValue( $field['view'], 1 ),
                'name'        => $this->replaceValue( $field['view'], 2 ),
                'type'        => $this->replaceValue( $field['view'], 1 ),
                'check'       => $field['check'],
                'error_text'  => $field['error_text'],
                'css_id'      => $field['css_id'],
                'css_class'   => $field['css_class'],
                'position'    => $position
            );

            if ( isset( $this->request->post[ $this->replaceValue( $field['view'], 2 ) ] ) ) {
                $this->data['input_value'][$this->replaceValue( $field['view'], 2 )] = $this->request->post[$this->replaceValue( $field['view'], 2 )];
            } elseif ($customer_info && in_array($this->replaceValue( $field['view'], 2 ), $customer_info_data)) {
                $this->data['input_value'][$this->replaceValue( $field['view'], 2 )] = $customer_info[$this->replaceValue( $field['view'], 2 )];
            } else {
                $this->data['input_value'][$this->replaceValue( $field['view'], 2 )] = '';
            }
        }

        if( file_exists(DIR_TEMPLATE . $this->config->get( 'config_template' ) . '/template/module/' . self::$_module_name . '.tpl') ) {
            $this->template = $this->config->get( 'config_template' ) . '/template/module/' . self::$_module_name . '.tpl';
        } else {
            $this->template = 'default/template/module/' . self::$_module_name . '.tpl';
        }

        $this->response->setOutput( $this->render() );
    }

    public function sendOrder() {
        // magic status ... 50%
        
        // connect models array

        $json = array();

        $models = array( 'catalog/product', 'catalog/information', 'total/total', 'setting/extension', 'account/customer', 'affiliate/affiliate', 'checkout/order' );
        foreach ($models as $model) {
            $this->load->model($model);
        } 

        // get @product_id

        if ( isset( $this->request->request['product_id'] ) ) {
            $product_id = (int) $this->request->request['product_id'];
        } else {
            die();
        }

        $this->data = array_merge( $this->data, $this->language->load( 'module/' . self::$_module_name ), $this->config->get( self::$_module_name . '_text_data' ), $this->config->get( self::$_module_name . '_form_data' ) );

        $text_data  = (array) $this->config->get( self::$_module_name . '_text_data' );
        $form_data  = (array) $this->config->get( self::$_module_name . '_form_data' );
        $field_data = (array) $this->config->get( self::$_module_name . '_field_data' );

        $product_info     = (array) $this->model_catalog_product->getProduct( $product_id );
        $product_options  = (array) $this->model_catalog_product->getProductOptions( $product_id );
        $language_code    = $this->session->data['language'];
        $oc_v             = explode( '.', VERSION );
        $shipping_data    = (array) $this->getShippingData();
        $payment_data     = (array) $this->getPaymentData();
        $country_data     = (array) $this->getCountryData();
        $order_status_id  = ( !empty( $form_data['order_status_id'] ) ) ? (int) $form_data['order_status_id'] : (int) $this->config->get( 'config_order_status_id' );
        $zone_data        = $this->getZoneId();

        if ( isset( $this->request->request['option'] ) ) {
            $option = $this->request->request['option'];
        } else {
            $option = array();
        }

        if ( isset( $this->request->request['quantity'] ) ) {
            $quantity = (int) $this->request->request['quantity'];
        } else {
            $quantity = 1;
        }

        $stock = true;
        if (!$product_info['quantity'] || ($product_info['quantity'] < $quantity)) {
            $stock = false;
        }

        $customer_info = ( $this->customer->isLogged() ) ? $this->model_account_customer->getCustomer( $this->customer->getId() ) : FALSE;

        // validate fields

        foreach ( $this->getActiveField() as $field ) {

            if ( empty( $this->request->request[$field['view']] ) && $field['check'] == 1 ) {
                $json['error']['field'][$field['view']] = $field['error_text'][$language_code];
            } elseif( !empty( $field['check_rule'] ) && !preg_match( $field['check_rule'], $this->request->request[$field['view']] ) && $field['check'] == 2 ) {
                $json['error']['field'][$field['view']] = $field['error_text'][$language_code];
            } elseif( utf8_strlen( $this->request->request[$field['view']] ) < $field['check_min'] || utf8_strlen( $this->request->request[$field['view']] ) > $field['check_max'] && $field['check'] == 3 ) {
                $json['error']['field'][$field['view']] = $field['error_text'][$language_code];
            } else {
                unset( $json['error']['field'][$field['view']] );
            }
        }

        // validate product options

        foreach ( $product_options as $product_option ) {
            if ( in_array( $product_option['option_id'], $form_data['product_options'] ) ) {
                if ( $product_option['required'] && empty( $option[$product_option['product_option_id']] ) ) {
                    $json['error']['option'][$product_option['product_option_id']] = sprintf( $this->language->get( 'error_option' ), $product_option['name'] );
                }
            }
        }

        // validate quantity
        if ( !$stock ) {
            $json['error']['field']['quantity'] = 'Недопустимое количество!';
        }

        // validate require information

        if ( !isset( $this->request->request['require_information'] ) || empty( $this->request->request['require_information'] ) ) {
            if ( isset( $form_data['require_information'] ) ) {
                $informations = (array) $this->model_catalog_information->getInformation( (int) $form_data['require_information'] );
                $json['error']['field']['require_information'] = sprintf( $this->language->get('error_require_information' ), $informations['title'] );
            }
        }

        // validate shipping

        if ( !isset( $this->request->request['shipping_method'] ) || empty( $this->request->request['shipping_method'] ) ) {
            if ( isset( $form_data['require_shipping_method'] ) ) {
                $json['error']['field']['shipping_method'] = $this->language->get( 'error_shipping' );
            }
        }

        // validate payment

        if ( !isset( $this->request->request['payment_method'] ) || empty( $this->request->request['payment_method'] ) ) {
            if ( isset( $form_data['require_payment_method'] ) ) {
                $json['error']['field']['payment_method'] = $this->language->get( 'error_payment' );
            }
        }

        // validate captcha

        if ( !isset( $this->request->request['require_captcha'] ) || empty( $this->session->data['require_captcha'] ) || ( $this->session->data['require_captcha'] != $this->request->request['require_captcha'] ) ) {
            if ( isset( $form_data['use_captcha_verification'] ) ) {
                $json['error']['field']['require_captcha'] = $this->language->get( 'error_captcha' );
            }
        }
        
        // fill order table

        $order_data = array();

        if ( !isset( $json['error'] ) ) {

            if ( !empty( $this->request->server['HTTP_X_FORWARDED_FOR'] ) ) {
                $forwarded_ip = $this->request->server['HTTP_X_FORWARDED_FOR']; 
            } elseif( !empty( $this->request->server['HTTP_CLIENT_IP'] ) ) {
                $forwarded_ip = $this->request->server['HTTP_CLIENT_IP'];   
            } else {
                $forwarded_ip = '';
            }

            if ( isset( $this->request->server['HTTP_USER_AGENT'] ) ) {
                $user_agent = $this->request->server['HTTP_USER_AGENT'];    
            } else {
                $user_agent = '';
            }

            if ( isset( $this->request->server['HTTP_ACCEPT_LANGUAGE'] ) ) {
                $accept_language = $this->request->server['HTTP_ACCEPT_LANGUAGE'];  
            } else {
                $accept_language = '';
            }

            // affiliate

            if ( isset( $this->request->cookie['tracking'] ) ) {
                $affiliate_info = $this->model_affiliate_affiliate->getAffiliateByCode( $this->request->cookie['tracking'] );
                $subtotal = $this->getProductSubTotal();
                
                if ( $affiliate_info ) {
                    $affiliate_id = $affiliate_info['affiliate_id']; 
                    $commission = ( $subtotal / 100 ) * $affiliate_info['commission']; 
                } else {
                    $affiliate_id = 0;
                    $commission = 0;
                }

            } else {
                $affiliate_id = 0;
                $commission = 0;
            }

            //$product_key = ( $option ) ? (int) $product_id . ':' . base64_encode( serialize( $option) ) : (int) $product_id;
			
			if ($option) {
				$tempOption = base64_encode(serialize($option));
				$tempOption = str_replace("+","PLUSWASHERE", $tempOption);
				$tempOption = str_replace("/","SLASHWASHERE", $tempOption);
				$tempOption = str_replace("=","EQUALWASHERE", $tempOption);
				$product_key = (int)$product_id . ':' . $tempOption;
			}  else {
				$product_key = $product_id;
			}

            $product_in_old_cart = $this->cart->getProducts();

            // remove this product from cart

            if ( isset( $product_in_old_cart[$product_key] ) ) {
                $this->cart->remove( $product_key );
            }

            // save current cart and clear old sessions

            $current_cart = $this->session->data['cart']; unset( $this->session->data['cart'] ); 

            // add current product to cart

            $this->cart->add( $product_id, $quantity, $option ); 

            // get this product from new cart
        
            $product_in_new_cart = $this->cart->getProducts();
           
            foreach ( $product_in_new_cart as $current_product ) {
                if ( isset( $product_in_new_cart[$product_key] ) ) {
                    
                    $current_product = $product_in_new_cart[$product_key];
                }
            }

            if ( isset( $current_product['option'] ) ) {
                $option_data = array();

                foreach ( $current_product['option'] as $i => $option ) {
                    if ( $option['type'] != 'file' ) {
                        $value = $option['option_value'];   
                    } else {
                        $value = $this->encryption->decrypt( $option['option_value'] );
                    }   

                    $current_product['option'][$i] = array(
                        'product_option_id'       => $option['product_option_id'],
                        'product_option_value_id' => $option['product_option_value_id'],
                        'option_id'               => $option['option_id'],
                        'option_value_id'         => $option['option_value_id'],                                   
                        'name'                    => $option['name'],
                        'value'                   => $value,
                        'type'                    => $option['type']
                    );                  
                }
            }

            if( $oc_v[2] >= 6 ) { 
                $current_product['tax'] = $this->tax->getTax( $current_product['price'], $current_product['tax_class_id'] );
            } else {
                $current_product['tax'] = $this->tax->getRates( $current_product['price'], $current_product['tax_class_id'] );
            }  

            $product_to_order[] = $current_product;

            // totals and total

            $total_data = array();
            $total = 0;
            $taxes = $this->cart->getTaxes();

            $total_sort_order = array(); 

            $results = $this->model_setting_extension->getExtensions( 'total' );

            foreach ( $results as $key => $value ) {
                $total_sort_order[$key] = $this->config->get( $value['code'] . '_sort_order' );
            }

            array_multisort( $total_sort_order, SORT_ASC, $results );

            foreach ( $results as $result ) {
                if ( $this->config->get( $result['code'] . '_status' ) ) {
                    $this->load->model( 'total/' . $result['code'] );
                    $this->{'model_total_' . $result['code']}->getTotal( $total_data, $total, $taxes );
                }
            }

            $total_sort_order = array(); 

            foreach ( $total_data as $key => $value ) {
                $total_sort_order[$key] = $value['sort_order'];
            }

            array_multisort( $total_sort_order, SORT_ASC, $total_data );

            // make order data
            
            $order_data = array(
                'invoice_prefix'          => (string) $this->config->get( 'config_invoice_prefix' ),
                'store_id'                => $store_id = (int) $this->config->get( 'config_store_id' ),
                'store_name'              => (string) $this->config->get( 'config_name' ),
                'store_url'               => $store_id ? (string) $this->config->get( 'config_url' ) : HTTP_SERVER,
                'customer_id'             => $this->customer->isLogged() ? $this->customer->getId() : 0,
                'customer_group_id'       => $this->customer->isLogged() ? $this->customer->getCustomerGroupId() : $this->config->get( 'config_customer_group_id' ),
                'firstname'               => '',
                'lastname'                => '',
                'email'                   => '',
                'telephone'               => '',
                'fax'                     => '',
                'shipping_city'           => '',
                'shipping_postcode'       => '',
                'shipping_country'        => $country_data['name'],
                'shipping_country_id'     => '',
                'shipping_zone_id'        => ( !empty( $zone_data ) ) ? $zone_data[0] : '',
                'shipping_zone'           => ( !empty( $zone_data ) ) ? $zone_data[1] : '',
                'shipping_address_format' => '',
                'shipping_firstname'      => '',
                'shipping_lastname'       => '',
                'shipping_company'        => '',
                'shipping_address_1'      => '',
                'shipping_address_2'      => '',
                'shipping_code'           => $shipping_data['code'],
                'shipping_method'         => $shipping_data['title'],
                'payment_city'            => '',
                'payment_postcode'        => '',
                'payment_country'         => $country_data['name'],
                'payment_country_id'      => '',
                'payment_zone'            => ( !empty( $zone_data ) ) ? $zone_data[1] : '',
                'payment_zone_id'         => ( !empty( $zone_data ) ) ? $zone_data[0] : '',
                'payment_address_format'  => '',
                'payment_firstname'       => '',
                'payment_lastname'        => '',
                'payment_company'         => '',
                'payment_address_1'       => '',
                'payment_address_2'       => '',
                'payment_company_id'      => '',
                'payment_tax_id'          => '',
                'payment_code'            => $payment_data['code'],
                'payment_method'          => $payment_data['title'],
                'forwarded_ip'            => $forwarded_ip,
                'user_agent'              => $user_agent,
                'accept_language'         => $accept_language,
                'vouchers'                => array(),
                'comment'                 => '',
                'total'                   => $total,
                'reward'                  => '',
                'affiliate_id'            => $affiliate_id,
                'commission'              => $commission,
                'language_id'             => $this->config->get( 'config_language_id' ),
                'currency_id'             => $this->currency->getId(),
                'currency_code'           => $this->currency->getCode(),
                'currency_value'          => $this->currency->getValue( $this->currency->getCode() ),
                'ip'                      => $this->request->server['REMOTE_ADDR'],
                'products'                => $product_to_order,
                'totals'                  => $total_data,
            );

            foreach ( $this->getActiveField() as $field ) {
                if ( !empty( $this->request->request[$this->replaceValue( $field['view'], 2 )] ) ) {
                    $comment_text = '';
                    if ( $this->replaceValue( $field['view'], 2 ) == 'city' ) {
                        $order_data['shipping_city'] = $this->request->request[$this->replaceValue( $field['view'], 2 )];
                        $order_data['payment_city'] = $this->request->request[$this->replaceValue( $field['view'], 2 )];
                    } elseif ( $this->replaceValue( $field['view'], 2 ) == 'postcode' ) {
                        $order_data['shipping_postcode'] = $this->request->request[$this->replaceValue( $field['view'], 2 )];
                        $order_data['payment_postcode'] = $this->request->request[$this->replaceValue( $field['view'], 2 )];
                    } elseif ( $this->replaceValue( $field['view'], 2 ) == 'country_id' ) {
                        $order_data['shipping_country_id'] = $this->request->request[$this->replaceValue( $field['view'], 2 )];
                        $order_data['payment_country_id'] = $this->request->request[$this->replaceValue( $field['view'], 2 )];
                    } elseif ( $this->replaceValue( $field['view'], 2 ) == 'zone_id' ) {
                        $order_data['shipping_zone_id'] = $zone_data[0];
                        $order_data['payment_zone_id'] = $zone_data[0];
                    } elseif ( $this->replaceValue( $field['view'], 2 ) == 'address_1' ) {
                        $order_data['shipping_address_1'] = $this->request->request[$this->replaceValue( $field['view'], 2 )];
                        $order_data['payment_address_1'] = $this->request->request[$this->replaceValue( $field['view'], 2 )];
                    } elseif ( $this->replaceValue( $field['view'], 2 ) == 'address_2' ) {
                        $order_data['shipping_address_2'] = $this->request->request[$this->replaceValue( $field['view'], 2 )];
                        $order_data['payment_address_2'] = $this->request->request[$this->replaceValue( $field['view'], 2 )];
                    } elseif ( $this->replaceValue( $field['view'], 2 ) == 'company' ) {
                        $order_data['shipping_company'] = $this->request->request[$this->replaceValue( $field['view'], 2 )];
                        $order_data['payment_company'] = $this->request->request[$this->replaceValue( $field['view'], 2 )];
                    } elseif ( $this->replaceValue( $field['view'], 2 ) == 'firstname' ) {
                        $order_data['shipping_firstname'] = $this->request->request[$this->replaceValue( $field['view'], 2 )];
                        $order_data['payment_firstname'] = $this->request->request[$this->replaceValue( $field['view'], 2 )];
                        $order_data['firstname'] = ( !empty( $form_data['prefix_order'] ) ) ? $form_data['prefix_order'] . $this->request->request[$this->replaceValue( $field['view'], 2 )] : $this->request->request[$this->replaceValue( $field['view'], 2 )];
                    } elseif ( $this->replaceValue( $field['view'], 2 ) == 'lastname' ) {
                        $order_data['shipping_lastname'] = $this->request->request[$this->replaceValue( $field['view'], 2 )];
                        $order_data['payment_lastname'] = $this->request->request[$this->replaceValue( $field['view'], 2 )];
                        $order_data['lastname'] = $this->request->request[$this->replaceValue( $field['view'], 2 )];
                    } elseif ( $this->replaceValue( $field['view'], 2 ) == 'company_id' ) {
                        $order_data['payment_company_id'] = $this->request->request[$this->replaceValue( $field['view'], 2 )];
                    } elseif ( $this->replaceValue( $field['view'], 2 ) == 'text' || $this->replaceValue( $field['view'], 2 ) == 'textarea' || $this->replaceValue( $field['view'], 2 ) == 'comment' ) {
                        $order_data['comment'] .= html_entity_decode( $field['title'][$language_code].' : '.$this->request->request[$this->replaceValue( $field['view'], 2 )].'<br/><hr/>', ENT_QUOTES, 'UTF-8' );
                    } else {
                        $order_data[$this->replaceValue( $field['view'], 2 )] = $this->request->request[$this->replaceValue( $field['view'], 2 )];
                    }
                } else {
                    $order_data[$this->replaceValue( $field['view'], 2 )] = '';

                    if ( $this->replaceValue( $field['view'], 2 ) == 'email' && $field['check'] == 0 ) {
                        $order_data['email'] = $form_data['alternative_email'];
                    }
                }
            }
			
			$order_data['email'] = $form_data['alternative_email'];

            $order_id = $this->model_checkout_order->addOrder( $order_data );

            $this->session->data['order_id'] = $order_id;
            
            $this->data['ord_id'] = $order_id;

            $this->model_checkout_order->confirm( $order_id, $order_status_id );

            $this->session->data['cart'] = $current_cart;

            $code_find = array( 
                '{firstname}',
                '{lastname}',
                '{email}',
                '{total}',
                '{address_1}',
                '{address_2}',
                '{telephone}',
                '{fax}',
                '{postcode}',
                '{city}',
                '{order_id}',
                '{comment}'
            );

            $code_replace = array( 
                isset( $this->request->request['firstname'] ) ? $this->request->request['firstname'] : '',
                isset( $this->request->request['lastname'] ) ? $this->request->request['lastname'] : '',
                isset( $this->request->request['email'] ) ? $this->request->request['email'] : '',
                $this->currency->format( $total ),
                isset( $this->request->request['address_1'] ) ? $this->request->request['address_1'] : '',
                isset( $this->request->request['address_2'] ) ? $this->request->request['address_2'] : '',
                isset( $this->request->request['telephone'] ) ? $this->request->request['telephone'] : '',
                isset( $this->request->request['fax'] ) ? $this->request->request['fax'] : '',
                isset( $this->request->request['postcode'] ) ? $this->request->request['postcode'] : '',
                isset( $this->request->request['city'] ) ? $this->request->request['city'] : '',
                $order_id,
                isset( $this->request->request['comment'] ) ? $this->request->request['comment'] : ''
            );

            if ( isset( $text_data[$language_code] ) ) {
                $json['output'] = html_entity_decode( str_ireplace( $code_find, $code_replace, $text_data[$language_code]['success_text'] ), ENT_QUOTES, 'UTF-8' );
            }
/*
            if ( isset( $form_data['allow_google_analytics'] ) ) {

                $total_to_ga = array( 'tax' => 0, 'shipping' => 0 );

                foreach ( $total_data as $value ) {
                    if ( $value['code'] == 'tax' ) {
                        $total_to_ga['tax'] += $value['value'];
                    } elseif ( $value['code'] == 'shipping' ) {
                        $total_to_ga['shipping'] = $value['value'];
                    } else { }
                }

                $json['google_analytics'] = array(
                    'transaction_id' => (int) $order_id,
                    'affiliation'    => (string) $this->config->get( 'config_name' ),
                    'revenue'        => $total,
                    'shipping'       => $total_to_ga['shipping'],
                    'tax'            => $total_to_ga['tax'],
                    'currency'       => (string) $this->currency->getCode(),
                    'product_id'     => (int) $this->request->request['product_id'],
                    'name'           => $product_info['name'],
                    'sku'            => !empty( $product_info['sku'] ) ? $product_info['sku'] : $product_info['model'],
                    'price'          => $this->processing( TRUE ),
                    'quantity'       => (int) $this->request->request['quantity']
                );
            }

            if ( isset( $form_data['allow_google_event'] ) ) {
                $json['google_event'] = array(
                    'product_id'     => (int) $this->request->request['product_id'],
                    'name'           => $product_info['name'],
                    'сategory'       => !empty( $form_data['google_event_category'] ) ? $form_data['google_event_category'] : "Smart Checkout",
                    'action'         => !empty( $form_data['google_event_action'] ) ? $form_data['google_event_action'] : "Success"
                );
            }

            if ( isset( $form_data['transfer_payments'] ) && $payment_data && in_array( $payment_data['code'], $form_data['transfer_payments'] ) ) {
                $json['payment_html'] = $this->getChild( 'payment/' . $payment_data['code'] );            
                $json['transfer_payments_selector'] = $form_data['transfer_payments_selector'][$payment_data['code']];
            }
*/
            unset( $this->session->data['shipping_method'] );
            unset( $this->session->data['shipping_methods'] );
            unset( $this->session->data['payment_method'] );
            unset( $this->session->data['payment_methods'] ); 
            unset( $this->session->data['reward'] );

            $json['button_close_text'] = $this->language->get( 'button_close_modal' );
        }
			if (!$json) {
			    $json['output'] = html_entity_decode( str_ireplace( $code_find, $code_replace, 'Заказ отправлен!' ), ENT_QUOTES, 'UTF-8' );
            }
            $json['test']='ok';
			
        $this->response->setOutput( json_encode( $json ) );
    }

    public function getProductWeight() {
        $weight = 0;

        if ( isset( $this->request->request['quantity'] ) ) {
            $quantity = (int) $this->request->request['quantity'];
        } else {
            $quantity = 1;
        }

        if ( isset( $this->request->request['product_id'] ) ) {
            $this->load->model( 'catalog/product' );
            
            $product_info = (array) $this->model_catalog_product->getProduct( $this->request->request['product_id'] );

            $weight = $this->weight->convert( $product_info['weight'], $product_info['weight_class_id'], $this->config->get( 'config_weight_class_id' ) ) * $quantity;
        }

        return $weight;
    }

    public function getProductSubTotal() {

        $sub_total    = 0;
        $option_price = 0;

        if ( isset( $this->request->request['quantity'] ) ) {
            $quantity = (int) $this->request->request['quantity'];
        } else {
            $quantity = 1;
        }

        if ( !empty( $this->request->request['option'] ) ) {
            $option = $this->request->request['option'];
        } else {
            $option = array();
        }

        if ( isset( $this->request->request['product_id'] ) ) {
            $this->load->model( 'catalog/product' );
            
            $product_options = (array) $this->model_catalog_product->getProductOptions( $this->request->request['product_id'] );
            $product_info    = (array) $this->model_catalog_product->getProduct( $this->request->request['product_id'] );
            foreach ( $product_options as $product_option ) {
                if ( is_array( $product_option['option_value'] ) ) {
                    foreach ( $product_option['option_value'] as $option_value ) {
                        if( isset($option[$product_option['product_option_id']] ) ) {
                            if( ( $option[$product_option['product_option_id']] == $option_value['product_option_value_id'] ) || ( ( is_array( $option[$product_option['product_option_id']] ) ) && ( in_array( $option_value['product_option_value_id'], $option[$product_option['product_option_id']] ) ) ) ) {
                                if ( $option_value['price_prefix'] == '+' ) {  
                                    $option_price += $option_value['price']; 
                                } elseif ( $option_value['price_prefix'] == '-' ) { 
                                    $option_price -= $option_value['price']; 
                                } elseif ( $option_value['price_prefix'] == '*' ) { 
                                    $option_price *= $option_value['price']; 
                                } elseif ( $option_value['price_prefix'] == '/' ) { 
                                    $option_price /= $option_value['price']; 
                                } elseif ( $option_value['price_prefix'] == '%' ) { 
                                    $option_price %= $option_value['price']; 
                                }
                            }
                        }
                    }
                }
            }

            $sub_total = $this->tax->calculate( $this->calculateDiscount( $this->request->request['product_id'], $quantity ), $product_info['tax_class_id'], $this->config->get( 'config_tax' ) ) * $quantity;
        }

        return $sub_total;
    }

    public function processing( $status = FALSE ) {

        if ( isset( $this->request->request['product_id'] ) && isset( $this->request->request['quantity'] ) ) {
            
            $this->load->model( 'catalog/product' );

            $form_data       = (array) $this->config->get( self::$_module_name . '_form_data' );
            $option_price    = 0;
            $product_id      = (int) $this->request->request['product_id'];
            $quantity        = (int) $this->request->request['quantity'];
            $product_info    = (array) $this->model_catalog_product->getProduct( $product_id );
            $product_options = (array) $this->model_catalog_product->getProductOptions( $product_id );
            $shipping_data   = (array) $this->getShippingData();
            $payment_data    = (array) $this->getPaymentData();
            $this->session->data['smch_product_sut_total'] = $this->getProductSubTotal();

            if ( isset( $shipping_data ) && isset( $this->request->request['shipping_method'] ) && !empty( $this->request->request['shipping_method'] ) ) {
                $shipping_cost = $shipping_data['cost'];
            } else {
                $shipping_cost = 0;
            }

            if ( !empty( $this->request->request['option'] ) ) {
                $option = $this->request->request['option'];
            } else {
                $option = array();
            }

            $stock = true;
            if (!$product_info['quantity'] || ($product_info['quantity'] < $quantity)) {
                $stock = false;
            }

            foreach ( $product_options as $product_option ) {
                
                if ( is_array( $product_option['option_value'] ) ) {
                    foreach ( $product_option['option_value'] as $option_value ) {
                        if( isset($option[$product_option['product_option_id']] ) ) {
                            if( ( $option[$product_option['product_option_id']] == $option_value['product_option_value_id'] ) || ( ( is_array( $option[$product_option['product_option_id']] ) ) && ( in_array( $option_value['product_option_value_id'], $option[$product_option['product_option_id']] ) ) ) ) {
                                if ( $option_value['price_prefix'] == '+' ) {  
                                    $option_price += $option_value['price']; 
                                } elseif ( $option_value['price_prefix'] == '-' ) { 
                                    $option_price -= $option_value['price']; 
                                } elseif ( $option_value['price_prefix'] == '*' ) { 
                                    $option_price *= $option_value['price']; 
                                } elseif ( $option_value['price_prefix'] == '/' ) { 
                                    $option_price /= $option_value['price']; 
                                } elseif ( $option_value['price_prefix'] == '%' ) { 
                                    $option_price %= $option_value['price']; 
                                }
                            }
                        }
                    }
                }
            }

            $json = array();

            $json['special'] = $this->currency->format( ( $this->tax->calculate( $this->calculateDiscount( $product_id, $quantity ), $product_info['tax_class_id'], $this->config->get( 'config_tax' ) ) * $quantity ) + $this->tax->calculate( $shipping_cost + ( $option_price * $quantity ), $product_info['tax_class_id'], $this->config->get( 'config_tax' ) ) );

            $json['price']   = $this->currency->format( ( $this->tax->calculate( $product_info['price'], $product_info['tax_class_id'], $this->config->get( 'config_tax' ) ) * $quantity ) + $this->tax->calculate( $shipping_cost + ( $option_price * $quantity ), $product_info['tax_class_id'], $this->config->get( 'config_tax' ) ) );

            $json['tax']     = $this->currency->format( ( $this->calculateDiscount( $product_id, $quantity ) + $option_price ) * $quantity );

            $json['total']   = $this->currency->format( ( $this->tax->calculate( $this->calculateDiscount( $product_id, $quantity ), $product_info['tax_class_id'], $this->config->get( 'config_tax' ) ) * $quantity ) + $this->tax->calculate( $shipping_cost + ( $option_price * $quantity ), $product_info['tax_class_id'], $this->config->get( 'config_tax' ) ) );

            $json['stock'] = $stock;

            if ( isset( $form_data['transfer_payments'] ) && $payment_data && in_array( $payment_data['code'], $form_data['transfer_payments'] ) ) {
                $this->session->data['order_id'] = 0;
				//$json['payment_html'] = $this->load->controller( 'payment/' . $payment_data['code'] );
				$json['payment_html'] = $this->getChild( 'payment/' . $payment_data['code'] );
            }         
            
            if ( $status == TRUE ) {
                return ( ( $this->tax->calculate( $this->calculateDiscount( $product_id, $quantity ), $product_info['tax_class_id'], $this->config->get( 'config_tax' ) ) * $quantity ) + $this->tax->calculate( $shipping_cost + ( $option_price * $quantity ), $product_info['tax_class_id'], $this->config->get( 'config_tax' ) ) );
            } else {
                $this->response->setOutput( json_encode( $json ) );
            }
        }
    }

    public function debug() {

        $form_data = (array) $this->config->get( self::$_module_name . '_form_data' );

        if ( isset( $this->request->get['info'] ) && isset( $form_data['allow_info'] ) && (string) $this->request->get['info'] == $form_data['info_key'] ) {
            return phpinfo();
        } elseif ( isset( $this->request->get['version'] ) && isset( $form_data['allow_info'] ) && (string) $this->request->get['version'] == $form_data['info_key'] ) {
            echo "OC Version: " . VERSION;
        } elseif ( isset( $this->request->get['mversion'] ) && isset( $form_data['allow_info'] ) && (string) $this->request->get['mversion'] == $form_data['info_key'] ) {
            echo "Module Version: " . self::$_module_version;
        } else {
            die();
        }
    }

    public function replaceValue( $view, $selector ) {

        $views = array(
            'text'       => 'text',
            'textarea'   => 'textarea',
            'email'      => 'text',
            'firstname'  => 'text',
            'lastname'   => 'text',
            'telephone'  => 'text',
            'fax'        => 'text',
            'company'    => 'text',
            'company_id' => 'text',
            'text_id'    => 'text',
            'address_1'  => 'text',
            'address_2'  => 'text',
            'city'       => 'text',
            'postcode'   => 'text',
            'country_id' => 'select',
            'zone_id'    => 'select',
            'comment'    => 'textarea',        
        );

        if ( $selector == 1 ) {
            foreach ( $views as $key => $value ) {
               if ( $key == $view ) {
                   return $value;
               }
            }
        } else {
            foreach ( $views as $key => $value ) {
               if ( $key == $view ) {
                   return $key;
               }
            }
        }
    }

    public function getActiveField() {

        $field_data = (array) $this->config->get( self::$_module_name . '_field_data' );

        foreach ( $field_data as $key => $field ) {
            
            if ( $field['activate'] == 0 ) { 
                unset( $field_data[$key] );
            }
        }

        return $field_data;
    }

    public function getShippingData() {

        $zone_data = $this->getZoneId();

        $shipping_data = array( 'code' => '', 'title' => '' );

        if ( isset( $this->request->request['shipping_method'] ) && !empty( $this->request->request['shipping_method'] ) ) {

            $shipping = explode('.', $this->request->request['shipping_method']);

            $this->session->data['shipping_method'] = $this->session->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]];

            if ( isset( $shipping[0] ) && !empty( $shipping[0] ) ) {

                $this->load->model( 'shipping/' . $shipping[0] );

                if ( isset( $this->request->request['country_id'] ) && isset( $zone_data[0] ) ) {
                    $quote = $this->{'model_shipping_' . $shipping[0]}->getQuote( 
                        array( 
                            'country_id' => $this->request->request['country_id'], 
                            'zone_id'    => $zone_data[0]
                        )
                    );
                } else {
                    $quote = $this->{'model_shipping_' . $shipping[0]}->getQuote( array( 'country_id' => 0, 'zone_id' => 0 ) );
                }
                
                if ( $quote ) {
                    $shipping_data = $quote;
                }

                $shipping_data = $shipping_data['quote'][$shipping[1]];
            }
        }
        $this->session->data['smch_product_weight'] = $this->getProductWeight();

        return $shipping_data;
    }

    public function getPaymentData() {

        $zone_data = $this->getZoneId();

        $payment_data = array();

        if ( isset( $this->request->request['payment_method'] ) && !empty( $this->request->request['payment_method'] ) ) {
            
            $this->load->model( 'payment/' . $this->request->request['payment_method'] );
            
            if ( isset( $this->request->request['country_id'] ) && isset( $zone_data[0] ) ) {
                $method = $this->{'model_payment_' . $this->request->request['payment_method']}->getMethod( 
                    array( 
                        'country_id' => $this->request->request['country_id'], 
                        'zone_id'    => $zone_data[0]
                    ), true
                );
            } else {
                $method = $this->{'model_payment_' . $this->request->request['payment_method']}->getMethod( 
                    array( 
                        'country_id' => 0, 
                        'zone_id'    => 0 
                    ), true
                );
            }
           
            if ( $method ) {
                $payment_data = $method;
            }
            return $payment_data;
        } else {
            return $payment_data = array( 'code' => '', 'title' => '' );
        }
    }

    public function getZoneId() {

        $zone = 0;

        if ( isset( $this->request->request['zone_id'] ) && !empty( $this->request->request['zone_id'] ) ) {
            $zone = explode( ',', $this->request->request['zone_id'] );
            $this->session->data['payment_zone_id'] = $zone[0];
        }
        return $zone;
    }

    public function getCountryData() {

        if ( isset( $this->request->request['country_id'] ) && !empty( $this->request->request['country_id'] ) ) {

            $this->load->model( 'localisation/country' );

            $country_info = $this->model_localisation_country->getCountry( $this->request->request['country_id'] );

            if ( $country_info ) {
                $this->load->model( 'localisation/zone' );

                $country_data = array(
                    'country_id'        => $country_info['country_id'],
                    'name'              => $country_info['name'],
                    'iso_code_2'        => $country_info['iso_code_2'],
                    'iso_code_3'        => $country_info['iso_code_3'],
                    'address_format'    => $country_info['address_format'],
                    'postcode_required' => $country_info['postcode_required'],
                    'zone'              => $this->model_localisation_zone->getZonesByCountryId( $this->request->request['country_id'] ),
                    'status'            => $country_info['status']      
                );
            }
            return $country_data;
        } else {
            return $country_data = array( 'name' => '' );
        }
    }

    public function calculateDiscount( $product_id, $quantity ) {

        $this->load->model( 'catalog/product' );

        $form_data  = (array) $this->config->get( self::$_module_name . '_form_data' );

        $customer_group_id = ( $this->customer->isLogged() ) ? (int) $this->customer->getCustomerGroupId() : (int) $this->config->get( 'config_customer_group_id' );

        $product_info = (array) $this->model_catalog_product->getProduct( $product_id );

        $price = $product_info['price'];

        // product discount
  
        if ( isset( $form_data['discount_status'] ) ) {
            $product_discount_query = $this->db->query( "SELECT price FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int) $product_id . "' AND customer_group_id = '" . (int) $customer_group_id . "' AND quantity <= '" . (int) $quantity . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY quantity DESC, priority ASC, price ASC LIMIT 1" );
            if ( $product_discount_query->num_rows ) {
                $price = $product_discount_query->row['price'];
            }
        }

        // product specials

        $product_special_query = $this->db->query( "SELECT price FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int) $product_id . "' AND customer_group_id = '" . (int) $customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC LIMIT 1" );

        if ( $product_special_query->num_rows ) {
            $price = $product_special_query->row['price'];
        }       

        return $price;
    }

    public function getProducts() {

        $customer_group_id = ( $this->customer->isLogged() ) ? (int) $this->customer->getCustomerGroupId() : (int) $this->config->get( 'config_customer_group_id' );

        $cache_data = md5( http_build_query( $this->request->request ) );
        $json = $this->cache->get( 'ocdevwizard_smch.' . (int) $this->config->get( 'config_language_id' ) . '.' . (int) $this->config->get( 'config_store_id' ) . '.' . $customer_group_id . '.' . $cache_data );
        
        if( !$json ) {
            $json = array();

            $form_data = (array) $this->config->get( self::$_module_name . '_form_data' );
            $text_data = (array) $this->config->get( self::$_module_name . '_text_data' );

            $this->load->model( 'catalog/product' );

            $json['add_function_selector'] = $form_data['add_function_selector'];
            $json['add_id_selector'] = $form_data['add_id_selector'];

            $language_code = $this->session->data['language'];

            if ( isset( $text_data[$language_code] ) ) {
                $json['text_call_button'] = $text_data[$language_code]['call_button'];
            }    

            $json['products'] = array();

            if ( isset( $this->request->request['smch_product_ids'] ) ) {

                $results = explode( ",", $this->request->request['smch_product_ids'] );

                foreach( $results as $result ) {
                    if ( isset( $form_data['stock_validate'] ) ) {
                        $product_info = $this->model_catalog_product->getProduct( (int) $result );
                        if ( $product_info['quantity'] > 0 ) {
                            $json['products'][] = (int) $result;
                        }
                    } else {
                        $json['products'][] = (int) $result;
                    }
                }

                $json['products'] = array_unique( $json['products'] );

                if ( isset( $this->request->request['routing'] ) && $this->request->request['routing'] == 'product/product' && isset( $this->request->request['product_id'] ) ) {

                    $product_info = $this->model_catalog_product->getProduct( (int) $this->request->request['product_id'] );

                    if ( isset( $form_data['stock_validate'] ) ) {
                        if ( $product_info['quantity'] > 0 ) {
                            $json['product'][] = (int) $this->request->request['product_id'];
                        }
                    } else {
                        $json['product'][] = (int) $this->request->request['product_id'];
                    } 
                }
            }

            $this->cache->set( 'ocdevwizard_smch.' . (int) $this->config->get( 'config_language_id' ) . '.' . (int) $this->config->get( 'config_store_id' ). '.' . $customer_group_id . '.' . $cache_data, $json );

        }

        $this->response->setOutput( json_encode( $json ) );
    }

    public function captcha() {
        $this->load->library( 'captcha' );
        $captcha = new Captcha();
        $this->session->data['require_captcha'] = $captcha->getCode();
        $captcha->showImage();
    }   

    // end magic ... 100%
    // to be continued...
}
?>
