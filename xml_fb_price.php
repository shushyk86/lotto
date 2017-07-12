<?
ini_set('max_execution_time', 900);
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
require_once(DIR_SYSTEM . 'library/image.php');

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
<feed xmlns="http://www.w3.org/2005/Atom" xmlns:g="http://base.google.com/ns/1.0">
<title>Официальный интернет магазин LOTTO</title>
<link rel="self" href="'.HTTP_SERVER.'"/>';

$sql='SELECT *
	FROM oc_product_to_category p2c 
	LEFT JOIN oc_product p ON (p2c.product_id = p.product_id) 
	LEFT JOIN oc_product_description pd ON (p.product_id = pd.product_id) 
	LEFT JOIN oc_product_to_store p2s ON (p.product_id = p2s.product_id)
	WHERE p.status = \'1\' AND p.date_available <= NOW() AND p.quantity > 0
	GROUP BY p.product_id ORDER BY p.sort_order ASC, LCASE(pd.name) ASC';
$query = $db->query($sql);
foreach ($query->rows as $row) {
	if($row['name']){
		$sql0 = "SELECT name FROM oc_manufacturer WHERE manufacturer_id = " . $row['manufacturer_id'];
		$query0 = $db->query($sql0);

			// GETTING URL ALIAS OF PRODUCT
			$sql1 = "SELECT * FROM oc_url_alias WHERE query = 'product_id={$row['product_id']}' ";
			$query1 = $db->query($sql1);
			foreach ($query1->rows as $row1) {
				//	GETTING URL ALIAS OF CATEGORY
				$sql2 = "SELECT * FROM oc_url_alias WHERE query = 'category_id={$row['category_id']}' ";
				$query2 = $db->query($sql2);
				foreach ($query2->rows as $row2) {
				
			$price[]='<entry><g:id>'.$row['sku'].'</g:id>
			<g:title>'.$row['name'].'</g:title>
			<g:description>'.strip_tags($row['description']).'</g:description>
			<g:link>'.HTTP_SERVER.''.$row2['keyword'].'/'.$row1['keyword'].'</g:link>';

					$img = resize($row['image'], 600, 600);

			$price[] = '<g:image_link>'.HTTP_SERVER. $img .'</g:image_link>
			<g:brand>Lotto</g:brand>
			<g:condition>new</g:condition>
			<g:availability>'.($row['quantity']>0?'in stock':'preorder').'</g:availability>
			<g:price>'.(int)$row['price'].' UAH</g:price>';
			// GETTING SPECIAL PRICE
			$sql3 = 'SELECT * FROM oc_product_special WHERE product_id = '.$row['product_id'];
			$query3 = $db->query($sql3);
			foreach ($query3->rows as $row3) {
				if($row3['price']){
					$price[]='<g:sale_price>'.(int)$row3['price'].' UAH</g:sale_price>';
				}
			}
				$price[]='</entry>';
			
			}
		}
	}
}

$price[]='</feed>';
echo join('',$price);
//var_dump($price);

function resize($filename, $width, $height) {
	if (!is_file(DIR_IMAGE . $filename)) {
		return;
	}

	$extension = pathinfo($filename, PATHINFO_EXTENSION);

	$old_image = $filename;
	$new_image = 'cache_fb/' . utf8_substr($filename, 0, utf8_strrpos($filename, '.')) . '-' . $width . 'x' . $height . '.' . $extension;

	if (!is_file(DIR_IMAGE . $new_image) || (filectime(DIR_IMAGE . $old_image) > filectime(DIR_IMAGE . $new_image))) {
		$path = '';

		$directories = explode('/', dirname(str_replace('../', '', $new_image)));

		foreach ($directories as $directory) {
			$path = $path . '/' . $directory;

			if (!is_dir(DIR_IMAGE . $path)) {
				@mkdir(DIR_IMAGE . $path, 0777);
			}
		}

		list($width_orig, $height_orig) = getimagesize(DIR_IMAGE . $old_image);

		if ($width_orig != $width || $height_orig != $height) {
			$image = new Image(DIR_IMAGE . $old_image);
			$image->resize($width, $height);
			$image->save(DIR_IMAGE . $new_image);
		} else {
			copy(DIR_IMAGE . $old_image, DIR_IMAGE . $new_image);
		}
	}

	$imagepath_parts = explode('/', $new_image);
	$new_image = implode('/', array_map('rawurlencode', $imagepath_parts));


	return 'image/' . $new_image;

}

?>
