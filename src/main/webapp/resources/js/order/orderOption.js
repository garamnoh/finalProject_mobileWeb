/* js_주문화면 메뉴 상세정보 */
// 메뉴 상세정보 보기
$('#menuOption>.menuList').on('click', (e)=>{
	var productId;
	if($(e.target).attr('class')=='menuList') productId = $(e.target).find('#productId').val();
	else if($(e.target).attr('class')=='menuImg' || $(e.target).attr('class')=='menuText') productId = $(e.target).parent('.menuList').find('#productId').val();
	else productId = $(e.target).parent().parent('.menuList').find('#productId').val();
	
	// 상품 아이디 -> 상세정보 요청
	location.assign(path + '/order/orderDetail.do?productId=' + productId);
});