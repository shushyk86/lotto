$(document).ready(function() {

	//Wrapping boxes with a links
	linkWrap('.cat');
	linkWrap('.timer-top');
	$(".phonef2").mask("+38 (099) 999-99-99");

	if ($('#simplecheckout_payment_form .button').length) {
		$('#simplecheckout_button_confirm').hide();
	}

	//Adding and removing an elements to the DOM
	$('.box-content > p:nth-of-type(1)').wrap("<a href='/privacy'></a>");
	$('.offcanvas-siderbars').prepend('<div id="grey-line"></div>');
	$('#header').find('.cat-wrap').addClass('hidden-xs hidden-sm')
	$('.menu-offcanvas-inner').prepend('<p id="hide-menu1"><i class="fa fa-times"></i></p>')
	$('#checkout_customer_main_country_id option:first').text('НАСЕЛЕННЫЙ ПУНКТ');
	$('#checkout_customer_main_zone_id option:first').text('№ ОТДЕЛЕНИЯ НОВОЙ ПОЧТЫ');
	$('.footer-center').find('.row').children().addClass('col-xs-12 col-sm-3 col-lg-3 col-md-3 column');
	$('#total_total').detach().appendTo('.total-block11').show();
	$('#oc-column-left').prepend('<div id="close-left-menu"><p class="hide-left-menu"><i class="fa fa-bars"></i>спрятать меню</p></div>');
	$('#oc-column-left').prepend('<p class="shows hidden visible-md visible-lg"><i class="fa fa-bars"></i>отобразить меню</p>');

	var rasprodazha = $('.home-tab').closest('.box-content').find('.tab-nav ul li a');
	rasprodazha.removeAttr("data-toggle");
	rasprodazha.attr("href", "http://lotto-sport.com.ua/rasprodaza");

	$('#cart-link, #xs_cart a').live('click', function(e){
		if($('#cart-link').attr('class') === "empty-cart"){
			e.preventDefault();
		}
	});

	//24.11.16 button-up-scroll
	$ (window).scroll (function () {
		if ($ (this).scrollTop () > 300) {
		$ ('.button-up').fadeIn();
		} else {
		$ ('.button-up').fadeOut();
		}
		});
		 
		$('.button-up').click(function(){
		$('body,html').animate({
		scrollTop: 0
		}, 100);
		return false;
	});
	
	// $('.pagination-top .sort').hover(function() {
	//     $($(this).data('.limit-block')).show();
	// });

	// $('.pagination-top .sort').hover( 
 //    function(){
 //        $('.limit-block').css('display','block');
 //   	 }
	// );
	 
	   	// $('.pagination-top .sort').mouseover(function(){   
	   	//  	$('.limit-block').next().slideDown('slow');  
	   	//  	 }); 

	   	// $('.limit-block').next().mouseout(function(){   
	   	//  	$(this).slideUp('slow');
	   	//  });


	//position filter
    if(document.documentElement.clientWidth < 767) {
    	console.log('fuwcudu');
      $(function(){
	    $(window).scroll(function() {
	        var top = $(document).scrollTop();
		        if (top < 100) $(".shows").css({top: '-35.2vw', position: 'absolute'});
		        else $(".shows").css({top: '0px', position: 'fixed'});
    	});
	  })
    }

	$(function(){
	    $(window).scroll(function() {
	        var top = $(document).scrollTop();
		        if (top < 100) $(".shows").css({});
		        else $(".shows").css({top: '0px', position: 'fixed'});
    	});
	})

	$('#notification').on('click', '.close', function() {
	  $(this).parent().fadeOut('slow', function() {
	    $(this).remove();
	  });
	});

	if ($('.description_bottom').text().length < 200){
		$('#short_text_show_link').hide();
	}
	
	//Description appearing
	$('#short_text_show_link').on('click', function(e) {
		e.preventDefault();

		$(this).hide(500);
		$('.brand-description, .description_bottom').removeClass('short', {duration:1500});
	});


	//Links and buttons wrapping
	setTimeout(function() {
		wrap()
		$('.smch_call_button').wrap('<div class=under-color-gray></div>');
	},600);


	// Modal for product
	$('#modal123').on('click', function() {
		$(this).hide();
		$('.sizer').detach();
		$('.under-color-focus').removeClass('under-color-focus');
	});


	//Auto height for cat bloks
	var boxW = $('.cat').width(),
		winW = $(window).width();
	$('.cat-img, .cat-dct').height(boxW);
	if(winW >= 320) {
		$('.cat-img, .cat-dct').height(boxW);
		$( window ).resize(function() {
			boxW = $('.cat-img').width(),
				$('.cat-img, .cat-dct').height(boxW);
		});
	};


	if(winW > 991) {
		$('#cmpro-1').hide();
		$('#close-left-menu .hide-left-menu').hide();
		$('.shows').removeClass('hidden');
		
		$('#close-left-menu .hide-left-menu').on('click', function() {
			$('#cmpro-1').hide(500);
			$(this).hide();
			$('.shows').removeClass('hidden');
		});
		$('.shows').on('click', function() {
			$('#cmpro-1').show(400);
			$(this).addClass('hidden');
			$('.hide-left-menu').show();
		});
		$('#use-filter').on('click', function() {
			var offs = $('.main-column').offset().top;
			$('#cmpro-1').hide(500);
			$('#close-left-menu .hide-left-menu').hide();
			$('.shows').removeClass('hidden');
			$('body').animate({scrollTop: offs}, 400);
		});
	};
// 320 -991 Фільт товарів
	if(winW >= 320 && winW <= 767) {
		$('.cat-img, .cat-dct').height(boxW / 2);
		$('.shows').removeClass('hidden');
		$('.shows i').attr('class', 'fa fa-outdent');
		$('#close-left-menu i').attr('class', 'fa fa-outdent');
		if ($('.hide-left-menu').length) {
			$('.hide-left-menu').html($('.hide-left-menu').html().replace('спрятать меню', 'спрятать фильтр'));
		};
		$('#close-left-menu .hide-left-menu').on('click', function() {
			$('#oc-column-left').hide(500);
			$('.main-column').attr('class', 'col-lg-12 col-md-12 col-sm-12 col-xs-12 main-column');
			$(this).hide();
			$('.shows').removeClass('hidden');
		});
		$('.shows').on('click', function() {
			$('#oc-column-left').show(400);
			$('.main-column').attr('class', 'col-lg-9 col-md-9 col-sm-12 col-xs-12 main-column');
			$(this).addClass('hidden');
			$('.hide-left-menu').show();
		});
		$('#use-filter').on('click', function() {
			var offs = $('.product-list').offset().top - 120;
			$('#oc-column-left').hide(500);
			$('.main-column').attr('class', 'col-lg-12 col-md-12 col-sm-12 col-xs-12 main-column');
			$('#close-left-menu .hide-left-menu').hide();
			$('.shows').removeClass('hidden');
			$('body').animate({scrollTop: offs}, 400);
		});
			$(" #use-filter").click(function() {
			 	$(this).closest('.filterpro');
			});
	};

// 3- 9
	if(winW >= 320 && winW <= 767) {
		$('.cat-img, .cat-dct').height(boxW / 2);
	};

	/*
	 //Change sidebar's height
	 if(winW > 991) {
		 $('.offcanvas-sidebar').find('input').on('change', function() {
			 var ri = $('.main-column').height();
			 if($('.offcanvas-sidebar').height < ri) {
				$('.offcanvas-sidebar').height(ri);
			 }
		 });
	 };
	 */

	// if(winW <= 767) {
	// 	$(window).on('scroll', function() {
	// 		var scrollTop = $(window).scrollTop();
	// 		if(scrollTop > 39) {
	// 			$('#mainmenutop .navbar-toggle').css({'position': 'fixed','top': '0'});
	// 			$('#topbar').css({'position': 'fixed','top': '0'});
	// 			$('#header').css('margin-top', '63px');
	// 			$('.shows').css({'position': 'fixed','top': '53px'});
	// 			$('.back-mini').css({'display': 'block', 'position': 'fixed','top': '53px'});
	// 		} else {
	// 			$('#mainmenutop .navbar-toggle').css({'position': 'absolute','top': '102px'});
	// 			$('#topbar').css({'position': 'absolute','top': '39px'});
	// 			$('#header').css('margin-top', '0');
	// 			$('.shows').css({'position': 'absolute','top': '0'});
	// 			$('.back-mini').css({'position': 'absolute','top': '0'});
	// 		}
	// 	});
	// }

//XS - mode on click buttons
$('#xs_top_bar').click(function(){
	$('#xs_toggle_menu').slideToggle();
});
$('#xs_top_bar1').click(function(){
	$('#xs_akordeon').slideToggle();
});



// XS - Akordeon
 //$('.xs_wrapper>.xs_article').not(':first-of-type').hide();
// $('.xs_article').hide();
//
//   $('.xs_wrapper>.xs_h1').click(function() {
//
//     var findArticle = $(this).next();
//     var findWrapper = $(this).closest('.xs_wrapper');
//
//     if (findArticle.is(':visible')) {
//       findArticle.slideUp('fast');
//     }
//     else {
//       findWrapper.find('>.xs_article').slideUp('fast');
//       findArticle.slideDown('fast');
//     }
//   });

	//Search appearing
	// $('.menu-icon-search, #back').on('click', function(e) {
	// 	e.preventDefault();
	// 	$('#search_in_header').find('#search').toggleClass('hidden');
	// });


	$(window).resize(function() {
		$('.header-wrap').find('#search').addClass('hidden');
		$(window).on('scroll', function() {
			var scrollTop = $(window).scrollTop();
			if(scrollTop > 10) {
				$('#topbar').css('padding', '7px')
			} else {
				$('#topbar').css('padding', '8px')
			}
		});
		$('#topbar').css('padding', '8px')
	});


	//Dropdown menu on category page
///////////////////////////
	$(document).on('touchstart click', '.dropdown-submenu', function(event){
        event.stopPropagation();
    //  event.preventDefault();
        if(event.handled !== true) {

            // Do your magic here.
        	if( $(window).width() < 768 ){
					$(this).closest('.mega-col').siblings().find('.dropdown-mega').hide();
					$(this).find('.dropdown-mega').show();
					//
	            event.handled = true;
	        }

		  event.handled = true;       

        } else {
            return false;
        }
	});

////.............................


// $('.parent.dropdown-submenu').on('touchstart click', function(e){
//     e.stopPropagation();
// 		e.preventDefault();
// 		$(this).closest('.mega-col').siblings().find('.dropdown-mega').hide();
// 		$(this).find('.dropdown-mega').slideToggle();
// });

//var clickEventType=((document.ontouchstart!==null)?'click':'touc‌​hstart');
//$(theElem).on(clickEventType...

// робоча версія
// $('.parent.dropdown-submenu').on('click', function(event) {
// 	event.stopPropagation();
// 	$(this).closest('.mega-col').siblings().find('.dropdown-mega').hide();
// 	$(this).find('.dropdown-mega').slideToggle();
// });
///////////////////////////
// $(document).on('click', '.parent.dropdown-submenu', function(e) {
//   e.stopPropagation();
// 	$(this).closest('.mega-col').siblings().find('.dropdown-mega').hide();
// 	$(this).find('.dropdown-mega').slideToggle();
// });
///// $('.parent.dropdown-submenu').on('click', function(event) {..........................

	$('.simplecheckout-customer-right').each(function() {
      var holder = $(this).siblings('.simplecheckout-customer-left').text().replace(/\s+/g, ' ').toUpperCase();
      $(this).find('input').attr('placeholder', holder)
  });


	//Breadcrumbs
	if($('.breadcrumb').length < 1) {
		$('#grey-line').hide();
	};


	var el2 = $('.breadcrumb');
	el2.html(el2.html().replace(/\»/gi, "<span>/</span>"));
	el2.find('i').remove();


	var listLen = $('.category-list > ul').length
	if(listLen < 1) {
		$('.category-list').css('padding', '0')
		$('.category-list > h1').css('padding', '40px 30px')
	};

	setTimeout(function() {
		$('#left-dct').find('.cart').animate({'opacity': '1'}, 600, 'linear');
	},600);
/*
	setTimeout(function() {
		$('.login-content').find('.button, .under-color').animate({'opacity': '1'}, 600, 'linear')
	}, 1600);
*/
	var firstlink = $('.parent').find('a[data-toggle="dropdown"]');
	firstlink.each(function() {
		if($(this).attr('href') === '') {
			$(this).find('span').unwrap();
		}
	});

	$(window).on('scroll', function() {
		var scrollTop = $(window).scrollTop(),
			footOff = $('#footer').offset().top -1000;
		if(scrollTop > footOff) {
			$('.social-fixed').removeClass('hide');
			social('#fb-fix', 200)
			social('#vk-fix', 250)
			social('#yot-fix', 300)
			social('#ig-fix', 350)
		}
	});

	callBackF('.callback2f');
	callBackFClose('.close2f');
	callBackFClose('.modal2f');

	$('.submit-sudo').on('click', function() {
		var val1 = $('#namef2').val(),
			val2 = $('.phonef2').val();


		if(val1.length != 0 && val2.length != 0) {
			$('.form-holder2f').hide();
			$('.gratf2').fadeIn(600);
			setTimeout(function() {
				$('#submitf2').trigger('click')
			}, 3000)
		};
	});

});

