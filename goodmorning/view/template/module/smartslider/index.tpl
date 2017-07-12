<!-- set layout and position for sliders -->

<?php echo $header; ?>

<div id="save_dialog" class="popup">
  <p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span><?php echo $popup_save_success; ?></p>
</div>
<div id="remove_dialog" class="popup">
  <p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>A you sure you want to remove this slider?</p>
</div>
<div id="save_wait" class="popup">
  <img src="view/stylesheet/smartslider/image/load.gif" alt="">
</div>

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
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title_inex; ?></h1>
      <div class="buttons">
		<a style="" class="button show_hide_help show"><span><?php echo $button_help_hide; ?></span></a>
		<a class="button save"><?php echo $button_save; ?></a>
		<a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a>
	  </div>
    </div>
    <div class="content">
	
	<div id="tabs" class="htabs">
		<a href="#tab-page"><?php echo $text_ss_on_page; ?> <i title="<?php echo $help_ss_on_page; ?>" class="icon-question-sign vtip_b"></i></a>
		<a href="#tab-list"><?php echo $text_ss_list; ?> <i title="<?php echo $help_ss_list; ?>" class="icon-question-sign vtip_b"></i></a>
		<a href="#tab-exp_imp"><?php echo $text_export_import_ss; ?> <i title="<?php echo $help_export_import_ss; ?>" class="icon-question-sign vtip_b"></i></a>
	</div>
	
	<div id="tab-page">
		<div class="ss_page">
			<?php echo $text_list_ss_on_page; ?>
			<div class="ls-box ls-slider-list">
			<table id="position">
				<thead>
					<tr style="text-align:center;">
						<td class="left"><?php echo $entry_banner; ?></td>
						<td class="left"><?php echo $entry_layout; ?></td>
						<td class="left"><?php echo $entry_position; ?></td>
						<td class="left"><?php echo $entry_status; ?></td>
						<td class="right"><?php echo $entry_sort_order; ?></td>
						<td class="right"><?php echo $entry_mobile_status; ?></td>
						<td></td>
					</tr>
				</thead>
				<?php $pos_row = 0; ?>
				<?php if(!empty($sliders)) { ?>
				<?php foreach ($positions as $position) { ?>
				<tbody id="position-row<?php echo $pos_row; ?>">
					<tr>
						<td class="left">
							<input type="hidden" name="positions[<?php echo $pos_row; ?>][pos_id]" value="<?php echo $pos_row; ?>"/>
							<select name="positions[<?php echo $pos_row; ?>][slider_id]">
								<?php foreach ($sliders as $slider) { ?>
								<?php //var_dump($position);  ?>
								<?php if ($slider['properties']['slider_id'] == $position['slider_id']) { ?>
								<option value="<?php echo $slider['properties']['slider_id']; ?>" selected="selected"><?php echo $slider['properties']['title']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $slider['properties']['slider_id']; ?>"><?php echo $slider['properties']['title']; ?></option>
								<?php } ?>
								<?php } ?>
							</select></td>
						<td class="left"><select class="layout" name="positions[<?php echo $pos_row; ?>][layout_id]">
						  <?php foreach ($layouts as $layout) { ?>
						  <?php if ($layout['layout_id'] == $position['layout_id']) { ?>
						  <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
						  <?php } else { ?>
						  <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
						  <?php } ?>
						  <?php } ?>
						</select></td>
						<td class="left"><select name="positions[<?php echo $pos_row; ?>][position]">
						  <?php if ($position['position'] == 'content_top') { ?>
						  <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
						  <?php } else { ?>
						  <option value="content_top"><?php echo $text_content_top; ?></option>
						  <?php } ?>
						  <?php if ($position['position'] == 'content_bottom') { ?>
						  <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
						  <?php } else { ?>
						  <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
						  <?php } ?>
						  <?php if ($position['position'] == 'column_left') { ?>
						  <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
						  <?php } else { ?>
						  <option value="column_left"><?php echo $text_column_left; ?></option>
						  <?php } ?>
						  <?php if ($position['position'] == 'column_right') { ?>
						  <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
						  <?php } else { ?>
						  <option value="column_right"><?php echo $text_column_right; ?></option>
						  <?php } ?>
						</select></td>
						<td class="left"><select name="positions[<?php echo $pos_row; ?>][status]">
						  <?php if ($position['status']) { ?>
						  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						  <option value="0"><?php echo $text_disabled; ?></option>
						  <?php } else { ?>
						  <option value="1"><?php echo $text_enabled; ?></option>
						  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						  <?php } ?>
						</select></td>
						<td class="right"><input type="text" name="positions[<?php echo $pos_row; ?>][sort_order]" value="<?php echo $position['sort_order']; ?>" size="3" /></td>
						<td class="right">
						<select name="positions[<?php echo $pos_row; ?>][mobile_status]">
						  <?php if (isset($position['mobile_status']) AND $position['mobile_status']) { ?>
						  <option value="1" selected="selected">Visible</option>
						  <option value="0">Hidden</option>
						  <?php } else { ?>
						  <option value="1">Visible</option>
						  <option value="0" selected="selected">Hidden</option>
						  <?php } ?>
						</select>
						</td>
						<td class="left"><a class="button remove_pos"><?php echo $button_remove; ?></a></td>
					</tr>
				</tbody>
				<?php $pos_row++; ?>
				<?php } ?>
				<?php }else {?>	
					<tr class="center">
							<td colspan="5">You didn't create a slider yet</td>
							<td class="right">
								<a class="button" href="<?php echo $newslider_url ?>">Add New Slider</a> 
							</td>
					</tr>
				<?php } ?>
				<tfoot>
				<?php if(!empty($sliders)) { ?>
					<tr>
						<td colspan="5"></td>
						<td class="right" style="float:right;"><a class="button add_pos" style="margin: 5px 0;"><?php echo $button_add_slider; ?></a></td>
					</tr>
				<?php } ?>	
				</tfoot>
			</table>
			</div>
		</div>
	</div>
	<div id="tab-list">
		<div class="ss_list">
			<!-- SLIDER LIST START-->
			
			<div class="button_block">
			<?php if($is_example) { ?>
				<a style="" class="button" href="<?php echo $delexampleproduct_url; ?>"><?php echo $text_del_example_product; ?> <i title="<?php echo $help_del_example_product; ?>" class="icon-question-sign vtip_r"></i></a>
			<?php } ?>
				<a style="" class="button" href="<?php echo $getexample_url; ?>"><?php echo $text_get_example; ?> <i title="<?php echo $help_get_example; ?>" class="icon-question-sign vtip_br"></i></a>
				<a class="button" href="<?php echo $newslider_url ?>">Add New Slider</a> 
			</div>
			<div class="ls-box ls-slider-list" style="clear:both;">
				
				<table>
					<thead>
						<tr class="center">
							<td>Name</td>
							<td>Created</td>
							<td>Modified</td>
							<td>Action</td>
						</tr>
					</thead>
					<tbody>
						<?php if(!empty($sliders)) : ?>
						<?php foreach($sliders as $slider) : ?>
						<?php $title = empty($slider['properties']['title']) ? 'Unnamed' : $slider['properties']['title']; ?>
						<tr class="center">
							<td><a href="/edit&id=<?php echo $slider['properties']['slider_id']; ?>"><?php echo $title ?></a></td>
							<td><?php echo $slider['properties']['date_c'] ?></td>
							<td><?php echo $slider['properties']['date_m'] ?></td>
							<td>
								<a class="button" href="<?php echo $editslider_url; ?>&id=<?php echo $slider['properties']['slider_id']; ?>">Edit</a> 
								<a class="button duplicate" data-id="<?php echo $slider['properties']['slider_id']; ?>">Duplicate</a> 
								<a class="button remove" data-id="<?php echo $slider['properties']['slider_id']; ?>">Remove</a>
							</td>
						</tr>
						<?php endforeach; ?>
						<?php endif; ?>
						<tr class="center">
							<td colspan="3"><?php if(empty($sliders)) : ?>You didn't create a slider yet<?php endif; ?></td>
							<td>
							</td>
						</tr>
						
					</tbody>
				</table>
			</div>			
			<!-- SLIDER LIST END-->
		</div>
	</div>
	<div id="tab-exp_imp">
		<div class="ss_export">
			<!-- IMPORT/EXPORT START-->
			<form action="<?php echo $import_url; ?>" method="post" class="ls-box ls-import-box">
				<h3 class="header"><?php echo $text_import_ss; ?></h3>
				<div class="inner">
					<textarea name="import" rows="10" cols="50"></textarea>
					<button class="button"><?php echo $text_import; ?></button> 
				</div>
			</form>

			<div class="ls-box ls-import-box">
				<h3 class="header"><?php echo $text_export_ss; ?></h3>
				<div class="inner">
					<textarea rows="10" cols="50" readonly="readonly"><?php echo base64_encode(json_encode($smartSlider)) ?></textarea>
					<p><?php echo $text_export_import_info; ?></p>
				</div>
			</div>
			<!-- IMPORT/EXPORT END-->		
		</div>
	</div>
  </div>
