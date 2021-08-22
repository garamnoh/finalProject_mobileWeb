// 매장찾기 버튼 클릭
$('#searchLocation').on('click', (e)=>{
	location.assign(path + '/store/orderLocation.do');
});

$(document).ready(function(){
	$.ajax({
		url: path + '/order/checkShoppingCart.do',
		success: (data)=>{
			$('#basketCount').html(data);
		}
	});
});

// 장바구니로 이동
$('#basket').on('click', ()=>{
	location.assign(path + '/order/cart/moveToShoppingCart.do');
});