<?
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
$price[]='<?xml version="1.0" encoding="utf-8"?><torg_price date="'.date('Y-m-d H:i').'"><shop>
<shopname>Официальный интернет магазин LOTTO</shopname>
<company>LOTTO UKRAINE</company>
<url>'.HTTP_SERVER.'</url>
<currencies>
<currency id="UAH" rate="1"/>
</currencies>
<categories>
';

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

$price[]='</categories><offers>';

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

			//  GETTING PRODUCT ATTRIBUTES: RANGE (Номенклатура)
			$sql7 = 'SELECT text FROM '. DB_PREFIX .'product_attribute WHERE product_id = '.$row['product_id'].' AND attribute_id = 13 AND language_id = 5';
			$query7 = $db->query($sql7);
				if($query7->rows) {
					foreach ($query7->rows as $row7) {
						$price[]='<typePrefix>'.$row7['text'].'</typePrefix>';
					}
				}
			
			$price[] = '<name>'.htmlspecialchars($row['name']).'</name>						
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
			
			$price[] = '<description>'.strip_tags(preg_replace("/Перейдя на страницу.*(.*)этой категории\.?/i", "", $row['description'])).'</description>';
			
			$price[]='<vendorCode>'.$row['sku'].'</vendorCode>';
			
			$price[] = '<pickup>true</pickup>';						
			
			$price[] = '<delivery>true</delivery>';
			
			$price[]='</offer>';
			
		}
	}
}

$price[]='</offers>
</shop>
</torg_price>';
echo join('',$price);
//var_dump($price);



?>
