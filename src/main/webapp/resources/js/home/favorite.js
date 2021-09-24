/* js_메뉴 즐겨찾기 */
// 메뉴 상세정보 보기
$('#favoriteScrollBox #favoriteProduct').on('click', (e)=>{
	var productId;

	if($(e.target).attr('id')=='favoriteProduct') productId = $(e.target).find('#productId').val();
	else productId = $(e.target).parent('#favoriteProduct').find('#productId').val();

	console.log(productId);
	
	location.assign(path + '/order/orderDetail.do?productId=' + productId);
});