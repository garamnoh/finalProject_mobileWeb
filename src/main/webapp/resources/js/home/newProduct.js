/* js_새로나온 메뉴 */
// 메뉴 상세정보 보기
$('#scrollBox #newProduct').on('click', (e)=>{
	var productId;

	if($(e.target).attr('id')=='newProduct') productId = $(e.target).find('#productId').val();
	else productId = $(e.target).parent('#newProduct').find('#productId').val();

	console.log(productId);
	
	location.assign(path + '/order/orderDetail.do?productId=' + productId);
});