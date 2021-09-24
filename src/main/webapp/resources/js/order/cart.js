/* js_장바구니 */
// 메뉴 삭제
$('#cartContainer>#cartList>#deleteCartList').on('click', (e)=>{
	var cartSeq = $(e.target).parent().prev().val();
	location.replace(path + '/order/cart/deleteCartList.do?cartSeq=' + cartSeq);
});

// 수량 변경
$('#cartContainer #cartQuantityBox>img').on('click', (e)=>{
	var quantityButton = $(e.target).attr('id');
	var quantity = $(e.target).siblings('#cartProductQuantity').html();
	var cartSeq = $(e.target).parent().parent().prev().prev().val();
	console.log(cartSeq);
	
	if(quantityButton == 'cartRemoveQuantity') {
		if(quantity > 1) {
			quantity--;
			if(quantity == 1) $(e.target).attr('style', 'opacity: .5;');
			$(e.target).siblings('#cartProductQuantity').html(quantity);
			location.replace(path + '/order/cart/changeQuantity.do?cartSeq='+cartSeq+'&productQuantity='+quantity);
		}
	} else if(quantityButton == 'cartAddQuantity') {
		quantity++;
		if(quantity > 1) $(e.target).siblings('img').attr('style', 'opacity: 1;');
		$(e.target).siblings('#cartProductQuantity').html(quantity);
		location.replace(path + '/order/cart/changeQuantity.do?cartSeq='+cartSeq+'&productQuantity='+quantity);
	}
});