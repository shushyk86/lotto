<!-- edit slider -->
<?php echo $header; ?>

<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
	<?php if ($success) { ?>
		<div class="success"><?php echo $success; ?></div>
	<?php } ?>
	<?php if ($error_warning) { ?>
		<div class="warning"><?php echo $error_warning; ?></div>
	<?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons">
		<a href="<?php echo $backToList_url; ?>" class="button"><?php echo $button_list; ?></a>
		<a class="button show_hide_help show"><?php echo $button_help_hide; ?></a>
		<a class="button save"><?php echo $button_save; ?></a>
		<a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a>
	  </div>
    </div>
    <div class="content">

<div id="ls-sample">
<!-- layers tab start -->
	<div class="ls-box ls-layer-box">
		<input type="hidden" name="layerkey" value="0">
		<table>
			<thead class="ls-layer-options-thead">
				<tr>
					<td colspan="7">
						<h4><span class="icon-th-list"></span>
							<?php echo $layer_options; ?>
							<a href="#" class="duplicate ls-layer-duplicate">
								<?php echo $duplicate_this_layer; ?>
							</a>
						</h4>
					</td>
				</tr>
			</thead>
			<tbody class="ls-slide-options">
				<tr>
					<td class="right"><?php echo $slide_options; ?></td>
					<td class="right"><?php echo $background; ?> <i title="<?php echo $help_layer_Background; ?>" class="icon-question-sign vtip"></i></td>
					<td>
						<div class="reset-parent">
							<input type="text" name="background" class="ls-upload" value="">
							<span class="ls-reset icon-remove-sign"></span>
						</div>
					</td>
					<td class="right"><?php echo $direction; ?> <i title="<?php echo $help_layer_Direction; ?>" class="icon-question-sign vtip"></i></td>
					<td>
						<select name="slidedirection">
							<option value="top">top</option>
							<option value="right" selected="selecter">right</option>
							<option value="bottom">bottom</option>
							<option value="left">left</option>
						</select>
					</td>
					<td class="right"><?php echo $delay; ?> <i title="<?php echo $help_layer_Delay; ?>" class="icon-question-sign vtip"></i></td>
					<td><input type="text" name="slidedelay" value="4000"> (ms)</td>
				</tr>
				<tr>
					<td class="right"><?php echo $slide_in_animation; ?></td>
					<td class="right"><?php echo $duration; ?>  <i title="<?php echo $help_slide_Duration_in; ?>" class="icon-question-sign vtip"></i></td>
					<td><input type="text" name="durationin" value="1500"> (ms)</td>
					<td class="right"><?php echo $easing; ?> <i title="<?php echo $help_slide_Easing; ?>" class="icon-question-sign vtip"></i></td>
					<td>
						<select name="easingin">
							<option>linear</option>
							<option>swing</option>
							<option>easeInQuad</option>
							<option>easeOutQuad</option>
							<option>easeInOutQuad</option>
							<option>easeInCubic</option>
							<option>easeOutCubic</option>
							<option>easeInOutCubic</option>
							<option>easeInQuart</option>
							<option>easeOutQuart</option>
							<option>easeInOutQuart</option>
							<option>easeInQuint</option>
							<option>easeOutQuint</option>
							<option selected="selected">easeInOutQuint</option>
							<option>easeInSine</option>
							<option>easeOutSine</option>
							<option>easeInOutSine</option>
							<option>easeInExpo</option>
							<option>easeOutExpo</option>
							<option>easeInOutExpo</option>
							<option>easeInCirc</option>
							<option>easeOutCirc</option>
							<option>easeInOutCirc</option>
							<option>easeInElastic</option>
							<option>easeOutElastic</option>
							<option>easeInOutElastic</option>
							<option>easeInBack</option>
							<option>easeOutBack</option>
							<option>easeInOutBack</option>
							<option>easeInBounce</option>
							<option>easeOutBounce</option>
							<option>easeInOutBounce</option>
						</select>
					</td>
					<td class="right"><?php echo $delay; ?> <i title="<?php echo $help_slide_Delay; ?>" class="icon-question-sign vtip"></i></td>
					<td><input type="text" name="delayin" value="0"> (ms)</td>
				</tr>
				<tr>
					<td class="right"><?php echo $slide_out_animation; ?></td>
					<td class="right"><?php echo $duration; ?><i title="<?php echo $help_slide_Duration_out; ?>" class="icon-question-sign vtip"></i></td>
					<td><input type="text" name="durationout" value="1500"> (ms)</td>
					<td class="right"><?php echo $easing; ?> <i title="<?php echo $help_slide_Easing; ?>" class="icon-question-sign vtip"></i></td>
					<td>
						<select name="easingout">
							<option>linear</option>
							<option>swing</option>
							<option>easeInQuad</option>
							<option>easeOutQuad</option>
							<option>easeInOutQuad</option>
							<option>easeInCubic</option>
							<option>easeOutCubic</option>
							<option>easeInOutCubic</option>
							<option>easeInQuart</option>
							<option>easeOutQuart</option>
							<option>easeInOutQuart</option>
							<option>easeInQuint</option>
							<option>easeOutQuint</option>
							<option selected="selected">easeInOutQuint</option>
							<option>easeInSine</option>
							<option>easeOutSine</option>
							<option>easeInOutSine</option>
							<option>easeInExpo</option>
							<option>easeOutExpo</option>
							<option>easeInOutExpo</option>
							<option>easeInCirc</option>
							<option>easeOutCirc</option>
							<option>easeInOutCirc</option>
							<option>easeInElastic</option>
							<option>easeOutElastic</option>
							<option>easeInOutElastic</option>
							<option>easeInBack</option>
							<option>easeOutBack</option>
							<option>easeInOutBack</option>
							<option>easeInBounce</option>
							<option>easeOutBounce</option>
							<option>easeInOutBounce</option>
						</select>
					</td>
					<td class="right"><?php echo $delay; ?> <i title="<?php echo $help_slide_Delay; ?>" class="icon-question-sign vtip"></td>
					<td><input type="text" name="delayout" value="0"> (ms)</td>
				</tr>
				<tr style="display:none;">
					<td class="right">Misc</td>
					<td class="right">#ID</td>
					<td><input type="text" name="id" value=""></td>
					<td class="right">Deeplink</td>
					<td><input type="text" name="deeplink"></td>
					<td class="right">Hidden</td>
					<td><input type="checkbox" name="skip" class="checkbox"></td>
				</tr>
				<tr>
					<td class="right"><?php echo $navigation; ?></td>
					<td class="right"><?php echo $thumbnail; ?> <i title="<?php echo $help_slide_Thumbnail; ?>" class="icon-question-sign vtip"></td>
					<td colspan="5">
						<div class="reset-parent">
							<input type="text" name="thumbnail" class="ls-upload" value="">
							<span class="ls-reset icon-remove-sign"></span>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<table>
			<thead>
				<tr>
					<td>
						<h4><span class="icon-eye-open"></span>
									<?php echo $preview; ?> <i title="<?php echo $help_wisiwig_editor; ?>" class="icon-question-sign vtip_l"></i>
						</h4>
					</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="ls-preview-td">
						<div class="ls-preview-wrapper">
							<div class="ls-preview">
								<div class="draggable"></div>
							</div>
							<div class="ls-real-time-preview"></div>
							<button class="button ls-preview-button"><i class="icon-play"></i> <?php echo $enter_preview; ?></button>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<table>
			<thead>
				<tr>
					<td>
						<h4><span class="icon-th-large"></span>
									<?php echo $sublayers; ?> <i title="<?php echo $help_sublayers; ?>" class="icon-question-sign vtip_l"></i></h4>
					</td>
				</tr>
			</thead>
			<tbody class="ls-sublayers ls-sublayer-sortable">
				<tr>
					<td>
						<div class="ls-sublayer-wrapper">
							<span class="ls-sublayer-number">1</span>
							<span class="ls-highlight"><input type="checkbox"></span>
							<input type="text" name="subtitle" class="ls-sublayer-title" value="Sublayer #1">
							<div class="clear"></div>
							<div class="ls-sublayer-nav">
								<a href="#" class="active"><?php echo $basic; ?> <i title="<?php echo $help_sub_Basic; ?>" class="icon-question-sign vtip"></i></a>
								<a href="#"><?php echo $options; ?> <i title="<?php echo $help_sub_Options; ?>" class="icon-question-sign vtip"></i></a>
								<a href="#"><?php echo $link; ?> <i title="<?php echo $help_sub_Link; ?>" class="icon-question-sign vtip"></i></a>
								<a href="#"><?php echo $style; ?> <i title="<?php echo $help_sub_Style; ?>" class="icon-question-sign vtip"></i></a>
								<a href="#"><?php echo $attributes; ?> <i title="<?php echo $help_sub_Attributes; ?>" class="icon-question-sign vtip_r"></i></a>
								<a href="#" title="Remove this sublayer'" class="remove"><span class="icon-remove-sign"></span></a>
							</div>
							<div class="ls-sublayer-pages">
								<div class="ls-sublayer-page ls-sublayer-basic active">
									<select name="type">
										<option selected="selected"><?php echo $product; ?></option>
										<option>img</option>
										<option>div</option>
										<option>p</option>
										<option>span</option>
										<option>h1</option>
										<option>h2</option>
										<option>h3</option>
										<option>h4</option>
										<option>h5</option>
										<option>h6</option>
									</select>
									<div class="ls-sublayer-types">
										<span class="ls-type">
											<span class="ls-icon-product"></span><br>
											<?php echo $Product; ?>
										</span>
										<span class="ls-type">
											<span class="ls-icon-img"></span><br>
											Image
										</span>

										<span class="ls-type">
											<span class="ls-icon-div"></span><br>
											Div
										</span>

										<span class="ls-type">
											<span class="ls-icon-p"></span><br>
											Paragraph
										</span>

										<span class="ls-type">
											<span class="ls-icon-span"></span><br>
											Span
										</span>

										<span class="ls-type">
											<span class="ls-icon-h1"></span><br>
											H1
										</span>

										<span class="ls-type">
											<span class="ls-icon-h2"></span><br>
											H2
										</span>

										<span class="ls-type">
											<span class="ls-icon-h3"></span><br>
											H3
										</span>

										<span class="ls-type">
											<span class="ls-icon-h4"></span><br>
											H4
										</span>

										<span class="ls-type">
											<span class="ls-icon-h5"></span><br>
											H5
										</span>

										<span class="ls-type">
											<span class="ls-icon-h6"></span><br>
											H6
										</span>
									</div>
									<div class="ls-product-uploader">
										<h5 style="margin-bottom:8px;"><?php echo $product_in_sublayer; ?> <a href="#" class="ls-add-product"><?php echo $add_new_product; ?></a><a href="#" class="ls-icon-del"><?php echo $remove_product; ?></a></h5>
										
										<!-- LABEL FOR PRODUCT START -->
										<?php if(count($labels['data'])) { ?> <!-- lev.1 -->
										<div class="product_labels" style="margin-botom:8px;">

											<!-- data for server start-->
											<input type="hidden" name="label_type" value="">
											<input type="hidden" name="label_color" value="">
											<input type="hidden" name="label_file" value="">
											<!-- data for server end-->
											
											<div class="product_labels_text">Label for product:</div>
														
											<div style=" text-align:right; margin-bottom:5px;">
												<div style="float:left; margin-right:15px;">
													<label>Horisontal position:
													<select style="display:inline;" name="label_pos_hor">
														<option data-value = "right" value="right">Right</option>
														<option data-value = "right" value="left">Left</option>
													</select></label>
													<input style="width: 40px;"  type="text" name="label_pos_hor_val" value="50%">
												</div>
												<div style="float:left; margin-right:15px;">
													<label>Vertical position:
													<select style="display:inline;" name="label_pos_ver">
														<option data-value = "top" value="top">Top</option>
														<option data-value = "top" value="bottom">Bottom</option>
													</select></label>
													<input style="width: 40px;" type="text" name="label_pos_ver_val" value="0">
												</div>
												<div style="clear:both;"></div>
											</div>
											
											<?php foreach($labels['data'] as $label) { ?> <!-- lev.2 -->
											<div class="product_label" data-type="<?php echo $label['type'] ?>">
												
												<span class="label_name"><?php echo $label['name']; ?></span>
												<div class="color_box">
													<ul>
														<?php 
														$index = 1;
														foreach($label['colors'] as $color) {	?>
														<li style="background-color: #<?php echo $color; ?>;" >
																<a class="<?php if($index) echo 'color_box_activ' ?>" data-color="<?php echo $color; ?>"></a>
														</li>
														<?php $index = 0;} ?>
													</ul>
												</div>

												<select data-path="<?php echo $label['path'] ; ?>" class="d_d-sample" style="width:180px;">
													<option data-image="<?php echo $labels['image_null']; ?>" data-imagecss="w20_h20" value="" selected="selected">
														Choose...
													</option>
													<?php foreach($label['files'] as $file) { 
														$data_image = $label['path'] .$label['colors'][0]  .'/'.$file['file'];
													?><!-- lev.3 -->
													<option data-imagecss="w_50" data-image="<?php echo $data_image; ?>" value="<?php echo $file['file']; ?>" >
														<?php echo $file['name']; ?>
													</option>
													<?php } ?> <!-- lev.3 -->
												</select>
											</div>
											<?php } ?> <!-- lev.2 -->
											<div style="clear:both;"></div>
										</div>
										<?php } ?> <!-- lev.1 -->
										<!-- LABEL FOR PRODUCT END -->
													
										<div style="clear:both; margin-botom:8px;">
										<?php echo $set_discount_label; ?>
										<select style="display:inline;" name="discount">
										<?php 
										$discounts = array('10','15','20','30','35','40','45','50','60'); 
											$select = 'selected="selected"';
											
											echo '<option '.$select.' value="" >Choose Discount</option>';
											
											foreach($discounts as $discount){

												echo '<option value ="'.$discount.'">'.$discount.'%</option>';
											}
										?>
										</select>
										</div>
										<input type="hidden" name="product" value="">
									</div>
									<div class="ls-image-uploader">
									<!-- TODO IMAGE src-->
										<img src="" alt="sublayer image">
										<input type="text" name="image" class="ls-upload" value="">
										<p>
											<?php echo $text_field; ?>
										</p>
									</div>

									<div class="ls-html-code">
										<h5><?php echo $custom_content; ?></h5>
										<textarea name="html" cols="50" rows="5"></textarea>
									</div>
								</div>
								<div class="ls-sublayer-page ls-sublayer-options">
									<table>
										<tbody>
											<tr>
												<td><?php echo $slide_in_animation; ?></td>
												<td class="right"><?php echo $direction; ?> <i title="<?php echo $help_sub_Direction_in; ?>" class="icon-question-sign vtip"></i></td>
												<td>
													<select name="slidedirection">
														<option value="auto">auto</option>
														<option value="fade">fade</option>
														<option value="top">top</option>
														<option value="right">right</option>
														<option value="bottom">bottom</option>
														<option value="left">left</option>
													</select>
												</td>
												<td class="right"><?php echo $duration; ?> <i title="<?php echo $help_sub_Duration_in; ?>" class="icon-question-sign vtip"></i></td>
												<td><input type="text" name="durationin" value="1500"> (ms)</td>
												<td class="right"><?php echo $easing; ?> <i title="<?php echo $help_sub_Easing; ?>" class="icon-question-sign vtip"></i></td>
												<td>
													<select name="easingin">
														<option>linear</option>
														<option>swing</option>
														<option>easeInQuad</option>
														<option>easeOutQuad</option>
														<option>easeInOutQuad</option>
														<option>easeInCubic</option>
														<option>easeOutCubic</option>
														<option>easeInOutCubic</option>
														<option>easeInQuart</option>
														<option>easeOutQuart</option>
														<option>easeInOutQuart</option>
														<option>easeInQuint</option>
														<option>easeOutQuint</option>
														<option selected="selected">easeInOutQuint</option>
														<option>easeInSine</option>
														<option>easeOutSine</option>
														<option>easeInOutSine</option>
														<option>easeInExpo</option>
														<option>easeOutExpo</option>
														<option>easeInOutExpo</option>
														<option>easeInCirc</option>
														<option>easeOutCirc</option>
														<option>easeInOutCirc</option>
														<option>easeInElastic</option>
														<option>easeOutElastic</option>
														<option>easeInOutElastic</option>
														<option>easeInBack</option>
														<option>easeOutBack</option>
														<option>easeInOutBack</option>
														<option>easeInBounce</option>
														<option>easeOutBounce</option>
														<option>easeInOutBounce</option>
													</select>
												</td>
												<td class="right"><?php echo $delay; ?> <i title="<?php echo $help_sub_Delay_in; ?>" class="icon-question-sign vtip"></i></td>
												<td><input type="text" name="delayin" value="0"> (ms)</td>
											</tr>

											<tr>
												<td><?php echo $slide_out_animation; ?></td>
												<td class="right"><?php echo $direction; ?> <i title="<?php echo $help_sub_Direction_out; ?>" class="icon-question-sign vtip"></i></td>
												<td>
													<select name="slideoutdirection">
														<option value="auto">auto</option>
														<option value="fade">fade</option>
														<option value="top">top</option>
														<option value="right">right</option>
														<option value="bottom">bottom</option>
														<option value="left">left</option>
													</select>
												</td>
												<td class="right"><?php echo $duration; ?> <i title="<?php echo $help_sub_Duration_out; ?>" class="icon-question-sign vtip"></i></td>
												<td><input type="text" name="durationout" value="1500"> (ms)</td>
												<td class="right"><?php echo $easing; ?> <i title="<?php echo $help_sub_Easing; ?>" class="icon-question-sign vtip"></i></td>
												<td>
													<select name="easingout">
														<option>linear</option>
														<option>swing</option>
														<option>easeInQuad</option>
														<option>easeOutQuad</option>
														<option>easeInOutQuad</option>
														<option>easeInCubic</option>
														<option>easeOutCubic</option>
														<option>easeInOutCubic</option>
														<option>easeInQuart</option>
														<option>easeOutQuart</option>
														<option>easeInOutQuart</option>
														<option>easeInQuint</option>
														<option>easeOutQuint</option>
														<option selected="selected">easeInOutQuint</option>
														<option>easeInSine</option>
														<option>easeOutSine</option>
														<option>easeInOutSine</option>
														<option>easeInExpo</option>
														<option>easeOutExpo</option>
														<option>easeInOutExpo</option>
														<option>easeInCirc</option>
														<option>easeOutCirc</option>
														<option>easeInOutCirc</option>
														<option>easeInElastic</option>
														<option>easeOutElastic</option>
														<option>easeInOutElastic</option>
														<option>easeInBack</option>
														<option>easeOutBack</option>
														<option>easeInOutBack</option>
														<option>easeInBounce</option>
														<option>easeOutBounce</option>
														<option>easeInOutBounce</option>
													</select>
												</td>
												<td class="right"><?php echo $delay; ?> <i title="<?php echo $help_sub_Delay_out; ?>" class="icon-question-sign vtip"></i></td>
												<td><input type="text" name="delayout" value="0"> (ms)</td>
											</tr>

											<tr>
												<td><?php echo $other_options; ?></td>
												<td class="right"><?php echo $p_level; ?> <i title="<?php echo $help_sub_P_level; ?>" class="icon-question-sign vtip"></i></td>
												<td><input type="text" name="level" value="2"></td>
												<td class="right"><?php echo $show_until; ?> <i title="<?php echo $help_sub_Show_until; ?>" class="icon-question-sign vtip"></i></td>
												<td><input type="text" name="showuntil" value="0"> (ms)</td>
												<td class="right"><?php echo $hidden; ?><i title="<?php echo $help_sub_Hidden; ?>" class="icon-question-sign vtip"></i></td>
												<td><input type="checkbox" name="skip" class="checkbox"></td>
												<td colspan="3"><button class="button duplicate"><?php echo $duplicate_this_sublayer; ?></button></td>
											</tr>
									</table>
								</div>
								<div class="ls-sublayer-page ls-sublayer-link">
									<table>
										<tbody>
											<tr>
												<td>URL</td>
												<td class="url"><input type="text" name="url" value=""></td>
												<td>
													<select name="target">
														<option>_self</option>
														<option>_blank</option>
													</select>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="ls-sublayer-page ls-sublayer-style">
									<table>
										<tbody>
											<tr>
												<td rowspan="2" ><?php echo $basic_style_settings; ?></td>
												<td class="right">
													<?php echo $top; ?><input type="text" name="top" value="50%">
												</td>
												<td class="right">
													<?php echo $left; ?><input type="text" name="left" value="50%">
												</td>
												<td class="right"><?php echo $height; ?><input type="text" name="height" value="80%"></td>
												<td class="right"><?php echo $transparent; ?><input type="text" name="transparent" value="100"></td>
											</tr>
											<tr>
												<td class="right">
													<?php echo $bottom; ?><input type="text" name="bottom" value="">
												</td>
												<td class="right">
													<?php echo $right; ?><input type="text" name="right" value="">
												</td>
												<td class="right"><?php echo $width; ?><input type="text" name="width" value=""></td>
												<td class="right"><?php echo $word_wrap; ?><input type="checkbox" name="wordwrap" class="checkbox"></td>
											</tr>
											<tr>
												<td><?php echo $custom_style; ?></td>
												<td class="right"></td>
												<td colspan="4"><textarea rows="5" cols="50" name="style" class="style"></textarea></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="ls-sublayer-page ls-sublayer-attributes">
									<table>
										<tbody>
											<tr>
												<td><?php echo $attributes; ?></td>
												<td class="right">ID</td>
												<td><input type="text" name="id" value=""></td>
												<td class="right">Classes</td>
												<td><input type="text" name="class" value=""></td>
												<td class="right">Title</td>
												<td><input type="text" name="title" value=""></td>
												<td class="right">Alt</td>
												<td><input type="text" name="alt" value=""></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<a href="#" class="ls-add-sublayer"><span class="icon-plus-sign"></span> <?php echo $add_sublayer; ?></a>
	</div>
</div>

<form action="test" method="post" class="wrap" id="ls-slider-form">

	<input type="hidden" name="posted_edit" value="1">

	<!-- Main menu bar -->
	<div id="tabs" class="htabs">
		<a href="#tab-general"><?php echo $global_settings; ?> <i title="<?php echo $help_global_about; ?>" class="icon-question-sign vtip_b"></i></a>
		<a href="#tab-layers"><?php echo $layers; ?> <i title="<?php echo $help_layer_about; ?>" class="icon-question-sign vtip_b"></i></a>
		<a href="#tab-callback"><?php echo $event_callbacks; ?> <i title="<?php echo $help_call_about; ?>" class="icon-question-sign vtip_b"></i></a>
	</div>
	<!-- Pages -->
	<div id="ls-pages">

	<!-- Global Settings -->
		<div id="tab-general" class="ls-page ls-settings active">
			
			<div id="post-body-content">
				<div id="titlediv">
					<div id="titlewrap" style="line-height:24px; vertical-align:top;" >
						<input style=" border-color: #ccc;width: 220px;height: 22px;font-size: 18px;" name="title" value="<?php echo $slider['properties']['title'] ?>" id="title" autocomplete="off" placeholder="Type your slider name here'">
					</div>
				</div>
			</div>

			<div class="ls-box">
				<h3 class="header"><?php echo $global_settings; ?></h3>
				<table>
					<thead>
						<tr>
							<td colspan="3">
								<h4 ><span class="icon-book"></span>
								<?php echo $basic; ?></h4>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><?php echo $slider_width; ?></td>
							<td><input type="text" name="width" value="<?php echo $slider['properties']['width'] ?>" class="input"></td>
							<td class="desc"><?php echo $slider_width_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $slider_height; ?></td>
							<td><input type="text" name="height" value="<?php echo $slider['properties']['height'] ?>" class="input"></td>
							<td class="desc"><?php echo $slider_height_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $responsive; ?></td>
							<td><input type="checkbox" name="responsive" <?php echo isset($slider['properties']['responsive']) ? 'checked="checked"' : '' ?>></td>
							<td class="desc"><?php echo $responsive_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $full_width_slider; ?></td>
							<td><input type="checkbox" name="forceresponsive" <?php echo ( isset($slider['properties']['forceresponsive']) && $slider['properties']['forceresponsive'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc"><?php echo $full_width_slider_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $responsive_under; ?></td>
							<td><input type="text" name="responsiveunder" value="<?php echo !empty($slider['properties']['responsiveunder']) ? $slider['properties']['responsiveunder'] : '0' ?>"></td>
							<td class="desc"><?php echo $responsive_under_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $sublayer_container; ?></td>
							<td><input type="text" name="sublayercontainer" value="<?php echo !empty($slider['properties']['sublayercontainer']) ? $slider['properties']['sublayercontainer'] : '0' ?>"></td>
							<td class="desc"><?php echo $sublayer_container_info; ?></td>
						</tr>
					</tbody>
					<thead>
						<tr>
							<td colspan="3">
								<h4><span class="icon-film"></span>
								<?php echo $slideshow; ?></h4>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><?php echo $automatically_start; ?></td>
							<td><input type="checkbox" name="autostart" <?php echo ( isset($slider['properties']['autostart']) && $slider['properties']['autostart'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc"><?php echo $automatically_start_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $pause_hover; ?></td>
							<td><input type="checkbox" name="pauseonhover" <?php echo ( isset($slider['properties']['pauseonhover']) && $slider['properties']['pauseonhover'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc"><?php echo $pause_hover_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $first_layer; ?></td>
							<td><input type="text" name="firstlayer" value="<?php echo $slider['properties']['firstlayer'] ?>" class="input"></td>
							<td class="desc"><?php echo $first_layer_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $animate_first_layer; ?></td>
							<td><input type="checkbox" name="animatefirstlayer" <?php echo ( isset($slider['properties']['animatefirstlayer']) && $slider['properties']['animatefirstlayer'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc"><?php echo $animate_first_layer_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $random_slideshow; ?></td>
							<td><input type="checkbox" name="randomslideshow" <?php echo ( isset($slider['properties']['randomslideshow']) && $slider['properties']['randomslideshow'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc"><?php echo $random_slideshow_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $two_way_slideshow; ?></td>
							<td><input type="checkbox" name="twowayslideshow" <?php echo ( isset($slider['properties']['twowayslideshow']) && $slider['properties']['twowayslideshow'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc"><?php echo $two_way_slideshow_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $loops; ?></td>
							<td>
								<select name="loops">
									<?php for($c = 0; $c < 11; $c++) : ?>
									<?php if($slider['properties']['loops'] == $c) { ?>
									<option selected="selected"><?php echo $c ?></option>
									<?php } else {  ?>
									<option><?php echo $c ?></option>
									<?php } ?>
									<?php endfor; ?>
								</select>
							</td>
							<td class="desc"><?php echo $loops_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $force_number; ?></td>
							<td><input type="checkbox" name="forceloopnum" <?php echo ( isset($slider['properties']['forceloopnum']) && $slider['properties']['forceloopnum'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc"><?php echo $force_number_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $automatically_play_videos; ?></td>
							<td><input type="checkbox" name="autoplayvideos" <?php echo ( isset($slider['properties']['autoplayvideos']) && $slider['properties']['autoplayvideos'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc"><?php echo $automatically_play_videos_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $automatically_pause_videos; ?></td>
							<td>
								<select name="autopauseslideshow">
									<option <?php echo ($slider['properties']['autopauseslideshow'] == 'auto') ? 'selected="selected"' : '' ?>>auto</option>
									<option <?php echo ($slider['properties']['autopauseslideshow'] == 'enabled') ? 'selected="selected"' : '' ?>>enabled</option>
									<option <?php echo ($slider['properties']['autopauseslideshow'] == 'disabled') ? 'selected="selected"' : '' ?>>disabled</option>
								</select>
							</td>
							<td class="desc"><?php echo $automatically_pause_videos_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $youtube_preview; ?></td>
							<td>
								<select name="youtubepreview">
									<option value="maxresdefault.jpg">Maximum quality</option>
									<option value="hqdefault.jpg">High quality</option>
									<option value="mqdefault.jpg">Medium quality</option>
									<option value="default.jpg">Default quality</option>
								</select>
							</td>
							<td class="desc"><?php echo $youtube_preview_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $keyboard_navigation; ?></td>
							<td><input type="checkbox" name="keybnav" <?php echo ( isset($slider['properties']['keybnav']) && $slider['properties']['keybnav'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc"><?php echo $keyboard_navigation_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $touch_navigation; ?></td>
							<td><input type="checkbox" name="touchnav" <?php echo ( isset($slider['properties']['touchnav']) && $slider['properties']['touchnav'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc"><?php echo $touch_navigation_info; ?></td>
						</tr>
					</tbody>
					<thead>
						<tr>
							<td colspan="3">
								<h4><span class="icon-leaf"></span>
								<?php echo $appearance; ?></h4>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><?php echo $skin; ?></td>
							<td>
								<select name="skin">
									<?php $files = scandir( $layerSkinDir); ?>
									<?php foreach($files as $entry) : ?>
									<?php if($entry == '.' || $entry == '..' || $entry == 'preview') continue; ?>
									<?php if($entry == $slider['properties']['skin']) { ?>
									<option selected="selected"><?php echo $entry ?></option>
									<?php } else { ?>
									<option><?php echo $entry ?></option>
									<?php } ?>
									<?php endforeach; ?>
								</select>
							</td>
							<td class="desc"><?php echo $skin_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $background_color; ?></td>
							<td>
								<div class="reset-parent">
									<input type="text" name="backgroundcolor" value="<?php echo $slider['properties']['backgroundcolor'] ?>" class="input color">
									<div class="ls-colorpicker">colorpicker</div>
								</div>
							</td>
							<td class="desc"><?php echo $background_color_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $background_image; ?></td>
							<td>
								<div class="reset-parent">
									<input data-relat_url="<?php if($slider['properties']['backgroundimage']) echo $slider['properties']['backgroundimage']; ?>" type="text" name="backgroundimage" value="<?php if($slider['properties']['backgroundimage']) echo  $mainImagePath . $slider['properties']['backgroundimage'] ?>" class="input ls-upload">
									<span class="ls-reset icon-remove-sign"></span>
								</div>
							</td>
							<td class="desc"><?php echo $background_image_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $slider_style; ?></td>
							<td>
								<div class="reset-parent">
									<input type="text" name="sliderstyle" value="<?php echo isset($slider['properties']['sliderstyle']) ? $slider['properties']['sliderstyle'] : '' ?>" class="input">
									<span class="ls-reset icon-remove-sign"></span>
								</div>
							</td>
							<td class="desc"><?php echo $slider_style_info; ?></td>
						</tr>
					</tbody>
					<thead>
						<tr>
							<td colspan="3">
								<h4><span class="icon-road"></span>
								<?php echo $navigation; ?></h4>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><?php echo $prev_next_buttons; ?></td>
							<td><input type="checkbox" name="navprevnext" <?php echo ( isset($slider['properties']['navprevnext']) && $slider['properties']['navprevnext'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc"><?php echo $prev_next_buttons_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $start_stop_buttons; ?></td>
							<td><input type="checkbox" name="navstartstop" <?php echo ( isset($slider['properties']['navstartstop']) && $slider['properties']['navstartstop'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc"><?php echo $start_stop_buttons_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $navigation_buttons; ?></td>
							<td><input type="checkbox" name="navbuttons" <?php echo ( isset($slider['properties']['navbuttons']) && $slider['properties']['navbuttons'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc"><?php echo $navigation_buttons_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $prev_next_buttons_hover; ?></td>
							<td><input type="checkbox" name="hoverprevnext" <?php echo ( isset($slider['properties']['hoverprevnext']) && $slider['properties']['hoverprevnext'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc"><?php echo $prev_next_buttons_hover_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $bottom_navigation_hover; ?></td>
							<td><input type="checkbox" name="hoverbottomnav" <?php echo ( isset($slider['properties']['hoverbottomnav']) && $slider['properties']['hoverbottomnav'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc"><?php echo $bottom_navigation_hover_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $thumbnail_navigation; ?></td>
							<td>
								<?php $slider['properties']['thumb_nav'] = !empty($slider['properties']['thumb_nav']) ? $slider['properties']['thumb_nav'] : 'hover'; ?>
								<select name="thumb_nav">
									<option <?php echo ($slider['properties']['thumb_nav'] == 'disabled') ? 'selected="selected"' : '' ?>>disabled</option>
									<option <?php echo ($slider['properties']['thumb_nav'] == 'hover') ? 'selected="selected"' : '' ?>>hover</option>
									<option <?php echo ($slider['properties']['thumb_nav'] == 'always') ? 'selected="selected"' : '' ?>>always</option>
								</select>
							</td>
							<td class="desc"></td>
						</tr>
						<tr>
							<td><?php echo $thumbnail_width; ?></td>
							<td><input type="text" name="thumb_width" value="<?php echo !empty($slider['properties']['thumb_width']) ? $slider['properties']['thumb_width'] : '100' ?>"></td>
							<td class="desc"><?php echo $thumbnail_width_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $thumbnail_height; ?></td>
							<td><input type="text" name="thumb_height" value="<?php echo !empty($slider['properties']['thumb_height']) ? $slider['properties']['thumb_height'] : '60' ?>"></td>
							<td class="desc"><?php echo $thumbnail_height_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $thumbnail_container_width; ?></td>
							<td><input type="text" name="thumb_container_width" value="<?php echo !empty($slider['properties']['thumb_container_width']) ? $slider['properties']['thumb_container_width'] : '60%' ?>"></td>
							<td class="desc"><?php echo $thumbnail_container_width_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $thumbnail_active_opacity; ?></td>
							<td><input type="text" name="thumb_active_opacity" value="<?php echo !empty($slider['properties']['thumb_active_opacity']) ? $slider['properties']['thumb_active_opacity'] : '35' ?>"></td>
							<td class="desc"><?php echo $thumbnail_active_opacity_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $thumbnail_inactive_opacity; ?></td>
							<td><input type="text" name="thumb_inactive_opacity" value="<?php echo !empty($slider['properties']['thumb_inactive_opacity']) ? $slider['properties']['thumb_inactive_opacity'] : '100' ?>"></td>
							<td class="desc"><?php echo $thumbnail_inactive_opacity_info; ?></td>
						</tr>
					</tbody>
					<thead>
						<tr>
							<td colspan="3">
								<h4><span class="icon-cog"></span>
								Misc</h4>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><?php echo $image_preload; ?></td>
							<td><input type="checkbox" name="imgpreload" <?php echo ( isset($slider['properties']['imgpreload']) && $slider['properties']['imgpreload'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc"><?php echo $image_preload_info; ?></td>
						</tr>
						<tr style="display:none;">
							<td style="display:none;">Use relative URLs</td>
							<td><input type="checkbox" name="relativeurls" <?php echo ( isset($slider['properties']['relativeurls']) && $slider['properties']['relativeurls'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc"></td>
						</tr>
					</tbody>
					<thead>
						<tr>
							<td colspan="3">
								<h4><span class="icon-flag"></span>
								<?php echo $your_logo; ?></h4>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><?php echo $your_logo; ?></td>
							<td>
								<div class="reset-parent">
									<input data-relat_url="<?php if($slider['properties']['yourlogo']) echo  $slider['properties']['yourlogo']; ?>" type="text" name="yourlogo" value="<?php if($slider['properties']['yourlogo']) echo  $mainImagePath . $slider['properties']['yourlogo'] ?>" class="input ls-upload">
									<span class="ls-reset icon-remove-sign"></span>
								</div>
							</td>
							<td class="desc"><?php echo $your_logo_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $your_logo_style; ?></td>
							<td><input type="text" name="yourlogostyle" value="<?php echo $slider['properties']['yourlogostyle'] ?>" class="input"></td>
							<td class="desc"><?php echo $your_logo_style_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $your_logo_link; ?></td>
							<td>
								<div class="reset-parent">
									<input type="text" name="yourlogolink" value="<?php echo $slider['properties']['yourlogolink'] ?>" class="input">
									<span class="ls-reset icon-remove-sign"></span>
								</div>
							</td>
							<td class="desc"><?php echo $your_logo_link_info; ?></td>
						</tr>
						<tr>
							<td><?php echo $your_logo_link_target; ?></td>
							<td>
								<select name="yourlogotarget">
									<option <?php echo ($slider['properties']['yourlogotarget'] == '_self') ? 'selected="selected"' : '' ?>>_self</option>
									<option <?php echo ($slider['properties']['yourlogotarget'] == '_blank') ? 'selected="selected"' : '' ?>>_blank</option>
								</select>
							</td>
							<td class="desc"><?php echo $your_logo_link_target_info; ?></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

	<!-- Layers START -->
		<div id="tab-layers" class="ls-page">

			<div id="ls-layer-tabs">
				<?php foreach($slider['layers'] as $key => $layer) : ?>
				<?php $active = empty($key) ? 'active' : '' ?>
				<a href="#" class="<?php echo $active ?>">Layer #<?php echo ($key+1) ?> <span class="icon-remove-sign"></span></a>
				<?php endforeach; ?>
				<a href="#" class="unsortable" id="ls-add-layer"><i class="icon-plus-sign"></i> <?php echo $add_new_layer; ?></a>
				<div class="unsortable clear"></div>
			</div>
	<!-- layers -->	
			<div id="ls-layers">
				<?php if(!empty($slider['layers'])) : ?>
				<?php foreach($slider['layers'] as $key => $layer) : ?>
				<?php $active = empty($key) ? 'active' : '' ?>
				<div class="ls-box ls-layer-box <?php echo $active ?>">
					<input type="hidden" name="layerkey" value="0">
					<table>
						<thead class="ls-layer-options-thead">
							<tr>
								<td colspan="7">
									<h4><span class="icon-th-list"></span>
									
										<?php echo $layer_options; ?>
										<a href="#" class="duplicate ls-layer-duplicate">Duplicate this layer</a>
									</h4>
								</td>
							</tr>
						</thead>
						<tbody class="ls-slide-options">
							<tr>
								<td class="right"><?php echo $slide_options; ?></td>
								<td class="right"><?php echo $background; ?> <i title="<?php echo $help_layer_Background; ?>" class="icon-question-sign vtip"></i></td>
								<td>
									<div class="reset-parent">
										<input data-relat_url="<?php if($layer['properties']['background']) echo  $layer['properties']['background'];?>" type="text" name="background" class="ls-upload" value="<?php if($layer['properties']['background']) echo  $mainImagePath . $layer['properties']['background']?>">
										<span class="ls-reset icon-remove-sign"></span>
										
									</div>
								</td>
								<td class="right"><?php echo $direction; ?>  <i title="<?php echo $help_layer_Direction; ?>" class="icon-question-sign vtip"></td>
								<td>
									<select name="slidedirection">
										<option value="top" <?php echo ($layer['properties']['slidedirection'] == 'top') ? 'selected="selected"' : '' ?>>top</option>
										<option value="right" <?php echo ($layer['properties']['slidedirection'] == 'right') ? 'selected="selected"' : '' ?>>right</option>
										<option value="bottom" <?php echo ($layer['properties']['slidedirection'] == 'bottom') ? 'selected="selected"' : '' ?>>bottom</option>
										<option value="left" <?php echo ($layer['properties']['slidedirection'] == 'left') ? 'selected="selected"' : '' ?>>left</option>
									</select>
								</td>
								<td class="right"><?php echo $delay; ?>  <i title="<?php echo $help_layer_Delay; ?>" class="icon-question-sign vtip"></td>
								<td><input type="text" name="slidedelay" value="<?php echo $layer['properties']['slidedelay']?>"> (ms)</td>
							</tr>
							<tr>
								<td class="right"><?php echo $slide_in_animation; ?></td>
								<td class="right"><?php echo $duration; ?>  <i title="<?php echo $help_slide_Duration_in; ?>" class="icon-question-sign vtip"></td>
								<td><input type="text" name="durationin" value="<?php echo $layer['properties']['durationin']?>"> (ms)</td>
								<td class="right"><?php echo $easing; ?>  <i title="<?php echo $help_slide_Easing; ?>" class="icon-question-sign vtip"></td>
								<td>
									<select name="easingin">
										<option <?php echo ($layer['properties']['easingin'] == 'linear') ? 'selected="selected"' : '' ?>>linear</option>
										<option <?php echo ($layer['properties']['easingin'] == 'swing') ? 'selected="selected"' : '' ?>>swing</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInQuad') ? 'selected="selected"' : '' ?>>easeInQuad</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeOutQuad') ? 'selected="selected"' : '' ?>>easeOutQuad</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInOutQuad') ? 'selected="selected"' : '' ?>>easeInOutQuad</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInCubic') ? 'selected="selected"' : '' ?>>easeInCubic</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeOutCubic') ? 'selected="selected"' : '' ?>>easeOutCubic</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInOutCubic') ? 'selected="selected"' : '' ?>>easeInOutCubic</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInQuart') ? 'selected="selected"' : '' ?>>easeInQuart</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeOutQuart') ? 'selected="selected"' : '' ?>>easeOutQuart</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInOutQuart') ? 'selected="selected"' : '' ?>>easeInOutQuart</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInQuint') ? 'selected="selected"' : '' ?>>easeInQuint</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeOutQuint') ? 'selected="selected"' : '' ?>>easeOutQuint</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInOutQuint') ? 'selected="selected"' : '' ?>>easeInOutQuint</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInSine') ? 'selected="selected"' : '' ?>>easeInSine</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeOutSine') ? 'selected="selected"' : '' ?>>easeOutSine</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInOutSine') ? 'selected="selected"' : '' ?>>easeInOutSine</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInExpo') ? 'selected="selected"' : '' ?>>easeInExpo</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeOutExpo') ? 'selected="selected"' : '' ?>>easeOutExpo</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInOutExpo') ? 'selected="selected"' : '' ?>>easeInOutExpo</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInCirc') ? 'selected="selected"' : '' ?>>easeInCirc</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeOutCirc') ? 'selected="selected"' : '' ?>>easeOutCirc</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInOutCirc') ? 'selected="selected"' : '' ?>>easeInOutCirc</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInElastic') ? 'selected="selected"' : '' ?>>easeInElastic</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeOutElastic') ? 'selected="selected"' : '' ?>>easeOutElastic</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInOutElastic') ? 'selected="selected"' : '' ?>>easeInOutElastic</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInBack') ? 'selected="selected"' : '' ?>>easeInBack</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeOutBack') ? 'selected="selected"' : '' ?>>easeOutBack</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInOutBack') ? 'selected="selected"' : '' ?>>easeInOutBack</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInBounce') ? 'selected="selected"' : '' ?>>easeInBounce</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeOutBounce') ? 'selected="selected"' : '' ?>>easeOutBounce</option>
										<option <?php echo ($layer['properties']['easingin'] == 'easeInOutBounce') ? 'selected="selected"' : '' ?>>easeInOutBounce</option>
									</select>
								</td>
								<td class="right"><?php echo $delay; ?> <i title="<?php echo $help_slide_Delay; ?>" class="icon-question-sign vtip"></td>
								<td><input type="text" name="delayin" value="<?php echo $layer['properties']['delayin']?>"> (ms)</td>
							</tr>
							<tr>
								<td class="right"><?php echo $slide_out_animation; ?></td>
								<td class="right"><?php echo $duration; ?> <i title="<?php echo $help_slide_Duration_out; ?>" class="icon-question-sign vtip"></td>
								<td><input type="text" name="durationout" value="<?php echo $layer['properties']['durationout']?>"> (ms)</td>
								<td class="right"><?php echo $easing; ?> <i title="<?php echo $help_slide_Easing; ?>" class="icon-question-sign vtip"></td>
								<td>
									<select name="easingout">
										<option <?php echo ($layer['properties']['easingout'] == 'linear') ? 'selected="selected"' : '' ?>>linear</option>
										<option <?php echo ($layer['properties']['easingout'] == 'swing') ? 'selected="selected"' : '' ?>>swing</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInQuad') ? 'selected="selected"' : '' ?>>easeInQuad</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeOutQuad') ? 'selected="selected"' : '' ?>>easeOutQuad</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInOutQuad') ? 'selected="selected"' : '' ?>>easeInOutQuad</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInCubic') ? 'selected="selected"' : '' ?>>easeInCubic</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeOutCubic') ? 'selected="selected"' : '' ?>>easeOutCubic</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInOutCubic') ? 'selected="selected"' : '' ?>>easeInOutCubic</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInQuart') ? 'selected="selected"' : '' ?>>easeInQuart</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeOutQuart') ? 'selected="selected"' : '' ?>>easeOutQuart</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInOutQuart') ? 'selected="selected"' : '' ?>>easeInOutQuart</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInQuint') ? 'selected="selected"' : '' ?>>easeInQuint</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeOutQuint') ? 'selected="selected"' : '' ?>>easeOutQuint</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInOutQuint') ? 'selected="selected"' : '' ?>>easeInOutQuint</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInSine') ? 'selected="selected"' : '' ?>>easeInSine</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeOutSine') ? 'selected="selected"' : '' ?>>easeOutSine</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInOutSine') ? 'selected="selected"' : '' ?>>easeInOutSine</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInExpo') ? 'selected="selected"' : '' ?>>easeInExpo</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeOutExpo') ? 'selected="selected"' : '' ?>>easeOutExpo</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInOutExpo') ? 'selected="selected"' : '' ?>>easeInOutExpo</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInCirc') ? 'selected="selected"' : '' ?>>easeInCirc</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeOutCirc') ? 'selected="selected"' : '' ?>>easeOutCirc</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInOutCirc') ? 'selected="selected"' : '' ?>>easeInOutCirc</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInElastic') ? 'selected="selected"' : '' ?>>easeInElastic</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeOutElastic') ? 'selected="selected"' : '' ?>>easeOutElastic</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInOutElastic') ? 'selected="selected"' : '' ?>>easeInOutElastic</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInBack') ? 'selected="selected"' : '' ?>>easeInBack</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeOutBack') ? 'selected="selected"' : '' ?>>easeOutBack</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInOutBack') ? 'selected="selected"' : '' ?>>easeInOutBack</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInBounce') ? 'selected="selected"' : '' ?>>easeInBounce</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeOutBounce') ? 'selected="selected"' : '' ?>>easeOutBounce</option>
										<option <?php echo ($layer['properties']['easingout'] == 'easeInOutBounce') ? 'selected="selected"' : '' ?>>easeInOutBounce</option>
									</select>
								</td>
								<td class="right"><?php echo $delay; ?> <i title="<?php echo $help_slide_Delay; ?>" class="icon-question-sign vtip"></td>
								<td><input type="text" name="delayout" value="<?php echo $layer['properties']['delayout']?>"> (ms)</td>
							</tr>
							<tr style="display:none;">
								<td class="right">Misc</td>
								<td class="right">#ID</td>
								<td><input type="text" name="id" value="<?php echo $layer['properties']['id'] ?>"></td>
								<td class="right">Deeplink</td>
								<td><input type="text" name="deeplink" value="<?php echo isset($layer['properties']['deeplink']) ? $layer['properties']['deeplink'] : '' ?>"></td>
								<td class="right">Hidden</td>
								<td><input type="checkbox" name="skip" class="checkbox" <?php echo isset($layer['properties']['skip']) ? 'checked="checked"' : '' ?>></td>
							</tr>
							<tr>
								<td class="right"><?php echo $navigation; ?></td>
								<td class="right"><?php echo $thumbnail; ?> <i title="<?php echo $help_slide_Thumbnail; ?>" class="icon-question-sign vtip"></td>
								<td colspan="5">
									<div class="reset-parent">
										<input data-relat_url="<?php echo $layer['properties']['thumbnail'] ?  $layer['properties']['thumbnail'] : '' ?>" type="text" name="thumbnail" class="ls-upload" value="<?php echo $layer['properties']['thumbnail'] ? $mainImagePath . $layer['properties']['thumbnail'] : '' ?>">
										<span class="ls-reset icon-remove-sign"></span>
									</div>
								</td>
							</tr> 
						</tbody>
					</table>
					<table>
						<thead>
							<tr>
								<td>
									<h4><span class="icon-eye-open"></span>
									<?php echo $preview; ?> <i title="<?php echo $help_wisiwig_editor; ?>" class="icon-question-sign vtip_l"></i></h4>
								</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="ls-preview-td">
									<div class="ls-preview-wrapper">
										<div class="ls-preview">
											<div class="draggable"></div>
										</div>
										<div class="ls-real-time-preview"></div>
										<button class="button ls-preview-button"><i class="icon-play"></i> <?php echo $enter_preview; ?></button>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<table>
						<thead>
							<tr>
								<td>
									<h4><span class="icon-th-large"></span>
									<?php echo $sublayers; ?> <i title="<?php echo $help_sublayers; ?>" class="icon-question-sign vtip_l"></i></h4>
								</td>
							</tr>
						</thead>
						<tbody class="ls-sublayers ls-sublayer-sortable">
							<?php if(!empty($layer['sublayers'])) : ?>
							<?php foreach($layer['sublayers'] as $key => $sublayer) : ?>
							<?php $active = (count($layer['sublayers']) == ($key+1)) ? ' class="active"' : '' ?>
							<?php $title = empty($sublayer['subtitle']) ? 'Sublayer #'.($key+1).'' : htmlspecialchars(stripslashes($sublayer['subtitle'])); ?>
							<tr<?php echo $active ?>>
								<td>
									<div class="ls-sublayer-wrapper">
										<span class="ls-sublayer-number"><?php echo ($key + 1) ?></span>
										<span class="ls-highlight"><input type="checkbox"></span>
										<input type="text" name="subtitle" class="ls-sublayer-title" value="<?php echo $title ?>">
										<div class="clear"></div>
										<div class="ls-sublayer-nav">
											<a href="#" class="active"><?php echo $basic; ?> <i title="<?php echo $help_sub_Basic; ?>" class="icon-question-sign vtip"></i></a>
											<a href="#"><?php echo $options; ?> <i title="<?php echo $help_sub_Options; ?>" class="icon-question-sign vtip"></i></a>
											<a href="#">Link<?php echo $link; ?> <i title="<?php echo $help_sub_Link; ?>" class="icon-question-sign vtip"></i></a>
											<a href="#"><?php echo $style; ?> <i title="<?php echo $help_sub_Style; ?>" class="icon-question-sign vtip"></i></a>
											<a href="#"><?php echo $attributes; ?> <i title="<?php echo $help_sub_Attributes; ?>" class="icon-question-sign vtip_r"></i></a>
											<a href="#" title="Remove this sublayer" class="remove"><span class="icon-remove-sign"></span></a>
										</div>
										<div class="ls-sublayer-pages">
											<div class="ls-sublayer-page ls-sublayer-basic active">
												<select name="type">
													<option <?php echo ($sublayer['type'] == 'product') ? 'selected="selected"' : '' ?>><?php echo $product; ?></option>
													
													<option <?php echo ($sublayer['type'] == 'img') ? 'selected="selected"' : '' ?>>img</option>
													<option <?php echo ($sublayer['type'] == 'div') ? 'selected="selected"' : '' ?>>div</option>
													<option <?php echo ($sublayer['type'] == 'p') ? 'selected="selected"' : '' ?>>p</option>
													<option <?php echo ($sublayer['type'] == 'span') ? 'selected="selected"' : '' ?>>span</option>
													<option <?php echo ($sublayer['type'] == 'h1') ? 'selected="selected"' : '' ?>>h1</option>
													<option <?php echo ($sublayer['type'] == 'h2') ? 'selected="selected"' : '' ?>>h2</option>
													<option <?php echo ($sublayer['type'] == 'h3') ? 'selected="selected"' : '' ?>>h3</option>
													<option <?php echo ($sublayer['type'] == 'h4') ? 'selected="selected"' : '' ?>>h4</option>
													<option <?php echo ($sublayer['type'] == 'h5') ? 'selected="selected"' : '' ?>>h5</option>
													<option <?php echo ($sublayer['type'] == 'h6') ? 'selected="selected"' : '' ?>>h6</option>
												</select>

												<div class="ls-sublayer-types">
													<span class="ls-type">
														<span class="icon-briefcase"></span><br>
														<?php echo $Product; ?>
													</span>
													<span class="ls-type">
														<span class="icon-picture"></span><br>
														Image
													</span>

													<span class="ls-type">
														<span class="icon-retweet"></span><br>
														Div
													</span>

													<span class="ls-type">
														<span class="icon-tasks"></span><br>
														Paragraph
													</span>

													<span class="ls-type">
														<span class="icon-align-center"></span><br>
														Span
													</span>

													<span class="ls-type">
														<span class="icon-text-height"></span><br>
														H1
													</span>

													<span class="ls-type">
														<span class="icon-text-height"></span><br>
														H2
													</span>

													<span class="ls-type">
														<span class="icon-text-height"></span><br>
														H3
													</span>

													<span class="ls-type">
														<span class="icon-text-height"></span><br>
														H4
													</span>

													<span class="ls-type">
														<span class="icon-text-height"></span><br>
														H5
													</span>

													<span class="ls-type">
														<span class="icon-text-height"></span><br>
														H6
													</span>
												</div>
												<div class="ls-product-uploader">
													<h5 style="margin-bottom:8px;"><?php echo $product_in_sublayer; ?> <a href="#" class="ls-add-product" ><?php echo $add_new_product; ?></a><a href="#" class="ls-icon-del"><?php echo $remove_product; ?></a></h5>
													
													<!-- LABEL FOR PRODUCT START -->
													<?php if(count($labels['data'])) { ?> <!-- lev.1 -->
													<div class="product_labels">
														<?php 
															$sl_label_type = '';
															$sl_label_color = '';
															$sl_lable_file = '';
																			
															$label_pos_hor = ''; 
															$label_pos_hor_val = '';
															$label_pos_ver = '';
															$label_pos_ver_val = '';
															
															if(!empty($sublayer['label_type']) AND !empty($sublayer['label_color']) AND !empty($sublayer['label_file'])) {
																$sl_label_type = $sublayer['label_type'];
																$sl_label_color = $sublayer['label_color'];
																$sl_lable_file = $sublayer['label_file'];
																
																$label_pos_hor = $sublayer['label_pos_hor'];
																$label_pos_hor_val = $sublayer['label_pos_hor_val'];
																
																$label_pos_ver = $sublayer['label_pos_ver'];
																$label_pos_ver_val = $sublayer['label_pos_ver_val'];
																
															}
														?>
													
														<!-- data for server start-->
														<input type="hidden" name="label_type" value="<?php echo $sl_label_type; ?>">
														<input type="hidden" name="label_color" value="<?php echo $sl_label_color; ?>">
														<input type="hidden" name="label_file" value="<?php echo $sl_lable_file; ?>">
														<!-- data for server end-->
														
														<div class="product_labels_text">Label for product:</div>
														
														<div style=" text-align:right; margin-bottom:5px;">
															<div style="float:left; margin-right:15px;">
																<label>Horisontal position:
																<select style="display:inline;" name="label_pos_hor">
																	<option data-value = "<?php echo $label_pos_hor ?  $label_pos_hor : 'default'; ?>" value="right">Right</option>
																	<option data-value = "<?php echo $label_pos_hor ; ?>" value="left">Left</option>
																</select></label>
																<input style="width: 40px;"  type="text" name="label_pos_hor_val" value="<?php  echo $label_pos_hor_val ? $label_pos_hor_val : '50%'; ?>">
															</div>
															<div style="float:left; margin-right:15px;">
																<label>Vertical position:
																<select style="display:inline;" name="label_pos_ver">
																	<option data-value = "<?php echo $label_pos_ver ?  $label_pos_ver : 'default'; ?>" value="top">Top</option>
																	<option data-value = "<?php echo $label_pos_ver ; ?>" value="bottom">Bottom</option>
																</select></label>
																<input style="width: 40px;" type="text" name="label_pos_ver_val" value="<?php  echo $label_pos_ver_val ? $label_pos_ver_val : '0'; ?>">
															</div>
															<div style="clear:both;"></div>
														</div>
														
														<?php foreach($labels['data'] as $label) { ?> <!-- lev.2 -->
														<div class="product_label" data-type="<?php echo $label['type'] ?>">
															
															<span class="label_name <?php if($sl_label_type == $label['type']) echo ' active'?>"><?php echo $label['name']; ?>:</span>
															<?php if($label['type'] == 'discount') {?>
																<input style="width: 40px;" type="text" name="discount_val" value="<?php  echo isset($sublayer['discount_val']) ? $sublayer['discount_val'] : ''; ?>" >
															<?php }?>
															<div class="color_box" style="<?php  if($label['type'] !='discount') echo 'margin-top: 10px;'; ?>">
																<ul>
																	<?php  
																	$a_first_activ = true;
																	foreach($label['colors'] as $color) {
																		if($sl_label_type == $label['type'] AND $sl_label_color == $color) $a_first_activ = false;
																	}
																	$index = 1;
																	foreach($label['colors'] as $color) { 
																		$color_box_activ = ($sl_label_type == $label['type'] AND $sl_label_color == $color) ? 'color_box_activ' : '';
																		if($a_first_activ AND $index) $color_box_activ = 'color_box_activ';
																		$index = 0;
																	?>
																	<li style="background-color:#<?php echo $color; ?>;" >
																			<a class="<?php echo $color_box_activ ?>" data-color="<?php echo $color; ?>"></a>
																	</li>
																	<?php } ?>
																</ul>
															</div>

															<select data-path="<?php echo $label['path'] ; ?>" class="d_d" style="width:180px;">
																<option data-image="<?php echo $labels['image_null']; ?>" data-imagecss="w20_h20" value="" <?php if($sl_label_type != $label['type']) echo 'selected="selected"'; ?> >
																	Choose...
																</option>
																<?php foreach($label['files'] as $file) { ?><!-- lev.3 -->	
																	<?php 
																	$selected = ''; 
																	$sl_label_color_ = $label['colors'][0];
																	if($sl_label_type == $label['type']) { 
																		if($sl_lable_file == $file['file']){
																			$selected = 'selected="selected"';
																		}
																		$sl_label_color_ = $sl_label_color;
																	}

																	$data_image = $label['path'] .$sl_label_color_  .'/'.$file['file'];
																	?>
																		<option data-imagecss="w_50" data-image="<?php echo $data_image; ?>" value="<?php echo $file['file']; ?>" <?php echo $selected; ?> >
																			<?php echo $file['name']; ?>
																		</option>
																	<?php } ?> <!-- lev.3 -->
															</select>
														</div>
														<?php } ?> <!-- lev.2 -->
														<div style="clear:both;"></div>
													</div>
													<?php } ?> <!-- lev.1 -->
													<!-- LABEL FOR PRODUCT END -->

													<?php if(isset($sublayer['product']) AND $sublayer['product'] !=''){ 
														if($productsForSlider['status']){
															$productForSlider = $productsForSlider['data'][$sublayer['product']];
														
														?>

														<table class='list'>
														<tr>
															<td class="center">
															<img data-image="<?php echo $productForSlider['image']; ?>" class="prod_img_url" src="<?php echo $productForSlider['tumb'] ?>" style="padding: 1px; border: 1px solid #DDDDDD;">
															</td>
															<td class="prod_name">
																<?php echo $productForSlider['name'] ?>	
															</td>
															<td>
																<?php echo $productForSlider['model'] ?>
															</td>
															<td class="prod_price">
																<?php if ($productForSlider['special']) { ?>
																<span class="prod_old_price" style="text-decoration: line-through;"><?php echo $productForSlider['price']; ?></span><br/>
																<span class="prod_new_price" style="color: #b00;"><?php echo $productForSlider['special']; ?></span>
																<?php } else { ?>
																<?php echo $productForSlider['price']; ?>
																<?php } ?>
															</td>
														</tr>
														</table>
													<?php }}?>
													<input type="hidden" name="product" value="<?php echo (isset($sublayer['product']) AND $sublayer['product'] !='') ? $sublayer['product'] : ''; ?>">
														
												</div>
												<div class="ls-image-uploader">
				<!-- TODO else transparent background -->
													<?php 
$imageSrc = !empty($sublayer['image']) ? $sliderImagePath .$sublayer['image'] :'view/stylesheet/smartslider/image/transparent.png' ?>
													<img src="<?php echo $imageSrc ?>" alt="sublayer image">
													<input data-relat_url="<?php if($sublayer['image']) echo  $sublayer['image']; ?>" type="text" name="image" class="ls-upload" value="<?php if($sublayer['image']) echo  $sliderImagePath .$sublayer['image'] ?>">
													<p><?php echo $text_field; ?>
														
													</p>
												</div>

												<div class="ls-html-code">
													<h5><?php echo $custom_content; ?></h5>
													<textarea name="html" cols="50" rows="5"><?php echo stripslashes($sublayer['html']) ?></textarea>
												</div>
											</div>
											<div class="ls-sublayer-page ls-sublayer-options">
												<table>
													<tbody>
														<tr>
															<td><?php echo $slide_in_animation; ?></td>
															<td class="right"><?php echo $direction; ?> <i title="<?php echo $help_sub_Direction_in; ?>" class="icon-question-sign vtip"></i></td>
															<td>
																<select name="slidedirection">
																	<option value="auto" <?php echo ($sublayer['slidedirection'] == 'auto') ? 'selected="selected"' : '' ?>>auto</option>
																	<option value="fade" <?php echo ($sublayer['slidedirection'] == 'fade') ? 'selected="selected"' : '' ?>>fade</option>
																	<option value="top" <?php echo ($sublayer['slidedirection'] == 'top') ? 'selected="selected"' : '' ?>>top</option>
																	<option value="right" <?php echo ($sublayer['slidedirection'] == 'right') ? 'selected="selected"' : '' ?>>right</option>
																	<option value="bottom" <?php echo ($sublayer['slidedirection'] == 'bottom') ? 'selected="selected"' : '' ?>>bottom</option>
																	<option value="left" <?php echo ($sublayer['slidedirection'] == 'left') ? 'selected="selected"' : '' ?>>left</option>
																</select>
															</td>
															<td class="right"><?php echo $duration; ?> <i title="<?php echo $help_sub_Duration_in; ?>" class="icon-question-sign vtip"></i></td>
															<td><input type="text" name="durationin" value="<?php echo $sublayer['durationin'] ?>"> (ms)</td>
															<td class="right"><?php echo $easing; ?> <i title="<?php echo $help_sub_Easing; ?>" class="icon-question-sign vtip"></i></td>
															<td>
																<select name="easingin">
																	<option <?php echo ($sublayer['easingin'] == 'linear') ? 'selected="selected"' : '' ?>>linear</option>
																	<option <?php echo ($sublayer['easingin'] == 'swing') ? 'selected="selected"' : '' ?>>swing</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInQuad') ? 'selected="selected"' : '' ?>>easeInQuad</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeOutQuad') ? 'selected="selected"' : '' ?>>easeOutQuad</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInOutQuad') ? 'selected="selected"' : '' ?>>easeInOutQuad</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInCubic') ? 'selected="selected"' : '' ?>>easeInCubic</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeOutCubic') ? 'selected="selected"' : '' ?>>easeOutCubic</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInOutCubic') ? 'selected="selected"' : '' ?>>easeInOutCubic</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInQuart') ? 'selected="selected"' : '' ?>>easeInQuart</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeOutQuart') ? 'selected="selected"' : '' ?>>easeOutQuart</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInOutQuart') ? 'selected="selected"' : '' ?>>easeInOutQuart</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInQuint') ? 'selected="selected"' : '' ?>>easeInQuint</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeOutQuint') ? 'selected="selected"' : '' ?>>easeOutQuint</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInOutQuint') ? 'selected="selected"' : '' ?>>easeInOutQuint</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInSine') ? 'selected="selected"' : '' ?>>easeInSine</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeOutSine') ? 'selected="selected"' : '' ?>>easeOutSine</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInOutSine') ? 'selected="selected"' : '' ?>>easeInOutSine</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInExpo') ? 'selected="selected"' : '' ?>>easeInExpo</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeOutExpo') ? 'selected="selected"' : '' ?>>easeOutExpo</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInOutExpo') ? 'selected="selected"' : '' ?>>easeInOutExpo</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInCirc') ? 'selected="selected"' : '' ?>>easeInCirc</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeOutCirc') ? 'selected="selected"' : '' ?>>easeOutCirc</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInOutCirc') ? 'selected="selected"' : '' ?>>easeInOutCirc</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInElastic') ? 'selected="selected"' : '' ?>>easeInElastic</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeOutElastic') ? 'selected="selected"' : '' ?>>easeOutElastic</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInOutElastic') ? 'selected="selected"' : '' ?>>easeInOutElastic</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInBack') ? 'selected="selected"' : '' ?>>easeInBack</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeOutBack') ? 'selected="selected"' : '' ?>>easeOutBack</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInOutBack') ? 'selected="selected"' : '' ?>>easeInOutBack</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInBounce') ? 'selected="selected"' : '' ?>>easeInBounce</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeOutBounce') ? 'selected="selected"' : '' ?>>easeOutBounce</option>
																	<option <?php echo ($sublayer['easingin'] == 'easeInOutBounce') ? 'selected="selected"' : '' ?>>easeInOutBounce</option>
																</select>
															</td>
															<td class="right"><?php echo $delay; ?> <i title="<?php echo $help_sub_Delay_in; ?>" class="icon-question-sign vtip"></i></td>
															<td><input type="text" name="delayin" value="<?php echo $sublayer['delayin'] ?>"> (ms)</td>
														</tr>

														<tr>
															<td><?php echo $slide_out_animation; ?></td>
															<td class="right"><?php echo $direction; ?> <i title="<?php echo $help_sub_Direction_out; ?>" class="icon-question-sign vtip"></i></td>
															<td>
																<select name="slideoutdirection">
																	<option value="auto" <?php echo ($sublayer['slideoutdirection'] == 'auto') ? 'selected="selected"' : '' ?>>auto</option>
																	<option value="fade" <?php echo ($sublayer['slideoutdirection'] == 'fade') ? 'selected="selected"' : '' ?>>fade</option>
																	<option value="top" <?php echo ($sublayer['slideoutdirection'] == 'top') ? 'selected="selected"' : '' ?>>top</option>
																	<option value="right" <?php echo ($sublayer['slideoutdirection'] == 'right') ? 'selected="selected"' : '' ?>>right</option>
																	<option value="bottom" <?php echo ($sublayer['slideoutdirection'] == 'bottom') ? 'selected="selected"' : '' ?>>bottom</option>
																	<option value="left" <?php echo ($sublayer['slideoutdirection'] == 'left') ? 'selected="selected"' : '' ?>>left</option>
																</select>
															</td>
															<td class="right"><?php echo $duration; ?> <i title="<?php echo $help_sub_Duration_out; ?>" class="icon-question-sign vtip"></i></td>
															<td><input type="text" name="durationout" value="<?php echo $sublayer['durationout'] ?>"> (ms)</td>
															<td class="right"><?php echo $easing; ?> <i title="<?php echo $help_sub_Easing; ?>" class="icon-question-sign vtip"></i></td>
															<td>
																<select name="easingout">
																	<option <?php echo ($sublayer['easingout'] == 'linear') ? 'selected="selected"' : '' ?>>linear</option>
																	<option <?php echo ($sublayer['easingout'] == 'swing') ? 'selected="selected"' : '' ?>>swing</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInQuad') ? 'selected="selected"' : '' ?>>easeInQuad</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeOutQuad') ? 'selected="selected"' : '' ?>>easeOutQuad</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInOutQuad') ? 'selected="selected"' : '' ?>>easeInOutQuad</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInCubic') ? 'selected="selected"' : '' ?>>easeInCubic</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeOutCubic') ? 'selected="selected"' : '' ?>>easeOutCubic</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInOutCubic') ? 'selected="selected"' : '' ?>>easeInOutCubic</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInQuart') ? 'selected="selected"' : '' ?>>easeInQuart</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeOutQuart') ? 'selected="selected"' : '' ?>>easeOutQuart</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInOutQuart') ? 'selected="selected"' : '' ?>>easeInOutQuart</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInQuint') ? 'selected="selected"' : '' ?>>easeInQuint</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeOutQuint') ? 'selected="selected"' : '' ?>>easeOutQuint</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInOutQuint') ? 'selected="selected"' : '' ?>>easeInOutQuint</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInSine') ? 'selected="selected"' : '' ?>>easeInSine</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeOutSine') ? 'selected="selected"' : '' ?>>easeOutSine</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInOutSine') ? 'selected="selected"' : '' ?>>easeInOutSine</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInExpo') ? 'selected="selected"' : '' ?>>easeInExpo</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeOutExpo') ? 'selected="selected"' : '' ?>>easeOutExpo</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInOutExpo') ? 'selected="selected"' : '' ?>>easeInOutExpo</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInCirc') ? 'selected="selected"' : '' ?>>easeInCirc</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeOutCirc') ? 'selected="selected"' : '' ?>>easeOutCirc</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInOutCirc') ? 'selected="selected"' : '' ?>>easeInOutCirc</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInElastic') ? 'selected="selected"' : '' ?>>easeInElastic</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeOutElastic') ? 'selected="selected"' : '' ?>>easeOutElastic</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInOutElastic') ? 'selected="selected"' : '' ?>>easeInOutElastic</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInBack') ? 'selected="selected"' : '' ?>>easeInBack</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeOutBack') ? 'selected="selected"' : '' ?>>easeOutBack</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInOutBack') ? 'selected="selected"' : '' ?>>easeInOutBack</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInBounce') ? 'selected="selected"' : '' ?>>easeInBounce</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeOutBounce') ? 'selected="selected"' : '' ?>>easeOutBounce</option>
																	<option <?php echo ($sublayer['easingout'] == 'easeInOutBounce') ? 'selected="selected"' : '' ?>>easeInOutBounce</option>
																</select>
															</td>
															<td class="right"><?php echo $delay; ?> <i title="<?php echo $help_sub_Delay_out; ?>" class="icon-question-sign vtip"></i></td>
															<td><input type="text" name="delayout" value="<?php echo $sublayer['delayout'] ?>"> (ms)</td>
														</tr>

														<tr>
															<td><?php echo $other_options; ?></td>
															<td class="right"><?php echo $p_level; ?> <i title="<?php echo $help_sub_P_level; ?>" class="icon-question-sign vtip"></i></td>
															<td><input type="text" name="level" value="<?php echo $sublayer['level'] ?>"></td>
															<td class="right"><?php echo $show_until; ?> <i title="<?php echo $help_sub_Show_until; ?>" class="icon-question-sign vtip"></i></td>
															<td><input type="text" name="showuntil" value="<?php echo !empty($sublayer['showuntil']) ? $sublayer['showuntil'] : '0'  ?>"> (ms)</td>
															<td class="right"><?php echo $hidden; ?> <i title="<?php echo $help_sub_Hidden; ?>" class="icon-question-sign vtip"></i></td>
															<td><input type="checkbox" name="skip" class="checkbox" <?php echo isset($sublayer['skip']) ? 'checked="checked"' : '' ?>></td>
															<td colspan="3"><button class="button duplicate"><?php echo $duplicate_this_sublayer; ?></button></td>
														</tr>
												</table>
											</div>
											<div class="ls-sublayer-page ls-sublayer-link">
												<table>
													<tbody>
														<tr>
															<td>URL </td>
															<td class="url"><input type="text" name="url" value="<?php if(isset($sublayer['product']) AND $sublayer['product'] !='' AND $productsForSlider['status']){$productForSlider = $productsForSlider['data'][$sublayer['product']];echo $productForSlider['href'];
															}else {echo isset($sublayer['url']) ? $sublayer['url'] : '';} ?>"></td>
															<td>
																<select name="target">
																	<option <?php echo ($sublayer['target'] == '_self') ? 'selected="selected"' : '' ?>>_self</option>
																	<option <?php echo ($sublayer['target'] == '_blank') ? 'selected="selected"' : '' ?>>_blank</option>
																</select>
															</td>
														</tr>
													</tbody>
												</table>
											</div>
											<div class="ls-sublayer-page ls-sublayer-style">
												<table>
													<tbody>
																																						<tr>
															<td rowspan="2" ><?php echo $basic_style_settings ; ?></td>
															<td class="right">
																<?php echo $top; ?><input type="text" name="top" value="<?php echo $sublayer['top'] ?>">
															</td>
															<td class="right">
																<?php echo $left; ?><input type="text" name="left" value="<?php echo $sublayer['left'] ?>">
															</td>
															<td class="right"><?php echo $height; ?><input type="text" name="height" value="<?php echo $sublayer['height'] ?>"></td>
															<td class="right"><?php echo $transparent; ?><input type="text" name="transparent" value="<?php echo $sublayer['transparent'] ?>"></td>
														</tr>
														<tr>
															<td class="right">
																<?php echo $bottom; ?><input type="text" name="bottom" value="<?php echo $sublayer['bottom'] ?>">
															</td>
															<td class="right">
																<?php echo $right; ?><input type="text" name="right" value="<?php echo $sublayer['right'] ?>">
															</td>
															<td class="right"><?php echo $width; ?><input type="text" name="width" value="<?php echo $sublayer['width'] ?>"></td>
															<td class="right"><?php echo $word_wrap; ?><input type="checkbox" name="wordwrap" class="checkbox" <?php echo isset($sublayer['wordwrap']) ? 'checked="checked"' : '' ?>></td>
														</tr>
														<tr>
															<td><?php echo $custom_style; ?></td>
															<td class="right"></td>
															<td colspan="4"><textarea rows="5" cols="50" name="style" class="style"><?php echo stripslashes($sublayer['style']) ?></textarea></td>
														</tr>
													</tbody>
												</table>
											</div>
											<div class="ls-sublayer-page ls-sublayer-attributes">
												<table>
													<tbody>
														<tr>
															<td><?php echo $attributes; ?></td>
															<td class="right">ID</td>
															<td><input type="text" name="id" value="<?php echo $sublayer['id'] ?>"></td>
															<td class="right">Classes</td>
															<td><input type="text" name="class" value="<?php echo $sublayer['class'] ?>"></td>
															<td class="right">Title</td>
															<td><input type="text" name="title" value="<?php echo $sublayer['title'] ?>"></td>
															<td class="right">Alt</td>
															<td><input type="text" name="alt" value="<?php echo $sublayer['alt'] ?>"></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</td>
							</tr>
							<?php endforeach; ?>
							<?php endif; ?>
						</tbody>
					</table>
					<a href="#" class="ls-add-sublayer"><span class="icon-plus-sign"></span> <?php echo $add_sublayer; ?></a>
				</div>
				<?php endforeach; ?>
			<?php endif; ?>
			</div>
		</div>

	<!-- Event Callbacks -->
		<div id="tab-callback" class="ls-page ls-callback-page">
			<div class="ls-box ls-callback-box">
				<h3 class="header">cbInit <i title="<?php echo $help_call_cbInit; ?>" class="icon-question-sign vtip_l"></i></h3>
				<div class="inner">
					<textarea name="cbinit" cols="20" rows="5"><?php echo stripslashes($slider['properties']['cbinit']) ?></textarea>
				</div>
			</div>

			<div class="ls-box ls-callback-box">
				<h3 class="header">cbStart <i title="<?php echo $help_call_cbStart; ?>" class="icon-question-sign vtip"></i></h3>
				<div class="inner">
					<textarea name="cbstart" cols="20" rows="5"><?php echo stripslashes($slider['properties']['cbstart']) ?></textarea>
				</div>
			</div>

			<div class="ls-box ls-callback-box side">
				<h3 class="header">cbStop <i title="<?php echo $help_call_cbStop; ?>" class="icon-question-sign vtip_r"></i></h3>
				<div class="inner">
					<textarea name="cbstop" cols="20" rows="5"><?php echo stripslashes($slider['properties']['cbstop']) ?></textarea>
				</div>
			</div>

			<div class="ls-box ls-callback-box">
				<h3 class="header">cbPause <i title="<?php echo $help_call_cbPause; ?>" class="icon-question-sign vtip_l"></i></h3>
				<div class="inner">
					<textarea name="cbpause" cols="20" rows="5"><?php echo stripslashes($slider['properties']['cbpause']) ?></textarea>
				</div>
			</div>

			<div class="ls-box ls-callback-box">
				<h3 class="header">cbAnimStart <i title="<?php echo $help_call_cbAnimStart; ?>" class="icon-question-sign vtip"></i></h3>
				<div class="inner">
					<textarea name="cbanimstart" cols="20" rows="5"><?php echo stripslashes($slider['properties']['cbanimstart']) ?></textarea>
				</div>
			</div>

			<div class="ls-box ls-callback-box side">
				<h3 class="header">cbAnimStop <i title="<?php echo $help_call_cbAnimStop; ?>" class="icon-question-sign vtip_r"></i></h3>
				<div class="inner">
					<textarea name="cbanimstop" cols="20" rows="5"><?php echo stripslashes($slider['properties']['cbanimstop']) ?></textarea>
				</div>
			</div>

			<div class="ls-box ls-callback-box">
				<h3 class="header">cbPrev <i title="<?php echo $help_call_cbPrev; ?>" class="icon-question-sign vtip_l"></i></h3>
				<div class="inner">
					<textarea name="cbprev" cols="20" rows="5"><?php echo stripslashes($slider['properties']['cbprev']) ?></textarea>
				</div>
			</div>

			<div class="ls-box ls-callback-box">
				<h3 class="header">cbNext <i title="<?php echo $help_call_cbNext; ?>" class="icon-question-sign vtip"></i></h3>
				<div class="inner">
					<textarea name="cbnext" cols="20" rows="5"><?php echo stripslashes($slider['properties']['cbnext']) ?></textarea>
				</div>
			</div>
			<div class="clear"></div>
		</div>
	</div>
