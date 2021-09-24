/* js_주문화면 메뉴 음료 상세 */
$('.menuList').on('click', (e)=>{
	var menu;
	if($(e.target).attr('class')=='menuList') menu = $(e.target).attr('id');
	else if($(e.target).attr('class')=='menuImg' || $(e.target).attr('class')=='menuText') menu = $(e.target).parent('.menuList').attr('id');
	else menu = $(e.target).parent().parent('.menuList').attr('id');
	
	console.log(menu);
	
	location.assign(path + '/order/orderMenuDrink.do?menuButton=drink&menu='+ menu);
});