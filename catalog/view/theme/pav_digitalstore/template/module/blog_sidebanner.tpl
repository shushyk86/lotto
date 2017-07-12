<?php if (!empty($banners)) { ?>
<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
    <div class="box-category">
        <?php foreach ($banners as $banner) { ?>
          <a href="<?php echo $banner['href']; ?>"><img src="<?php echo $banner['image']; ?>"/></a>
        <?php } ?>
    </div>
  </div>
</div>
<?php } ?>