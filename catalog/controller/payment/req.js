
// Пробовать первой
(function() {
	var location = window.location.href;
	if(location === "http://lotto-sport.com.ua/index.php?route=payment/kaznachey/pay") {
		$('#quick_form').find('.close').on('click', function(e) {
			e.preventDefault()
			window.history.back();
		});
})()


// Если не сработает - то же самое, но с задержкой 
(function() {
	var location = window.location.href;
	if(location === "http://lotto-sport.com.ua/index.php?route=payment/kaznachey/pay") {
		setTimeout(function() {
			$('#quick_form').find('.close').on('click', function(e) {
				e.preventDefault()
				window.history.back();
			});
		},1000)
})()	
			
