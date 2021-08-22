// 자동실행 - 주문번호 리스트 표시
$(document).ready(function(){
	$('#businessListContainer #orderNo').trigger('click');
});

// 주문번호 클릭이벤트 -> 리스트 표시 (위에서 자동으로 실행)
$('#businessListContainer #orderNo').on('click', (e)=>{
	var orderNo = $(e.target).parent().prev().val();
	
	$.ajax({
		url: path + '/pc/business/getOrderDetail.do',
		data: { 'orderNo': orderNo },
		success: (data)=>{
			$(e.target).parents('#orderBox').next().children('#orderDetailResult').html('');			
			$(e.target).parents('#orderBox').next().children('#orderDetailResult').append(data);
		}
	});
});

// 완료 버튼 클릭 ( 고객 알림 및 내역 삭제 )
$('#businessListContainer #sendComplete').on('click', (e)=>{
	var recipient = $(e.target).parent().find('#paramRecipient').val();
	var orderNo = $(e.target).parent().find('#paramOrderNo').val();
	var title = '준비 완료';
	var content = '픽업대에서 메뉴를 픽업해주세요!';
	var date = new Date().toLocaleString();
	
	var productCount = $(e.target).parent().next().children('#orderDetailResult').find('#productCount').val();
	var productName = $(e.target).parent().next().children('#orderDetailResult').find('#firstProductName').val();
	if(productCount > 1) productName = productName + ' 외 ' + (productCount - 1);

	// db 등록
	$.ajax({
		url: path + '/notification/addNotification.do',
		type: 'POST',
		data: {
			'id': recipient,
			'orderNo': orderNo,
			'notificationTitle': title,
			'notificationContent': content,
			'notificationDate': date,
			'productName': productName
		},
		success: (data)=>{
			console.log(data);
			sock.send(recipient + ',' + title + ',' + content + ',' + date + ',' + productName + ',' + orderNo);
			$(e.target).parent().next().hide(500);
			$(e.target).parent().hide(500);
		}
	});
});

sock.onmessage = (e)=>{
	var messageArr = e.data.split(',');
	var recipient = messageArr[0];
	var content = messageArr[1];
	var date = messageArr[2];
	console.log(recipient);
	console.log(content);
	console.log(date);
	
	$('#notificationContent').html("[ " + date + " ] " + content);
	$('#notificationContainer').slideDown();
}

// notification 확인 버튼
$('#confirmButton').on('click', ()=>{
	location.replace(path + '/');
});