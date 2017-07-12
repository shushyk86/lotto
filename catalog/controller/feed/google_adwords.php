<?php
class ControllerFeedGoogleAdwords extends Controller {
	public function index() {
        require_once(DIR_SYSTEM . 'PHPExcel/Classes/PHPExcel.php');
        require_once(DIR_SYSTEM . 'PHPExcel/Classes/PHPExcel/Writer/Excel5.php');
	    $this->load->model('catalog/product');
        $this->load->model('export/google_adwords');

        // Товарные предложения
        $products = $this->model_catalog_product->getProducts();

        $data = array();

        foreach ($products as $product) {
            if ($product['image']) {
                $img = $this->model_export_google_adwords->resize($product['image'], 600, 600);
                $data[] = array(
                    'id' => $product['sku'],
                    'item title' => html_entity_decode($product['name']),
                    'final url' => $this->url->link('product/product', 'path=' . $this->getPath($this->model_export_google_adwords->getCategories($product['product_id'])) . '&product_id=' . $product['product_id']),
                    'image url' => HTTP_SERVER . $img,
                    'price' => (float)$product['special'] ? (int)$product['special'] . ' ' . 'UAH' : (int)$product['price'] . ' ' . 'UAH'
                );
            }
        }

        $xls = new PHPExcel();
        $xls->setActiveSheetIndex(0);
// Получаем активный лист
        $sheet = $xls->getActiveSheet();
// Подписываем лист
        $sheet->setTitle('Google Adwords Feed');

        for ($row = -1; $row < count($data); $row++) {
            $col = 0;
            if($row == -1){
                foreach ($data[$row+1] as $k => $value) {
                    $sheet->setCellValueByColumnAndRow($col, $row + 2, $k);
                    $col++;
                }
            } else {
                foreach ($data[$row] as $k => $value) {
                    $sheet->setCellValueByColumnAndRow($col, $row + 2, $data[$row][$k]);
                    $col++;
                }
            }
        }

        $objWriter = new PHPExcel_Writer_Excel5($xls);
        $objWriter->save('google_adw.xls');
        $this->file_force_download('google_adw.xls');
//        $objWriter->save('php://output');

    }

    private function file_force_download($file) {
        if (file_exists($file)) {
            // сбрасываем буфер вывода PHP, чтобы избежать переполнения памяти выделенной под скрипт
            // если этого не сделать файл будет читаться в память полностью!
            if (ob_get_level()) {
                ob_end_clean();
            }
            // заставляем браузер показать окно сохранения файла
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=' . basename($file));
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . filesize($file));
            // читаем файл и отправляем его пользователю
            readfile($file);
            exit;
        }
    }

    protected function getPath($category_id, $current_path = '') {
        if (isset($this->categories[$category_id])) {
            $this->categories[$category_id]['export'] = 1;

            if (!$current_path) {
                $new_path = $this->categories[$category_id]['id'];
            } else {
                $new_path = $this->categories[$category_id]['id'] . '_' . $current_path;
            }

            if (isset($this->categories[$category_id]['parentId'])) {
                return $this->getPath($this->categories[$category_id]['parentId'], $new_path);
            } else {
                return $new_path;
            }

        }
    }
}
?>