<?php 
$simple_page = '';
include $simple->tpl_header();
include $simple->tpl_static();
?>

    <div class="content text-center style_text_info">
        <p>У Вас в корзине нет товаров</p>
        <p>Выбрать новые?</p>
    </div>
    <div class="simplecheckout-button-block buttons">
        <div class="button">
            <a href="/rasprodaza">
                <span>Товары из распродажи</span>
            </a>
        </div>
        <div class="button">
            <a href="<?php echo $continue; ?>">
                <span>На главную страницу</span>
            </a>
        </div>
    </div>

<?php include $simple->tpl_footer() ?>