// 충전 금액 선택
$('#chargingBox>div').children().on('click', (e)=>{
	var chargingPrice = $(e.target).attr('id');
	
	switch(chargingPrice){
		case "one": $('#chargingPriceTemp').val("10000"); break;
		case "three": $('#chargingPriceTemp').val("30000"); break;
		case "five": $('#chargingPriceTemp').val("50000"); break;
		case "seven": $('#chargingPriceTemp').val("70000"); break;
		case "nine": $('#chargingPriceTemp').val("90000"); break;
	}
	
	// 버튼 비활성화
	if(chargingPrice != 'otherPrice') {
		$('div.chargingBoxClass').attr('style', 'background-color:#ffffff;');
		$('div.chargingBoxClass').children().attr('style', 'color:#000000;');	
	}
	// 버튼 활성화
	$('div#'+chargingPrice).attr('style', 'background-color:#00704A;');
	$('span#'+chargingPrice).attr('style', 'color:#ffffff;');
	
	// 다른 금액 눌렀을 떄 입력 창 출력
	if(chargingPrice == 'one'
		 || chargingPrice == 'three'
		 || chargingPrice == 'five'
		 || chargingPrice == 'seven'
		 || chargingPrice == 'nine') {
		$('#otherPrice').hide();
		$('#otherPrice').val('');
		var price = priceFormat($('#chargingPriceTemp').val());
		$('#price').html(price + '원');
	} 
	else {
		$('#otherPrice').show();
		$('#otherPrice').focus();
	}
	
	// 총 결제 예상 금액 출력
	var totalChargingPrice = $('#myCardBalance').val() * 1 + $('#chargingPriceTemp').val() * 1;
	$('#totalChargingPrice').val(totalChargingPrice);
	$('#paymentPrice').html(priceFormat(totalChargingPrice) + '원');
});

// 다른 금액 선택 및 입력 (2가지)
// enter key
$('#otherPrice').on('keyup', (e)=>{
	var price = $('#otherPrice').val();
	if(e.keyCode == 13) {
		if(price == '' || price == 0) {
			$('#chargingPriceTemp').val(0);
			$('#otherPrice').val('');
			$('#price').html('');
		} else if(price >= 0) {
			$('#chargingPriceTemp').val(price);
			$('#price').html(priceFormat(price) + '원');
		} else {
			alert('다시 입력하세요');
			$('#otherPrice').val('');
			$('#otherPrice').focus();
		}
	}
	
	// 총 결제 예상 금액 출력
	var totalChargingPrice = $('#myCardBalance').val() * 1 + $('#chargingPriceTemp').val() * 1;
	$('#totalChargingPrice').val(totalChargingPrice);
	$('#paymentPrice').html(priceFormat(totalChargingPrice) + '원');
});

// blur
$('#otherPrice').on('focusout', (e)=>{
	var price = $('#otherPrice').val();

	if(price == '' || price == 0) {
		$('#chargingPriceTemp').val(0);
		$('#otherPrice').val('');
		$('#price').html('');
	} else if(price >= 0) {
		$('#chargingPriceTemp').val(price);
		$('#price').html(priceFormat(price) + '원');
	} else {
		alert('다시 입력하세요');
		$('#otherPrice').val('');
		$('#otherPrice').focus();
	}
	
	// 총 결제 예상 금액 출력
	var totalChargingPrice = $('#myCardBalance').val() * 1 + $('#chargingPriceTemp').val() * 1;
	$('#totalChargingPrice').val(totalChargingPrice);
	$('#paymentPrice').html(priceFormat(totalChargingPrice) + '원');
});