</form>

 <iframe title="Please change protuct for slider" class="product_list" src="<?php echo $product_url; ?>" name="iframe" width="580" height="360"> 


</iframe>
	
	</div>
</div>


<div id="save_dialog" class="popup">
	<p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span><?php echo $popup_save_success; ?></p>
</div>
<div id="save_wait" class="popup">
  <img src="view/stylesheet/smartslider/image/load.gif" alt="">
</div>
<div id="not_save" class="popup"></div>

<div id="confirm_dialog" class="popup"></div>

<script type="text/javascript">
jQuery(document).ready(function() {
	$('.show_hide_help').click(function(){
		var $tips =$('.icon-question-sign');
		if($(this).hasClass('show')){
			$(this).removeClass('show').addClass('hide').text('<?php echo $button_help_show; ?>');
			$tips.hide();
		}else{
			$(this).addClass('show').removeClass('hide').text('<?php echo $button_help_hide; ?>');
			$tips.show();
		}
	}).click();
	
});


var slider = {
	text : {
		confirm_del_layer 		: '<p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>Are you sure you want to remove this layer?</p>',
		confirm_del_sublayer	: '<p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>Are you sure you want to remove this sublayer?</p>',
		alert_not_save			: '<p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>You not have Layers, please add New Layer and then you will can save.</p>'
	},
	url: {
		action	: '<?php echo htmlspecialchars_decode($action); ?>',
		cancel	: '<?php echo htmlspecialchars_decode($cancel); ?>',
		save	: '<?php echo htmlspecialchars_decode($save_url); ?>'
	},
	path:{
		layerSkin 	: '<?php echo $layerSkinPath ?>',
		mainImage	: '<?php echo $mainImagePath; ?>'
	},
	token : '<?php echo $token ?>',
	id : '<?php echo $token ?>'
}

