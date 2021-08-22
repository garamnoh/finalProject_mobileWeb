var checkedType = '';

// 결제 수단 라디오 버튼 클릭 -> 해당 결제 화면으로 변경
$('#paymentType [type=radio]').on('click', (e)=>{
	checkedType = $('#paymentType [type=radio]:checked').attr('id');

	switch(checkedType) {
		// 결제수단이 스타벅스 카드인 경우
		case 'starbucks':
				$('#finalPayment').html('스타벅스 카드');
				$('#finalPayment').attr('style', 'background-color:#00704A; color:#ffffff;');
				$.ajax({
					url: path + '/order/cart/paymentTypeStarbucks.do',
					success: (data)=>{
						$('#paymentTypeResultContainer').html(data);
					}
				});
				break;
		// 결제수단이 간편결제인 경우
		case 'simple':
				$('#paymentTypeResultContainer').html('');
				$('#finalPayment').html('Kakao Pay');
				$('#finalPayment').attr('style', 'background-color:#fee500; color:#181600;');
				break;
	}

	// 결제 버튼 활성화
	$('#finalPayment').addClass('activation');
});


// 결제버튼 클릭 이벤트
$('#finalPayment').on('click', (e)=>{
	var cashReceipt = $('#receiptInputBox').val();
	var productName = $('#productInfoName').html();
	if(totalQuantity > 1) productName = productName + " 외 " + (totalQuantity - 1) + "건"
	
	
	// WebSocket 관련
	var recipient = $('#recipientStoreId').val();
	var title = '-';
	var content = '새로운 주문이 들어왔습니다';
	var date = new Date().toLocaleString();
	var productName = '-';
	var orderNo = '-';
	
	// 결제 수단이 체크되어있는 경우 버튼 작동
	if($(e.target).hasClass('activation') && checkedType != '') {

		switch(checkedType) {
			// 결제수단이 스타벅스 카드인 경우
			case 'starbucks': 
					var paymentCardSeq = $('#paymentCardSeq').val();
					if(balance < totalPrice) console.log('결제 불가');
					else {
						$.ajax({
							url: path + '/order/cart/starbucksPaymentExcution.do',
							type: 'post',
							data: {
								'balance': balance,
								'totalPrice': totalPrice,
								'cashReceipt': cashReceipt,
								'cardSeq': paymentCardSeq,
							},
							success: (data)=>{
								alert("주문이 완료되었습니다");
								sock.send(recipient + ',' + title + ',' + content + ',' + date + ',' + productName + ',' + orderNo);
								if(data==true) {
									// 페이지 이동
									location.replace(path + "/");
								}
							}
						});
					}
					break;
			// 결제수단이 간편결제인 경우
			case 'simple':
				$.ajax({
					url: path + '/order/cart/simplePaymentExcution.do',
					type: 'post',
					data: {
						'totalPrice': totalPrice,
						'totalQuantity': totalQuantity,
						'productName': productName,
						'userId': userId,
						'sockMsg': sockMsg
					},
					success: (data)=>{
						window.location.href = data;
						sock.send(recipient + ',' + title + ',' + content + ',' + date + ',' + productName + ',' + orderNo);
					}
				});				
				break;
			}
		}
});