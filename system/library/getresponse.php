<?php
class Getresponse {
    private $url = "https://api.getresponse.com/v3/contacts";
    private $api_key = "15ad07c6cc6737f5d9072dd4640de3ea";

    public function sendContact($name, $email, $campaign, $token = '', $gender = ''){
        if(!empty($token)) {
            $request = json_encode(array(
                    "name" => $name,
                    "email" => $email,
                    "campaign" => array("campaignId" => $campaign),
                    "customFieldValues" => array(
                        array(
                            "customFieldId" => "uHv9u",
                            "value" => array("http://lotto-sport.com.ua/index.php?route=account/login&type=ma1104&token=" . $token)
                        ),
                        array(
                            "customFieldId" => "9TTc",
                            "value" => array("$gender")
                        )
                    )
                )
            );
        } else {
            $request = json_encode(array(
                    "name"          => $name,
                    "email"         => $email,
                    "campaign"      => array("campaignId" => $campaign)
                )
            );
        }


        $ch = curl_init();
        // set URL
        curl_setopt($ch, CURLOPT_URL, $this->url);
        curl_setopt($ch, CURLOPT_POST, TRUE);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $request);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('X-Auth-Token: api-key '.$this->api_key, 'Content-Type: application/json'));
        curl_setopt($ch, CURLOPT_ENCODING, 'gzip,deflate');
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
//		curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 30);
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        // send the request
        curl_exec($ch);
        // check http status code
        $http_errors = array(
            400 => '400 (Bad Request)',
            401 => '401 (Authentication error)',
            409 => '409 (An email address can be used only once within a given campaign)',
            500 => '500 (Internal Server Error)'
        );

        $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);

        if (isset($http_errors[$http_code])) {
            $this->adderr(date('H:i:s d-m-Y') . " Response Http Error " . $http_errors[$http_code] . " - Customer: ".$name. ", E-mail: ".$email.", Point: ".$campaign. " \n");
        } elseif(!empty($http_code) && $http_code != 202){
            $this->adderr(date('H:i:s d-m-Y') . " Response Http Error " . $http_code . " - Customer: ".$name. ", E-mail: ".$email.", Point: ".$campaign. " \n");
        }
        // check for curl error
        if (0 < curl_errno($ch)) {
            $this->adderr(date('H:i:s d-m-Y') . " Unable to connect to " . $this->gr_url . ": " . curl_error($ch) . ", Customer: ".$name. ", E-mail: ".$email.", Point: ".$campaign. " \n");
        }

        // close the connection
        curl_close($ch);
    }

    private function adderr($err) {
        $file_er = DIR_LOGS."gr_errors.txt";
        $er = @fopen($file_er,'a');
        if (!$er) $er = @fopen($file_er,'w+');
        @fputs($er, $err);
        @fclose($er);
    }
}
?>