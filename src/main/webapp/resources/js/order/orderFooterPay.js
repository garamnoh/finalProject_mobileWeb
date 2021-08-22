$(document).ready(function(){
	finalOrder();
});

// 총 수량 및 금액 표기
// function
function finalOrder(){
	var totalQuantity = 0;
	var totalPrice = 0;
	var price = 0;
	$.each(cart, (i, e)=>{
		// 총 음료 수량 계산
		totalQuantity += (e.quantity * 1);
		
		// 음료 사이즈별 가격 변경
		if(e.size == "tall" || e.size=="none") price = e.price * 1;
		else if(e.size == "grande") price = e.price * 1 + 500;
		else price = e.price * 1 + 1000;
		
		// 음료 수량 별 가격 저장
		price = (price + (e.extraShot * 500)) * e.quantity;
		
		// 총 음료 가격 저장
		totalPrice += price;
	});
	
	// 총 수량
	$('#totalQuantity').val(totalQuantity);
	
	// 가격 형식 변환
	totalPrice = priceFormat(totalPrice);
	
	$('#totalQuantity>span').html(totalQuantity);
	$('#totalPriceDiv').html(totalPrice+'원');
	$('#totalPrice').val(totalPrice + '원');
}

// function: 숫자 -> 가격 형식으로 변환
function priceFormat(number) {
	return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// 주문하기 버튼
$('#finalOrder').on('click', (e)=>{
	var selectedStore = $('#selectedStore').val();
	if(selectedStore == '') alert('매장을 선택해 주세요');
	else $('#finalOrderButtonContainer').submit();	
});