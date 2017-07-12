
var SmartSlider = { 

	uploadInput : null,
	uploadTumb	: null,
	dragContainer : null,
	dragIndex : 0,
	newIndex : 0,
	timeout : 0,
	counter : 0,

	selectMainTab : function(el) {

		// Remove highlight from the other tabs
		jQuery('#ls-main-nav-bar a').removeClass('active');

		// Highlight selected tab
		jQuery(el).addClass('active');

		// Hide other pages
		jQuery('#ls-pages .ls-page').removeClass('active');

		// Show selected page
		jQuery('#ls-pages .ls-page').eq( jQuery(el).index() ).addClass('active')
	},

	addLayer : function() {

		// Clone the sample layer page
		var clone = jQuery('#ls-sample > div').clone();

		// Append to place
		clone.appendTo('#ls-layers');

		// Close other layers
		jQuery('#ls-layer-tabs a').removeClass('active');

		// Get layer index
		var index = clone.index();

		// Add layer tab
		var tab = jQuery('<a href="#">Layer #'+(index+1)+' <span class="icon-remove-sign"></span></a>').insertBefore('#ls-add-layer');

		// Open new layer
		tab.click();

		// Add sortables
		SmartSlider.addSortables();

		// Generate preview
		SmartSlider.generatePreview(index);
		
		clone.find('.d_d-sample').removeClass('d_d-sample').addClass('d_d');
		SmartSlider.dropDownImage.create(clone.find('.d_d'));

		SmartSlider.tipsy();
	},

	removeLayer : function(el, confirm) {
		
		if(confirm){
			// Get menu item
			var item = jQuery(el).parent();

			// Get layer
			var layer = jQuery(el).closest('#ls-layer-tabs').next().children().eq( item.index() );

			// Open next or prev layer
			if(layer.next().length > 0) {
				item.next().click();

			} else if(layer.prev().length > 0) {
				item.prev().click();
			}

			// Remove menu item
			item.remove();

			// Remove the layer
			layer.remove();

			// Reindex layers
			SmartSlider.reindexLayers();
		}else{
			$( "#confirm_dialog" ).dialog('option', {
				buttons: {
					"Confirm Remove": function() {
						SmartSlider.removeLayer(el, true);
						$(this).dialog( "close" );
					},
					"Cancel": function() {
						$(this).dialog( "close" );
					}
				}
			}).dialog( "open" ).html(slider.text.confirm_del_layer);		
		}
	},

	selectLayer : function(el) {

		// Close other layers
		jQuery('#ls-layer-tabs a').removeClass('active');
		jQuery('#ls-layers .ls-layer-box').removeClass('active');

		// Open new layer
		jQuery(el).addClass('active');
		jQuery('#ls-layers .ls-layer-box').eq( jQuery(el).index() ).addClass('active');

		// Open first sublayer
		jQuery('#ls-layers .ls-layer-box').eq( jQuery(el).index() ).find('.ls-sublayers td:first').click();

		// Update preview
		SmartSlider.generatePreview( jQuery(el).index() );

		// Stop preview
		SmartSlider.stop();
	},

	duplicateLayer : function(el) {
		// full recreate drop image start (1)
		jQuery(el).closest('.ls-layer-box').find('.d_d').each(function(){
			var selected_index =  $(this).data('api').get("selectedIndex");
			if(selected_index == -1 )selected_index = 0;
			$(this).find('option').eq(selected_index).attr('selected', 'selected');
		});
		// full recreate drop image end (1)
		
		// Clone fix
		SmartSlider.cloneFix();

		// Get layer index
		var index = jQuery(el).closest('.ls-layer-box').index();

		// Append new tab
		jQuery('<a href="#">Layer #0 <span class="icon-remove-sign"></span></a>').insertBefore('#ls-layer-tabs a:last');

		// Rename tab
		SmartSlider.reindexLayers();

		// Clone layer
		var clone = jQuery(el).closest('.ls-layer-box').clone();

		// Append new layer
		clone.appendTo('#ls-layers');

		// Remove active class if any
		clone.removeClass('active');

		// Add sortables
		SmartSlider.addSortables();
		
		// full recreate drop image start (2)
		clone.find('.dd').remove();
		clone.find('.ddOutOfVision').each(function(){
			var select = $(this).find('.d_d').clone();
			//alert(select.html());
			var $label = $(this).parents('.product_label');
			$(this).remove();
			select.appendTo($label);
			//alert($label.find('select.d_d').val());
			//if()
		});
		clone.find('.d_d').removeAttr('id');
		SmartSlider.dropDownImage.create(clone.find('.d_d'));
		// full recreate drop image end
		
		SmartSlider.tipsy();
	},

	addSublayer : function(el) {

		// Get clone from sample
		var clone = jQuery('#ls-sample .ls-sublayers > tr').clone();

		// Appent to place
		clone.appendTo( jQuery(el).prev().find('.ls-sublayers') );

		// Get sublayer index
		var index = clone.index();

		// Rewrite sublayer number
		clone.find('.ls-sublayer-number').html( index + 1);
		clone.find('.ls-sublayer-title').val('Sublayer #' + (index + 1) );

		clone.find('.d_d-sample').removeClass('d_d-sample').addClass('d_d');
		SmartSlider.dropDownImage.create(clone.find('.d_d'));
		
		// Open it
		clone.click();
		
		// full recreate drop image start (1)
		clone.find('.d_d').each(function(){
			var selected_index =  $(this).data('api').get("selectedIndex");
			if(selected_index == -1 )selected_index = 0;
			$(this).find('option').eq(selected_index).attr('selected', 'selected');
		});
		// full recreate drop image end (1)
		// full recreate drop image start (2)
		clone.find('.dd').remove();
		clone.find('.ddOutOfVision').each(function(){
			var select = $(this).find('.d_d').clone();
			var $label = $(this).parents('.product_label');
			$(this).remove();
			select.appendTo($label);
		});
		clone.find('.d_d').removeAttr('id');
		SmartSlider.dropDownImage.create(clone.find('.d_d'));
		// full recreate drop image end
		
		SmartSlider.tipsy();
	},

	selectSubLayer : function(el) {

		if(jQuery(el).index() == jQuery(el).parent().children('.active:first').index() ) {
			return;
		}

		// Close other sublayers
		jQuery(el).parent().children().removeClass('active');

		// Open the new one
		jQuery(el).addClass('active');
	},

	selectSublayerPage : function(el) {

		// Close previous page
		jQuery(el).parent().children().removeClass('active');
		jQuery(el).parent().next().find('.ls-sublayer-page').removeClass('active');

		// Open the selected one
		jQuery(el).addClass('active');
		jQuery(el).parent().next().find('.ls-sublayer-page').eq( jQuery(el).index() ).addClass('active');
	},

	removeSublayer : function(el, confirm) {

		if(confirm){
			// Get sublayer
			var sublayer = jQuery(el).closest('tr');

			// Get layer index
			var layer = jQuery(el).closest('.ls-layer-box');

			// Open the next or prev sublayer
			if(sublayer.next().length > 0) {
				sublayer.next().click();

			} else if(sublayer.prev().length > 0) {
				sublayer.prev().click();
			}

			// Remove menu item
			jQuery(el).remove();

			// Remove sublayer
			sublayer.remove();

			// Update preview
			SmartSlider.generatePreview( layer.index() );
		}else{
			$( "#confirm_dialog" ).dialog('option', {
				buttons: {
					"Confirm Remove": function() {
						SmartSlider.removeSublayer(el, true);
						$(this).dialog( "close" );
					},
					"Cancel": function() {
						$(this).dialog( "close" );
					}
				}
			}).dialog( "open" ).html(slider.text.confirm_del_sublayer);		
		}
	},

	highlightSublayer : function(el) {

		if(jQuery(el).prop('checked') == true) {

			// Deselect other checkboxes
			jQuery('.ls-highlight input').not(el).prop('checked', false);

			// Restore sublayers in the preview
			jQuery(el).closest('.ls-layer-box').find('.draggable').children().css({ opacity : 0.5 });

			// Get element index
			var index = jQuery(el).closest('tr').index();

			// Highlight selected one
			jQuery(el).closest('.ls-layer-box').find('.draggable').children().eq(index).css({ zIndex : 1000, opacity : 1 });

		} else {

			// Restore sublayers in the preview
			jQuery(el).closest('.ls-layer-box').find('.draggable').children().each(function(index) {
				jQuery(this).css({ zIndex : 10 + index });
				jQuery(this).css('opacity', 1);
			});
		}
	},

	duplicateSublayer : function(el) {
		// full recreate drop image start (1)
		jQuery(el).closest('.ls-sublayer-wrapper').closest('tr').find('.d_d').each(function(){
			var selected_index =  $(this).data('api').get("selectedIndex");
			if(selected_index == -1 )selected_index = 0;
			$(this).find('option').eq(selected_index).attr('selected', 'selected');
		});
		// full recreate drop image end (1)
		
		// Clone fix
		SmartSlider.cloneFix();

		// Clone sublayer
		var clone = jQuery(el).closest('.ls-sublayer-wrapper').closest('tr').clone();

		// Remove active class
		clone.removeClass('active');

		// Append
		clone.appendTo( jQuery(el).closest('.ls-sublayers')  );

		// Rename sublayer
		clone.find('.ls-sublayer-title').val( clone.find('.ls-sublayer-title').val() + ' copy' );
		SmartSlider.reindexSublayers( jQuery(el).closest('.ls-layer-box') );

		// full recreate drop image start (2)
		clone.find('.dd').remove();
		clone.find('.ddOutOfVision').each(function(){
			var select = $(this).find('.d_d').clone();
			//alert(select.html());
			var $label = $(this).parents('.product_label');
			$(this).remove();
			select.appendTo($label);
			//alert($label.find('select.d_d').val());
			//if()
		});
		clone.find('.d_d').removeAttr('id');
		SmartSlider.dropDownImage.create(clone.find('.d_d'));
		// full recreate drop image end
		
		// Update preview
		SmartSlider.generatePreview( jQuery(el).closest('.ls-layer-box').index() );

		SmartSlider.tipsy();
	},

	skipSublayer : function(el) {

		SmartSlider.generatePreview( jQuery(el).closest('.ls-layer-box').index()  );
	},

	selectMediaType : function(el) {

		// Remove highlight from the others
		jQuery(el).parent().children().removeClass('active');

		// Highlight the selected one
		jQuery(el).addClass('active');

		// Deselect old elements
		var $select = jQuery(el).closest('.ls-sublayer-basic').find('select').not('select[name=discount]').find('option');
		
		$select.attr('selected', false);

		// Change the select option
		var option = $select.eq( jQuery(el).index() ).attr('selected', true);

		// Show / hide image or product upload field
		if(option.val() == 'img') {
			jQuery(el).closest('.ls-sublayer-basic').find('.ls-image-uploader').show();
			jQuery(el).closest('.ls-sublayer-basic').find('.ls-product-uploader').hide();
			jQuery(el).closest('.ls-sublayer-basic').find('.ls-html-code').hide();
		} else if(option.val() == 'product'){
			jQuery(el).closest('.ls-sublayer-basic').find('.ls-image-uploader').hide();
			jQuery(el).closest('.ls-sublayer-basic').find('.ls-html-code').hide();
			jQuery(el).closest('.ls-sublayer-basic').find('.ls-product-uploader').show();
		} else {
			jQuery(el).closest('.ls-sublayer-basic').find('.ls-image-uploader').hide();
			jQuery(el).closest('.ls-sublayer-basic').find('.ls-product-uploader').hide();
			jQuery(el).closest('.ls-sublayer-basic').find('.ls-html-code').show();
		}
	},

	didSelectMediaType : function(el) {
		SmartSlider.selectMediaType(el);
		SmartSlider.generatePreview( jQuery(el).closest('.ls-layer-box').index() );
	},

	setCallbackBoxesWidth : function() {

		jQuery('.ls-callback-box').width( (jQuery('.wrap').width() - 26) / 3);
	},

	willGeneratePreview : function(index) {
		clearTimeout(SmartSlider.timeout);
		SmartSlider.timeout = setTimeout(function() {

			if(index == -1) {
				jQuery('#ls-layers .ls-layer-box').each(function( index ) {
					SmartSlider.generatePreview(index);
				});
			} else {
				SmartSlider.generatePreview(index);
			}
		}, 1000);
	},

	generatePreview : function(index) {

		// Get preview element
		var preview = jQuery('.ls-preview').eq( index + 1 ); // ????????????? + 1

		// Get the draggable element
		var draggable = preview.find('.draggable');

		// Get sizes
		var width = jQuery('.ls-settings input[name="width"]').val();
		var height = jQuery('.ls-settings input[name="height"]').val();
		
		var sub_container = jQuery('.ls-settings input[name="sublayercontainer"]').val();

		// Which width?
		if(sub_container != '' && sub_container != 0) {
			width = sub_container;
		}

		// Set sizes TODO
		//preview.add(draggable).css({ width : width, height : height });
		//preview.parent().css({ width : width });
		
		preview.add(draggable).css({ width : '100%', height : height });
		draggable.css({ width : '100%', height : '100%' });
		preview.parent().css({ width : width });

		// Get backgrounds
		var bgColor = jQuery('.ls-settings input[name="backgroundcolor"]').val();
		var bgImage = jQuery('.ls-settings input[name="backgroundimage"]').val();

		// Set backgrounds
		if(bgColor != '') {
			preview.css({ backgroundColor : bgColor });
		} else {
			preview.css({ backgroundColor : 'transparent' });
		}

		if(bgImage != '') {
			preview.css({ backgroundImage : 'url('+bgImage+')' });
		} else {
			preview.css({ backgroundImage : 'none' });
		}

		// Get yourLogo
		var yourLogo = jQuery('.ls-settings input[name="yourlogo"]').val();
		var yourLogoStyle = jQuery('.ls-settings input[name="yourlogostyle"]').val();

		// Remove previous yourLogo
		preview.parent().find('.yourlogo').remove();

		// Set yourLogo
		if(yourLogo && yourLogo != '') {
			var logo = jQuery('<img src="'+yourLogo+'" class="yourlogo">').prependTo( jQuery(preview).parent() );
			logo.attr('style', yourLogoStyle);

			var oL = oR = oT = oB = 'auto';

			if( logo.css('left') != 'auto' ){
				var logoLeft = logo[0].style.left;
			}
			if( logo.css('right') != 'auto' ){
				var logoRight = logo[0].style.right;
			}
			if( logo.css('top') != 'auto' ){
				var logoTop = logo[0].style.top;
			}
			if( logo.css('bottom') != 'auto' ){
				var logoBottom = logo[0].style.bottom;
			}

			if( logoLeft && logoLeft.indexOf('%') != -1 ){
				oL = width / 100 * parseInt( logoLeft ) - logo.width() / 2;
			}else{
				oL = parseInt( logoLeft );
			}

			if( logoRight && logoRight.indexOf('%') != -1 ){
				oR = width / 100 * parseInt( logoRight ) - logo.width() / 2;
			}else{
				oR = parseInt( logoRight );
			}

			if( logoTop && logoTop.indexOf('%') != -1 ){
				oT = height / 100 * parseInt( logoTop ) - logo.height() / 2;
			}else{
				oT = parseInt( logoTop );
			}

			if( logoBottom && logoBottom.indexOf('%') != -1 ){
				oB = height / 100 * parseInt( logoBottom ) - logo.height() / 2;
			}else{
				oB = parseInt( logoBottom );
			}

			logo.css({
				left : oL,
				right : oR,
				top : oT,
				bottom : oB
			});
		}

		// Get layer background
		var background = jQuery('#ls-layers .ls-layer-box').eq(index).find('input[name="background"]').val();

		// Set layer background
		if(background != '') {
			draggable.css({
				backgroundImage : 'url('+background+')',
				backgroundPosition : 'center center'
			});
		} else {
			draggable.css({
				backgroundImage : 'none'
			});
		}

		// Empty draggable
		draggable.children().remove();

		// Iterate over the sublayers
		jQuery('#ls-layers .ls-layer-box').eq(index).find('.ls-sublayers > tr').each(function() {

			// Get sublayer type
			var type = jQuery(this).find('select[name="type"] option:selected').val()

			// Get image URL
			var url = jQuery(this).find('input[name="image"]').val();

			// Skip?
			var skip = jQuery(this).find('input[name="skip"]').prop('checked');

			// WordWrap
			var wordWrap = jQuery(this).find('input[name="wordwrap"]').prop('checked');

			// smart add width, height and transparent
			var width = jQuery(this).find('input[name="width"]').val();
			var height = jQuery(this).find('input[name="height"]').val();
			var transparent = jQuery(this).find('input[name="transparent"]').val();

			// Append element
			if(skip) {
				jQuery('<div>').appendTo(draggable);
				return true;

			} else if(type == 'img') {
				if(url != '') {
					var item = jQuery('<img src="'+url+'">').appendTo(draggable);
				} else {
					var item =jQuery('<div>').appendTo(draggable);
				}
			
			// smart type = product start
			} else if(type == 'product') {
				var item = SmartSlider.makeProductItemForSlider(this, draggable,width, height, transparent);
			// smart type = product end	
			
			} else {

				// Get HTML content
				var html = jQuery(this).find('textarea[name="html"]').val();
				
				// Append the element
				var item =jQuery('<'+type+'>').appendTo(draggable);

				// Set HTML
				if(html != '') {
					item.html(html);
				}
			}

			// Abs pos
			item.css('position', 'absolute');

			// Get style settings
			var top = jQuery(this).find('input[name="top"]').val();
			var left = jQuery(this).find('input[name="left"]').val();
			var custom = jQuery(this).find('textarea[name="style"]').val();
			
			// Get style additional for smart (1)
			var bottom = jQuery(this).find('input[name="bottom"]').val();
			var right  = jQuery(this).find('input[name="right"]').val();

			// Set custom style settings
			item.attr('style', custom);

			// Word wrap
			if(wordWrap == true) {
				item.css('white-space', 'nowrap');
			}

			var pt = isNaN( parseInt( item.css('padding-top') ) ) ? 0 : parseInt( item.css('padding-top') );
			var pl = isNaN( parseInt( item.css('padding-left') ) ) ? 0 : parseInt( item.css('padding-left') );
			// Get style additional for smart (2)
			var pt = isNaN( parseInt( item.css('padding-bottom') ) ) ? 0 : parseInt( item.css('padding-bottom') );
			var pl = isNaN( parseInt( item.css('padding-right') ) ) ? 0 : parseInt( item.css('padding-right') );
			
			var bt = isNaN( parseInt( item.css('border-top-width') ) ) ? 0 : parseInt( item.css('border-top-width') );
			var bl = isNaN( parseInt( item.css('border-left-width') ) ) ? 0 : parseInt( item.css('border-left-width') );

			var setPositions = function(){
			
			// smart add width, height and transparent
			// size and transparent of element
				if(width.indexOf('%') != -1) {
					item.css({ 'width' : width });
				} else if(width != ""){
					item.width(parseInt(width));}
				
				if(height.indexOf('%') != -1) {
					item.css({ 'height' : height });
				} else if(height != "") {
					item.height(parseInt(height));
					
					}
				
				if(transparent != "") {item.css({ 'opacity' : parseInt(transparent)/100 });}
			
				// Position the element
				if(top.indexOf('%') != -1) {
					item.css({ top : draggable.height() / 100 * parseInt( top ) - item.height() / 2 - pt - bt });
				} else {
					item.css({ top : parseInt(top) });
				}

				if(left.indexOf('%') != -1) {
					item.css({ left : draggable.width() / 100 * parseInt( left ) - item.width() / 2 - pl - bl });
				} else {
					item.css({ left : parseInt(left) });
				}
				
				// Get style additional for smart (3)
				if(bottom.indexOf('%') != -1) {
					item.css({ bottom : draggable.height() / 100 * parseInt( bottom ) - item.height() / 2 - pt - bt });
				} else {
					item.css({ bottom : parseInt(bottom) });
				}

				if(right.indexOf('%') != -1) {
					item.css({ right : draggable.width() / 100 * parseInt( right ) - item.width() / 2 - pl - bl });
				} else {
					item.css({ right : parseInt(right) });
				}				
			};

			if( item.is('img') ){

				item.load(function(){
					setPositions();
				}).attr('src',item.attr('src') );
			}else{
				setPositions();
			}

			// Z-index
			item.css({ zIndex : 10 + item.index() });


			// Add draggable
			SmartSlider.addDraggable();
		});
	},

	openMediaLibrary : function() {
		// Bind upload button to show media uploader
		jQuery('.ls-upload').live('click', function() {
			uploadInput = this;
			$(uploadInput).attr('id', 'uploadInput_activ');
			SmartSlider.image_upload('uploadInput_activ');
			return false;
		});
	},

	image_upload : function(field) {
		var $_field = $('#' + field);
		var value_start = $_field.val();
		$('#dialog').remove();
		$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token='+slider.token+'&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
		
		$('#dialog').dialog({
			title: 'Image Manager',
			close: function (event, ui) {
				if ($_field.attr('value')) {
					$.ajax({
						url: 'index.php?route=common/filemanager/image&token='+slider.token+'&image=' + encodeURIComponent($_field.attr('value')),
						dataType: 'text',
						success: function(text) {
							if($_field.is('input[name="image"]')) {
								$_field.prev().attr('src', text);
							}
							if(value_start != $_field.val()){
								$_field.attr('data-relat_url', $_field.val());
								$_field.val(slider.path.mainImage+$_field.val());
								
							}
							$_field.removeAttr('id');
						// Generate preview
							jQuery('#ls-layers .ls-layer-box').each(function( index ) {
								SmartSlider.generatePreview(index);
							});	
						}
					});
				}
			},	
			bgiframe: false,
			width: 800,
			height: 400,
			resizable: false,
			modal: false
		});
	},
	
	addSortables : function() {

		// Bind sortable function
        jQuery('.ls-sublayer-sortable').sortable({
        	axis : 'y',

			helper: function(e, tr) {
				var $originals = tr.children();
				var $helper = tr.clone();
				$helper.children().each(function(index) {

					// Set helper cell sizes to match the original sizes
					jQuery(this).width($originals.eq(index).width());
				});
				return $helper;
			},
			sort : function(event, ui){
				SmartSlider.dragContainer = jQuery('.ui-sortable-helper').closest('.ls-layer-box');
			},
			stop : function(event, ui) {
				SmartSlider.generatePreview( SmartSlider.dragContainer.index() );
				SmartSlider.reindexSublayers( SmartSlider.dragContainer );
            },
            containment : 'parent',
			tolerance : 'pointer'
        });
	},

	addLayerSortables : function() {

		// Bind sortable function
		jQuery('#ls-layer-tabs').sortable({
			//axis : 'x',
			start : function() {
				SmartSlider.dragIndex = jQuery('.ui-sortable-placeholder').index() - 1;
			},
			change: function() {
				jQuery('.ui-sortable-helper').addClass('moving');
			},
			stop : function(event, ui) {

				// Get old index
				var oldIndex = SmartSlider.dragIndex;

				// Get new index
				var index = jQuery('.moving').index();

				if( index > -1 ){

					// Rearraange layer pages

					if(index == 0) {
						jQuery('#ls-layers .ls-layer-box').eq(oldIndex).prependTo('#ls-layers');
					}else{
						var layerObj = jQuery('#ls-layers .ls-layer-box').eq(oldIndex);
						jQuery('#ls-layers .ls-layer-box').eq(oldIndex).remove();

						layerObj.insertAfter('#ls-layers .ls-layer-box:eq('+(index-1)+')');
					}
				}

				jQuery('.moving').removeClass('moving');

				// Reindex layers
				SmartSlider.reindexLayers();
            },
            containment : 'parent',
			tolerance : 'pointer',
			items : 'a:not(.unsortable)'
        });
	},

	addDraggable : function() {
		jQuery('.draggable').children().draggable({
        	drag : function() {

        		SmartSlider.dragging();
        	},
        	stop : function() {

        		SmartSlider.dragging();
        	}
        });
	},

	dragging : function() {

		// Get positions
		var top = jQuery('.ui-draggable-dragging').position().top;
		var left = jQuery('.ui-draggable-dragging').position().left;

		// Get index
		var wrapper = jQuery('.ui-draggable-dragging').closest('.ls-layer-box');
		var index = jQuery('.ui-draggable-dragging').index();

		// Set positions
		wrapper.find('input[name="top"]').eq(index).val(top + 'px');
		wrapper.find('input[name="left"]').eq(index).val(left + 'px');
	},

	selectDragElement : function(el) {

		jQuery(el).closest('.ls-layer-box').find('.ls-sublayers > tr').eq( jQuery(el).index() ).click();
		jQuery(el).closest('.ls-layer-box').find('.ls-sublayers > tr').eq( jQuery(el).index() ).find('.ls-sublayer-nav a:eq(1)').click();
	},

	reindexSublayers : function(el) {

		jQuery(el).find('.ls-sublayers > tr').each(function(index) {

			// Reindex sublayer number
			jQuery(this).find('.ls-sublayer-number').html( index + 1 );

			// Reindex sublayer title if it is untoched
			if(
				jQuery(this).find('.ls-sublayer-title').val().indexOf('Sublayer') != -1 &&
				jQuery(this).find('.ls-sublayer-title').val().indexOf('copy') == -1
			) {
				jQuery(this).find('.ls-sublayer-title').val('Sublayer #' + (index + 1) );
			}
		});
	},

	reindexLayers : function() {
		jQuery('#ls-layer-tabs a:not(.unsortable)').each(function(index) {
			jQuery(this).html('Layer #' + (index + 1) + ' <span class="icon-remove-sign"></span>');
		});
	},

	play : function( index ) {

		// Get smartslider contaier
		var smartslider = jQuery('#ls-layers .ls-layer-box').eq(index).find('.ls-real-time-preview');

		// Stop
		if(smartslider.children().length > 0) {
			jQuery('#ls-layers .ls-layer-box').eq(index).find('.ls-preview').show();
			smartslider.find('.ls-container').smartSlider('stop');
			smartslider.html('').hide();
			jQuery('#ls-layers .ls-layer-box').eq(index).find('.ls-preview-button').html('<i class="icon-play"></i> Enter Preview').removeClass('playing');
			return;
		}

		// Show the SmartSlider
		smartslider.show();
		smartslider = jQuery('<div class="smartslider">').appendTo(smartslider);

		// Hide the preview
		jQuery('#ls-layers .ls-layer-box').eq(index).find('.ls-preview').hide();

		// Change button status
		jQuery('#ls-layers .ls-layer-box').eq(index).find('.ls-preview-button').html('<i class="icon-stop"></i> Exit Preview').addClass('playing');

		// Get global settings
		var width = jQuery('.ls-settings input[name="width"]').val();
		var height = jQuery('.ls-settings input[name="height"]').val();
		var backgroundColor = jQuery('.ls-settings input[name="backgroundcolor"]').val();
		var backgroundImage = jQuery('.ls-settings input[name="backgroundimage"]').val();

		// Apply global settings
		smartslider.css({ width: width, height : height });


		if(backgroundColor != '') {
			smartslider.css({ backgroundColor : backgroundColor });
		}

		if(backgroundImage != '') {
			 smartslider.css({ backgroundImage : 'url('+backgroundImage+')' });
		}

		// Iterate over the layers
		jQuery('#ls-layers .ls-layer-box').each(function() {

			// Gather layer data
			var background = jQuery(this).find('input[name="background"]').val();
			var direction = jQuery(this).find('select[name="slidedirection"]:first option:selected').val();
			var delay = jQuery(this).find('input[name="slidedelay"]').val();

			var durationIn = jQuery(this).find('input[name="durationin"]').val();
			var easingIn = jQuery(this).find('select[name="easingin"] option:selected').val();
			var delayIn = jQuery(this).find('input[name="delayin"]').val();

			var durationOut = jQuery(this).find('input[name="durationout"]').val();
			var easingOut = jQuery(this).find('select[name="easingout"] option:selected').val();
			var delayOut = jQuery(this).find('input[name="delayout"]').val();

			// Build the layer
			var layer = jQuery('<div class="ls-layer">').appendTo(smartslider);
				layer.attr('rel', 'slidedirection:'+direction+';');
				layer.attr('rel', layer.attr('rel') + 'slidedelay:'+delay+';');
				layer.attr('rel', layer.attr('rel') + 'durationin:'+durationIn+';');
				layer.attr('rel', layer.attr('rel') + 'durationout:'+durationOut+';');
				layer.attr('rel', layer.attr('rel') + 'easingin:'+easingIn+';');
				layer.attr('rel', layer.attr('rel') + 'easingout:'+easingOut+';');
				layer.attr('rel', layer.attr('rel') + 'delayin:'+delayIn+';');
				layer.attr('rel', layer.attr('rel') + 'delayout:'+delayOut+';');

			// Background
			if(background != '') {
				jQuery('<img src="'+background+'" class="ls-bg">').appendTo(layer);
			}

			// Iterate over the sublayers
			jQuery(this).find('.ls-sublayers > tr').each(function(index) {

				// Gather sublayer data
				var type = jQuery(this).find('select[name="type"] option:selected').val();
				
				var image = jQuery(this).find('input[name="image"]').val();
				var html = jQuery(this).find('textarea[name="html"]').val();
				var style = jQuery(this).find('textarea[name="style"]').val();

				// smart add width, height and transparent
				var width = jQuery(this).find('input[name="width"]').val();
				var height = jQuery(this).find('input[name="height"]').val();
				var transparent = jQuery(this).find('input[name="transparent"]').val();
				
				var level = jQuery(this).find('input[name="level"]').val();
				var skip = jQuery(this).find('input[name="skip"]').prop('checked');
				var url = jQuery(this).find('input[name="url"]').val();

				
				var sub_css ={
					slidedirection : jQuery(this).find('select[name="slidedirection"] option:selected').val(),
					
					slideoutdirection : jQuery(this).find('select[name="slideoutdirection"] option:selected').val(),
					
					top : jQuery(this).find('input[name="top"]').val(),
					
					bottom : jQuery(this).find('input[name="bottom"]').val(),
					
					width : jQuery(this).find('input[name="width"]').val(),
					
					height: jQuery(this).find('input[name="height"]').val(),
					
					transparent: jQuery(this).find('input[name="transparent"]').val(),
					
					left : jQuery(this).find('input[name="left"]').val(),
					
					right : jQuery(this).find('input[name="right"]').val(),
					
					durationin : jQuery(this).find('input[name="durationin"]').val(),
					
					durationout : jQuery(this).find('input[name="durationout"]').val(),
					
					easingin : jQuery(this).find('select[name="easingin"] option:selected').val(),
					
					easingout : jQuery(this).find('select[name="easingout"] option:selected').val(),
					
					delayin : jQuery(this).find('input[name="delayin"]').val(),
					
					delayout : jQuery(this).find('input[name="delayout"]').val(),
					
					showuntil : jQuery(this).find('input[name="showuntil"]').val()
				}

				var wordWrap = jQuery(this).find('input[name="wordwrap"]').prop('checked');

				// Skip sublayer?
				if(skip) {
					return true;
				}

				// Build the sublayer
				if(type == 'img') {
					if(image != '') {
						var sublayer = jQuery('<img src="'+image+'">').appendTo(layer).addClass('ls-s'+level);
						
						//alert(sublayer.attr('src') + '==' + JSON.stringify(sub_css));
						SmartSlider.setSublayerSize(sub_css, sublayer);
						//alert(JSON.stringify(sub_css));
						var sublayerCSS = SmartSlider.getSublayerCSS(sub_css);
						sublayerCSS = 'position: absolute; ' + sublayerCSS + style;
						//alert(sublayerCSS)
						sublayer.attr('style', sublayerCSS);
						
					} else {
						return true;
					}
				// smart add produkt layer start	
				} else if(type == 'product'){
					var sublayer = SmartSlider.makeProductItemForSlider(this, layer, width, height, transparent, level);
					sublayer.addClass('ls-s'+level);
					
					SmartSlider.setSublayerSize(sub_css, sublayer.find('img'));
					if(sub_css.height)sublayer.find('img').height(parseInt(sub_css.height)*0.8);
					var sublayerCSS = SmartSlider.getSublayerCSS(sub_css);
					sublayerCSS = 'position: absolute; ' + sublayerCSS + style;
					//alert(sublayerCSS)
					sublayer.attr('style', sublayerCSS);
					
				// smart add produkt layer end	
				}else {
					var sublayer = jQuery('<'+type+'>').appendTo(layer).html(html).addClass('ls-s'+level);
					SmartSlider.setOtherSublayerPos(sub_css);
					var sublayerCSS = SmartSlider.getSublayerCSS(sub_css);
					sublayerCSS = 'position: absolute; ' + sublayerCSS + style;
					sublayer.attr('style', sublayerCSS);
				}

				// WordWrap
				if(wordWrap == true) {
					sublayer.css('white-space', 'nowrap');
				}

			});
		});

		// LayerSlider init params
		var skinPath = slider.path.layerSkin;

		// Init smartslider
		var paralax = SmartSlider.getParalax();
		jQuery(smartslider).smartSlider({
			parallaxIn : paralax,
			parallaxOut : paralax,
			width : width,
			height : height,
			skin : 'preview',
			skinsPath : skinPath,
			animateFirstLayer : true,
			firstLayer : (index + 1),
			autoStart : true,
			pauseOnHover : false
		});
			
	},

	stop : function() {

		// Get smartslider contaier
		var layersliders = jQuery('#ls-layers .ls-layer-box .ls-real-time-preview');

		// Stop the preview if any
		if(layersliders.children().length > 0) {

			// Show the editor
			jQuery('#ls-layers .ls-layer-box .ls-preview').show();

			// Stop LayerSlider
			layersliders.find('.ls-container').smartSlider('stop');

			// Empty and hide the Preview
			layersliders.html('').hide();

			// Rewrote the Preview button text
			jQuery('#ls-layers .ls-layer-box .ls-preview-button').html('<i class="icon-play"></i> Enter Preview').removeClass('playing');
		}
	},

	// smart
	getParalax : function(){
		var width = $(".smartslider").width();
		if(320 > width) return 2;
		if(320 < width && width < 480) return 1.5;
		if(480 < width && width < 800) return 0.9;
		if(800 < width && width < 1000) return 0.7;
		if(width > 1000) return 0.5;
	},
	
	checkUnit : function(data){
		if(data.indexOf('px') < 0 && data.indexOf('%') < 0) {
			return data + 'px';
		} else {
			return data;
		}
	},
	
	assocArrToStr : function (arrIn, separator, key_or_val){
		var arrOut = [];
		//alert (JSON.stringify(arrIn));
		$.each(arrIn, function(key, value) { 
			eval('arrOut.push(' + key_or_val + ')');
		});
		return arrOut.join(separator);
	},
	
	getSublayerCSS : function (sub_css){
		
		var css = {};
		
		css['slidedirection'] = (sub_css.slidedirection && sub_css.slidedirection != 'auto') ? 'slidedirection : ' + sub_css.slidedirection + '; ' : '';
		
		css['slideoutdirection'] = (sub_css.slideoutdirection && sub_css.slideoutdirection != 'auto') ? 'slideoutdirection : ' + sub_css.slideoutdirection + '; ' : '';

		css['sublayerTop'] = sub_css.top ? ' top: ' + SmartSlider.checkUnit(sub_css.top) + '; ' : '';
		
		css['sublayerWidth'] = sub_css.width ? ' width: ' + SmartSlider.checkUnit(sub_css.width) + '; ' : '';
		
		css['sublayerHeight'] = sub_css.height ? ' height: ' + SmartSlider.checkUnit(sub_css.height) + '; ' : '';
		
		css['sublayerOpacity'] = sub_css.transparent ? ' opacity: ' + sub_css.transparent/100 + '; ' : '';
		
		css['sublayerLeft'] = sub_css.left ? ' left: ' + SmartSlider.checkUnit(sub_css.left) + '; ' : '';
		
		css['durationin'] = sub_css.durationin ? ' durationin: ' + sub_css.durationin + '; ' : '';
		
		css['durationout'] = sub_css.durationout ? ' durationout: ' + sub_css.durationout + '; ' : '';
		
		css['easingin'] = sub_css.easingin ? ' easingin: ' + sub_css.easingin + '; ' : '';
		
		css['easingout'] = sub_css.easingout ? ' easingout: ' + sub_css.easingout + '; ' : '';
		
		css['delayin'] = sub_css.delayin ? ' delayin: ' + sub_css.delayin + '; ' : '';
		
		css['delayout'] = sub_css.delayout ? ' delayout: ' + sub_css.delayout + '; ' : '';
		
		css['showuntil'] = sub_css.showuntil ? ' showuntil: ' + sub_css.showuntil + '; ' : 'showuntil: 0; ';
		
		return SmartSlider.assocArrToStr(css, '', 'value');
	},
	
	setOtherSublayerPos : function(sub_css){
		var layer_s= {
			width : $('.smartslider').width(),
			height: $('.smartslider').height()
			};
	// set position	left if isset right		
		if(sub_css.right !='' && sub_css.right.indexOf('%') < 0){
			if(sub_css.width !='' && sub_css.width.indexOf('%') > 0){
				sub_css.width  = (layer_s.width * parseInt(sub_css.width)/100) + 'px';
			}
			//alert(sub_css.width);
			sub_css.left = (layer_s.width - parseInt(sub_css.right) - parseInt(sub_css.width)) + 'px';

		}else if(sub_css.right !='' && sub_css.right.indexOf('%') > 0){
			sub_css.left = (100 - parseInt(sub_css.right)) + '%';
		}
	// set position	top if isset bottom		
		if(sub_css.bottom !='' && sub_css.bottom.indexOf('%') < 0){
			if(sub_css.height !='' && sub_css.height.indexOf('%') > 0){
				sub_css.height  = (layer_s.height * parseInt(sub_css.height)/100) + 'px';
			}
			sub_css.top = (layer_s.height - parseInt(sub_css.bottom) - parseInt(sub_css.height)) + 'px';
		}else if(sub_css.bottom !='' && sub_css.bottom.indexOf('%') > 0){
			sub_css.top = (100 - parseInt(sub_css.bottom)) + '%';
		}
	},
	
	setSublayerSize : function(sub_css, $img){
		var layer_s= {
				width : $('.smartslider').width(),
				height: $('.smartslider').height()
				};
		
		var img_s = {
				width : $img.actual('width'),
				height: $img.actual('height')
				};
		//alert(layer_s.width);
	// set actual size sub_css 
		if(sub_css.width !='' && sub_css.width.indexOf('%') > 0  && sub_css.height !='' && sub_css.height.indexOf('%') > 0){
			sub_css.width  = (layer_s.width * parseInt(sub_css.width)/100) + 'px';
			sub_css.height = (layer_s.height * parseInt(sub_css.height)/100) + 'px';
			
		}else{
			if(sub_css.width !=''){
				if(sub_css.width.indexOf('%') > 0){
					sub_css.width  = (layer_s.width * parseInt(sub_css.width)/100) + 'px';
				}
				sub_css.height = parseInt((parseInt(sub_css.width) * img_s.height) / img_s.width) + 'px';
			}
			if(sub_css.height !=''){
				if(sub_css.height.indexOf('%') > 0){
					sub_css.height = (layer_s.height * parseInt(sub_css.height)/100) + 'px';
				}
				sub_css.width  = parseInt((parseInt(sub_css.height) * img_s.width) / img_s.height) + 'px';
			}
		}
		
	// set position	left if isset right		
		if(sub_css.right !='' && sub_css.right.indexOf('%') < 0){
			sub_css.left = (layer_s.width - parseInt(sub_css.right) - parseInt(sub_css.width)) + 'px';

		}else if(sub_css.right !='' && sub_css.right.indexOf('%') > 0){
			sub_css.left = (100 - parseInt(sub_css.right)) + '%';
		}
	// set position	top if isset bottom		
		if(sub_css.bottom !='' && sub_css.bottom.indexOf('%') < 0){
			sub_css.top = (layer_s.height - parseInt(sub_css.bottom) - parseInt(sub_css.height)) + 'px';
		}else if(sub_css.bottom !='' && sub_css.bottom.indexOf('%') > 0){
			sub_css.top = (100 - parseInt(sub_css.bottom)) + '%';
		}	
	},
	
	makeProductItemForSlider : function(self, draggable,width, height, transparent, level){

		// smart Get product img URL
		var prod_url = jQuery(self).find('img.prod_img_url').attr('data-image');

		if(prod_url != undefined & prod_url != '') {
			if(jQuery(self).find('span.prod_new_price').text() != undefined & jQuery(self).find('span.prod_new_price').text() !=''){
				var new_price = jQuery(self).find('span.prod_new_price').text();
				var old_price = jQuery(self).find('span.prod_old_price').text();
				
			}else{
				var new_price = '';
				var old_price = jQuery(self).find('td.prod_price').text();
			}

			var prod_data = {
				href : jQuery(self).find('.ls-sublayer-link').find('input[name=url]').val(),
				img_src: prod_url,
				name: jQuery(self).find('td.prod_name').html(),
				new_price: new_price,
				old_price: old_price
			};

			var prod_html = "<div class='slider_prod'>";
			
			// LABEL RENDER START
			//alert(jQuery(self).find('input[name=label_type]').val());
			var label_type = jQuery(self).find('input[name=label_type]').val();
			
			if(label_type){
				var label_image = SmartSlider.dropDownImage.getActiveImage(jQuery(self));
			}
			
			if(label_image){
				
				var pos_hor = label_image.pos.l_hor + ' : ' + SmartSlider.checkUnit(label_image.pos.l_hor_val) + ';';
				var pos_ver = label_image.pos.l_ver + ' : ' + SmartSlider.checkUnit(label_image.pos.l_ver_val) + ';';
				
				margin =[];
				if(pos_hor.indexOf('%') != -1){
					if(label_image.pos.l_hor == 'left'){
						margin.push('margin-right: ' + label_image.size.width/2 + 'px; ');
					}else{
						margin.push('margin-right: -' + label_image.size.width/2 + 'px; ');
					}
				}
				if(pos_ver.indexOf('%') != -1){
					if(label_image.pos.l_ver == 'bottom'){
						margin.push('margin-top: ' + label_image.size.height/2 + 'px; ');
					}else{
						margin.push('margin-top: -' + label_image.size.height/2 + 'px; ');
					}
				}
				if(label_image.activ_type =='discount'){
					prod_html +="<div style='position: absolute; background:url(" + label_image.src + ")no-repeat; width:" + label_image.size.width + "px; height:" + label_image.size.height + "px; " + pos_hor + pos_ver + margin.join(' ') + "' class='product_label_on_slider'><div class='discount_val' style='color:#" + label_image.color + ";' >" + label_image.discount_val + "</div></div>";
				}else{
					prod_html +="<div style='position: absolute; background:url(" + label_image.src + ")no-repeat; width:" + label_image.size.width + "px; height:" + label_image.size.height + "px; " + pos_hor + pos_ver + margin.join(' ') + "' class='product_label_on_slider'></div>";
				}
				//alert(prod_html);
			}
			// LABEL RENDER END
			
			prod_html += "<div><img  src='"+prod_data.img_src+"' alt='"+prod_data.name+"'></div><div class='name'>"+prod_data.name+"</div><div class='price'>";

			if(prod_data.new_price != ''){
				prod_html += "<span class='price-old'>"+prod_data.old_price+"</span><span class='price-new'>"+prod_data.new_price+"</span></div></div>";
				}else{prod_html += prod_data.old_price+"</div></div>";}

				var item = jQuery(prod_html).appendTo(draggable);
				var img = item.find('img');
				// size and transparent of element
				if(height!= '') {img.css({ 'height' : '80%' });}
				if(transparent != "") {img.css({ 'opacity' : parseInt(transparent)/100 });}
			
		} else {var item =jQuery('<div>').appendTo(draggable);}
		
		if(level)item.addClass('ls-s'+level);
		
		return item;
	},
	addProduct : function(data){
		var $productUploader = $('.product_activ');

		$input = $productUploader.find('input[name=product]');
		$input.val(data.id);
		$productUploader.parent().parent().find('.ls-sublayer-link').find('input[name=url]').val(data.href);
		
		$productUploader.find('table').remove();
		$productUploader.append("<table class='list'><tr>"+data.html+"</tr></table>");
		$productUploader.find('table').find('td').eq(0).remove();
		$productUploader.find('table').find('td').eq(0).find('img').addClass('prod_img_url');
		$productUploader.find('table').find('td').eq(3).addClass('prod_price');
		$productUploader.removeClass('product_activ');
		
		jQuery('#ls-layers .ls-layer-box').each(function( index ) {
			SmartSlider.generatePreview(index);
		});
	},
	removeProduct : function($self){
		var $productUploader = $self.parent().parent();
		$productUploader.find('input[name=product]').val('');
		$productUploader.find('table.list').remove();
	},
	getURLData : function(){  // public
		SmartSlider.rewriteName('temp');

		// Data to send 1
			$data = jQuery('.ls-settings').find('input, textarea, select');
			$data = $data.add( jQuery('.ls-settings').find('input, textarea, select') );
		// Data to send 2
			$data = $data.add( jQuery('.ls-callback-page textarea') );
			
		// Iterate over the layers
			jQuery('#ls-layers .ls-layer-box').each(function(layer) {

			// Reindex layerkey
				jQuery(this).find('input[name="layerkey[]"]').val(layer);

			// Data to send 3
				$data = $data.add(jQuery('#ls-layers .ls-layer-box').eq(layer).find('input, textarea, select'));
			});	
			
		var data = $data.serialize();
		
		SmartSlider.rewriteName('original');

		return 	data;
	},
	
	getImgSize : function (src) {
		var img = $('<img src="'+src+'">').css({
			position: 'absolute',
			top: '-9999px',
			visibility: 'hidden'
			}).appendTo('body');
		var size = {
			width:	img.width(),
			height: img.height()
		}	
		img.remove();
		return size;
	},
	
	rewriteName :function(write){
		if(write == 'temp'){
			
			// ============================
			// add slider size if height_auto==checked  start  (height_auto)
			$('input[name=slider_size]').remove();
			if($('input[name=height_auto]').prop("checked")){
				
				$('input[name=background]').each(function(){
					if($(this).val() != ''){
						var size = SmartSlider.getImgSize($(this).val());
						size = size.width+ '-l-'+size.height;
						$('input[name=height_auto]').after('<input type="hidden" name="slider_size" value="'+size+'" >');
						return false;
					}
				});
			}
			
			// add product size start
			jQuery('img.prod_img_url').each(function() {
				var $product_labels =  $(this).parents('div.ls-product-uploader');
				
				var prod_url = $(this).attr('data-image');

				if(prod_url && prod_url != ''){//alert(prod_url);
					//alert($(this).val());
					var size = SmartSlider.getImgSize(prod_url);
					size = size.width+ '-l-'+size.height;
					$product_labels.find('input[name=image_size]').remove();
					$('<input type="hidden" name="image_size" value="'+size+'" >').prependTo($product_labels);
					//alert($product_labels.html());
				}
			});
			// add image size start
			jQuery('input.ls-upload').each(function() {
				if($(this).val() != ''){
					//alert($(this).val());
					var size = SmartSlider.getImgSize($(this).val());
					size = size.width+ '-l-'+size.height;
					$(this).parent().find('input[name=image_size]').remove();
					$(this).after('<input type="hidden" name="image_size" value="'+size+'" >');
				}
			});
			// add label size start
			jQuery('span.label_name').each(function() {
				if($(this).hasClass('active')){
					var $product_labels =  $(this).parents('div.product_labels');
					var $product_label =  $(this).parents('div.product_label');
					var $select = $product_label.find('select.d_d');
					var sel_val = $product_labels.find('input[name=label_file]').val();
					
					var src = '';
					$select.find('option').each(function() {
						if($(this).attr('value') == sel_val) src = $(this).attr('data-image');
					});
					if(src != ''){ 
						var size = SmartSlider.getImgSize(src);
						size = size.width+ '-l-'+size.height;
						
						$product_labels.find('input[name=label_size]').remove();
						$('<input type="hidden" name="label_size" value="'+size+'" >').prependTo($product_labels);
					}
				}
			});
			//==================
			
		
		jQuery('input.ls-upload').each(function() {
			if(jQuery(this).attr('data-relat_url') && jQuery(this).attr('data-relat_url') != ''){
				var relat_url = jQuery(this).attr('data-relat_url');
				jQuery(this).attr('data-absol_url', jQuery(this).val() );
				jQuery(this).val(relat_url);
			}
		});

	// Iterate over the settings
		jQuery('.ls-settings input, .ls-settings select').each(function() {

			// Save original name attr to element's data
			jQuery(this).data('name', jQuery(this).attr('name') );

			// Rewrite the name attr
			jQuery(this).attr('name', 'smartslider-slides[properties]['+jQuery(this).attr('name')+']');
		});

	// Iterate over the layers
		jQuery('#ls-layers .ls-layer-box').each(function(layer) {

			// Iterate over layer settings
			jQuery(this).find('.ls-slide-options input, .ls-slide-options select').each(function() {

				// Save original name attr to element's data
				jQuery(this).data('name', jQuery(this).attr('name') );

				// Rewrite the name attr
				jQuery(this).attr('name', 'smartslider-slides[layers]['+layer+'][properties]['+jQuery(this).attr('name')+']');

			});

	// Iterate over the sublayers
			jQuery(this).find('.ls-sublayers > tr').each(function(sublayer) {

				// Iterate over the sublayer properties
				jQuery(this).find('input, select, textarea').not('.product_label .dd input, .product_label select').each(function() {

					// Save original name attr to element's data
					jQuery(this).data('name', jQuery(this).attr('name') );

					// Rewrite the name attr
					jQuery(this).attr('name', 'smartslider-slides[layers]['+layer+'][sublayers]['+sublayer+']['+jQuery(this).attr('name')+']');
				});
			});
		});

	// Iterate over the callback functions
		jQuery('.ls-callback-page textarea').each(function() {

			// Save original name attr to element's data
			jQuery(this).data('name', jQuery(this).attr('name') );

			// Rewrite the name attr
			jQuery(this).attr('name', 'smartslider-slides[properties]['+jQuery(this).attr('name')+']');
			});
		}else if(write == 'original'){
			jQuery('input.ls-upload').each(function() {
				if(jQuery(this).attr('data-absol_url') && jQuery(this).attr('data-absol_url') != ''){
					var absol_url = jQuery(this).attr('data-absol_url');
					jQuery(this).val(absol_url);
				}
			});		
		
		// Global settings
			jQuery('.ls-settings input, .ls-settings select').each(function() {
				jQuery(this).attr('name', jQuery(this).data('name'));
			});

		// Layers
			jQuery('#ls-layers .ls-layer-box').each(function(layer) {

		// Layer settings
				jQuery(this).find('.ls-slide-options input, .ls-slide-options select').each(function() {
					jQuery(this).attr('name', jQuery(this).data('name'));
				});

		// Sublayers
				jQuery(this).find('.ls-sublayers > tr').each(function(sublayer) {
					jQuery(this).find('input, select, textarea').not('.product_label .dd input, .product_label select').each(function() {
						jQuery(this).attr('name', jQuery(this).data('name'));
					});
				});
			});

		// Iterate over the callback functions
			jQuery('.ls-callback-page textarea').each(function() {
				jQuery(this).attr('name', jQuery(this).data('name'));
			});
		}
	},
	
	save : function() { //deprecate (не використовуэться)
		if(!jQuery('#ls-layers .ls-layer-box').html()) {
			$( "#not_save" ).dialog('open').html(slider.text.alert_not_save);
			return;
		}
	
		SmartSlider.rewriteName('temp');
		$( "#save_wait" ).dialog( "open" );
		// Reset layer counter
		SmartSlider.counter = 0;

	// send Layer Properies start
		$data = jQuery('#ls-slider-form > input').not('select.d_d');
		$data = $data.add( jQuery('.ls-settings').find('input, textarea, select').not('select.d_d') );
		$data = $data.add( jQuery('.ls-callback-page textarea').not('select.d_d') );
		
		jQuery.ajax(slider.url.save, {
			type : 'POST',
			data : $data.serialize(),
			async : false,
			success : function(id) {

			}
		});
	// send Layer Properies end

		setTimeout(function() {

			// Iterate over the layers
			jQuery('#ls-layers .ls-layer-box').each(function(layer) {

				// Reindex layerkey
				jQuery(this).find('input[name="layerkey"]').val(layer);

				// Data to send
				$data = jQuery('#ls-layers .ls-layer-box').eq(layer).find('input, textarea, select');
				$data.not('.product_label input, .product_label select');

				// Post layer
				jQuery.ajax(slider.url.save, {
					type : 'POST',
					data : $data.serialize(),
					async : false,
					success : function(id) {

						SmartSlider.counter += 1;

						if(jQuery('#ls-layers .ls-layer-box').length == SmartSlider.counter) {

							SmartSlider.rewriteName('original');
							$( "#save_wait" ).dialog( "close" );
							$( "#save_dialog" ).dialog('open');

							// Redirect the edit page when adding new slider
							if(document.location.href.indexOf('layerslider_add_new') != -1) {
								alert('Redirect-???');
								// Redirect
								document.location.href = 'admin.php?page=smartslider&action=edit&id='+id+'';
							}
						}
					}
				});
			});
		}, 500);	
			
	},

	cloneFix : function() {

		jQuery('textarea').each(function() {
			jQuery(this).text( jQuery(this).val() );
		});

		// Select clone fix
		jQuery('select').each(function() {

			// Get selected index
			var index = jQuery(this).find('option:selected').index();
			
			// Deselect old options
			jQuery(this).find('option').attr('selected', false);

			// Select the new one
			jQuery(this).find('option').eq( index ).attr('selected', true);
		});
	},

	// msDropDown for image
	dropDownImage : {
		init : function(){
			$('.d_d').live('change', function(){
				SmartSlider.dropDownImage.refreshSelects($(this));
				SmartSlider.dropDownImage.handRefresh($(this));
			});
			SmartSlider.dropDownImage.create(jQuery('.d_d'));
		},
		
		getActiveImage : function($sublayer){
			var activ_type  = $sublayer.find('.label_name.active').parents('.product_label').attr('data-type');
			var $activ_label = $sublayer.find('.label_name.active').parents('.product_label');
			var $image = $activ_label.find('span.ddTitleText ').find('img');

			var pos ={
				l_hor : $sublayer.find('select[name=label_pos_hor]').val(),
				l_ver : $sublayer.find('select[name=label_pos_ver]').val(),
				l_hor_val : $sublayer.find('input[name=label_pos_hor_val]').val(),
				l_ver_val : $sublayer.find('input[name=label_pos_ver_val]').val()
			}
		
			var size = {
				width : $image.labelActual('width'),
				height: $image.labelActual('height')
				};
				
			var color = $sublayer.find('input[name=label_color]').val()

			var discount_val = '';
			if(activ_type !=''){
				discount_val = $sublayer.find('input[name=discount_val]').val();
			}	
				
			return {src : $image.attr('src'), size : size, pos: pos, color: color, activ_type : activ_type, discount_val: discount_val };
		},
		
		refreshData : function($labels, data){
			$labels.find('input[name=label_color]').val(data.color);
			$labels.find('input[name=label_type]').val(data.type);
			$labels.find('input[name=label_file]').val(data.file);
		},
		
		clearData : function($labels){
			$labels.find('input[name=label_color]').val('');
			$labels.find('input[name=label_type]').val('');
			$labels.find('input[name=label_file]').val('');
		},
		
		create : function($selects){
			$selects.live('change', function(){
				SmartSlider.dropDownImage.refreshSelects($(this));
				SmartSlider.dropDownImage.handRefresh($(this));
			});
			$selects.each(function(){
				$(this).data('api', $(this).msDropDown().data("dd"));

				var selected_index =  $(this).data('api').get("selectedIndex");
				if(selected_index == -1 )selected_index = 0;
				$(this).find('option').eq(selected_index).attr('selected', 'selected');
			})
		},
		refreshSelects : function($select){ 
			if(!$select.val()){
				SmartSlider.dropDownImage.clearData($select.parents('.product_labels'));
				return;
			}
			$select.parents('.product_labels').find('.d_d').not($select).each(function(){
				$(this).data('api').set("selectedIndex", 0);
			});
			$select.parents('.product_labels').find('span.label_name').removeClass('active');
			$select.parents('.product_label').find('span.label_name').addClass('active');
			
	
			
			// refresh data start
			var data = {
				color : $select.parents('.product_label').find('.color_box').find('a.color_box_activ').attr('data-color'),
				type : $select.parents('.product_label').attr('data-type'),
				file : $select.val()
			}
			SmartSlider.dropDownImage.refreshData($select.parents('.product_labels'), data);
		},
		
		reCreate : function($select){
			$select.data('api').destroy();
			$select.data('api', $select.msDropDown().data("dd"));
			SmartSlider.dropDownImage.handRefresh($select);
		},
		
		colorChange : function($self){
			if(!$self.parents('.product_label').find('.label_name').hasClass('active'))return;
			// change color in color box start
			$_color_box = $self.parent().parent();
			$_color_box.find('a').removeClass('color_box_activ');
			$self.addClass('color_box_activ');
			
			var color = $self.attr('data-color');

			var $select = $self.parents('.product_label').find('.d_d');

			var path = $select.attr('data-path');
				
			$select.find('option').not(':first').each(function(){
				var file = $(this).attr('value');
				var new_img = path + color + '/' + file;
				$(this).attr('data-image', new_img);
			});

			var selected_index =  $select.data('api').get("selectedIndex");
			$select.find('option').eq(selected_index).attr('selected', 'selected');

			// refresh data start
			var data = {
				color : color,
				type : $select.parents('.product_label').attr('data-type'),
				file : $select.val()
			}
			SmartSlider.dropDownImage.refreshData($select.parents('.product_labels'), data);
			// refresh data end
			
			$select.data('api').destroy();
			$select.data('api', $select.msDropDown().data("dd"));
			SmartSlider.dropDownImage.handRefresh($select);
		},
	// виправлення бага ms_dd: при динамічній зміні атрибутів опцій змінюємо відображення в лі елементах
		handRefresh : function($select){ 
			// виправлення бага ms_dd: при динамічній зміні атрибутів опцій змінюємо відображення в лі елементах
			
			var ddTitleText = $select.parent().next().find('.ddTitleText');
			var ddChild_li	= $select.parent().next().find('.ddChild li');

			var selected = $select.find('option:selected').attr('data-image');
			ddTitleText.find('img').attr('src', selected);
			
			ddChild_li.each(function(ii){
				$(this).find('img').attr('src', $select.find('option').eq(ii).attr('data-image'));
			});	
		}
	},

	tipsy : function() {
		//==================== HELP SYSTEM TIPS
		$( ".vtip" ).tipsy({gravity: 's', delayIn: 500, delayOut: 500, opacity: 0.9, html: true});
		$( ".vtip_l" ).tipsy({gravity: 'sw', delayIn: 500, delayOut: 500, opacity: 0.9, html: true});
		$( ".vtip_r" ).tipsy({gravity: 'se', delayIn: 500, delayOut: 500, opacity: 0.9, html: true});
		$( ".vtip_b" ).tipsy({gravity: 'n', delayIn: 500, delayOut: 500, opacity: 0.9, html: true, offset: 20,});
	} 
};

