// 카드 등록 화면으로 이동
$('.cardEmpty').on('click', ()=>{
	location.assign(path + '/pay/moveToRegistCardPage.do');
});
$('#newCard').on('click', ()=>{
	location.assign(path + '/pay/moveToRegistCardPage.do');
});

// 카드 선택 화면으로 이동
$('#editCard').on('click', ()=>{
	location.assign(path +'/pay/moveToSelectCardPage.do');
});

// 충전 화면으로 이동
$('#chargeContainer').children().on('click', ()=>{
	location.assign(path + '/pay/moveToChargingPage.do');
});

// 바코드 생성
$('#generateBarcode').children().on('click', (e)=>{
	var cardNo = $('#cardNo').val();
	var fileName = $('#memberId').val();
	
	$.ajax({
		url: path + '/pay/gerateBarcode.do',
		type: 'post',
		data: {
			'cardNo': cardNo,
			'fileName': fileName,
		},
		success: (data)=>{
			$('#generateBarcode').hide();
			
			$('#barcode').show();
			$('#barcodeUsable').show();
			$('#barcodeImg').attr('src', path + "/resources/image/barcode/" + fileName + ".png");
			
			usableTime();
		}
	});
});

$(document).ready(function(){
	$('#barcode').hide();
	$('#barcodeUsable').hide();
});

// 바코드 인증 유효 시간
function usableTime(){
	var time = 15;

	setInterval(function(){
		if(time > 9) $('#usableTime').html("00:"+time);
		else $('#usableTime').html("00:0"+time);
		time--;
		
		if(time == -2) {
			$('#usableTime').html('00:00');
			$('#barcode').hide();
			$('#barcodeUsable').hide();

			$('#generateBarcode').show();
		}
	}, 1000);
}