// function: 숫자 -> 가격 형식으로 변환
function priceFormat(number) {
	return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


//////////////////////////////////////////////////////////////////////////////////////////
// 결제 수단 및 결제
//////////////////////////////////////////////////////////////////////////////////////////
var IMP = window.IMP;

// 결제 수단 선택
$('#paymentType input[type=radio]').on('click', (e)=>{
	var radio = $(e.target).attr('id');

	switch(radio) {
		// 결제수단이 신용카드인 경우
		case 'credit':
				IMP.init('imp61858657');
				$('#paymentButton>span').html('신용카드');
				$('#paymentButton>span').attr('style', 'color:#ffffff;');
				$('#paymentButton').attr('style', 'background-color:#00704A;');
				break;
		// 결제수단이 간편결제인 경우
		case 'simple':
				$('#paymentButton>span').html('Kakao Pay');
				$('#paymentButton>span').attr('style', 'color:#181600;');
				$('#paymentButton').attr('style', 'background-color:#fee500;');
				break;
	}
});


// 결제버튼
$('#paymentButton').on('click', (e)=>{
	var chargingPrice = $('#chargingPriceTemp').val();
	var balanceAfterCharging = $('#totalChargingPrice').val();
	var name = 'STARBUCKS CARD ' + priceFormat(chargingPrice);
	
	var userName = $('#userName').val();
	var userPhone = $('#userPhone').val();
	var userEmail = $('#userEmail').val();
	
	var paymentType = $('input[name="paymentType"]:checked').attr('id');
	
	
	///////////////////////////////////////////////////////////////////////
	// merchantUid 생성
	///////////////////////////////////////////////////////////////////////
	var today = new Date();   

	var year = today.getFullYear();
	var month = ('0' + (today.getMonth() + 1)).slice(-2);
	var day = ('0' + today.getDate()).slice(-2);

	var hours = ('0' + today.getHours()).slice(-2); 
	var minutes = ('0' + today.getMinutes()).slice(-2);
	var seconds = ('0' + today.getSeconds()).slice(-2);
	
	var userNo = userPhone.slice(-4);
	
	var merchantUid = year + '-' + month + day + '-' + hours + minutes + seconds +'-' + userNo;
	///////////////////////////////////////////////////////////////////////

	
	if(chargingPrice != '') {
		switch(paymentType) {
			// 신용카드
			case 'credit':
				    if(/Android|WebOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)){
				    	console.log('mobile');
						IMP.request_pay({
						    pg: "html5_inicis",
						    pay_method: "card",
						    merchant_uid: merchantUid,
						    name: name,
						    amount: chargingPrice,
						    buyer_email: userEmail,
						    buyer_name: userName,
						    buyer_tel: userPhone,
				    		m_redirect_url: 'http://rclass.iptime.org:9999/21PM_STARBUCKS_final/pay/chargingByCreditFromMobile.do?price='+chargingPrice
					    });
				    } else {
						IMP.request_pay({
							    pg: "html5_inicis",
							    pay_method: "card",
							    merchant_uid: merchantUid,
							    name: name,
							    amount: chargingPrice,
							    buyer_email: userEmail,
							    buyer_name: userName,
							    buyer_tel: userPhone,
						    },
						    function (rsp) {
						    	if (rsp.success) {
									// 결제 성공 시 로직
									console.log('success');
									$.ajax({
										url: path + '/pay/chargingByCredit.do',
										method: 'POST',
										data: {
											'imp_uid': rsp.imp_uid,
											'merchant_uid': rsp.merchant_uid,
											'price': chargingPrice,
											'finalBalance': balanceAfterCharging
										}
									}).done((data)=>{
									  	console.log(data);
									  	var button = "pay";
									  	if(data == true) location.replace(path + '/navigation/' + button + '.do');
									  	else {
									  		// 카드 결제 취소 로직
									  		console.log(data);
									  		location.replace(path + '/pay/moveToChargingPage.do');
									  	}
									});
					    		} else {
						          // 결제 실패 시 로직,
						          console.log('fail');
						          alert(rsp.error_msg);
								}
					   		});
				    }
					break;
			// 카카오페이
			case 'simple':
					
					break;
		}
	}
});
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////