jQuery(document).ready(function() {
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
	// setting save dialog (1.2)
	$( "#save_dialog" ).dialog('option', {
		buttons: {
			"Continue editing": function() {
			$(this).dialog( "close" );
			},
			"Cancel": function() {
			window.location = slider.url.cancel;
			}
		}
	});
	// setting save dialog (1.2)
	$( "#not_save" ).dialog('option', {
		buttons: {
			"Continue editing": function() {
			$(this).dialog( "close" );
			}
		}
	});
	$( "#save_wait" ).dialog('option', 'dialogClass', 'save_wait');
	
	$( "#save_wait" ).dialog( "open" );
	
	// bug with auto select start
	jQuery(document).ready(function() {
		$('select[name=label_pos_hor], select[name=label_pos_ver]').each(function(){
			var $opt = $(this).find('option');
			$opt.each(function(){
				if($(this).attr('data-value') == $(this).attr('value'))		$(this).attr('selected','selected');
				if($(this).attr('data-value') == 'default')		$(this).attr('selected','selected');
			});
		});
	})
	// bug with auto select end
	
	$('#tabs a').tabs();
	
	// click on  last activ tab	
	$('#tabs a').click(function(){
		$.cookie('tabs_activ', $(this).index());
	});
	if($.cookie('tabs_activ'))$('#tabs a').eq($.cookie('tabs_activ')).click();

	//==================== DROP DOWN IMAGE
	SmartSlider.dropDownImage.init();
	// бере з палітри кольорів назву кольора та міняє картинки в селекті;
	$('.color_box a').live('click', function(){
		$self = $(this);
		SmartSlider.dropDownImage.colorChange($self);
	});

	jQuery('.box input:checkbox').not('.ls-layer-box input:checkbox').customCheckbox();

	// save data to server
	jQuery('.save').click(function(e) {
		SmartSlider.save();
	});

	//========================================
	// Generate preview
	jQuery(window).load(function() {
		SmartSlider.generatePreview( jQuery('.ls-box.active').index() );
	});
	
	// Main tab bar page select
	jQuery('#ls-main-nav-bar a:not(.unselectable)').click(function(e) {
		e.preventDefault();
		SmartSlider.selectMainTab( this );
	});

	// Generate preview if user resizes the browser
	jQuery(window).resize(function(){
		SmartSlider.willGeneratePreview( jQuery('.ls-box.active').index() );
	});
	// Generate preview if user change parameter
	jQuery('.ls-page input, .ls-page select, .ls-page textarea').on('change', function() {
		SmartSlider.willGeneratePreview( jQuery('.ls-box.active').index() );
	});

	// Support menu
	/*
	jQuery('#ls-main-nav-bar a.support').click(function(e) {
		e.preventDefault();
		jQuery('#contextual-help-link').click();
	});*/

	// Uploads
	SmartSlider.openMediaLibrary();

	// Settings: reset button
	jQuery('.ls-reset').live('click', function() {
		// Empty field
		jQuery(this).parent().find('input').val('').attr('data-relat_url', '');
		// Generate preview
		SmartSlider.generatePreview( jQuery('.ls-box.active').index() );
	});


	// Add layer
	jQuery('#ls-add-layer').click(function(e) {
		e.preventDefault();
		SmartSlider.addLayer();
	});
	
	// Select layer
	jQuery('#ls-layer-tabs a:not(.unsortable)').live('click', function(e) {
		e.preventDefault();
		SmartSlider.selectLayer(this);
	});

	// Duplicate layer
	jQuery('.ls-layer-options-thead a.duplicate').live('click', function(e){
		e.preventDefault();
		SmartSlider.duplicateLayer(this);
	});

	// Add sublayer
	jQuery('.ls-add-sublayer').live('click', function(e) {
		e.preventDefault();
		SmartSlider.addSublayer(this);
	});

	// Remove layer
	jQuery('#ls-layer-tabs a span').live('click', function(e) {
		e.preventDefault();
		e.stopPropagation();
		SmartSlider.removeLayer(this);
	});

	// Select sublayer
	jQuery('.ls-sublayers tr').live('click', function() {
		SmartSlider.selectSubLayer(this);
	});


	// Sublayer pages
	jQuery('.ls-sublayer-nav a:not(:last-child)').live('click', function(e) {
		e.preventDefault();
		SmartSlider.selectSublayerPage(this);
	});

	// Remove sublayer
	jQuery('.ls-sublayer-nav a:last-child').live('click', function(e) {
		e.preventDefault();
		SmartSlider.removeSublayer(this);
	});

	// Duplicate sublayer
	jQuery('.ls-sublayer-options button.duplicate').live('click', function(e) {
		e.preventDefault();
		SmartSlider.duplicateSublayer(this);
	});

	// Highlight sublayer
	jQuery('.ls-highlight input').live('click', function(e) {
		e.stopPropagation();
		SmartSlider.highlightSublayer(this);
	});

	// Sublayer media type
	jQuery('.ls-sublayer-types > span').live('click', function(e) {
		e.preventDefault();
		SmartSlider.didSelectMediaType(this);
	});

	// Restore sublayer media type
	jQuery('.ls-sublayer-basic select').each(function() {

		// Get selected element
		var index = jQuery(this).find('option:selected').index();

		// Restore
		SmartSlider.selectMediaType(jQuery(this).parent().find('.ls-sublayer-types > span').eq(index));
	});

	// smart Add product
	jQuery('.ls-add-product').live('click', function(e) {
		e.preventDefault();
		$(this).parent().parent().addClass('product_activ');
		$( ".product_list" ).dialog( "open" );
	});
	// product list dialog
	$( ".product_list" ).dialog({
		height: 400,
		width : 600,
		modal : true,
		autoOpen: false,
		buttons: [
			{
			  text: "ADD",
			  click: function() {
				$( this ).dialog( "close" );
				var $product = $('.product_list').contents().find('input[name=selected]:checked');
				
				var $prod_col = $product.parent().parent().find('td');
				var data = {};
				data.id		= $prod_col.eq(0).find('input').val();
				data.href	= $prod_col.eq(0).find('input').attr('data-href');
				data.html 	= $product.parent().parent().html();
				if(data.id != undefined)SmartSlider.addProduct(data);
			  }
			}
		],
		show: {
		effect: "explode",
		duration: 500
		},
		hide: {
		effect: "explode",
		duration: 500
		},
		open: function( event, ui ) { 
			$('.product_list').contents().find('input[name=selected]').removeAttr('checked');
		}
    });
	
	// Remove product
	jQuery('.ls-icon-del').live('click', function(e) {
		e.preventDefault();
		SmartSlider.removeProduct($(this));
		jQuery('#ls-layers .ls-layer-box').each(function( index ) {
			SmartSlider.generatePreview(index);
		});
	});
	

	// Sublayer: sortables, draggable, etc
	SmartSlider.addSortables();
	SmartSlider.addDraggable();
	SmartSlider.addLayerSortables();

	// Sublayer: skip
	jQuery('.ls-sublayer-options input[name="skip"]').live('click', function() {
		SmartSlider.skipSublayer(this);
	});

	// Preview
	jQuery('.ls-preview-button').live('click', function(e) {
		e.preventDefault();
		SmartSlider.play( jQuery(this).closest('.ls-layer-box').index() );
	});

	// Preview drag element select
	jQuery('.draggable > *').live('click', function() {
		SmartSlider.selectDragElement(this);
	});

	// Save changes
	jQuery('#ls-slider-form').submit(function(e) {
		e.preventDefault();
		SmartSlider.save(this);
	});

	// Callback boxes
	SmartSlider.setCallbackBoxesWidth();
	jQuery(window).resize(function() {
		SmartSlider.setCallbackBoxesWidth();
	});

	// Color picker
	jQuery('.ls-colorpicker').each(function() {
		var self = this;
		jQuery(this).farbtastic( function(color) {

			// Set color code in the input
			jQuery(self).prev().val(color).trigger('change');

			// Set input background
			jQuery(self).prev().css('background-color', color);

			// Update preview
			//SmartSlider.willGeneratePreview( jQuery('.ls-box.active').index() );
		}).hide();
	});

	// Show color picker on focus
	jQuery('.color').focus(function() {
		jQuery(this).next().slideDown();
	});

	// Show color picker on blur
	jQuery('.color').blur(function() {
		jQuery(this).next().slideUp();
	});
	
	// smart prepare to display slider
	jQuery('#ls-layers .ls-layer-box').each(function( index ) {
			SmartSlider.generatePreview(index);
		});
	SmartSlider.willGeneratePreview( jQuery('.ls-box.active').index() );
	
	setTimeout( '$( "#save_wait" ).dialog( "close" )',2000 );

});

