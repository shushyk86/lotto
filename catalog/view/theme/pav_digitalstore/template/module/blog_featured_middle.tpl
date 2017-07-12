<?php if($articles){ ?>
<div class="box row products-item">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">

    <div class="box-product">
      <?php foreach ($articles as $article) { ?>
      <div class="block_rewievs col-xs-6 col-lg-4 col-sm-4 col-xs-12" >

        <div class="product-block ">

          <div class="block_rewievs--name"><?php echo $article['name']; ?></div>
          
          <a class="mask" href="<?php echo $article['href']; ?>"></a>

          <?php if ($article['thumb']) { ?>
          <div class="image" ><a href="<?php echo $article['href']; ?>"><img src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" /></a></div>
          <?php } ?>

        
		
    		<!-- <div class="added-viewed" style=""><i class="fa fa-clock-o"></i> <?php echo $article["date_added"];?>&nbsp;&nbsp;&nbsp;<i class="fa fa-eye"></i> <?php echo $text_views; ?> <?php echo $article["viewed"];?></div>
     -->
    		<!-- <div class="rating" style="text-align:right;overflow:hidden;">
              <?php for ($i = 1; $i <= 5; $i++) { ?>
              <?php if ($article['rating'] < $i) { ?>
              <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
              <?php } else { ?>
              <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
              <?php } ?>
              <?php } ?>
        </div> -->
          </div>
        </div>
      <?php } ?>
    </div>

  </div>
</div>
<?php } ?>