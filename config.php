<?php
$_r=$_SERVER['DOCUMENT_ROOT'];

// HTTP
define('HTTP_SERVER', 'http://localhost/');

// HTTPS
define('HTTPS_SERVER', 'http://localhost/');

// DIR
define('DIR_APPLICATION', $_r.'/catalog/');
define('DIR_SYSTEM', $_r.'/system/');
define('DIR_DATABASE', $_r.'/system/database/');
define('DIR_LANGUAGE', $_r.'/catalog/language/');
define('DIR_TEMPLATE', $_r.'/catalog/view/theme/');
define('DIR_CONFIG', $_r.'/system/config/');
define('DIR_IMAGE', $_r.'/image/');
define('DIR_CACHE', $_r.'/system/cache/');
define('DIR_DOWNLOAD', $_r.'/download/');
define('DIR_LOGS', $_r.'/system/logs/');

// DB
define('DB_DRIVER', 'mysqli');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'lottotest');
define('DB_PASSWORD', 'lotto');
define('DB_DATABASE', 'lottotest');
define('DB_PREFIX', 'oc_');
?>