function wrap() {
	$('.button').wrap('<div class="under-color"></div>');
	$('#left-dct .under-color').on('click', '.button', function() {

		if($("select.form-control option:selected").text() == " --- Выберите --- ") {
			$(this).parent().toggleClass('under-color-focus');
		}

		if ($('#sizer-val1').length !== 0) {
			$('#modal123').toggle();
		}
	});
};

function linkWrap(block) {
	$(block).wrap('<a class="cat-wrap"></a>');
	$('.cat-wrap').on('click', function() {
		var href = $(this).find('a').attr('href');
		$(this).attr('href', href)
	});
}

function social(icon, sec) {
	setTimeout(function() {
		$(icon).addClass('visible11')
	}, sec)
}

function social2(icon, sec) {
	setTimeout(function() {
		$(icon).removeClass('visible11')
	}, sec)
}

function callBackF(btn) {
	$(btn).on('click', function() {
		$('.call-back-box').show();
		$('.modal2f').show();
	});
}

function callBackFClose(btn) {
	$(btn).on('click', function() {
		$('.call-back-box').hide();
		$('.modal2f').hide();
	});
}

function hidePageScroll( status ) {
  if ( status == true ) {
    $( 'html' ).css( 'overflow-x', 'hidden' );
  } else {
    $( 'html' ).css( 'overflow-x', 'auto' );
  }
}
