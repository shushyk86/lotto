<form action="<?php echo $action; ?>" id="platon_checkout" name="platon_checkout" method="post">
    <input type="hidden" name="key" value="<?php echo $key; ?>" />
    <input type="hidden" name="order" value="<?php echo $order; ?>" />
    <input type="hidden" name="url" value="<?php echo $url; ?>" />
    <input type="hidden" name="data" value="<?php echo $data; ?>" />
    <input type="hidden" name="sign" value="<?php echo $sign; ?>" />
</form>
<script type="text/javascript">document.getElementById("platon_checkout").submit();</script>