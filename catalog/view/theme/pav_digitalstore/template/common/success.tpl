<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>

<!-- admitad -->
<script type="text/javascript">
(function (d, w) {
w._admitadPixel = {
response_type: 'img',
action_code: '1',
campaign_code: '566ea40b58'
};
w._admitadPositions = w._admitadPositions || [];

<?php if(isset($items)) { ?>
<?php for($i = 0; $i < count($items); $i++) { ?>
w._admitadPositions.push({
uid: '<?php echo $items[$i]['admitad_uid']; ?>',
order_id: '<?php echo $order_id; ?>',
position_id: '<?php echo ($i + 1); ?>',
client_id: '<?php echo $items[$i]['customer_id']; ?>',
tariff_code: '1',
currency_code: 'UAH',
position_count: '<?php echo count($items); ?>',
price: '<?php echo $items[$i]['price']; ?>',
quantity: '<?php echo $items[$i]['quantity']; ?>',
product_id: '<?php echo $items[$i]['sku']; ?>',
screen: '',
tracking: '',
old_customer: '<?php echo $items[$i]['old_customer']; ?>',
coupon: '',
payment_type: 'sale',
promocode: '<?php echo $items[$i]['coupon']; ?>'
});
<?php } ?>
<?php } ?>

var id = '_admitad-pixel';
if (d.getElementById(id)) { return; }
var s = d.createElement('script');
s.id = id;
var r = (new Date).getTime();
var protocol = (d.location.protocol === 'https:' ? 'https:' : 'http:');
s.src = protocol + '//cdn.asbmit.com/static/js/pixel.min.js?r=' + r;
d.head.appendChild(s);
})(document, window)
</script>
<noscript>
<img src="//ad.admitad.com/r?
campaign_code=566ea40b58&action_code=1&response_type=img&uid=&order_id=&position_id=&tari
ff_code=1&currency_code=&position_count=&price=&quantity=&product_id=&coupon=&payment_typ
e=sale&promocode=" width="1" height="1" alt="">
</noscript>
<!-- End admitad -->

<!-- FB and GOOGLE tracking -->

<?php
if(isset($items)) {
	foreach ($items as $item) {
		$all_sku[] = "'" . $item['sku'] . "'";
	}
	$all_sku_text = implode(', ', $all_sku);
?>
<script type="text/javascript">
$(document).ready(function() {
	fbq('track', 'Purchase', {
	  content_ids: [<?php echo $all_sku_text; ?>],
	  content_type: 'product',
	  value: <?php echo $all_price; ?>,
	  currency: 'UAH'
	});
});
</script>
<?php } ?>

<?php if(isset($order_products)) { ?>
<script type="text/javascript">
<?php foreach($order_products as $product) { ?>
ga('ec:addProduct', {
	'id': '<?php echo $product['id']; ?>',
	'name': '<?php echo $product['name']; ?>',
	'price': '<?php echo $product['price']; ?>',
	'quantity': <?php echo $product['quantity']; ?>
});
<?php } ?>
</script>
<?php } ?>

<?php if(isset($transaction)) { ?>
<script type="text/javascript">
ga('ec:setAction', 'purchase', {
	'id': '<?php echo $transaction['order_id']; ?>',
	'affiliation': 'Lotto-sport',
	'revenue': '<?php echo $transaction['total_price']; ?>',
	'shipping': '<?php echo $transaction['shipping']; ?>'
});
</script>
<?php } ?>
<!-- End FB and GOOGLE tracking -->

<?php if( $SPAN[0] ): ?>
<aside class="col-lg-<?php echo $SPAN[0];?> col-sm-<?php echo $SPAN[0];?> col-xs-12">
	<?php echo $column_left; ?>
</aside>
<?php endif; ?>

<section class="col-lg-<?php echo $SPAN[1];?> col-sm-<?php echo $SPAN[1];?> col-xs-12">
    <?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?>
    <div id="content">
        <?php echo $content_top; ?>
        <h1><?php echo $heading_title; ?></h1>    
        <div style="padding: 10px;"><?php echo $text_message; ?></div>
		
		<table class="order-table">
			<?php if(isset($order_id)) { ?>
			<tr>
				<td>Номер заказа:</td>
				<td><?php echo $order_id; ?></td>
			</tr>
			<?php } ?>
			<?php if(!empty($order_info['payment_method'])) { ?>
			<tr>
				<td>Способ оплаты:</td>
				<td><?php echo $order_info['payment_method']; ?></td>
			</tr>
			<?php } ?>
			<?php if(!empty($order_info['shipping_method'])) { ?>
			<tr>
				<td>Способ доставки:</td>
				<td><?php echo strip_tags($order_info['shipping_method']); ?></td>
			</tr>
			<?php } ?>
			<?php if(!empty($order_info['total'])) { ?>
			<tr>
				<td>Сумма:</td>
				<td><?php echo (int)$order_info['total']; ?> грн.</td>
			</tr>
			<?php } ?>
		</table>
        <div class="buttons">
            <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
        </div>
        <?php echo $content_bottom; ?>
    </div>
</section>

<?php if( $SPAN[2] ): ?>
<aside class="col-lg-<?php echo $SPAN[2];?> col-sm-<?php echo $SPAN[2];?> col-xs-12">	
	<?php echo $column_right; ?>
</aside>
<?php endif; ?>

<?php if(isset($items)) { ?>
<script type="text/javascript">
var _tmr = _tmr || [];
_tmr.push({
type: 'itemView',
productid: [<?php for($j = 0; $j < count($items); $j++) { ?>'<?php echo $items[$j]['sku']; ?>'<?php if($j != (count($items) - 1)) { echo ", "; } } ?>],
pagetype: 'purchase',
totalvalue: '<?php echo $all_price; ?>',
list: '1' });
</script>
<?php } ?>

<!-- ReTag -->
<script type="text/javascript">

<?php if(isset($items)) { ?>
window.ad_order = "<?php echo $order_id; ?>";
window.ad_amount = "<?php echo $all_price; ?>";
window.ad_products = [<?php for($i = 0; $i < count($items); $i++) { ?>
{ 
"id": "<?php echo $items[$i]['sku']; ?>",
"number": "<?php echo $items[$i]['quantity']; ?>"
<?php if($i != (count($items) - 1)) {
echo "},
";
}
}
?>
}];
<?php } ?>

window._retag = window._retag || [];
window._retag.push({code: "9ce88868a7", level: 4});
(function () {
    var id = "admitad-retag";
    if (document.getElementById(id)) {return;}
    var s = document.createElement("script");
    s.async = true; s.id = id;
    var r = (new Date).getDate();
    s.src = (document.location.protocol == "https:" ? "https:" : "http:") + "//cdn.trmit.com/static/js/retag.min.js?r="+r;
    var a = document.getElementsByTagName("script")[0]
    a.parentNode.insertBefore(s, a);
})()
</script>
<!-- End ReTag -->

<?php if($this->customer->isLogged()){ ?>
<script type='text/javascript'>
	$(window).load(function(){
		gaSetUserId('<?php echo $this->customer->getEmail(); ?>');
	});
</script>
<?php } elseif(isset($order_info['email']) && !empty($order_info['email']) ) { ?>
<script type='text/javascript'>
	$(window).load(function(){
		gaSetUserId('<?php echo $order_info['email']; ?>');
	});
</script>
<?php } ?>

<?php echo $footer; ?>
