<?php

// @category  : OpenCart
// @module    : Smart Checkout
// @author    : OCdevWizard <ocdevwizard@gmail.com> 
// @copyright : Copyright (c) 2014, OCdevWizard
// @license   : http://license.ocdevwizard.com/Licensing_Policy.pdf

class ControllerModuleOCdevSmartCheckout extends Controller {

    private $error              = array(); 
    static  $_module_version    = '1.0.5';
    static  $_module_name       = 'ocdev_smart_checkout'; 

    public function index() {  

        // connect models array

        $models = array( 'setting/store', 'setting/setting', 'setting/extension', 'catalog/category', 'catalog/manufacturer', 'catalog/information', 'sale/customer_group', 'localisation/language', 'localisation/order_status', 'localisation/country', 'catalog/option' );
        foreach ( $models as $model ) {
            $this->load->model( $model );
        } 

        $this->data = array_merge( $this->data, $this->language->load( 'module/' . self::$_module_name ) );
        $this->document->setTitle( $this->language->get( 'heading_name' ) );
        
        $scripts = array( 'bootstrap.min.js', 'bootstrap-checkbox.min.js', 'button.js', 'tab.js' );
        foreach ( $scripts as $script ) {
            $this->document->addScript( 'view/javascript/' . self::$_module_name . '/' . $script );
        }

        $styles = array( 'bootstrap.css', 'bootstrap-theme.css', 'stylesheet.css' );
        foreach ( $styles as $style ) {
            $this->document->addStyle( 'view/stylesheet/' . self::$_module_name . '/' . $style );
        }
        
        if( $this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate() ) {                  
            $this->session->data['success'] = $this->language->get( 'text_success' );
            $this->model_setting_setting->editSetting( self::$_module_name, $this->request->post );               
            $this->redirect( $this->url->link( 'module/' . self::$_module_name, 'token=' . $this->session->data['token'], 'SSL' ) );
        }

        $this->data['error_warning'] = ( isset( $this->error['warning'] ) ) ? $this->error['warning'] : '';
        $this->data['error_text'] = ( isset( $this->error['text'] ) ) ? $this->error['text'] : array();
        $this->data['error_data_fields'] = ( isset( $this->error['data_fields'] ) ) ? $this->error['data_fields'] : array();

        if ( isset( $this->session->data['success'] ) ) {
            $this->data['success'] = $this->session->data['success'];
        
            unset( $this->session->data['success'] );
        } else {
            $this->data['success'] = '';
        }

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get( 'text_home' ),
            'href'      => $this->url->link( 'common/home', 'token=' . $this->session->data['token'], 'SSL' ),
            'separator' => false
        );
        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get( 'text_module' ),
            'href'      => $this->url->link( 'extension/module', 'token=' . $this->session->data['token'], 'SSL' ),
            'separator' => ' :: '
        );
        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get( 'heading_title' ),
            'href'      => $this->url->link( 'module/' . self::$_module_name, 'token=' . $this->session->data['token'], 'SSL' ),
            'separator' => ' :: '
        );
        
        $this->data['action'] = $this->url->link( 'module/' . self::$_module_name, 'token=' . $this->session->data['token'], 'SSL' );
        $this->data['cancel'] = $this->url->link( 'extension/module', 'token=' . $this->session->data['token'], 'SSL' );
        $this->data['cache'] = $this->url->link( 'module/' . self::$_module_name . '/clear_cache', 'token=' . $this->session->data['token'], 'SSL' );
        $this->data['admin_language']  = $this->config->get('config_admin_language');
        $this->data['_module_name']    = (string) self::$_module_name;
        $this->data['_module_version'] = (string) self::$_module_version;

        $this->data['text_data'] = isset( $this->request->post[self::$_module_name . '_text_data'] ) ? $this->request->post[self::$_module_name . '_text_data'] : $this->config->get( self::$_module_name . '_text_data' );
        $this->data['form_data'] = isset( $this->request->post[self::$_module_name . '_form_data'] ) ? $this->request->post[self::$_module_name . '_form_data'] : $this->config->get( self::$_module_name . '_form_data' );

        if ( isset( $this->request->post[self::$_module_name . '_field_data'] ) ) {
            $field_datas = $this->request->post[self::$_module_name . '_field_data'];
        } elseif ( $this->config->get( self::$_module_name . '_field_data' ) ) {
            $field_datas = $this->config->get( self::$_module_name . '_field_data' );
        } else {
            $field_datas = array( 0 );
        }

        $this->data['field_view_data'] = array(
            'text'        => $this->language->get('text_field_simple_text'),
            'textarea'    => $this->language->get('text_field_simple_textarea'),
            'email'       => $this->language->get('text_field_email'),
            'firstname'   => $this->language->get('text_field_firstname'),
            'lastname'    => $this->language->get('text_field_lastname'),
            'telephone'   => $this->language->get('text_field_telephone'),
            'fax'         => $this->language->get('text_field_fax'),
            'company'     => $this->language->get('text_field_company'),
            'company_id'  => $this->language->get('text_field_company_id'),
            'address_1'   => $this->language->get('text_field_address_1'),
            'address_2'   => $this->language->get('text_field_address_2'),
            'city'        => $this->language->get('text_field_city'),
            'postcode'    => $this->language->get('text_field_postcode'),
            'country_id'  => $this->language->get('text_field_country_id'),
            'zone_id'     => $this->language->get('text_field_zone_id'),
            'comment'     => $this->language->get('text_field_comment')
        );

        $this->data['field_data'] = array();

        foreach ( $field_datas as $field ) {
            $this->data['field_data'][] = array(
                'sort_order'        => $field['sort_order'],
                'activate'          => $field['activate'],
                'title'             => $field['title'],
                'view'              => $field['view'],
                'check'             => $field['check'],
                'check_rule'        => $field['check_rule'],
                'check_min'         => $field['check_min'],
                'check_max'         => $field['check_max'],
                'error_text'        => $field['error_text'],
                'css_id'            => $field['css_id'],
                'css_class'         => $field['css_class'],
                'position'          => $field['position']
            );
        }      

        $this->data['product_options'] = array();

        $allowed_types = array( 'file' );

        foreach ( $this->model_catalog_option->getOptions() as $product_option ) {
            if ( !in_array( $product_option['type'], $allowed_types ) ) {
                $this->data['product_options'][] = array(
                    'option_id'  => $product_option['option_id'],
                    'name'       => $product_option['name']
                );   
            }           
        }

        $default_store = array( 0 => array( 'store_id' => 0, 'name' => $this->config->get( 'config_name' ) . ' (Default)' ) );

        $all_stores = array_merge( $this->model_setting_store->getStores(), $default_store );

        $this->data['all_stores'] = array();
        
        foreach ( $all_stores as $store ) {
            $this->data['all_stores'][] = array(
                'store_id' => $store['store_id'],
                'name'     => $store['name']
            );
        }

        $this->data['all_customer_groups'] = array();
        
        foreach ( $this->model_sale_customer_group->getCustomerGroups() as $customer_group ) {
            $this->data['all_customer_groups'][] = array(
                'customer_group_id' => $customer_group['customer_group_id'],
                'name'              => $customer_group['name']
            );
        }

        $payments = $this->model_setting_extension->getInstalled( 'payment' );

        $this->data['payments'] = array();
    
        foreach ( $payments as $payment ) {
            if ( $payment ) {

                $this->load->language( 'payment/' . $payment );

                $this->data['payments'][] = array(
                    'code' => $payment,
                    'name' => $this->language->get( 'heading_title' )
                );
            }
        }

        $shippings = $this->model_setting_extension->getInstalled( 'shipping' );

        $this->data['shippings'] = array();
    
        foreach ( $shippings as $shipping ) {
            if ( $shipping ) {

                $this->load->language( 'shipping/' . $shipping );

                $this->data['shippings'][] = array(
                    'code' => $shipping,
                    'name' => $this->language->get( 'heading_title' )
                );
            }
        }

        $this->data['order_statuses'] = array(); 
        
        foreach ( $this->model_localisation_order_status->getOrderStatuses() as $status ) {
            $this->data['order_statuses'][] = array(
                'status_id' => $status['order_status_id'],
                'name'      => $status['name']
            );
        }

        $this->data['backgrounds'] = array();

        if ( $this->get_background() ) {
            foreach ( $this->get_background() as $background ) {
                $name_string = explode("/", $background);
                $name = array_pop($name_string);
                $this->data['backgrounds'][] = array(
                    'src'  => $background,
                    'name' => $name
                );
            }
        }

        $this->data['countries_data'] = array();

        foreach ( $this->model_localisation_country->getCountries() as $country ) {
            $this->data['countries_data'][] = array(
                'country_id' => $country['country_id'],
                'name'       => $country['name'] . ( ($country['country_id'] == $this->config->get( 'config_country_id' ) ) ? $this->language->get( 'text_default' ) : null )
               
            );
        }

        $this->data['informations'] = array();

        foreach ( $this->model_catalog_information->getInformations() as $information ) {
            $this->data['informations'][] = array(
                'information_id' => $information['information_id'],
                'title'          => $information['title']
            );
        }   
        
        $this->data['languages'] = $this->model_localisation_language->getLanguages();

        $this->template = 'module/' . self::$_module_name . '.tpl';

        $this->children = array(
            'common/header',
            'common/footer'
        );      

        $this->response->setOutput( $this->render() );
    }

    public function install() {   

        // connect language data

        $text_form = $this->language->load( 'module/' . self::$_module_name );
        
        // connect model data

        $models = array( 'setting/setting', 'setting/extension', 'localisation/country' );
        foreach ( $models as $model ) {
            $this->load->model( $model );
        }
        
        // add countries to default settings

        $countries_id = array();

        foreach ( $this->model_localisation_country->getCountries() as $country ) {
            $countries_id[] = array( $country['country_id'] );
        }

        // set default data
        
        $this->model_setting_setting->editSetting( self::$_module_name, array(
            self::$_module_name . '_text_data' => array(
                $this->config->get('config_admin_language') => array( 
                    'heading'       => $this->language->get('default_heading'),
                    'call_button'   => $this->language->get('default_call_button'),
                    'success_text'  => $this->language->get('default_success_text')
                ),
            ),
            self::$_module_name . '_form_data' => array(
                'activate'                      => '1',
                'stock_validate'                => '1',
                'require_shipping_method'       => '1',
                'require_payment_method'        => '1',
                'telephone_mask'                => '',
                'alternative_email'             => (string) $this->config->get( 'config_email' ),
                'prefix_order'                  => 'OCdevWizard_smart_checkout: ',
                'add_function_selector'         => 'addToCart',
                'add_id_selector'               => 'button-cart',
                'hide_main_img'                 => '1',
                'main_image_width'              => '215',
                'main_image_height'             => '180',
                'hide_sub_img'                  => '1',
                'sub_images_width'              => '50',
                'sub_images_height'             => '50',
                'count_sub_images'              => '6',
                'option_images_width'           => '30',
                'option_images_height'          => '30',
                'discount_status'               => '1',
                'hide_table_info'               => '1',
                'hide_product_options'          => '1',
                'hide_product_attributes'       => '1',
                'hide_product_description'      => '1',
                'hide_product_model'            => '1',
                'style_beckground'              => 'bg_7.png',
                'background_opacity'            => '0.7',
                'google_event_category'         => 'Smart Checkout',
                'google_event_action'           => 'Success',
                'google_analytics_script'       => '',
                'stores'                        => array(),
                'customer_groups'               => array(),
                'product_countries'             => (array) $countries_id,
                'front_module_name'             => str_replace( array( '<b>','</b>' ), "", $text_form['heading_title'] ),
                'front_module_version'          => (string) self::$_module_version
            ),
            self::$_module_name . '_field_data' => array(
                0 => array( 
                    'sort_order' => '1',
                    'activate'   => '1',
                    'title'      => array( $this->config->get('config_admin_language') => 'Your name' ),
                    'view'       => 'firstname',
                    'check'      => '0',
                    'check_rule' => '',
                    'check_min'  => '',
                    'check_max'  => '',
                    'error_text' => array( $this->config->get('config_admin_language') => 'This is a required field!' ),
                    'css_id'     => '',
                    'css_class'  => '',
                    'position'   => '1',
                ),
                1 => array( 
                    'sort_order' => '2',
                    'activate'   => '1',
                    'title'      => array( $this->config->get('config_admin_language') => 'E-mail' ),
                    'view'       => 'email',
                    'check'      => '1',
                    'check_rule' => '',
                    'check_min'  => '',
                    'check_max'  => '',
                    'error_text' => array( $this->config->get('config_admin_language') => 'This is a required field!' ),
                    'css_id'     => '',
                    'css_class'  => '',
                    'position'   => '2',
                )
            )
        ));        

        if ( !in_array( self::$_module_name, $this->model_setting_extension->getInstalled( 'module' ) ) ) {
            $this->model_setting_extension->install( 'module', self::$_module_name );
        }
        
        $this->session->data['success'] = $text_form['text_success_install'];

        $this->redirect( $this->url->link( 'module/' . self::$_module_name, 'token=' . $this->session->data['token'], 'SSL' ) );
    }

    private function validate() {
        
        $text_form = $this->language->load( 'module/' . self::$_module_name );

        if ( !$this->user->hasPermission( 'modify', 'module/' . self::$_module_name ) ) {
            $this->error['warning'] = $text_form['error_permission'];
        }

        foreach ( $this->request->post[self::$_module_name . '_text_data'] as $language_code => $value ) {
            if ( ( utf8_strlen( $value['heading'] ) < 1) || ( utf8_strlen( $value['heading'] ) > 255 ) ) {
                $this->error['text'][$language_code] = sprintf($text_form['error_text_field'], $text_form['text_module_heading'], $language_code );
            }
            if ( ( utf8_strlen( $value['call_button'] ) < 1) || ( utf8_strlen( $value['call_button'] ) > 255 ) ) {
                $this->error['text'][$language_code] = sprintf($text_form['error_text_field'], $text_form['text_module_call_button'], $language_code );
            }
            if ( ( utf8_strlen( $value['success_text'] ) < 1 ) || ( utf8_strlen( $value['success_text'] ) > 5000 ) ) {
                $this->error['text'][$language_code] = sprintf($text_form['error_text_field'], $text_form['text_result_message'], $language_code );
            }
        }

        foreach ( $this->request->post[self::$_module_name . '_form_data'] as $key => $value ) {
            if ( empty( $value ) && $key == "add_function_selector" ) {
                $this->error['data_fields'][$key] = sprintf($text_form['error_data_field'], $text_form['text_add_function_selector'] );
            }
            if ( empty( $value ) && $key == "add_id_selector" ) {
                $this->error['data_fields'][$key] = sprintf($text_form['error_data_field'], $text_form['text_add_id_selector'] );
            }
        }

        return ( !$this->error ) ? TRUE : FALSE;
    }

    private function cacheCheck( $dir, $location ) {
        if ( $location == 1 ) {
            return !is_dir( DIR_SYSTEM . $dir ) || !is_writable( DIR_SYSTEM . $dir ) ? false : true;
        } else {
            return !is_dir( DIR_IMAGE . $dir ) || !is_writable( DIR_IMAGE . $dir ) ? false : true;
        }
    }

    public function clear_cache() {

        $text_form = $this->language->load( 'module/' . self::$_module_name );

        $check_dir = 'cache';

        if( !$this->cacheCheck( $check_dir, 1 ) ) {
            $this->error['warning'] = $text_form['error_cache_folter'];
        } else {    
            $dir   = opendir( DIR_SYSTEM . $check_dir );
            $count = 0;

            while ( ( $file = readdir( $dir ) ) !== FALSE ) {
                if( strlen( $file ) > 22 && strpos( $file, 'cache.ocdevwizard_smch' ) === 0 ) {
                    unlink( DIR_SYSTEM . $check_dir . '/' . $file ); 
                    $count++;
                }
            }

            closedir( $dir );

            $this->session->data['success'] = sprintf( $text_form['success_clear_cache_folder'], $count );
            $this->redirect( $this->url->link( 'module/' . self::$_module_name, 'token=' . $this->session->data['token'], 'SSL' ) );
        }
    }

    public function get_background() {

        $text_form = $this->language->load( 'module/' . self::$_module_name );

        $check_dir = 'ocdev_smart_checkout/background';

        $backgrounds = array();

        if( !$this->cacheCheck( $check_dir, 2 ) ) {
            $this->error['warning'] = $text_form['error_cache_folter'];
        } else {    
            $dir   = opendir( DIR_IMAGE . $check_dir );
            
            while ( ( $file = readdir( $dir ) ) !== FALSE ) {
                if ( in_array( substr( strrchr( $file, '.' ), 1 ), array( 'png', 'jpg' ) ) ) {
                    $backgrounds[] = ( '/image/' . $check_dir . '/' . $file ); 
                }
            }

            closedir( $dir );

            return $backgrounds;
        }
    }
}
?>