</div>

<script type="text/javascript">
$(function () { 
	$('#tabs a').tabs();

// click on  last activ tab	
	$('#tabs a').click(function(){
		$.cookie('tabs_activ', $(this).index());
	});
	if($.cookie('tabs_activ'))$('#tabs a').eq($.cookie('tabs_activ')).click();
	
	//====================
	$( ".vtip" ).tipsy({gravity: 's', delayIn: 500, delayOut: 500, opacity: 0.9, html: true});
	$( ".vtip_l" ).tipsy({gravity: 'sw', delayIn: 500, delayOut: 500, opacity: 0.9, html: true});
	$( ".vtip_r" ).tipsy({gravity: 'se', delayIn: 500, delayOut: 500, opacity: 0.9, html: true});
	$( ".vtip_b" ).tipsy({gravity: 'n', delayIn: 500, delayOut: 500, opacity: 0.9, html: true, offset: 20,});
	$( ".vtip_br" ).tipsy({gravity: 'ne', delayIn: 500, delayOut: 500, opacity: 0.9, html: true, offset: 20,});
	
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
	
// SETTING DIALOG, POPUP, LOADER start (1)
	// setting all popup (1.1)
	$( ".popup" ).dialog({
		autoOpen: false,
		draggable: false,
		resizable: false,
		modal: true,
		open: function(event, ui){
			$(this).prev().remove();
		}
	});
	
	// setting ajax loader start (2)
	$( "#save_wait" ).dialog('option', 'dialogClass', 'save_wait');
	
	$.ajaxSetup({
		beforeSend: function(event, jj){
			$( "#save_wait" ).dialog( "open" );
		},
		complete: function() {
			$( "#save_wait" ).dialog( "close" );
		}
	});
// SETTING DIALOG, POPUP, LOADER end	
	
	ss_admin.init();
});	
	
