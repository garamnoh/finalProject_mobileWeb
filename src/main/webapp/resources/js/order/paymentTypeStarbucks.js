$(document).ready(function(){
	checkBalance();
});

// 잔액이 부족한지 확인
function checkBalance() {
	// 카드 잔액이 부족하면 화면 표시
	if(balance < totalPrice) {
		$('#isEnough').html('잔액 부족');
		new Promise(function(resolve, reject){
			if(balance < totalPrice == true) resolve(true);
		}).then(function(param){
			console.log(param);
			$('#chargingIcon').show();
		});
	}
}

// 충전 아이콘 클릭 이벤트
$('#chargingIcon').on('click', ()=>{
	location.replace(path + '/pay/moveToChargingPage.do');
});

// 현금영수증 checkbox
$('#cashReceiptContainer>#receiptCheckBox').on('click', ()=>{
	
	var phoneNumber = $('#phoneNumber').val();
	
	if($('#receiptCheckBox').prop('checked')) $('#receiptInputBox').val(phoneNumber);
	else $('#receiptInputBox').val('');
});


// 카드 등록
$('#cardBox>#imgBox').children().on('click', (e)=>{
	location.replace(path + '/pay/moveToRegistCardPage.do');
});