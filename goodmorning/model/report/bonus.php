<?php
class ModelReportBonus extends Model {
	public function getBonuses($data = array()) {
		$sql_plus = "SELECT SUM(cr.points) AS plus FROM `" . DB_PREFIX . "customer_reward` cr WHERE cr.points > 0";

        $sql_minus = "SELECT SUM(cr.points) AS minus FROM `" . DB_PREFIX . "customer_reward` cr WHERE cr.points < 0";

        $sql_plus_zakaz = "SELECT SUM(cr.points) AS plus_zakaz FROM `" . DB_PREFIX . "customer_reward` cr WHERE cr.points > 0 AND cr.order_id > 0";

        $sql_plus_register = "SELECT SUM(cr.points) AS plus_register FROM `" . DB_PREFIX . "customer_reward` cr WHERE cr.description LIKE 'Регистрация на сайте'";

		$implode = array();
		
		if (!empty($data['filter_date_start'])) {
			$implode[] = "DATE(cr.date_added) >= '" . $this->db->escape($data['filter_date_start']) . "'";
		}

		if (!empty($data['filter_date_end'])) {
			$implode[] = "DATE(cr.date_added) <= '" . $this->db->escape($data['filter_date_end']) . "'";
		}

		if ($implode) {
            $sql_plus .= " AND " . implode(" AND ", $implode);
            $sql_minus .= " AND " . implode(" AND ", $implode);
            $sql_plus_zakaz .= " AND " . implode(" AND ", $implode);
            $sql_plus_register .= " AND " . implode(" AND ", $implode);
		}
		
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}			

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

            $sql_plus .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
            $sql_minus .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
            $sql_plus_zakaz .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
            $sql_plus_register .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}
		
		$query_plus = $this->db->query($sql_plus);
		$query_minus = $this->db->query($sql_minus);
        $query_plus_zakaz = $this->db->query($sql_plus_zakaz);
        $query_plus_register = $this->db->query($sql_plus_register);

		return array(
		    'plus' => $query_plus->row['plus'],
            'minus' => $query_minus->row['minus'],
            'plus_zakaz' => $query_plus_zakaz->row['plus_zakaz'],
            'plus_register' => $query_plus_register->row['plus_register'],
        );
	}	
	
	public function getTotalCoupons($data = array()) {
		$sql = "SELECT COUNT(DISTINCT coupon_id) AS total FROM `" . DB_PREFIX . "coupon_history`";
		
		$implode = array();
		
		if (!empty($data['filter_date_start'])) {
			$implode[] = "DATE(date_added) >= '" . $this->db->escape($data['filter_date_start']) . "'";
		}

		if (!empty($data['filter_date_end'])) {
			$implode[] = "DATE(date_added) <= '" . $this->db->escape($data['filter_date_end']) . "'";
		}

		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}

		$query = $this->db->query($sql);

		return $query->row['total'];	
	}		
}
?>