<?php
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

// Configuration
if (file_exists('config.php')) {
	require_once('config.php');
}  

// VQMODDED Startup
require_once(DIR_SYSTEM . 'startup.php');

// Application Classes
require_once(DIR_SYSTEM . 'library/customer.php');
require_once(DIR_SYSTEM . 'library/affiliate.php');
require_once(DIR_SYSTEM . 'library/currency.php');
require_once(DIR_SYSTEM . 'library/tax.php');
require_once(DIR_SYSTEM . 'library/weight.php');
require_once(DIR_SYSTEM . 'library/length.php');
require_once(DIR_SYSTEM . 'library/cart.php');

// Registry
$registry = new Registry();

// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);

// Config
$config = new Config();
$registry->set('config', $config);

// Database 
$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
$registry->set('db', $db);

// Response
$response = new Response();
$response->addHeader('Content-Type:text/xml');
$response->setCompression($config->get('config_compression'));
$registry->set('response', $response); 


header('Content-Type:text/xml');
$price[]='<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE yml_catalog SYSTEM "shops.dtd">
<yml_catalog date="'.date('Y-m-d H:i').'">
<shop>
<name>LOTTO UKRAINE</name>
<company>Официальный интернет магазин LOTTO</company>
<url>'.HTTP_SERVER.'</url>
<currencies>
<currency id="UAH" rate="1"/>
</currencies>
<categories>';

$sql = 'SELECT c.category_id, c.parent_id, cd.name FROM ' . DB_PREFIX . 'category c LEFT JOIN '
		.DB_PREFIX.'category_description cd ON c.category_id=cd.category_id WHERE c.status=\'1\'
		AND cd.language_id=\'5\' ';
$query = $db->query($sql);
foreach ($query->rows as $result) {
	if($result['category_id'] != 59 && $result['category_id'] != 233 && $result['category_id'] != 226 && $result['category_id'] != 227) {
		$price[] = '<category id="'.$result['category_id'].'"';
		if($result['parent_id'] != 0) { 
			$price[] = ' parentId="'.$result['parent_id'].'">'.$result['name'].'</category>';
		} else {
			$price[] = '>'.$result['name'].'</category>';
		}
	}
}
$price[] = '</categories>
<offers>';

$sql="SELECT *
	FROM ". DB_PREFIX ."product_to_category p2c 
	LEFT JOIN ". DB_PREFIX ."product p ON (p2c.product_id = p.product_id) 
	LEFT JOIN ". DB_PREFIX ."product_description pd ON (p.product_id = pd.product_id) 
	LEFT JOIN ". DB_PREFIX ."product_to_store p2s ON (p.product_id = p2s.product_id)
	WHERE p.status = '1' AND p.date_available <= NOW() AND p2c.main_category = 1 AND pd.language_id=5 AND p.quantity > 0";
