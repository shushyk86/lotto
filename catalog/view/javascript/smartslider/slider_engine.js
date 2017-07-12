/**
 * jQuery.browser.mobile (http://detectmobilebrowser.com/)
 *
 * jQuery.browser.mobile will be true if the browser is a mobile device
 *
 **/
(function(a){(jQuery.browser=jQuery.browser||{}).mobile=/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))})(navigator.userAgent||navigator.vendor||window.opera);

jQuery(window).load(function() {
  
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
	
	
	SliderEngine.start(getSlides());
	smartSliderStart(SliderEngine.getParalax()); //getParalax()

	window.onresize = function(event) {
		if(!$.browser.mobile){
			SliderEngine.restart();
		}
	}
	
})

SliderEngine = {

	run	: false,
	
	restart : function(){
		$('#smartslider').remove();
		SliderEngine.run = false;
		SliderEngine.start(getSlides());
		smartSliderStart(SliderEngine.getParalax()); //getParalax()
	},
	
	getParalax : function(){
		var width = $("#smartslider").width();
		if(320 > width) return 2;
		if(320 <= width && width < 480) return 1.5;
		if(480 <= width && width < 600) return 1.0;
		if(600 <= width && width < 800) return 0.9;
		if(800 <= width && width < 1000) return 0.7;
		if(width > 1000) return 0.5;
	},
	
	start : function(slides){
		
		if(SliderEngine.run) return; // перевірка на один запуск
		
	// Layer props
		var s_style = SliderEngine.replace(slides.properties.sliderstyle);
		var s_width = SliderEngine.replace(slides.properties.width) ? " width : " + SliderEngine.checkUnit(slides.properties.width) + '; ' : '';
		//alert(slides.properties.height_auto);
		
		//(height_auto) start
		if(slides.properties.height_auto){
			var s_height = " height : 250px;";
		}else{
			var s_height = SliderEngine.replace(slides.properties.height) ? " height : " + SliderEngine.checkUnit(slides.properties.height) + '; ' : '';
		}//(height_auto) end

	// past HTML (1) 
		var layer_html = '<div id="smartslider" style="' + s_width + s_height+ ' margin: 0px auto; ' + s_style + '"></div>';	
		$("#smartslider_container").prepend(layer_html);
		
		//(height_auto) start
		if(slides.properties.height_auto && slides.properties.slider_size){
			
			var slider_size = slides.properties.slider_size.split('-l-'); // [0]->width, [1]-height
			
			var koeficient = slider_size[1] / slider_size[0];

			var sl_height = new String(parseInt($("#smartslider").width())*koeficient);

			$("#smartslider").css('height', SliderEngine.checkUnit(sl_height));
		}//(height_auto) end
		
	// past HTML (1) END
	
		if($.isArray(slides.layers)) {
			$.each(slides.layers, function(layerkey, layer){
			// Skip layer?
				if(layer.properties.skip) {
					return true;
				}

			// ID
				var layerID = layer.properties.id ? ' id="' + layer.properties.id + '" ' : ' ';

				
			// css
				var deeplink = layer.properties.deeplink ? ' deeplink: ' + layer.properties.deeplink + '; ' : ' ';

				var slidedirection = layer.properties.slidedirection ? ' slidedirection: ' + layer.properties.slidedirection + '; ' : ' ';
				
				var slidedelay = layer.properties.slidedelay ? ' slidedelay: ' + layer.properties.slidedelay + '; ' : ' ';
				
				var durationin = layer.properties.durationin ? ' durationin: ' + layer.properties.durationin + '; ' : ' ';
				
				var durationout = layer.properties.durationout ? ' durationout: ' + layer.properties.durationout + '; ' : ' ';
				
				var easingin = layer.properties.easingin ? ' easingin: ' + layer.properties.easingin + '; ' : ' ';
				
				var easingout = layer.properties.easingout ? ' easingout: ' + layer.properties.easingout + '; ' : ' ';
				
				var delayin = layer.properties.delayin ? ' delayin: ' + layer.properties.delayin + '; ' : ' ';
				
				var delayout = layer.properties.delayout ? ' delayout: ' + layer.properties.delayout + '; ' : ' ';
			
			// past HTML (2) 
				var html = '<div class="ls-layer" ' + layerID + ' style="' + deeplink + slidedirection + slidedelay + durationin + durationout + easingin + easingout + delayin + delayout + '"></div>';
				var $ls_last = $(html).appendTo("#smartslider");	
			// past HTML (2) END
				
				
			// Layer background
				if(layer.properties.background) {
				// past HTML (3) 
					var mip ='';
					if(layer.properties.background.indexOf("http://") < 0 ) var mip = mainImagePath;
					var html = '<img src="'+ mip + layer.properties.background + '" class="ls-bg">';	
					$ls_last.append(html);
				// past HTML (3) END
				}

			// Layer thumbnail
				if(slides.properties.thumb_nav && slides.properties.thumb_nav != 'disabled') {
					if(layer.properties.thumbnail) {
					// past HTML (4) 
						var mip ='';
						if(layer.properties.thumbnail.indexOf("http://") < 0 ) var mip = mainImagePath;
						var html = '<img src="' + mip + layer.properties.thumbnail + '" class="ls-tn">';	
						$ls_last.append(html);
					// past HTML (4) END						
					}
				}
				
				if($.isArray(layer.sublayers)) {
					$.each(layer.sublayers, function(index, sublayer){
					// Skip layer?
						if(sublayer.skip) return true;
						
					// ID	
						var sublayerID = sublayer.id ? ' id="' + sublayer.id + '" ' : '';
										
					// class
						var linkTo = (sublayer.url && sublayer.url.match('/^\#[0-9]/') != null) ? ' ls-linkto-' + sublayer.url.substr(1) + '' : '';
						var sublayerClass = sublayer['class'] ? ' ' + sublayer['class'] + '' : '';
										
					// attr
						var sublayerTitle = sublayer.title ? ' title="' + sublayer.title + '" ' : '';
						var sublayerAlt = sublayer.alt ? ' alt="' + sublayer.alt + '" ' : '';

					// custom css	
						var sublayerStyle = sublayer.style ? ' ' + SliderEngine.stripslashes(sublayer.style).replace(/\s\s+/g, " ") + '; ' : '';	
						var sublayerWordWrap = sublayer.wordwrap ? ' white-space: nowrap; ' : '';
						
						var additionalStyle = SliderEngine.getElementSublayrCSS(sublayer);
					
					// start <a> =============
						if(sublayer.url && sublayer.url.match('/^\#[0-9]/') == null) {
						// past HTML (5) 
							var html = '<a href="' + sublayer.url + '" target="' + sublayer.target + '" ' + sublayerID + ' class="ls-s' + sublayer.level + '" ' + sublayerTitle + ' "></a>';	
							var $a_last = $(html).appendTo($ls_last);
						// past HTML (5) END	
							
							var $img_last = '';
							
					// TYPE IMAGE		
							if(!sublayer.type || sublayer.type == 'img') {
								if(sublayer.image) {
								// past HTML (6)
									var mip ='';
									if(sublayer.image.indexOf("http://") < 0 ) var mip = mainImagePath;
									var html = '<img src="' + mip + sublayer.image + '" ' + sublayerAlt + ' style="' + sublayerStyle + ' ' + additionalStyle + '">';
									$img_last = $(html).appendTo($a_last);
								// past HTML (6) END									

								}
					// TYPE PRODUCT			
							}else if(sublayer.type == 'product'){
									
								var productForSlider = productsForSlider[sublayer.product];

							// past HTML (7) 
								var html = '<div style="' + additionalStyle + ' '+ sublayerStyle + '" class="slider_prod"></div>';
								var $slider_prod_last = $(html).appendTo($a_last);
								// rewrite href
								$a_last.attr('href', productForSlider['href']);
							// past HTML (7) END
							
								// LABEL RENDER START
								if(sublayer.label_type && sublayer.label_type != ''){
									var label_type	= sublayer.label_type;
									var label_color = sublayer.label_color;
									var label_file	= sublayer.label_file;
									
									var label_src	= layerLabelPath + label_type + '/' + label_color + '/' + label_file;
										

									if(sublayer.label_size && sublayer.label_size != ''){
										var label_size	= sublayer.label_size.split('-l-');
										label_size ={
											width: 	label_size[0],
											height: label_size[1]
										};
									}else{
										var label_size	= srcSize (label_src);
									}
										

									var pos_hor = sublayer.label_pos_hor+' : '+SliderEngine.checkUnit(sublayer.label_pos_hor_val) + ';';
									var pos_ver = sublayer.label_pos_ver+' : '+SliderEngine.checkUnit(sublayer.label_pos_ver_val) + ';';

									margin =[];
									if(sublayer.label_pos_hor_val.indexOf('%') != -1){
										if(sublayer.label_pos_hor == 'left'){
											margin.push('margin-right: ' + label_size.width/2 + 'px; ');
										}else{
											margin.push('margin-right: -' + label_size.width/2 + 'px; ');
										}
									}
									if(sublayer.label_pos_ver_val.indexOf('%') != -1){
										if(sublayer.label_pos_ver == 'bottom'){
											margin.push('margin-top: ' + label_size.height/2 + 'px; ');
										}else{
											margin.push('margin-top: -' + label_size.height/2 + 'px; ');
										}
									}
									
									if(label_type =='discount'){
										var html = "<div style='position: absolute; background:url(" + label_src + ")no-repeat; width:" + label_size.width + "px; height:" + label_size.height + "px; " + pos_hor + pos_ver + margin.join(' ') + "' class='product_label_on_slider'><div class='discount_val' style='color:#" + label_color + ";' >" + sublayer.discount_val + "</div></div>";
									}else{
										html = "<div style='position: absolute; background:url(" + label_src + ")no-repeat; class='product_label_on_slider'></div>";
										html =  "<div style='position: absolute; background:url(" + label_src + ")no-repeat; width:" + label_size.width + "px; height:" + label_size.height + "px; " + pos_hor + pos_ver + margin.join(' ') + "' class='product_label_on_slider'></div>";
									}
									$slider_prod_last.append(html);
			
								}
								// LABEL RENDER END

								var prod_style = ' height: 80%; ';
								//var prod_style = (sublayer.width && sublayer.width != '') ? ' width: 100%; ' : '';
								
								prod_style += sublayer.transparent ? ' opacity: ' + sublayer.transparent/100 + '; ' : '';
								
							// past HTML (8) 
								var html = "<img style='" + prod_style + "' src='" + productForSlider['image'] + "' alt='" + productForSlider['name'] + "'>";
								$img_last = $(html).appendTo($slider_prod_last);
							// past HTML (8) END
								
							// past HTML (9) 
								var html = "<div class='name'>" + productForSlider['name'] + "</div>";
								$slider_prod_last.append(html);
							// past HTML (9) END	

								if(productForSlider['special']){
								// past HTML (10.a) 
									var html = "<div class='price'><span class='price-old'>" +  productForSlider['price'] + "</span><span class='price-new'>" + productForSlider['special'] + "</span></div>";
									$slider_prod_last.append(html);
								// past HTML (10.a) END
								}else{
								// past HTML (10.b) 
									var html = "<div class='price'>" + productForSlider['price'] + "</div>";
									$slider_prod_last.append(html);
								// past HTML (10.b) END

								}
					// TYPE OTHER		
							}else {
								// past HTML (10.b) 
									SliderEngine.setOtherSublayerPos(sublayer);
									var sublayerCSS = SliderEngine.getSublayerCSS(sublayer);
									var sublayerParamStyle = 'position: absolute; ' + sublayerCSS;
									$a_last.html(SliderEngine.stripslashes(sublayer.html));
								// past HTML (10.b) END
							}
							
						// add css	
							if($img_last != ''){
								if(sublayer.image_size != undefined){
									var image_size = sublayer.image_size.split('-l-'); // [0]->width, [1]-height
									SliderEngine.setSublayerSize(sublayer, $img_last, image_size);
								}else{
									SliderEngine.setSublayerSize(sublayer, $img_last);
								}
								var sublayerCSS = SliderEngine.getSublayerCSS(sublayer);
								var sublayerParamStyle = 'position: absolute; ' + sublayerCSS;
								$a_last.attr('style', sublayerParamStyle);
								
							}else{
							
								SliderEngine.setOtherSublayerPos(sublayer);
								var sublayerCSS = SliderEngine.getSublayerCSS(sublayer);
								var sublayerParamStyle = 'position: absolute; ' + sublayerCSS;
								var style = sublayerParamStyle + ' ' + sublayerStyle + ' ' + sublayerWordWrap;
								$a_last.attr('style', style);
								
							}
							
							
							
						} // end <a> ================
						else {
							if(!sublayer.type || sublayer.type == 'img') {
								if(sublayer.image) {
								// past HTML (6.a) 
									var mip ='';
									//alert(layer.properties.background +'='+layer.properties.background.indexOf("http://"))
									if(sublayer.image.indexOf("http://") < 0 ) var mip = mainImagePath;
									var html = '<img class="ls-s' + sublayer.level + ' ' + linkTo + ' ' +sublayerClass + '" ' + sublayerID + ' src="' + mip + sublayer.image + '" ' + sublayerAlt + '>';
									$img_last = $(html).appendTo($ls_last);
								// past HTML (6.a) END
									if(sublayer.image_size != undefined){
										var image_size = sublayer.image_size.split('-l-'); // [0]->width, [1]-height
										SliderEngine.setSublayerSize(sublayer, $img_last, image_size);
									}else{
										SliderEngine.setSublayerSize(sublayer, $img_last);
									}
									var sublayerCSS = SliderEngine.getSublayerCSS(sublayer);
									var sublayerParamStyle = 'position: absolute; ' + sublayerCSS;
									$img_last.attr('style', sublayerParamStyle + sublayerStyle);
								
								}
							}else {
								// past HTML (6.b) 
									SliderEngine.setOtherSublayerPos(sublayer);
									var sublayerCSS = SliderEngine.getSublayerCSS(sublayer);
									var sublayerParamStyle = 'position: absolute; ' + sublayerCSS;
									//alert(sublayer.html);
									var html = '<' + sublayer.type +' ' + sublayerID + ' class="ls-s' +sublayer.level + '' +linkTo + '' + sublayerClass + '" style="' +  sublayerParamStyle + ' ' +sublayerStyle + '' + sublayerWordWrap + '"> ' + SliderEngine.stripslashes(sublayer.html) + ' </' + sublayer.type + '>';
									$ls_last.append(html);
									
								// past HTML (6.b) END
							}
						}		

					});
				}
			})
		}
		
		//alert(data);
	
		SliderEngine.run = true;
	},
	
	setOtherSublayerPos : function(sublayer){
		var layer_s= {
			width : $('#smartslider').width(),
			height: $('#smartslider').height()
			};
	// set position	left if isset right		
		if(sublayer.right && sublayer.right !='' && sublayer.right.indexOf('%') < 0){
			if(sublayer.width !='' && sublayer.width.indexOf('%') > 0){
				sublayer.width  = (layer_s.width * parseInt(sublayer.width)/100) + 'px';
			}
			sublayer.left = (layer_s.width - parseInt(sublayer.right) - parseInt(sublayer.width)) + 'px';

		}else if(sublayer.right && sublayer.right !='' && sublayer.right.indexOf('%') > 0){
			sublayer.left = (100 - parseInt(sublayer.right)) + '%';
		}
	// set position	top if isset bottom		
		if(sublayer.bottom && sublayer.bottom !='' && sublayer.bottom.indexOf('%') < 0){
			if(sublayer.height !='' && sublayer.height.indexOf('%') > 0){
				sublayer.height  = (layer_s.height * parseInt(sublayer.height)/100) + 'px';
			}
			sublayer.top = (layer_s.height - parseInt(sublayer.bottom) - parseInt(sublayer.height)) + 'px';
		}else if(sublayer.bottom && sublayer.bottom !='' && sublayer.bottom.indexOf('%') > 0){
			sublayer.top = (100 - parseInt(sublayer.bottom)) + '%';
		}
	},
	
	setSublayerSize : function(sublayer, $img, image_size){
		var layer_s= {
				width : $('#smartslider').width(),
				height: $('#smartslider').height()
				}; 
		if(image_size){ //alert(image_size[0])
			var img_s = {
				width : image_size[0],
				height: image_size[1]
				};//alert('image_size='+img_s.height)
		}else{
			//if(!$img.attr('src').length)$img = $img.find('img'); 
			var img_s = {
				width : $img.actual('width'),
				height: $img.actual('height')
				};alert('auto='+img_s.height + 'type'+ JSON.stringify(sublayer));
		}		
		//alert(layer_s.width);
	// set actual size sublayer 
		if(sublayer.width !='' && sublayer.width.indexOf('%') > 0  && sublayer.height !='' && sublayer.height.indexOf('%') > 0){
			sublayer.width  = (layer_s.width * parseInt(sublayer.width)/100) + 'px';
			sublayer.height = (layer_s.height * parseInt(sublayer.height)/100) + 'px';
			
		}else{
			if(sublayer.width !=''){
				if(sublayer.width.indexOf('%') > 0){
					sublayer.width  = (layer_s.width * parseInt(sublayer.width)/100) + 'px';
				}
				sublayer.height = parseInt((parseInt(sublayer.width) * img_s.height) / img_s.width) + 'px';
			}
			if(sublayer.height !=''){
				if(sublayer.height.indexOf('%') > 0){
					sublayer.height = (layer_s.height * parseInt(sublayer.height)/100) + 'px';
				}
				sublayer.width  = parseInt((parseInt(sublayer.height) * img_s.width) / img_s.height) + 'px';
			}
		}
		
	// set position	left if isset right		
		if(sublayer.right !='' && sublayer.right.indexOf('%') < 0){
			sublayer.left = (layer_s.width - parseInt(sublayer.right) - parseInt(sublayer.width)) + 'px';

		}else if(sublayer.right !='' && sublayer.right.indexOf('%') > 0){
			sublayer.left = (100 - parseInt(sublayer.right)) + '%';
		}
	// set position	top if isset bottom		
		if(sublayer.bottom !='' && sublayer.bottom.indexOf('%') < 0){
			sublayer.top = (layer_s.height - parseInt(sublayer.bottom) - parseInt(sublayer.height)) + 'px';
		}else if(sublayer.bottom !='' && sublayer.bottom.indexOf('%') > 0){
			sublayer.top = (100 - parseInt(sublayer.bottom)) + '%';
		}	
	},
	/*
	setSublayerSize : function(sublayer, $img){
		var layer_s= {
				width : $('#smartslider').width(),
				height: $('#smartslider').height()
				};
		
		var img_s = {
				width : $img.actual('width'),
				height: $img.actual('height')
				};
		//alert(layer_s.width);
	// set actual size sublayer 
		if(sublayer.width !='' && sublayer.width.indexOf('%') > 0  && sublayer.height !='' && sublayer.height.indexOf('%') > 0){
			sublayer.width  = (layer_s.width * parseInt(sublayer.width)/100) + 'px';
			sublayer.height = (layer_s.height * parseInt(sublayer.height)/100) + 'px';
			
		}else{
			if(sublayer.width !='' && sublayer.width.indexOf('%') > 0){
				sublayer.width  = (layer_s.width * parseInt(sublayer.width)/100) + 'px';
				sublayer.height = parseInt((parseInt(sublayer.width) * img_s.height) / img_s.width) + 'px';
			}
			if(sublayer.height !='' && sublayer.height.indexOf('%') > 0){
				sublayer.height = (layer_s.height * parseInt(sublayer.height)/100) + 'px';
				sublayer.width  = parseInt((parseInt(sublayer.height) * img_s.width) / img_s.height) + 'px';
			}
		}
		
	// set position	left if isset right		
		if(sublayer.right !='' && sublayer.right.indexOf('%') < 0){
			sublayer.left = (layer_s.width - parseInt(sublayer.right) - parseInt(sublayer.width)) + 'px';

		}else if(sublayer.right !='' && sublayer.right.indexOf('%') > 0){
			sublayer.left = (100 - parseInt(sublayer.right)) + '%';
		}
	// set position	top if isset bottom		
		if(sublayer.bottom !='' && sublayer.bottom.indexOf('%') < 0){
			sublayer.top = (layer_s.height - parseInt(sublayer.bottom) - parseInt(sublayer.height)) + 'px';
		}else if(sublayer.bottom !='' && sublayer.bottom.indexOf('%') > 0){
			sublayer.top = (100 - parseInt(sublayer.bottom)) + '%';
		}	
	},*/
	
	getSublayerCSS : function (sublayer){

		var css = {};
		
		css['slidedirection'] = (sublayer.slidedirection && sublayer.slidedirection != 'auto') ? 'slidedirection : ' + sublayer.slidedirection + '; ' : '';
		
		css['slideoutdirection'] = (sublayer.slideoutdirection && sublayer.slideoutdirection != 'auto') ? 'slideoutdirection : ' + sublayer.slideoutdirection + '; ' : '';

		css['sublayerTop'] = sublayer.top ? ' top: ' + SliderEngine.checkUnit(sublayer.top) + '; ' : '';
		
		css['sublayerWidth'] = sublayer.width ? ' width: ' + SliderEngine.checkUnit(sublayer.width) + '; ' : '';
		
		css['sublayerHeight'] = sublayer.height ? ' height: ' + SliderEngine.checkUnit(sublayer.height) + '; ' : '';
		
		css['sublayerOpacity'] = sublayer.transparent ? ' opacity: ' + sublayer.transparent/100 + '; ' : '';
		
		css['sublayerLeft'] = sublayer.left ? ' left: ' + SliderEngine.checkUnit(sublayer.left) + '; ' : '';
		
		css['durationin'] = sublayer.durationin ? ' durationin: ' + sublayer.durationin + '; ' : '';
		
		css['durationout'] = sublayer.durationout ? ' durationout: ' + sublayer.durationout + '; ' : '';
		
		css['easingin'] = sublayer.easingin ? ' easingin: ' + sublayer.easingin + '; ' : '';
		
		css['easingout'] = sublayer.easingout ? ' easingout: ' + sublayer.easingout + '; ' : '';
		
		css['delayin'] = sublayer.delayin ? ' delayin: ' + sublayer.delayin + '; ' : '';
		
		css['delayout'] = sublayer.delayout ? ' delayout: ' + sublayer.delayout + '; ' : '';
		
		css['showuntil'] = sublayer.showuntil ? ' showuntil: ' + sublayer.showuntil + '; ' : 'showuntil: 0; ';
		
		return SliderEngine.assocArrToStr(css, '', 'value');
	},
	
	getElementSublayrCSS : function (sublayer){
		
		var css = {};
		
		css['width'] = sublayer.width ? ' width: ' + SliderEngine.checkUnit(sublayer.width) + '; ' : '';
		css['height'] = sublayer.height ? ' height: ' + SliderEngine.checkUnit(sublayer.height) + '; ' : '';
		css['opacity'] = sublayer.transparent ? ' opacity: ' + sublayer.transparent/100 + '; ' : '';
		
		return SliderEngine.assocArrToStr(css, '', 'value');
	},
	
	replace : function (data){
		return data ? data : '';
	},
	
	checkUnit : function(data){
		if(data.indexOf('px') < 0 && data.indexOf('%') < 0) {
			return data + 'px';
		} else {
			return data;
		}
	},
	
	stripslashes : function ( str ) {
		return str.replace('/\0/g', '0').replace('/\(.)/g', '$1');
	},
	
	assocArrToStr : function (arrIn, separator, key_or_val){
		var arrOut = [];
		//alert (JSON.stringify(arrIn));
		$.each(arrIn, function(key, value) { 
			eval('arrOut.push(' + key_or_val + ')');
		});
		return arrOut.join(separator);
	}
	
}

function srcSize (src) {
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
};