(function ($) {

	$.fn.actual = function () {
	if (arguments.length && typeof arguments[0] == 'string') {
		var dim = arguments[0];
		if (this.is(':visible')) {return this[dim](); }
		var clone = $(this).clone().css({
		position: 'absolute',
		top: '-9999px',
		visibility: 'hidden'
		}).appendTo('body');
		var s = clone[dim]();
		clone.remove();
		return s;
	};
	return undefined;
	};
	
	$.fn.labelActual = function () {
	if (arguments.length && typeof arguments[0] == 'string') {
		var dim = arguments[0];
		var clone = $(this).clone().removeClass().removeAttr('style').css({
		position: 'absolute',
		top: '-9999px',
		visibility: 'hidden'
		}).appendTo('body');
		var s = clone[dim]();
		clone.remove();
		return s;
	};
	return undefined;
	};
  
  	$.fn.customCheckbox = function() {

		return this.each(function() {

			// Get the original element
			var el = this;

			// Hide the checkbox
			$(this).hide();

			// Create replacement element
			var rep = $('<a href="#"><span></span></a>').addClass('ls-checkbox').insertAfter(this);

			// Set default state
			if($(this).is(':checked')) {
				$(rep).addClass('on');
			} else {
				$(rep).addClass('off');
			}

			// Click event
			$(rep).click(function(e) {

				e.preventDefault();

				if( $(el).is(':checked') ) {
					$(el).prop('checked', false);
					$(rep).removeClass('on').addClass('off');
				} else {
					$(el).prop('checked', true);
					$(rep).removeClass('off').addClass('on');
				}
			});
		});
	};
  
}(jQuery));