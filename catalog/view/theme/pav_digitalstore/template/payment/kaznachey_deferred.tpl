<?
	$OrderId = (isset($_GET['OrderId'])) ? $_GET['OrderId'] : '';
	$message = ($_GET['Result']=='inprogress')?'Платеж находится в обработке':'Вы сможете оплатить его после проверки менеджером. Ссылка на оплату будет выслана Вам по электронной почте';
	$mes = "<p class='invalid'>Ваш заказ №$OrderId <br/>
	Спасибо за Ваш заказ №$OrderId! <br/>$message.</p>";
?>
<style>
body{background-color: #527496; font: normal 13px Verdana,sans-serif;}
.message_container{background-color: #fff; width: 50%; text-align:center; margin: auto; margin-top: 100px; padding: 50px;}
.valid {color: green;}
.invalid {color: red;}
</style>

<div class='message_container'> <h4><?=$mes;?></h4>
	<input type='button' value=' Закрыть ' onCLick="location='http://<?=$_SERVER['HTTP_HOST'];?>';">
</div>