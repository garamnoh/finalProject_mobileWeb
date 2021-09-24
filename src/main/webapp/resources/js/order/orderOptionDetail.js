/* js_주문화면 메뉴 상세옵션 설정 */
// 수량 버튼
$('#amountContainer>img').on('click', (e)=>{
	var countButton = $(e.target).attr('id');
	
	var quantity = $('#productQuantity').val() * 1;
	var shot = $('#productShotQuantity').val() * 1;
	var size = $('#productSize').val();
	
	switch(countButton){
		case 'minusImg': 
						if(quantity > 1){
							// 버튼 누르면 수량 감소
							quantity--;
							
							// 수량이 1이 되면 버튼 비활성화
							if(quantity == 1) $(e.target).attr('style', 'opacity: .5');
							else $(e.target).attr('style', 'opacity: 1');
							
							// 화면에 표시되는 수량 변경
							$('#count>span').html(quantity);
							// 총 결제 금액 표시
							var productPrice = $('#productPrice').val() * 1;
							var totalPrice = quantity * productPrice;
							
							// 사이즈에 따른 추가 금액 적용
							if(size=='tall' || size=='none') totalPrice = totalPrice;
							else if(size=='grande') totalPrice = totalPrice + (500 * quantity);
							else totalPrice = totalPrice + (1000 * quantity);
							
							// 샷추가에 따른 금액 적용
							totalPrice = totalPrice + ((shot * 500) * quantity);

							$('#totalPrice').val(totalPrice);
							
							totalPrice = priceFormat(totalPrice);
							$('#priceInfoContainer>#price>span').html(totalPrice + " 원");
							
							// productQuantity에 값 저장
							$('#productQuantity').val(quantity);
						}
						break;
		case 'plusImg':
						// 수량 증가
						quantity++;
						// minus 버튼 활성화
						if(quantity == 2) $('#minusImg').attr('style', 'opacity: 1');
						
						// 화면에 표시되는 수량 변경
						$('#count>span').html(quantity);
						// 총 결제 금액 표시
						var productPrice = $('#productPrice').val();
						var totalPrice = quantity * productPrice;
						
						// 사이즈에 따른 추가 금액 적용
						if(size=='tall' || size=='none') totalPrice = totalPrice;
						else if(size=='grande') totalPrice = totalPrice + (500 * quantity);
						else totalPrice = totalPrice + (1000 * quantity);
						
						// 샷추가에 따른 금액 적용
						totalPrice = totalPrice + ((shot * 500) * quantity);

						$('#totalPrice').val(totalPrice);
						
						totalPrice = priceFormat(totalPrice);
						$('#priceInfoContainer>#price>span').html(totalPrice + " 원");
						
						// productQuantity에 값 저장
						$('#productQuantity').val(quantity);
						
						break;
	}
});


// 옵션이 있는 경우 옵션 값 입력 (HOT / ICED)
$('#option>div').on('click', (e)=>{
	var option = $(e.target).attr('id');
	
	if(option == 'hot') {
		$(e.target).attr('style', 'border:1px solid #BB4C41; background-color:#BB4C41; color:#ffffff;');
		$(e.target).siblings().attr('style', 'border:#dddcdc 1px solid; background-color:#ffffff; color:#dddcdc');
	} else {
		$(e.target).attr('style', 'border:1px solid #3274F6; background-color:#3274F6; color:#ffffff;');
		$(e.target).siblings().attr('style', 'border:#dddcdc 1px solid; background-color:#ffffff; color:#dddcdc');
	}
	$('#productOption').val(option);
});


// 음료 사이즈 선택 (TALL / GRANDE / VENTI)
$('#size>.sizeBox').on('click', (e)=>{
	var size;
	if($(e.target).attr('class')=='sizeBox') size = $(e.target).attr('id');
	else size = $(e.target).parent('.sizeBox').attr('id');

	// 박스
	$('#'+size).attr('style', 'border:2px #00704A solid;');
	$('#'+size).siblings().attr('style', 'border:1px  #dddcdc solid;');
	// 이미지
	$('#'+size+'>img').attr('style', 'opacity:.7;');
	$('#'+size+'>img').parent().siblings().find('img').attr('style', 'opacity:.2;');
	// 글자
	$('#'+size+'>span').attr('style', 'opacity:1;');
	$('#'+size+'>span').parent().siblings().find('span').attr('style', 'opacity:.2');

	var totalPrice;
	var productPrice = $('#productPrice').val() * 1;
	var quantity = $('#productQuantity').val() * 1;
	
	if(size == 'tall' || size=='none') totalPrice = productPrice * quantity;
	else if(size == 'grande') totalPrice = (500 + productPrice) * quantity;
	else totalPrice = (1000 + productPrice) * quantity;
	
	var shot = $('#productShotQuantity').val() * 1;
	totalPrice = totalPrice + (shot * 500) * quantity;
	
	$('#totalPrice').val(totalPrice);
	
	totalPrice = priceFormat(totalPrice);
	$('#priceInfoContainer>#price>span').html(totalPrice + " 원");	

	// 선택된 사이즈 정보 저장	
	$('#productSize').val(size);
});


