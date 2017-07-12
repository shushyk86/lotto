<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title><?php echo $title; ?></title>
  <style type="text/css">
    @media only screen and (max-width: 400px) {
      .two-columns .column {
        max-width: 100% !important;
      }
      .three-columns .column {
        max-width: 49.9% !important;
      }
      .four-columns .column {
        max-width: 100% !important;
      }
    }


    @media screen and (min-width: 401px) and (max-width: 635px) {
      .two-columns .column {
        max-width: 50% !important;
      }
      .three-columns .column {
        max-width: 33.33% !important;
      }
      .four-columns .column {
        max-width: 100% !important;
      }
    }
    @media screen and (max-width: 415px){
      .col_mob {
        background-color: #FAF6F5;
      }
      .for_mob {
        display: none;
      }
    }
  </style>
</head>

<body>

<div class="middle" style="-ms-text-size-adjust: 100%; -webkit-font-smoothing: subpixel-antialiased; -webkit-text-size-adjust: 100%;  margin: 0 10px; table-layout: fixed; text-align: center;">
  <!--[if (gte mso 9)|(IE)]>
  <table width="600" align="center">
    <tr>
      <td>
  <![endif]-->
  <table class="outer" cellpadding="0" align="center" style="background-color: #fff; border-collapse: collapse; margin: 0 auto; max-width: 600px; width: 100%;">

    <tr>
      <td class="cover_l" style="-webkit-font-smoothing: subpixel-antialiased; padding-top: 24px;padding-bottom:50px">
        <a href="<?php echo $store_url; ?>" target="_blank" style="color: #0077cc; text-decoration: underline;">
          <img src="<?php echo $logo; ?>" width="203" alt="<?php echo $store_name; ?>" style="border: 0; display: block; height: auto; margin: 0 auto; max-width: 260px; width: 100%;"/>
        </a>
      </td>
    </tr >
    <tr style="background: #EFEFEF;">
      <td  style="-webkit-font-smoothing: subpixel-antialiased; color: #4d4d4d; font-family: 'Segoe UI',arial; font-size: 15px; line-height: 21px; padding-left: 10px; padding-top: 20px;padding-right:10px;text-align: center;">
        <p style="font-size: 26px;color:#000;font-weight: bold;line-height: 26px;margin-bottom: 0px;">Ваш заказ получен</p>
        <p style="font-size: 18px;color:#000;">и в настоящее время обрабатывается</p>
      </td>
    </tr>

    <!--  -->


    <tr style="background: #EFEFEF;">
      <td class="h1" style="-webkit-font-smoothing: subpixel-antialiased; color: #000000; font-family: Arial; font-size: 20px; font-weight: bold; line-height: 26px; padding-top: 10px;padding-bottom: 15px; text-align: center;">
        О заказе
      </td>
    </tr>
    <tr style="background:#fff;box-shadow: inset 0px 0px 7px #EFEFEF;">
      <td class="" style="-webkit-font-smoothing: subpixel-antialiased; color: #000000; font-family: Arial; font-size: 14px;  line-height: 16px; padding: 50px; text-align: left;" >
        <p>№ заказа: <strong style="font-size: 16px;"><?php echo $order_id; ?></strong></p>
        <p>Дата заказа:  <strong style="font-size: 16px;"><?php echo $date_added; ?></strong></p>
        <?php if ($shipping_method) { ?>
          <p>Способ доставки: <strong style="font-size: 16px;"><?php echo $shipping_method; ?></strong></p>
        <?php } ?>
        <?php if ($payment_method) { ?>
        <p style="padding-bottom:30px;">Способ оплаты: <strong style="font-size: 16px;"><?php echo $payment_method; ?></strong></p>
        <?php } ?>
        <?php if ($email) { ?>
        <p>E-mail: <strong style="font-size: 16px;"><?php echo $email; ?></strong></p>
        <?php } ?>
        <p>Телефон: <strong style="font-size: 16px;"><?php echo $telephone; ?></strong></p>
      </td>
    </tr>
    <tr>
      <td class="" style="-webkit-font-smoothing: subpixel-antialiased; border-bottom: 1px solid #e6e6e6;">
        <!--[if (gte mso 9)|(IE)]>
        <table width="100%">
          <tr>
            <td valign="top">
        <![endif]-->
        <div class="" style="-webkit-font-smoothing: subpixel-antialiased; display: inline-block; font-size: 14px; margin: 0 auto; text-align: left; vertical-align: top; width: 100%;">
          <table width="100%" cellpadding="10" style="border-collapse: collapse;box-shadow: inset 0px 0px 7px #EFEFEF;">
            <tr>

              <td style="-webkit-font-smoothing: subpixel-antialiased;">
                <table width="100%" cellpadding="0" style="border-collapse: collapse;">
                  <thead>
                  <tr>
                    <th style="width: 50%;text-align: left;padding-bottom: 20px;">Товар</th>
                    <th style="width: 10%;text-align: center;padding-bottom: 20px;">Артикул</th>
                    <th style="width: 10%;text-align: center;padding-bottom: 20px;">Кол-во</th>
                    <th style="width: 10%;text-align: center;padding-bottom: 20px;">Цена</th>
                    <th style="width: 20%;text-align: center;padding-bottom: 20px;">Итого</th>
                  </tr>
                  </thead>
                <?php foreach ($products as $product) { ?>
                  <tbody>
                  <tr style="padding-bottom:20px;">
                    <td style="-webkit-font-smoothing: subpixel-antialiased; text-align: left;width:50%; padding-bottom:20px;">
                      <a href="<?php echo $product['href2']; ?>" target="_blank" style="display: inline-block;text-decoration: underline; width: 100%;">
                        <img src="<?php echo $product['image']; ?>" style="border: 0; margin: 0 auto; width: 60px;height: 60px;vertical-align: middle; margin-right: 10px;display: inline-block;"/>
                        <span style="color:#2a67b2;font-size: 14px; display: inline-block;vertical-align: middle;width: 70%;">
                          <?php echo $product['name']; ?><br />
                          <?php foreach ($product['option'] as $option) { ?>
                            <small style="color: #5a5a5a"><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                          <?php } ?>
                        </span>
                      </a>
                    </td>
                    <td style="width: 10%;text-align: center;padding-bottom:20px;font-weight: bold;"><?php echo $product['sku']; ?></td>
                    <td style="width: 10%;text-align: center;padding-bottom:20px;font-weight: bold;"><?php echo $product['quantity']; ?></td>
                    <td style="width: 10%;text-align: center;padding-bottom:20px;font-weight: bold;"><?php echo $product['price']; ?></td>
                    <td style="width: 20%;text-align: center;padding-bottom:20px;font-weight: bold;"><?php echo $product['total']; ?></td>
                  </tr>
                  <?php } ?>
                  <?php foreach ($totals as $total) { ?>
                  <tr style="padding-bottom:20px;">
                    <td style="text-align: right;padding-bottom:20px;" colspan="4" ><strong><?php echo $total['title']; ?>:</strong></td>
                    <td style="width: 20%;text-align: center;padding-bottom:20px;font-weight: bold;"><?php echo $total['text']; ?></td>
                  </tr>
                  <?php } ?>
                  </tbody>
                  <!-- <tr>
                      <td style="text-align: center;width: 50%;">

                      </td>
                      <td style="text-align: center;width: 50%;">
                          «Самовывоз из магазина» <a href="">см. карту</a>
                      </td>
                  </tr> -->
                </table>
              </td>
            </tr>
          </table>
        </div>


        <!--[if (gte mso 9)|(IE)]>
        </td>
        </tr>
        </table>
        <![endif]-->
      </td>
    </tr>
  </table>
  <!--[if (gte mso 9)|(IE)]>
  </td>
  </tr>
  </table>
  <![endif]-->