$query = $db->query($sql);
foreach ($query->rows as $row) {
	
	// GETTING URL ALIAS OF PRODUCT
	$sql1 = "SELECT * FROM ". DB_PREFIX ."url_alias WHERE query = 'product_id={$row['product_id']}' ";
	$query1 = $db->query($sql1);
	foreach ($query1->rows as $row1) {
		
		//	GETTING URL ALIAS OF CATEGORY
		$sql2 = "SELECT * FROM ". DB_PREFIX ."url_alias WHERE query = 'category_id={$row['category_id']}' ";
		$query2 = $db->query($sql2);
		foreach ($query2->rows as $row2) {
			
			$price[] = '<offer id="'.$row['sku'].'" available="true">';
			
			$price[] = '<url>'.HTTP_SERVER.''.$row2['keyword'].'/'.$row1['keyword'].'</url>
						<picture>'.HTTP_SERVER.'image/'.$row['image'].'</picture>';
			
			// GETTING ADDITIONAL IMAGES
			$sql3 = 'SELECT image FROM '. DB_PREFIX .'product_image WHERE product_id = '.$row['product_id'];
			$query3 = $db->query($sql3);
			foreach ($query3->rows as $row3) {
				$price[] = '<picture>'.HTTP_SERVER.'image/'.$row3['image'].'</picture>';
			}
			
			$price[] = '<store>true</store>';						
			
			$price[] = '<pickup>true</pickup>';						
			
			$price[] = '<delivery>true</delivery>';						
			
			$price[] = '<name>'.$row['name'].'</name>						
						<categoryId>'.$row['category_id'].'</categoryId>';
					
			// GETTING SPECIAL PRICE
			$sql4 = 'SELECT price FROM '. DB_PREFIX .'product_special WHERE product_id = '.$row['product_id'];
			$query4 = $db->query($sql4);
			if($query4->rows) {
				foreach ($query4->rows as $row4) {
					$price[]='<price>'.(int)$row4['price'].'</price>';
				}
				$price[] = '<oldprice>'.(int)$row['price'].'</oldprice>';
			} else {
				$price[]='<price>'.(int)$row['price'].'</price>';
			}
			
			$price[] = '<currencyId>UAH</currencyId>
						<vendor>LOTTO</vendor>';
			
			// GETTING PRODUCT OPTIONS
			$sql5 = 'SELECT option_value_id, option_id FROM '. DB_PREFIX .'product_option_value WHERE product_id = '.$row['product_id'].' AND quantity > 0';
			$query5 = $db->query($sql5);
			if($query5->rows) {
				$i=1;
				$price[] = '<param name="Размер">';
				foreach ($query5->rows as $row5) {
					
					$option_id = $row5['option_id'];
					$option_value_id = $row5['option_value_id'];
					
					$sql6 = 'SELECT name FROM '. DB_PREFIX .'option_value_description WHERE option_value_id = '.$row5['option_value_id'].' AND language_id = 5';
					$query6 = $db->query($sql6);
					foreach ($query6->rows as $row6) {
						switch($option_id){
							case 13: if($option_value_id != 49 && $option_value_id != 149) {	 //размер перчаток
										$size_unit = "US";
										} else {
											$size_unit = "INT";
											$row6['name'] = "UNI";
										} 
										break;
							case 14: $size_unit = "EU"; break; 		//размер обуви EUR
							case 15: switch($option_value_id){	 	//размер носков
										case 126: $row6['name'] = "XS"; break;
										case 127: $row6['name'] = "S"; break;
										case 128: $row6['name'] = "M"; break;
										case 129: $row6['name'] = "L"; break;
										case 130: $row6['name'] = "XL"; break;
										case 131: $row6['name'] = "XXL"; break;
										}
									 $size_unit = "INT"; break;
							case 16: $size_unit = "INT"; break; //размер одежды детский
							case 17: $size_unit = "INT"; break; //размер одежды + текстиль
							case 22: $size_unit = "EU"; break; //размер обуви детский EUR
						}
					}
					
					if($i < count($query5->rows)){
						$price[] = $row6['name'].', ';
					} else {
						$price[] = $row6['name'];
					}
					$i++;
				}
				$price[] = '</param>';
			}	
				
			//  GETTING PRODUCT ATTRIBUTES: COLOR
			$sql7 = 'SELECT text FROM '. DB_PREFIX .'product_attribute WHERE product_id = '.$row['product_id'].' AND attribute_id = 11 AND language_id = 5';
			$query7 = $db->query($sql7);
				if($query7->rows) {
					foreach ($query7->rows as $row7) {
						$price[]='<param name="Цвет">'.$row7['text'].'</param>';
					}
				}
			
			//  GETTING PRODUCT ATTRIBUTES: GENDER
			$sql8 = 'SELECT tag FROM '. DB_PREFIX .'product_description WHERE product_id = '.$row['product_id'].' AND language_id = 5';
			$query8 = $db->query($sql8);
				if($query8->rows) {
					foreach ($query8->rows as $row8) {
						if($row8['tag'] == "Мужчины" || $row8['tag'] == "Мальчики") {
							$price[]='<param name="Пол">Мужской</param>';
						} elseif ($row8['tag'] == "Женщины" || $row8['tag'] == "Девочки") {
							$price[]='<param name="Пол">Женский</param>';
						}
					}
				}
			
			//  GETTING PRODUCT ATTRIBUTES: MATERIAL				
			$sql10 = 'SELECT text FROM '. DB_PREFIX .'product_attribute WHERE product_id = '.$row['product_id'].' AND attribute_id = 10 AND language_id = 5';
			$query10 = $db->query($sql10);
				if($query10->rows) {
					foreach ($query10->rows as $row10) {
						$price[]='<param name="Материал">'.$row10['text'].'</param>';
					}
				}
			
			$price[] = '<description>'.strip_tags(preg_replace("/Перейдя на страницу.*(.*)этой категории\.?/i", "", $row['description'])).'</description>';
			
			$price[]='<vendorCode>'.$row['sku'].'</vendorCode>';
			
			$price[]='</offer>';
			
		}
	}
}


$price[]='</offers>
</shop>
</yml_catalog>';
//echo join('',$price);

$file = 'lotto_price_admitad.xml';
file_put_contents($file, $price);

?>
