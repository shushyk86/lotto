<!-- add slider -->
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
      <div class="buttons"><a class="button save"><span><?php echo $button_save; ?></span></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
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
						<span id="ls-icon-layer-options"></span>
						<h4>
							Layer Options
							<a href="#" class="duplicate ls-layer-duplicate">
								Duplicate this layer
							</a>
						</h4>
					</td>
				</tr>
			</thead>
			<tbody class="ls-slide-options">
				<tr>
					<td class="right">Slide options</td>
					<td class="right">Background</td>
					<td>
						<div class="reset-parent">
							<input type="text" name="background" class="ls-upload" value="">
							<span class="ls-reset">x</span>
						</div>
					</td>
					<td class="right">Direction</td>
					<td>
						<select name="slidedirection">
							<option value="top">top</option>
							<option value="right" selected="selecter">right</option>
							<option value="bottom">bottom</option>
							<option value="left">left</option>
						</select>
					</td>
					<td class="right">Delay</td>
					<td><input type="text" name="slidedelay" value="4000"> (ms)</td>
				</tr>
				<tr>
					<td class="right">Slide in animation</td>
					<td class="right">Duration</td>
					<td><input type="text" name="durationin" value="1500"> (ms)</td>
					<td class="right">Easing</td>
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
					<td class="right">Delay</td>
					<td><input type="text" name="delayin" value="0"> (ms)</td>
				</tr>
				<tr>
					<td class="right">Slide out animation</td>
					<td class="right">Duration</td>
					<td><input type="text" name="durationout" value="1500"> (ms)</td>
					<td class="right">Easing</td>
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
					<td class="right">Delay</td>
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
					<td class="right">Navigation</td>
					<td class="right">Thumbnail</td>
					<td colspan="5">
						<div class="reset-parent">
							<input type="text" name="thumbnail" class="ls-upload" value="">
							<span class="ls-reset">x</span>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<table>
			<thead>
				<tr>
					<td>
						<span id="ls-icon-preview"></span>
						<h4>Preview</h4>
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
							<button class="button ls-preview-button">Enter Preview</button>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<table>
			<thead>
				<tr>
					<td>
						<span id="ls-icon-sublayers"></span>
						<h4>Sublayers</h4>
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
								<a href="#" class="active">Basic</a>
								<a href="#">Options</a>
								<a href="#">Link</a>
								<a href="#">Style</a>
								<a href="#">Attributes</a>
								<a href="#" title="Remove this sublayer'" class="remove">x</a>
							</div>
							<div class="ls-sublayer-pages">
								<div class="ls-sublayer-page ls-sublayer-basic active">
									<select name="type">
										<option selected="selected">product</option>
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
											Product
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
										<h5 style="margin-bottom:8px;">Product in sublayer: <a href="#" class="ls-add-product">Add new product</a><a href="#" class="ls-icon-del">Remove product</a></h5>
										<div style="margin-botom:8px;">
										Set Discount Label:
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
											Click into this text field to open Media Library where you can upload new images or select previously used ones.'
										</p>
									</div>

									<div class="ls-html-code">
										<h5>Custom HTML content</h5>
										<textarea name="html" cols="50" rows="5"></textarea>
									</div>
								</div>
								<div class="ls-sublayer-page ls-sublayer-options">
									<table>
										<tbody>
											<tr>
												<td>Slide in animation</td>
												<td class="right">Direction</td>
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
												<td class="right">Duration</td>
												<td><input type="text" name="durationin" value="1500"> (ms)</td>
												<td class="right">Easing</td>
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
												<td class="right">Delay</td>
												<td><input type="text" name="delayin" value="0"> (ms)</td>
											</tr>

											<tr>
												<td>Slide out animation</td>
												<td class="right">Direction</td>
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
												<td class="right">Duration</td>
												<td><input type="text" name="durationout" value="1500"> (ms)</td>
												<td class="right">Easing</td>
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
												<td class="right">Delay</td>
												<td><input type="text" name="delayout" value="0"> (ms)</td>
											</tr>

											<tr>
												<td>Other options</td>
												<td class="right">P. Level</td>
												<td><input type="text" name="level" value="2"></td>
												<td class="right">Show until</td>
												<td><input type="text" name="showuntil" value="0"> (ms)</td>
												<td class="right">Hidden</td>
												<td><input type="checkbox" name="skip" class="checkbox"></td>
												<td colspan="3"><button class="button duplicate">Duplicate this sublayer</button></td>
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
												<td rowspan="2" >Basic style settings</td>
												<td class="right">
													Top:<input type="text" name="top" value="50%">
												</td>
												<td class="right">
													Left:<input type="text" name="left" value="50%">
												</td>
												<td class="right">Height:<input type="text" name="height" value="80%"></td>
												<td class="right">Transparent(0-100)<input type="text" name="transparent" value="100"></td>
											</tr>
											<tr>
												<td class="right">
													Bottom:<input type="text" name="bottom" value="">
												</td>
												<td class="right">
													Right:<input type="text" name="right" value="">
												</td>
												<td class="right">Width:<input type="text" name="width" value=""></td>
												<td class="right">Word-wrap<input type="checkbox" name="wordwrap" class="checkbox"></td>
											</tr>
											<tr>
												<td>Custom style settings</td>
												<td class="right">Custom styles</td>
												<td colspan="4"><textarea rows="5" cols="50" name="style" class="style"></textarea></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="ls-sublayer-page ls-sublayer-attributes">
									<table>
										<tbody>
											<tr>
												<td>Attributes</td>
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
		<a href="#" class="ls-add-sublayer">Add new sublayer</a>
	</div>