</div>
<div class="footer" style="-ms-text-size-adjust: 100%; -webkit-font-smoothing: subpixel-antialiased; -webkit-text-size-adjust: 100%; margin: 0 10px; table-layout: fixed; text-align: center;">
  <!--[if (gte mso 9)|(IE)]>
  <table width="600" align="center">
    <tr>
      <td>
  <![endif]-->
  <table class="outer" cellpadding="0" align="center" style=" background-color: #efefef;border-collapse: collapse; margin: 0 auto; max-width: 600px; width: 100%;">
    <tr>
      <td class="one-column credits" style="-webkit-font-smoothing: subpixel-antialiased; font-size: 0; ; text-align: center;">
        <div class="column" style="-webkit-font-smoothing: subpixel-antialiased; display: inline-block; font-size: 14px; max-width: 600px; text-align: left; vertical-align: top; width: 100%;">
          <table width="100%" cellpadding="20" style="background-color: #efefef; border-collapse: collapse;">
            <tr>
              <td class="n_f" style="-webkit-font-smoothing: subpixel-antialiased; color: #5a5a5a; font-size: 14px; text-align: center;">
                <p>Если у Вас есть какие-либо вопросы, ответьте на это сообщение.</p>
              </td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
  </table>
  <!--[if (gte mso 9)|(IE)]>
  </td>
  </tr>
  </table>
  <![endif]-->
</div>

</body>

</html>