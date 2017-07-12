<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>

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
        <?php echo $text_message; ?>
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
<body><!-- Google Code for &#1087;&#1086;&#1082;&#1091;&#1087;&#1082;&#1072;
Conversion Page -->
<script type="text/javascript">
/* <![CDATA[ */
var google_conversion_id = 945892932;
var google_conversion_language = "en";
var google_conversion_format = "3";
var google_conversion_color = "ffffff";
var google_conversion_label = "nVjVCJuB0VwQxNyEwwM"; 
var google_remarketing_only = false;
/* ]]> */
</script>
<script type="text/javascript"  
src="//www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt=""  
src="//www.googleadservices.com/pagead/conversion/945892932/?label=nVjVCJuB0VwQxNyEwwM&amp;guid=ON&amp;script=0"/>
</div>
</noscript>
</body>
<?php echo $footer; ?>