var ss_admin = { 
	data:{
		pos_row  			: '<?php echo $pos_row; ?>',
		layout				: <?php echo json_encode($layouts); ?>
	},

	init : function (){
		$('.add_pos').live('click', function(){ss_admin.addPosition()});
		
		$('.save').live('click', function(){ss_admin.saveSlider()});
		
		$('.remove').live('click', function(){ss_admin.removeSlider(this)});
		
		$('.duplicate').live('click', function(){ss_admin.duplicateSlider(this)});
		
		$('.remove_pos').live('click', function(){ss_admin.removePosition(this)});
		
		$('.still_continue_edit').live('click', function(){
			window.location = '<?php echo htmlspecialchars_decode($still_editslider_url); ?>&id=' +$(this).attr('data-id_slider');
		}); 
		
	},
	
// відсилання даних на сервер	
	saveSlider : function(){

		var http = '<?php echo htmlspecialchars_decode($save_url); ?>';

		$.ajax({
			url	 : http,
			type : 'POST', 
			data : ss_admin.getURLData(),
			async : true,
			success : function(success) {
				$( "#save_dialog" ).dialog('option', {
					buttons: {
						"Continue editing": function() {
						//window.location = '<?php echo htmlspecialchars_decode($action); ?>';
						$(this).dialog( "close" );
						},
						"Cancel": function() {
						window.location = '<?php echo htmlspecialchars_decode($cancel); ?>';
						}
					}
				}).dialog( "open" );
			}
		});		
	},

	removeSlider : function(slider, confirm){
		if(confirm){
			var id = $(slider).attr('data-id');
			var http = '<?php echo htmlspecialchars_decode($removeslider_url); ?>';
			$.ajax({
				url	 : http+'&id='+id,
				type : 'GET', 
				async : true,
				success : function(success) {
					window.location = '<?php echo htmlspecialchars_decode($action); ?>';
					// TODO CLICK ON ACTIVE TAB
				}
			});	
		}else{
			$( "#remove_dialog" ).dialog('option', {
				buttons: {
					"Confirm Remove": function() {
						ss_admin.removeSlider(slider, true)
						$(this).dialog( "close" );
					},
					"Cancel": function() {
						$(this).dialog( "close" );
					}
				}
			}).dialog( "open" );		
		}
	},
	
	duplicateSlider : function(slider){
		var http = '<?php echo htmlspecialchars_decode($duplicateslider_url); ?>';
		var id = $(slider).attr('data-id');
		$.ajax({
			url	 : http+'&id='+id,
			type : 'GET', 
			async : true,
			success : function(success) {
				window.location = '<?php echo htmlspecialchars_decode($action); ?>';
				// TODO CLICK ON ACTIVE TAB
			}
		});	
	},	

// @return string URLdata - settings in URL formats
	getURLData : function (){	
		$data = jQuery('.ss_page').find('input, textarea, select');
		return $data.serialize();
	},
	
	removePosition : function (el){
		$(el).parent().parent().parent().remove();
		ss_admin.correctLayout(true);
		$('.add_pos').show();
	},
	
	addPosition : function (){	
		//positions = ['name'=>'', 'slider_id'=>'', 'layout_id'=>'', 'position'=>'', 'status'=>'',...]
		html  = '<tbody id="position-row' + ss_admin.data.pos_row + '">';
		html += '  <tr>';
		
			html += '    <td class="left"><input type="hidden" name="positions['+ ss_admin.data.pos_row +'][pos_id]" value="'+ ss_admin.data.pos_row +'"/>';
			html += '    <select name="positions[' + ss_admin.data.pos_row + '][slider_id]">';
			<?php foreach ($sliders as $slider) { ?>
			html += '      <option value="<?php echo $slider['properties']['slider_id']; ?>"><?php echo addslashes($slider['properties']['title']); ?></option>';
			<?php } ?>
			html += '    </select></td>';	
			
			html += '    <td class="left"><select  class="layout" name="positions[' + ss_admin.data.pos_row + '][layout_id]">';
			<?php foreach ($layouts as $layout) { ?>
			html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
			<?php } ?>
			html += '    </select></td>';	
			
			html += '    <td class="left"><select name="positions[' + ss_admin.data.pos_row + '][position]">';
				html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
				html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
				html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
				html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
			html += '    </select></td>';
			
			html += '    <td class="left"><select name="positions[' + ss_admin.data.pos_row + '][status]">';
				html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
				html += '      <option value="0"><?php echo $text_disabled; ?></option>';
			html += '    </select></td>';
			
			html += '    <td class="right"><input type="text" name="positions[' + ss_admin.data.pos_row + '][sort_order]" value="0" size="3" /></td>';
			
			html += '    <td class="left"><a class="button remove_pos"><?php echo $button_remove; ?></a></td>';
		
		html += '  </tr>';
		html += '</tbody>';
		
		$('#position tfoot').before(html);
		
		ss_admin.data.pos_row++;
		ss_admin.correctLayout();
	},

	correctLayout : function (remove){
		//searc select option
		var selectValues = [];
		if(remove){
			$('select.layout').each(function(){
				if(selectValues.indexOf($(this).val())<0)
				selectValues.push($(this).val());
			});
		}
		else{
			$('select.layout').not(':last').each(function(){
				if(selectValues.indexOf($(this).val())<0)
				selectValues.push($(this).val());
			});
		}

		//alert(selectValues);
		// search free option
		var freeValues = [];
		
		$.each(ss_admin.data.layout, function(index, lay_value){
			if( selectValues.indexOf(lay_value.layout_id) < 0 ){
				freeValues.push({layout_id : lay_value.layout_id, name : lay_value.name});
			}
		});

		//alert(ss_admin.data.layout.length+'=='+freeValues.length);
		// clear option that not select
		if(!remove)$('select.layout:last').html('');
		$('select.layout').each(function(){
			var selectValue = $(this).val();
			$(this).find('option').each(function(){
				if($(this).attr('value') != selectValue){
					$(this).remove();
				}
			});
		});
		
		// add free option===========
		var options = '';
			$.each(freeValues, function(index, freeValue){
				options += '<option value="'+ freeValue.layout_id +'">'+ freeValue.name +'</option>';
			});
		$('select.layout').each(function(){
			$(this).append(options);
		});
		
		// hide button and remove last row if layout==0
		if (!$('select.layout:last option').length){

			$('select.layout:last').parent().parent().remove();
			$('.add_pos').hide();
		}else{
			$('.add_pos').show();
		}
	}

}

</script>

<style>
.button_block {
	float:right;
	margin-bottom:10px;
}
.button_block a{
	float:right;
	margin-right: 7px!important;
}

.warning .still_continue_edit{
	margin: 0px!important;
	float:right!important;
	background: #fff!important;
	color: red!important;
	padding: 4px 5px!important;
	margin-top: -4px!important;
	border-radius: 3px!important;
	border: 1px solid red!important;
}

.center{text-align:center; margin:0 auto;}
.ui-accordion .ui-accordion-header {
	padding: .5em .5em .5em 2.7em;
}
.ui-widget-content {
	border: 1px solid #dddddd;
	background: #fff;
	color: #333333;
}
.ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active {
	border: 1px solid #29b4ec;
	background: #29b4ec;
	font-weight: bold;
	color: #fff;
}

#accordion>div.ss_page, #accordion>div.ss_list {
    height: 250px!important;
}

.popup{
	display:none;
}
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
</style>
<?php echo $footer; ?>