// EXTRA SHOT (ESPRESSO 카테고리만)
$('#shot').on('click', (e)=>{
	var shot = $('#shotQuantity').html() * 1;
	var shotButton = $(e.target).attr('id');
	
	var size = $('#productSize').val();
	var quantity = $('#productQuantity').val() * 1;
	var productPrice = $('#productPrice').val() * 1;
	
	switch(shotButton){
		case 'removeShot': 
						if(shot > 0){
							// 버튼 누르면 수량 감소
							shot--;
							
							// 수량이 1이 되면 버튼 비활성화
							if(shot == 0) $(e.target).attr('style', 'opacity: .5');
							else $(e.target).attr('style', 'opacity: 1');
							
							// 화면에 표시되는 수량 변경
							$('#shot>span').html(shot);
							
							// 총 결제 금액 표시
							var totalPrice;
							
							if(size == 'tall' || size=='none') totalPrice = productPrice * quantity;
							else if(size == 'grande') totalPrice = (500 + productPrice) * quantity;
							else totalPrice = (1000 + productPrice) * quantity;
							
							totalPrice = totalPrice + (shot * 500) * quantity;

							$('#totalPrice').val(totalPrice);
							
							totalPrice = priceFormat(totalPrice);
							$('#priceInfoContainer>#price>span').html(totalPrice + " 원");
							
							// productShotQuantity에 값 저장
							$('#productShotQuantity').val(shot);
						}
						break;
		case 'addShot':
						// 수량 증가
						shot++;
						// minus 버튼 활성화
						if(shot == 1) $('#removeShot').attr('style', 'opacity: 1');
						
						// 화면에 표시되는 수량 변경
						$('#shot>span').html(shot);
						
						// 총 결제 금액 표시
						var totalPrice;
						
						if(size == 'tall' || size=='none') totalPrice = productPrice * quantity;
						else if(size == 'grande') totalPrice = (500 + productPrice) * quantity;
						else totalPrice = (1000 + productPrice) * quantity;
						
						totalPrice = totalPrice + (shot * 500) * quantity;
							
						$('#totalPrice').val(totalPrice);
						
						totalPrice = priceFormat(totalPrice);
						$('#priceInfoContainer>#price>span').html(totalPrice + " 원");
						
						// productShotQuantity에 값 저장
						$('#productShotQuantity').val(shot);
						
						break;
	}
});


// function: 숫자 -> 가격 형식으로 변환
function priceFormat(number) {
	return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// favorite 등록 및 삭제
$('#orderButtonsContainer>img').on('click', (e)=>{
	var productId = $('#productId').val();
	
	// 버튼 모양 변경
	var button = $(e.target).attr('id');
	if(button == 'likeButton') {
		$(e.target).attr('src', path + '/resources/image/icon/icon_like_outline.png');
		$(e.target).attr('id', 'unlikeButton');
		$.ajax({
			url: path + '/favorite/removeFromFavoriteList.do',
			data: {'productId': productId},
			success: (data)=>{
				console.log("success");
			}
		});
	} else {
		$(e.target).attr('src', path + '/resources/image/icon/icon_like_filled.png');
		$(e.target).attr('id', 'likeButton');
		$.ajax({
			url: path + '/favorite/addToFavoriteList.do',
			data: {'productId': productId},
			success: (data)=>{
				console.log(data);
				console.log("success");
			}
		});
	}
});


// 담기 버튼
$('#basketButton').on('click', ()=>{
	// 변수
	var productName = $('#productName').val();
	var productImg = $('#productImg').val();
	var productPrice = $('#productPrice').val();
	var productQuantity = $('#productQuantity').val();
	var productShotQuantity = $('#productShotQuantity').val();
	var productSize = $('#productSize').val();
	var productOption = $('#productOption').val();
	var category = $('#category').val();
	
	if(productOption=='none' || productOption=='hot' || productOption=='iced') {
		$.ajax({
			url: path + '/order/addToShoppingCart.do',
			type: 'POST',
			data: {
				'productName': productName,
				'productImg': productImg,
				'productPrice': productPrice,
				'productQuantity': productQuantity,
				'extraShot': productShotQuantity,
				'productSize': productSize,
				'productOption': productOption,
				'category': category
			},
			success: (data)=>{
				if(data > 0){
					alert('장바구니에 추가됨');
					$('#shoppingAlert').show();
				}
			}
		});
	} else {
		alert('옵션을 선택해 주세요');
	}
});