</script>

<style type="text/css">
.box{
	color: #666;
}


.product_label{
	float:left;
	margin-left:10px;
}
.product_label span.active {
	color: #FF802B;
	font-weight:bold;
}
.w_50{max-width:70px;}
.color_box { 
	height: 22px;
	margin: 0px auto;
	padding: 0px 0px 7px;
}
.color_box ul { 
	height: 20px;
	margin: 0px;
	padding: 0px;
}
.color_box li { 
	display: inline-block;
	height: 22px;
	margin: 1px;
	padding: 0px;
	width: 22px;
}
.color_box .color_box_activ { 
	background: url("view/stylesheet/smartslider/image/stylesprite.png") 1px 4px no-repeat transparent;
	border: 2px solid #FFFFFF;
	height: 18px;
	width: 18px;
}
.color_box a { 
	border: 4px solid #FFFFFF;
	display: inline-block;
	height: 14px;
	width: 14px;
}

.box .button, .box .button-secondary {
	background: #f3f3f3;
	background-image: -webkit-gradient(linear,left top,left bottom,from(#fefefe),to(#f4f4f4));
	background-image: -webkit-linear-gradient(top,#fefefe,#f4f4f4);
	background-image: -moz-linear-gradient(top,#fefefe,#f4f4f4);
	background-image: -o-linear-gradient(top,#fefefe,#f4f4f4);
	background-image: linear-gradient(to bottom,#fefefe,#f4f4f4);
	border-color: #bbb;
	color: #333;
	text-shadow: 0 1px 0 #fff;
	display: inline-block;
	text-decoration: none;
	line-height: 23px;
	height: 24px;
	margin: 0;
	padding: 0 10px 1px;
	cursor: pointer;
	border-width: 1px;
	border-style: solid;
	-webkit-border-radius: 3px;
	-webkit-appearance: none;
	border-radius: 3px;
	white-space: nowrap;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}
.box .button:hover{
	background: #f3f3f3;
	border-color: #999;
	color: #222;
}
.box .widefat, div.updated, div.error, .wrap .add-new-h2, textarea, input[type="text"], input[type="password"], input[type="file"], input[type="email"], input[type="number"], input[type="search"], input[type="tel"], input[type="url"], select, .tablenav .tablenav-pages a, .tablenav-pages span.current, #titlediv #title, .postbox, #postcustomstuff table, #postcustomstuff input, #postcustomstuff textarea, .imgedit-menu div, .plugin-update-tr .update-message, #poststuff .inside .the-tagcloud, .login form, #login_error, .login .message, #menu-management .menu-edit, .nav-menus-php .list-container, .menu-item-handle, .link-to-original, .nav-menus-php .major-publishing-actions .form-invalid, .press-this #message, #TB_window, .tbtitle, .highlight, .feature-filter, #widget-list .widget-top, .editwidget .widget-inside {
	-webkit-border-radius: 3px;
	border-radius: 3px;
	border-width: 1px;
	border-style: solid;
}
textarea, input[type="text"], input[type="password"], input[type="file"], input[type="email"], input[type="number"], input[type="search"], input[type="tel"], input[type="url"], select {
	border-color: #dfdfdf;
	background-color: #fff;
	color: #333;
	margin: 1px;
	padding: 3px;
}
td, th, input, select, textarea, option, optgroup {
font-family: Arial, Helvetica, sans-serif;
font-size: 14px;
color: #585858;
}
.save_wait{
	margin		: 0 auto;
	text-align	: center;
	background	: transparent;
	border		: 0;
}

.htabs a {
	-webkit-border-top-left-radius: 3px;
	-webkit-border-top-right-radius: 3px;
	-moz-border-radius-topleft: 3px;
	-moz-border-radius-topright: 3px;
	border-top-left-radius: 3px;
	border-top-right-radius: 3px;
}
.htabs a.selected{
	padding-bottom: 9px;
}
.htabs a.selected, #ls-main-nav-bar a.active {
	color: #FF802B;
}

.fl_left{
	float:left;
}
.fl_right{
	float:right;
}

.sf_footer{
	clear:both;
	margin-top:10px;
	text-align:center;
}

.radius_5{
	border-radius: 5px;
	-webkit-border-top-left-radius : 5px;
	-webkit-border-bottom-left-radius: 5px;
	-webkit-border-top-right-radius : 5px;
	-webkit-border-bottom-right-radius: 5px;	
	
	-moz-border-radius-topleft : 5px;
	-moz-border-radius-bottomleft: 5px;
	-moz-border-radius-topright : 5px;
	-moz-border-radius-bottomright: 5px;
	
	border-top-left-radius : 5px;
	border-bottom-left-radius : 5px;
	border-top-right-radius : 5px;
	border-bottom-right-radius : 5px;
}

input.ng-invalid {
	background-color: #FA787E!important;
}

.popup{
	display:none;
}
</style>
<?php echo $footer; ?>