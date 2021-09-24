/* js_header */
const path = $('#path').val();

$(document).ready(function(){
	checkShoppingCart();
	checkNotification();
});

// 장바구니 내역 확인
function checkShoppingCart() {
	$.ajax({
		url: path + '/order/checkShoppingCart.do',
		success: (data)=>{
			if(data > 0) $('#shoppingAlert').show();
			else $('#shoppingAlert').hide();
		}
	});
}

// 알람 확인
function checkNotification() {
	$.ajax({
		url: path + '/notification/checkNotification.do',
		success: (data)=>{
			console.log(data);
			if(data > 0) $('#notificationAlert').show();
			else $('#notificationAlert').hide();
		}
	});
}


// 장바구니로 이동
$('#shopping').on('click', ()=>{
	location.assign(path + '/order/cart/moveToShoppingCart.do');
});
$('#shoppingAlert').on('click', ()=>{
	location.assign(path + '/order/cart/moveToShoppingCart.do');
});

// WebSocket 메시지가 오면 알림 버튼 표시
sock.onmessage = (e)=>{
	var messageArr = e.data.split(',');
	var recipient = messageArr[0];
	var title = messageArr[1];
	var content = messageArr[2];
	var date = messageArr[3];
	var productName = messageArr[4];
	var orderNo = messageArr[5];
	
	$('#notificationAlert').show();
	$('#slideUpNoti #notiOrderNo').val(orderNo);
	$('#slideUpNoti #slideUpNotiRecipient').html(recipient + '님');
	$('#slideUpNoti #slideUpNotiTitle').html("[" + productName + "] " + title);
	$('#slideUpNoti #slideUpNotiContent').html(content);
	$('#slideUpNoti #slideUpNotiDate').html(date);
	$('#slideUpNoti').slideDown();
	$('#notificationAlert').show();
}


// Notification 상자 slideDown
$('#closeSlideUpNoti').on('click', ()=>{
	var notiOrderNo = $('notiOrderNo').val();

	$('#slideUpNoti').slideUp();
	$('#notificationAlert').hide();
	
	$.ajax({
		url: path + '/notification/changeConfirmationStatus.do',
		data: { 'orderNo': notiOrderNo },
		success: (data)=>{
			$('#notificationAlert').hide();
		}
	});
});



// Notification 버튼
$('#notificationAlert').on('click', ()=>{
	$('#modalBackgroundNoti').show();
	
	// 알람 목록 출력
	$.ajax({
		url: path + '/notification/getNotificationList.do',
		success: (data)=>{
			$('#modalContentContainerNoti').html('');
			$('#modalContentContainerNoti').append(data);
			
			// notification table 확인
			$.ajax({
				url: path + '/notification/changeConfirmationStatus.do',
				success: (data)=>{
					$('#notificationAlert').hide();
				}
			});
		}
	});
});
$('#closeModalNoti').on('click', ()=>{
	$('#modalBackgroundNoti').hide();
});
