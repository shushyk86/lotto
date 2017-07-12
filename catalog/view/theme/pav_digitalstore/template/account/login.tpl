<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>

<?php echo $header; ?>

<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?> 

<?php if( $SPAN[0] ): ?>

	<aside class="col-lg-<?php echo $SPAN[0];?> col-md-<?php echo $SPAN[0];?> col-sm-12 col-xs-12">

		<?php echo $column_left; ?>

	</aside>

<?php endif; ?> 

<section class="col-lg-<?php echo $SPAN[1];?> col-md-<?php echo $SPAN[1];?> col-sm-12 col-xs-12"> 

<?php if ($success) { ?>

<div class="success"><?php echo $success; ?></div>

<?php } ?>

<?php if ($error_warning) { ?>

<div class="warning"><?php echo $error_warning; ?></div>

<?php } ?>



<div id="content"><?php echo $content_top; ?>

 

  <!-- <h1><?php echo $heading_title; ?></h1> -->

  <div class="login-content">

		<div class="row">

			<div class="col-lg-5 col-sm-5 col-xs-12">

				<div class="inner">

				  <h2><?php echo $text_returning_customer; ?></h2>

				  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">

					<div class="content">

					  <!-- <p><?php echo $text_i_am_returning_customer; ?></p> -->

					  <b><?php echo $entry_email; ?></b>

					  <input class="form-control" type="text" name="email" value="<?php echo $email; ?>" />

					  <br />

					  <br />

					  <b><?php echo $entry_password; ?></b>

					  <input class="form-control" type="password" name="password" value="<?php echo $password; ?>" />

					  <br />

					  <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a><br />

						  <input type="submit" value="<?php echo $button_login; ?>" class="button" />

					  <?php if ($redirect) { ?>

					  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />

					  <?php } ?>

					</div>

				</form>

				</div>

			</div>	

			<div class="col-lg-7 col-sm-7 col-xs-12">

				<div class="inner">

				  <h2><?php echo $text_new_customer; ?></h2>

				  <div class="content">

					<!-- <p><b><?php echo $text_register; ?></b></p> -->

					<p class="acc-text"><?php echo $text_register_account; ?></p>

					<a href="<?php echo $register; ?>" class="button">создать учетную запись</a>

				</div>

			</div>

		</div>	

  </div>

  <?php echo $content_bottom; ?></div>

<script type="text/javascript"><!--

$('#login input').keydown(function(e) {

	if (e.keyCode == 13) {

		$('#login').submit();

	}

});

//--></script> 

</section> 

<?php if( $SPAN[2] ): ?>

<aside class="col-lg-<?php echo $SPAN[2];?> col-md-<?php echo $SPAN[2];?> col-sm-12 col-xs-12">	

	<?php echo $column_right; ?>

</aside>

<?php endif; ?>

<!-- ReTag -->
<script type="text/javascript">
    window._retag_data = {
    };
    window._retag = window._retag || [];
    window._retag.push({code: "9ce88868d8"});
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

<?php echo $footer; ?>
