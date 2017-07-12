<script type="text/javascript">
function checkout() {
    $('#gotoorderajax').attr("disabled", true);
    $.ajax({
        type: 'POST',
        url: 'index.php?route=checkout/ocjoyajaxcheckout/simpleorder',
        dataType: 'json',
        data: $('#ajaxorder input[type=\'text\'], #ajaxorder textarea, #ajaxorder input[type=\'hidden\'], #ajaxorder select, #ajaxorder input[type=\'radio\']:checked, #ajaxorder input[type=\'checkbox\']:checked'),
        success: function(json) {
            if (json['error']){
                  $("#gotoorderajax").bind("click", function () {
                    $("#cboxContent").mask("<?php echo $text_ocjoyajaxcheckout_loading; ?>");
                  });
                  $(this).colorbox.resize();
                  if (json['error']['firstname']) {
                    $('#error_firstname').show().html(json['error']['firstname']);
                    $("#cboxContent").unmask();
                  } else {
                    $('#error_firstname').hide();
                  };
                  if (json['error']['telephone']) {
                    $('#error_telephone').show().html(json['error']['telephone']);
                    $("#cboxContent").unmask();
                  } else {
                    $('#error_telephone').hide();
                  };
                  if (json['error']['email']) {
                    $('#error_email').show().html(json['error']['email']);
                    $("#cboxContent").unmask();
                  } else {
                    $('#error_email').hide();
                  };
                  $(this).colorbox.resize();
                  $('#gotoorderajax').attr("disabled", false);
            } else {
                if (json['output']) {
                  $("#cboxContent").unmask();
                  $('#ajaxordermainbody').html('<div id="ocjoyajaxcheckoutsuccess">'+json['output']+'</div>');
                  $(this).colorbox.resize();
                }
            }
        }
    });
}
function validate(input) {
  input.value = input.value.replace(/[^\d,]/g, '');
}
function getIamge(id) {
  $("#currentimg").attr("src", $(id).attr("rel"));
  return false;
}
function pluscon(pid) {
  qua = parseInt($("#quant-"+pid).val())+1;
  $("#quant-"+pid).val(qua);
  $.ajax({
    url: 'index.php?route=checkout/ocjoyajaxcheckout/calc&product_id='+pid+'&qty='+qua,
    type: 'post',
    dataType: 'json',
    data: $('#ajaxorder input[type=\'text\'], #ajaxorder  input[type=\'hidden\'], #ajaxorder  input[type=\'radio\']:checked, #ajaxorder  input[type=\'checkbox\']:checked, #ajaxorder  select, #ajaxorder textarea'),
    success:function(json) {
        $("#oldprice").html(json['price']);
        $("#newprice").html(json['special']);
      } 
  });
}
function ups() { 
  $.ajax({
    url: 'index.php?route=checkout/ocjoyajaxcheckout/calc',
    type: 'post',
    dataType: 'json',
    data: $('#ajaxorder input[type=\'text\'], #ajaxorder  input[type=\'hidden\'], #ajaxorder  input[type=\'radio\']:checked, #ajaxorder  input[type=\'checkbox\']:checked, #ajaxorder  select, #ajaxorder textarea'),
    success:function(json) {
        $("#oldprice").html(json['price']);
        $("#newprice").html(json['special']);
      } 
  });
}
function minuscon(pid) {
  if (parseInt($("#quant-"+pid).val())>1) {
    qua = parseInt($("#quant-"+pid).val())-1;
 $("#quant-"+pid).val(qua);
    $.ajax({
      url: 'index.php?route=checkout/ocjoyajaxcheckout/calc&product_id='+pid+'&qty='+qua,
      type: 'post',
      dataType: 'json',
      data: $('#ajaxorder input[type=\'text\'], #ajaxorder  input[type=\'hidden\'], #ajaxorder  input[type=\'radio\']:checked, #ajaxorder  input[type=\'checkbox\']:checked, #ajaxorder  select, #ajaxorder textarea'),
      success:function(json) {
        $("#oldprice").html(json['price']);
        $("#newprice").html(json['special']);
      } 
    });
  }
}
</script>
<div id="ajaxorder">
  <div id="ajaxordermainbody">
  <div id="ocjoyajaxcheckout"><?php echo $text_ocjoyajaxcheckout_head; ?></div>
  <?php if ($hideimg == 1) { ?>
    <div id="ajaxorderimg">
        <div class="mainimg"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="currentimg"/></div>
        <?php if ($images) { ?>
        <div class="image-additional">
          <div class="carousel-checkout"> 
            <div class="carousel-button-left-checkout"><a href="javascript:void(0);"><img src="image/ocjoyajaxcheckout/carousel-left.png"/></a></div> 
            <div class="carousel-button-right-checkout"><a href="javascript:void(0);"><img src="image/ocjoyajaxcheckout/carousel-right.png"/></a></div> 
            <div class="carousel-wrapper-checkout"> 
                <div class="carousel-items-checkout"> 
                  <?php foreach ($images as $image) { ?>
                    <div class="carousel-block-checkout"><img rel="<?php echo $image['popup']; ?>" src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" onclick="getIamge(this)"/></div>
                  <?php } ?>
                </div>
            </div>
          </div>
        </div>
        <?php } ?>
    </div>
  <?php } ?>
    <form style="clear:both;width:100%;float:left;" enctype="multipart/form-data" method="post">
    <table id="aboutproduct">
      <thead>
        <tr>
          <td style="width:40%;"><span class="aboutproductspan"><?php echo $text_ocjoyajaxcheckout_ibuy; ?></span></td>
          <td style="width:20%;"><span class="aboutproductspan"><?php echo $text_ocjoyajaxcheckout_priceof; ?></span></td>
          <td style="width:20%;text-align:center;"><?php echo $text_ocjoyajaxcheckout_inanamount; ?></td>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><span class="aboutproductspan"><?php echo $heading_title; ?></span></td>
          <td>
            <span class="aboutproductspan">
              <?php if ($price) { ?>
                <?php if ($special) { ?>
                  <span id="newprice" style="color:#f00;"><?php echo $special; ?></span> <span id="oldprice" style="text-decoration: line-through;"><?php echo $price; ?></span>
                <?php } else { ?>
                  <span id="oldprice"><?php echo $price; ?></span>
                <?php } ?>  
              <?php } ?>
            </span>
          </td>
          <td style="text-align:center;">
            <table style="width:100%;text-align:center;">
              <tr>
                <td style="border:0px;"> 
                    <a onclick="minuscon(<?php echo $product_id; ?>);" id="minuss" >-</a>
                    <input type="text" name="quantity" id="quant-<?php echo $product_id; ?>" onchange="ups(); return validate(this); " size="3" maxlength="3" onkeyup="ups(); return validate(this);" value="1" style="text-align:center;" />
                    <a onclick="pluscon(<?php echo $product_id; ?>);" id="pluss" >+</a>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </tbody>
    </table>
    <br />
      <?php if ($hidefio == 1) { ?>
        <?php if ($required_fio == 1) { ?>
        <div class="sections_block_rquaired">
          <i class="icon-append_1 icon-user"></i>
          <input type="text" name="firstname" class="ajaxorderinputsnorequired" placeholder="<?php echo $text_ocjoyajaxcheckout_entername; ?>"/>
          <div id="error_firstname" class="ocjoyajaxcheckout_errorfields"></div>
        </div>
        <?php } else { ?>
        <div class="sections_block">
          <i class="icon-append_1 icon-user"></i>
          <input type="text" name="firstname" class="ajaxorderinputs" placeholder="<?php echo $text_ocjoyajaxcheckout_entername; ?>"/>
        </div>
        <?php } ?>
      <?php } ?>
      <?php if ($hideemail == 1) { ?>
        <?php if ($required_email == 1) { ?>
        <div class="sections_block_rquaired">
          <i class="icon-append_1 icon-envelope-alt"></i>
          <input type="text" name="email" class="ajaxorderinputsnorequired" placeholder="<?php echo $text_ocjoyajaxcheckout_enteremail; ?>"/>
          <div id="error_email" class="ocjoyajaxcheckout_errorfields"></div>
        </div>
        <?php } else { ?>
        <div class="sections_block">
          <i class="icon-append_1 icon-envelope-alt"></i>
          <input type="text" name="email" class="ajaxorderinputs" placeholder="<?php echo $text_ocjoyajaxcheckout_enteremail; ?>"/>
        </div>
        <?php } ?>
      <?php } ?>
      <?php if ($hidetelephone == 1) { ?>
        <?php if ($required_telephone == 1) { ?>
        <div class="sections_block_rquaired">
          <i class="icon-append_1 icon-phone"></i>
          <input type="text" name="telephone" class="ajaxorderinputsnorequired" id="fortelephonemask" onclick="$(this).inputmask('<?php echo $mask_telephone; ?>');" placeholder="<?php echo $text_ocjoyajaxcheckout_entertelephone; ?>"/>
          <div id="error_telephone" class="ocjoyajaxcheckout_errorfields"></div>
        </div>
        <?php } else { ?>
        <div class="sections_block">
          <i class="icon-append_1 icon-phone"></i>
          <input type="text" name="telephone" class="ajaxorderinputs" id="fortelephonemask" onclick="$(this).inputmask('<?php echo $mask_telephone; ?>');" placeholder="<?php echo $text_ocjoyajaxcheckout_entertelephone; ?>"/>
        </div>
        <?php } ?>
      <?php } ?>
      <?php if ($hidedescription == 1) { ?>
          <textarea name="description" class="ajaxorderinputs" placeholder="<?php echo $text_ocjoyajaxcheckout_enterdescription; ?>"></textarea>
      <?php } ?>
        <input name="product_id" value="<?php echo $product_id ?>" type="hidden" />
      <?php if ($hidepayment == 1) { ?> 
        <div class="pay_ship_block">
          <div class="fieldname"><?php echo $text_ocjoyajaxcheckout_selectpayment; ?>: <?php if($config_info_payment == 1) { ?><a class="faqinfo" faq="<?php echo $info_payment_text; ?>">[?]</a><?php } ?></div>
          <select name="payment_method" class="ajaxorderinputs">
            <?php foreach ($payment_methods as $payment_method) { ?>
              <option value="<?php echo $payment_method['title']; ?>" id="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></option>
            <?php } ?>
          </select>
        </div>
      <?php } ?>
      <?php if ($hideshipping == 1) { ?> 
        <div class="pay_ship_block">
          <div class="fieldname"><?php echo $text_ocjoyajaxcheckout_selectshipping; ?>: <?php if($config_info_shipping == 1) { ?><a class="faqinfo" faq="<?php echo $info_shipping_text; ?>">[?]</a><?php } ?></div>
          <select name="shipping_method" class="ajaxorderinputs">
            <?php foreach ($shipping_methods as $shipping_method) { ?>
              <option value="<?php echo $shipping_method['title']; ?>" id="<?php echo $shipping_method['code'] ?>"><?php echo $shipping_method['title']; ?></option>
            <?php } ?>
          </select>
        </div>
      <?php } ?>
      <?php if ($hideoptions == 1) { ?> 
        <?php if ($options) { ?>
          <div class="options">
            <?php foreach ($options as $option) { ?>
              <?php if ($option['type'] == 'select') { ?>
                <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                  <b><?php echo $option['name']; ?>:</b><br />
                  <select onchange="ups();"  name="option[<?php echo $option['product_option_id']; ?>]" >
                    <option value=""><?php echo $text_ocjoyajaxcheckout_selectoption; ?></option>
                    <?php foreach ($option['option_value'] as $option_value) { ?>
                    <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                    </option>
                    <?php } ?>
                  </select>
                </div>
                <br />
              <?php } ?>
              <?php if ($option['type'] == 'radio') { ?>
                <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                  <b><?php echo $option['name']; ?>:</b>
                  <br />
                  <?php foreach ($option['option_value'] as $option_value) { ?>
                    <input onchange="ups();" type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
                    <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                    </label>
                    <br />
                  <?php } ?>
                </div>
                <br />
              <?php } ?>
              <?php if ($option['type'] == 'checkbox') { ?>
              <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                <b><?php echo $option['name']; ?>:</b>
                <br />
                <?php foreach ($option['option_value'] as $option_value) { ?>
                  <input onchange="ups();" type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
                  <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                  <?php if ($option_value['price']) { ?>
                  (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                  <?php } ?>
                  </label>
                  <br />
                <?php } ?>
              </div>
              <br />
              <?php } ?>
            <?php } ?>
          </div>
        <?php } ?>
      <?php } ?>
    </form>
    <a onclick="$.colorbox.close();" id="cancelorderajax"><?php echo $text_ocjoyajaxcheckout_cancel; ?></a>
    <input type="button" onclick="checkout('orderform');" id="gotoorderajax" value="<?php echo $text_ocjoyajaxcheckout_ordernow; ?>">
  </div>
</div>