</div>

<form action="test" method="post" class="wrap" id="ls-slider-form">

	<input type="hidden" name="posted_edit" value="1">

	<!-- Main menu bar -->
	<div id="ls-main-nav-bar">
		<a href="#" class="settings active">Global Settings</a>
		<a href="#" class="layers">Layers</a>
		<a href="#" class="callbacks">Event Callbacks</a>
		<a href="#" class="clear unselectable"></a>
	</div>
	<!-- Pages -->
	<div id="ls-pages">

	<!-- Global Settings -->
		<div class="ls-page ls-settings active">
			
			<div id="post-body-content">
				<div id="titlediv">
					<div id="titlewrap" style="line-height:24px; vertical-align:top;" >
						<input style=" border-color: #ccc;width: 220px;height: 22px;font-size: 18px;" name="title" value="<?php echo $slider['properties']['title'] ?>" id="title" autocomplete="off" placeholder="Type your slider name here'">
					</div>
				</div>
			</div>

			<div class="ls-box">
				<h3 class="header">Global Settings</h3>
				<table>
					<thead style="display:none;">
						<tr>
							<td colspan="3">
								<span id="ls-icon-basic"></span>
								<h4>Basic</h4>
							</td>
						</tr>
					</thead>
					<tbody style="display:none;">
						<tr>
							<td>Slider width</td>
							<td><input type="text" name="width" value="<?php echo $slider['properties']['width'] ?>" class="input"></td>
							<td class="desc"></td>
						</tr>
						<tr>
							<td>Slider height</td>
							<td><input type="text" name="height" value="<?php echo $slider['properties']['height'] ?>" class="input"></td>
							<td class="desc"></td>
						</tr>
						<tr>
							<td>Responsive</td>
							<td><input type="checkbox" name="responsive" <?php echo isset($slider['properties']['responsive']) ? 'checked="checked"' : '' ?>></td>
							<td class="desc"></td>
						</tr>
						<tr>
							<td>Full-width slider</td>
							<td><input type="checkbox" name="forceresponsive" <?php echo ( isset($slider['properties']['forceresponsive']) && $slider['properties']['forceresponsive'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc"></td>
						</tr>
						<tr>
							<td>Responsive under</td>
							<td><input type="text" name="responsiveunder" value="<?php echo !empty($slider['properties']['responsiveunder']) ? $slider['properties']['responsiveunder'] : '0' ?>"></td>
							<td class="desc"></td>
						</tr>
						<tr>
							<td>Sublayer Container</td>
							<td><input type="text" name="sublayercontainer" value="<?php echo !empty($slider['properties']['sublayercontainer']) ? $slider['properties']['sublayercontainer'] : '0' ?>"></td>
							<td class="desc"></td>
						</tr>
					</tbody>
					<thead>
						<tr>
							<td colspan="3">
								<span id="ls-icon-slideshow"></span>
								<h4>Slideshow</h4>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Automatically start slideshow</td>
							<td><input type="checkbox" name="autostart" <?php echo ( isset($slider['properties']['autostart']) && $slider['properties']['autostart'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc">If enabled, slideshow will automatically start after loading the page.</td>
						</tr>
						<tr>
							<td>Pause on hover</td>
							<td><input type="checkbox" name="pauseonhover" <?php echo ( isset($slider['properties']['pauseonhover']) && $slider['properties']['pauseonhover'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc">Slideshow will pause when mouse pointer is over LayerSlider.</td>
						</tr>
						<tr>
							<td>First layer</td>
							<td><input type="text" name="firstlayer" value="<?php echo $slider['properties']['firstlayer'] ?>" class="input"></td>
							<td class="desc">LayerSlider will start with this layer (you can type the word <i>random</i> if you want the slider to start with a random layer).</td>
						</tr>
						<tr>
							<td>Animate first layer</td>
							<td><input type="checkbox" name="animatefirstlayer" <?php echo ( isset($slider['properties']['animatefirstlayer']) && $slider['properties']['animatefirstlayer'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc">If enabled, first layer will animate (slide in) instead of fading.</td>
						</tr>
						<tr>
							<td>Random slideshow</td>
							<td><input type="checkbox" name="randomslideshow" <?php echo ( isset($slider['properties']['randomslideshow']) && $slider['properties']['randomslideshow'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc"> LayerSlider will change to a random layer instead of changing to the next / prev layer. Note that 'loops' feature won't work with this option.</td>
						</tr>
						<tr>
							<td>Two way slideshow</td>
							<td><input type="checkbox" name="twowayslideshow" <?php echo ( isset($slider['properties']['twowayslideshow']) && $slider['properties']['twowayslideshow'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc">If enabled, slideshow will go backwards if you click the prev button.</td>
						</tr>
						<tr>
							<td>Loops</td>
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
							<td class="desc">Number of loops if automatically start slideshow is enabled (0 means infinite!)</td>
						</tr>
						<tr>
							<td>Force the number of loops</td>
							<td><input type="checkbox" name="forceloopnum" <?php echo ( isset($slider['properties']['forceloopnum']) && $slider['properties']['forceloopnum'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc">If enabled, the slider will always stop at the given number of loops even if the user restarts the slideshow.</td>
						</tr>
						<tr>
							<td>Automatically play videos</td>
							<td><input type="checkbox" name="autoplayvideos" <?php echo ( isset($slider['properties']['autoplayvideos']) && $slider['properties']['autoplayvideos'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc">If enabled, the slider will automatically play youtube and vimeo videos.</td>
						</tr>
						<tr>
							<td>Automatically pause slideshow</td>
							<td>
								<select name="autopauseslideshow">
									<option <?php echo ($slider['properties']['autopauseslideshow'] == 'auto') ? 'selected="selected"' : '' ?>>auto</option>
									<option <?php echo ($slider['properties']['autopauseslideshow'] == 'enabled') ? 'selected="selected"' : '' ?>>enabled</option>
									<option <?php echo ($slider['properties']['autopauseslideshow'] == 'disabled') ? 'selected="selected"' : '' ?>>disabled</option>
								</select>
							</td>
							<td class="desc">If you enabled automatically play videos, the auto value means that the slideshow will stop UNTIL the video is playing and after that it continues. Enabled means slideshow will stop and it won't continue after video is played.</td>
						</tr>
						<tr>
							<td>Youtube preview</td>
							<td>
								<select name="youtubepreview">
									<option value="maxresdefault.jpg">Maximum quality</option>
									<option value="hqdefault.jpg">High quality</option>
									<option value="mqdefault.jpg">Medium quality</option>
									<option value="default.jpg">Default quality</option>
								</select>
							</td>
							<td class="desc">Default thumbnail picture of YouTube videos. Note, that Maximum quaility is not available to all (not HD) videos.</td>
						</tr>
						<tr>
							<td>Keyboard navigation</td>
							<td><input type="checkbox" name="keybnav" <?php echo ( isset($slider['properties']['keybnav']) && $slider['properties']['keybnav'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc">You can navigate with the left and right arrow keys.</td>
						</tr>
						<tr>
							<td>Touch navigation</td>
							<td><input type="checkbox" name="touchnav" <?php echo ( isset($slider['properties']['touchnav']) && $slider['properties']['touchnav'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc">Touch-control (on mobile devices).</td>
						</tr>
					</tbody>
					<thead>
						<tr>
							<td colspan="3">
								<span id="ls-icon-appearance"></span>
								<h4>Appearance</h4>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Skin</td>
							<td>
								<select name="skin">
									<?php $files = scandir( '../catalog/view/theme/vidnoff/stylesheet/layerskins/'); ?>
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
							<td class="desc">You can change the skin of the slider. The 'noskin' skin is a border- and buttonless skin. Your custom skins will appear in the list when you create their folders as well.</td>
						</tr>
						<tr>
							<td>Background color</td>
							<td>
								<div class="reset-parent">
									<input type="text" name="backgroundcolor" value="<?php echo $slider['properties']['backgroundcolor'] ?>" class="input color">
									<div class="ls-colorpicker">colorpicker</div>
								</div>
							</td>
							<td class="desc">Background color of LayerSlider. You can use all CSS methods, like hexa colors, rgb(r,g,b) method, color names, etc. Note, that background sublayers are covering the background.</td>
						</tr>
						<tr>
							<td>Background image</td>
							<td>
								<div class="reset-parent">
									<input type="text" name="backgroundimage" value="<?php echo $slider['properties']['backgroundimage'] ?>" class="input ls-upload">
									<span class="ls-reset">x</span>
								</div>
							</td>
							<td class="desc">Background image of LayerSlider. This will be a fixed background image of LayerSlider by default. Note, that background sublayers are covering the global background image.</td>
						</tr>
						<tr>
							<td>Slider style</td>
							<td>
								<div class="reset-parent">
									<input type="text" name="sliderstyle" value="<?php echo isset($slider['properties']['sliderstyle']) ? $slider['properties']['sliderstyle'] : '' ?>" class="input">
									<span class="ls-reset">x</span>
								</div>
							</td>
							<td class="desc">Here you can apply your custom CSS style settings to the slider.</td>
						</tr>
					</tbody>
					<thead>
						<tr>
							<td colspan="3">
								<span id="ls-icon-nav"></span>
								<h4>Navigation</h4>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Prev and Next buttons</td>
							<td><input type="checkbox" name="navprevnext" <?php echo ( isset($slider['properties']['navprevnext']) && $slider['properties']['navprevnext'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc">If disabled, Prev and Next buttons will be invisible.</td>
						</tr>
						<tr style="display:none;">
							<td>Start and Stop buttons</td>
							<td><input type="checkbox" name="navstartstop" <?php echo ( isset($slider['properties']['navstartstop']) && $slider['properties']['navstartstop'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc">If disabled, Start and Stop buttons will be invisible.</td>
						</tr>
						<tr style="display:none;">
							<td>Navigation buttons</td>
							<td><input type="checkbox" name="navbuttons" <?php echo ( isset($slider['properties']['navbuttons']) && $slider['properties']['navbuttons'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc">If disabled, slide buttons will be invisible.</td>
						</tr>
						<tr>
							<td>Prev and next buttons on hover</td>
							<td><input type="checkbox" name="hoverprevnext" <?php echo ( isset($slider['properties']['hoverprevnext']) && $slider['properties']['hoverprevnext'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc">If enabled, the prev and next buttons will be shown only if you move your mouse cursor over the slider.</td>
						</tr>
						<tr  style="display:none;">
							<td>Bottom navigation on hover</td>
							<td><input type="checkbox" name="hoverbottomnav" <?php echo ( isset($slider['properties']['hoverbottomnav']) && $slider['properties']['hoverbottomnav'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc">The bottom navigation controls (with also thumbnails) will be shown only if you move your mouse cursor over the slider.</td>
						</tr>
						<tr>
							<td>Thumbnail navigation</td>
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
							<td>Thumbnail width</td>
							<td><input type="text" name="thumb_width" value="<?php echo !empty($slider['properties']['thumb_width']) ? $slider['properties']['thumb_width'] : '100' ?>"></td>
							<td class="desc">The width of the thumbnails in the navigation area.</td>
						</tr>
						<tr>
							<td>Thumbnail height</td>
							<td><input type="text" name="thumb_height" value="<?php echo !empty($slider['properties']['thumb_height']) ? $slider['properties']['thumb_height'] : '60' ?>"></td>
							<td class="desc">The height of the thumbnails in the navigation area.</td>
						</tr>
						<tr>
							<td>Thumbnail container width</td>
							<td><input type="text" name="thumb_container_width" value="<?php echo !empty($slider['properties']['thumb_container_width']) ? $slider['properties']['thumb_container_width'] : '60%' ?>"></td>
							<td class="desc">The width of the thumbnail navigation area.</td>
						</tr>
						<tr>
							<td>Thumbnail active opacity</td>
							<td><input type="text" name="thumb_active_opacity" value="<?php echo !empty($slider['properties']['thumb_active_opacity']) ? $slider['properties']['thumb_active_opacity'] : '35' ?>"></td>
							<td class="desc">The selected thumbnail opacity (0-100).</td>
						</tr>
						<tr>
							<td>Thumbnail inactive opacity</td>
							<td><input type="text" name="thumb_inactive_opacity" value="<?php echo !empty($slider['properties']['thumb_inactive_opacity']) ? $slider['properties']['thumb_inactive_opacity'] : '100' ?>"></td>
							<td class="desc">The opacity of inactive thumbnails (0-100).</td>
						</tr>
					</tbody>
					<thead>
						<tr>
							<td colspan="3">
								<span id="ls-icon-misc"></span>
								<h4>Misc</h4>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Image preload</td>
							<td><input type="checkbox" name="imgpreload" <?php echo ( isset($slider['properties']['imgpreload']) && $slider['properties']['imgpreload'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc">Preloads all images and background-images of the next layer.</td>
						</tr>
						<tr style="display:none;">
							<td style="display:none;">Use relative URLs</td>
							<td><input type="checkbox" name="relativeurls" <?php echo ( isset($slider['properties']['relativeurls']) && $slider['properties']['relativeurls'] != 'false') ? 'checked="checked"' : '' ?>></td>
							<td class="desc">If enabled, LayerSlider WP will use relative URLs for images.</td>
						</tr>
					</tbody>
					<thead>
						<tr>
							<td colspan="3">
								<span id="ls-icon-yourlogo"></span>
								<h4>YourLogo</h4>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>YourLogo</td>
							<td>
								<div class="reset-parent">
									<input type="text" name="yourlogo" value="<?php echo $slider['properties']['yourlogo'] ?>" class="input ls-upload">
									<span class="ls-reset">x</span>
								</div>
							</td>
							<td class="desc">This is a fixed layer that will be shown above of LayerSlider container. For example if you want to display your own logo, etc., you can upload an image or choose one from the Media Library.</td>
						</tr>
						<tr>
							<td>YourLogo style</td>
							<td><input type="text" name="yourlogostyle" value="<?php echo $slider['properties']['yourlogostyle'] ?>" class="input"></td>
							<td class="desc">You can style your logo. You can use any CSS properties, for example you can add left and top properties to place the image inside the LayerSlider container anywhere you want.</td>
						</tr>
						<tr>
							<td>YourLogo link</td>
							<td>
								<div class="reset-parent">
									<input type="text" name="yourlogolink" value="<?php echo $slider['properties']['yourlogolink'] ?>" class="input">
									<span class="ls-reset">x</span>
								</div>
							</td>
							<td class="desc">You can add a link to your logo. Set false is you want to display only an image without a link.</td>
						</tr>
						<tr>
							<td>YourLogo link target</td>
							<td>
								<select name="yourlogotarget">
									<option <?php echo ($slider['properties']['yourlogotarget'] == '_self') ? 'selected="selected"' : '' ?>>_self</option>
									<option <?php echo ($slider['properties']['yourlogotarget'] == '_blank') ? 'selected="selected"' : '' ?>>_blank</option>
								</select>
							</td>
							<td class="desc">If '_blank', the clicked url will open in a new window.</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

	<!-- Layers START -->
		<div class="ls-page">

			<div id="ls-layer-tabs">
				<?php foreach($slider['layers'] as $key => $layer) : ?>
				<?php $active = empty($key) ? 'active' : '' ?>
				<a href="#" class="<?php echo $active ?>">Layer #<?php echo ($key+1) ?><span>x</span></a>
				<?php endforeach; ?>
				<a href="#" class="unsortable" id="ls-add-layer">Add new layer</a>
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
									<span id="ls-icon-layer-options"></span>
									<h4>
										Layer Options'
										<a href="#" class="duplicate ls-layer-duplicate">Duplicate this layer</a>
									</h4>
								</td>
							</tr>
						</thead>
						<tbody class="ls-slide-options">
							<tr>
								<td class="right">Slide options</td>
								<td class="right">Background</td>
								<td>
									<div class="reset-parent">
										<input type="text" name="background" class="ls-upload" value="<?php echo $layer['properties']['background']?>">
										<span class="ls-reset">x</span>
									</div>
								</td>
								<td class="right">Direction</td>
								<td>
									<select name="slidedirection">
										<option value="top" <?php echo ($layer['properties']['slidedirection'] == 'top') ? 'selected="selected"' : '' ?>>top</option>
										<option value="right" <?php echo ($layer['properties']['slidedirection'] == 'right') ? 'selected="selected"' : '' ?>>right</option>
										<option value="bottom" <?php echo ($layer['properties']['slidedirection'] == 'bottom') ? 'selected="selected"' : '' ?>>bottom</option>
										<option value="left" <?php echo ($layer['properties']['slidedirection'] == 'left') ? 'selected="selected"' : '' ?>>left</option>
									</select>
								</td>
								<td class="right">Delay</td>
								<td><input type="text" name="slidedelay" value="<?php echo $layer['properties']['slidedelay']?>"> (ms)</td>
							</tr>
							<tr>
								<td class="right">Slide in animation</td>
								<td class="right">Duration</td>
								<td><input type="text" name="durationin" value="<?php echo $layer['properties']['durationin']?>"> (ms)</td>
								<td class="right">Easing</td>
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
								<td class="right">Delay</td>
								<td><input type="text" name="delayin" value="<?php echo $layer['properties']['delayin']?>"> (ms)</td>
							</tr>
							<tr>
								<td class="right">Slide out animation</td>
								<td class="right">Duration</td>
								<td><input type="text" name="durationout" value="<?php echo $layer['properties']['durationout']?>"> (ms)</td>
								<td class="right">Easing</td>
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
								<td class="right">Delay</td>
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
								<td class="right">Navigation</td>
								<td class="right">Thumbnail</td>
								<td colspan="5">
									<div class="reset-parent">
										<input type="text" name="thumbnail" class="ls-upload" value="<?php echo isset($layer['properties']['thumbnail']) ? $layer['properties']['thumbnail'] : '' ?>">
										<span class="ls-reset">x</span>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<table>
						<thead>
							<tr>
								<td>
									<span id="ls-icon-preview"></span>
									<h4>Preview</h4>
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
										<button class="button ls-preview-button">Enter Preview</button>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<table>
						<thead>
							<tr>
								<td>
									<span id="ls-icon-sublayers"></span>
									<h4>Sublayers</h4>
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
											<a href="#" class="active">Basic</a>
											<a href="#">Options</a>
											<a href="#">Link</a>
											<a href="#">Style</a>
											<a href="#">Attributes</a>
											<a href="#" title="Remove this sublayer" class="remove">x</a>
										</div>
										<div class="ls-sublayer-pages">
											<div class="ls-sublayer-page ls-sublayer-basic active">
												<select name="type">
													<option <?php echo ($sublayer['type'] == 'product') ? 'selected="selected"' : '' ?>>product</option>
													
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
														<span class="ls-icon-product"></span><br>
														Product
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
													<h5 style="margin-bottom:8px;">Product in sublayer: <a href="#" class="ls-add-product" >Add new product</a><a href="#" class="ls-icon-del">Remove product</a></h5>
													<div style="margin-botom:8px;">
													Set Discount Label:
													<select style="display:inline;" name="discount">
													<?php 
														$select = '';
														
														if(!isset($sublayer['discount']) OR $sublayer['discount'] =='') $select = 'selected="selected"';
														
														echo '<option '.$select.' value="" >Choose Discount</option>';
														
														foreach($discounts as $discount){
															$select = '';

															if(isset($sublayer['discount']) AND $sublayer['discount'] == $discount)$select = 'selected="selected"';

															echo '<option '.$select.' value ="'.$discount.'">'.$discount.'%</option>';
														}
													?>
													</select>
													</div>
													<?php if(isset($sublayer['product']) AND $sublayer['product'] !=''){ 
														$productForSlider = $productsForSlider[$sublayer['product']];?>

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
													<?php }?>
													<input type="hidden" name="product" value="<?php echo (isset($sublayer['product']) AND $sublayer['product'] !='') ? $sublayer['product'] : ''; ?>">
														
												</div>
												<div class="ls-image-uploader">
				<!-- TODO else transparent background -->
													<?php 
$imageSrc = !empty($sublayer['image']) ? $sublayer['image'] :'/vidnoff.com/admin/view/stylesheet/vidnoff/image/transparent.png' ?>
													<img src="<?php echo $imageSrc ?>" alt="sublayer image">
													<input type="text" name="image" class="ls-upload" value="<?php echo $sublayer['image'] ?>">
													<p>
														Click into this text field to open WordPress Media Library where you can upload new images or select previously used ones.'
													</p>
												</div>

												<div class="ls-html-code">
													<h5>Custom HTML content</h5>
													<textarea name="html" cols="50" rows="5"><?php echo stripslashes($sublayer['html']) ?></textarea>
												</div>
											</div>
											<div class="ls-sublayer-page ls-sublayer-options">
												<table>
													<tbody>
														<tr>
															<td>Slide in animation</td>
															<td class="right">Direction</td>
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
															<td class="right">Duration</td>
															<td><input type="text" name="durationin" value="<?php echo $sublayer['durationin'] ?>"> (ms)</td>
															<td class="right">Easing</td>
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
															<td class="right">Delay</td>
															<td><input type="text" name="delayin" value="<?php echo $sublayer['delayin'] ?>"> (ms)</td>
														</tr>

														<tr>
															<td>Slide out animation</td>
															<td class="right">Direction</td>
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
															<td class="right">Duration</td>
															<td><input type="text" name="durationout" value="<?php echo $sublayer['durationout'] ?>"> (ms)</td>
															<td class="right">Easing</td>
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
															<td class="right">Delay</td>
															<td><input type="text" name="delayout" value="<?php echo $sublayer['delayout'] ?>"> (ms)</td>
														</tr>

														<tr>
															<td>Other options</td>
															<td class="right">P. Level</td>
															<td><input type="text" name="level" value="<?php echo $sublayer['level'] ?>"></td>
															<td class="right">Show until</td>
															<td><input type="text" name="showuntil" value="<?php echo !empty($sublayer['showuntil']) ? $sublayer['showuntil'] : '0'  ?>"> (ms)</td>
															<td class="right">Hidden</td>
															<td><input type="checkbox" name="skip" class="checkbox" <?php echo isset($sublayer['skip']) ? 'checked="checked"' : '' ?>></td>
															<td colspan="3"><button class="button duplicate">Duplicate this sublayer</button></td>
														</tr>
												</table>
											</div>
											<div class="ls-sublayer-page ls-sublayer-link">
												<table>
													<tbody>
														<tr>
															<td>URL</td>
															<td class="url"><input type="text" name="url" value="<?php if(isset($sublayer['product']) AND $sublayer['product'] !=''){$productForSlider = $productsForSlider[$sublayer['product']];echo $productForSlider['href'];
															}else {echo $sublayer['url'];} ?>"></td>
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
															<td rowspan="2" >Basic style settings</td>
															<td class="right">
																Top:<input type="text" name="top" value="<?php echo $sublayer['top'] ?>">
															</td>
															<td class="right">
																Left:<input type="text" name="left" value="<?php echo $sublayer['left'] ?>">
															</td>
															<td class="right">Height:<input type="text" name="height" value="<?php echo $sublayer['height'] ?>"></td>
															<td class="right">Transparent(0-100)<input type="text" name="transparent" value="<?php echo $sublayer['transparent'] ?>"></td>
														</tr>
														<tr>
															<td class="right">
																Bottom:<input type="text" name="bottom" value="<?php echo $sublayer['bottom'] ?>">
															</td>
															<td class="right">
																Right:<input type="text" name="right" value="<?php echo $sublayer['right'] ?>">
															</td>
															<td class="right">Width:<input type="text" name="width" value="<?php echo $sublayer['width'] ?>"></td>
															<td class="right">Word-wrap<input type="checkbox" name="wordwrap" class="checkbox" <?php echo isset($sublayer['wordwrap']) ? 'checked="checked"' : '' ?>></td>
														</tr>
														<tr>
															<td>Custom style settings</td>
															<td class="right">Custom styles</td>
															<td colspan="4"><textarea rows="5" cols="50" name="style" class="style"><?php echo stripslashes($sublayer['style']) ?></textarea></td>
														</tr>
													</tbody>
												</table>
											</div>
											<div class="ls-sublayer-page ls-sublayer-attributes">
												<table>
													<tbody>
														<tr>
															<td>Attributes</td>
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
					<a href="#" class="ls-add-sublayer">Add new sublayer</a>
				</div>
				<?php endforeach; ?>
			<?php endif; ?>
			</div>
		</div>

	<!-- Event Callbacks -->
		<div class="ls-page ls-callback-page">
			<div class="ls-box ls-callback-box">
				<h3 class="header">cbInit</h3>
				<div class="inner">
					<textarea name="cbinit" cols="20" rows="5"><?php echo stripslashes($slider['properties']['cbinit']) ?></textarea>
				</div>
			</div>

			<div class="ls-box ls-callback-box">
				<h3 class="header">cbStart</h3>
				<div class="inner">
					<textarea name="cbstart" cols="20" rows="5"><?php echo stripslashes($slider['properties']['cbstart']) ?></textarea>
				</div>
			</div>

			<div class="ls-box ls-callback-box side">
				<h3 class="header">cbStop</h3>
				<div class="inner">
					<textarea name="cbstop" cols="20" rows="5"><?php echo stripslashes($slider['properties']['cbstop']) ?></textarea>
				</div>
			</div>

			<div class="ls-box ls-callback-box">
				<h3 class="header">cbPause</h3>
				<div class="inner">
					<textarea name="cbpause" cols="20" rows="5"><?php echo stripslashes($slider['properties']['cbpause']) ?></textarea>
				</div>
			</div>

			<div class="ls-box ls-callback-box">
				<h3 class="header">cbAnimStart</h3>
				<div class="inner">
					<textarea name="cbanimstart" cols="20" rows="5"><?php echo stripslashes($slider['properties']['cbanimstart']) ?></textarea>
				</div>
			</div>

			<div class="ls-box ls-callback-box side">
				<h3 class="header">cbAnimStop</h3>
				<div class="inner">
					<textarea name="cbanimstop" cols="20" rows="5"><?php echo stripslashes($slider['properties']['cbanimstop']) ?></textarea>
				</div>
			</div>

			<div class="ls-box ls-callback-box">
				<h3 class="header">cbPrev</h3>
				<div class="inner">
					<textarea name="cbprev" cols="20" rows="5"><?php echo stripslashes($slider['properties']['cbprev']) ?></textarea>
				</div>
			</div>

			<div class="ls-box ls-callback-box">
				<h3 class="header">cbNext</h3>
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
	token : '<?php echo $token ?>'
}

</script>

<style type="text/css">
.box{
	color: #666;
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
	font-size: 12px;
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
	border-radius: 3px;
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