/* js_other화면 결제내역 상세정보(전자영수증) */
// 영수증
$('#historyResultContainer>#historyBox').on('click', (e)=>{
	// 모달창 open
	$('#modalBackground').show();
	
	// 영수증 상세정보
	var orderNumber;
	if($(e.target).attr('id') == 'historyBox') orderNumber = $(e.target).find('#orderNumber').val();
	else orderNumber = $(e.target).parent().find('#orderNumber').val();

	$.ajax({
		url: path + '/other/getBillInfo.do',
		type: 'post',
		data: {
			'orderNumber': orderNumber
		},
		success: (data)=>{
			$('#modalContentContainer').html(data);
		}
	});
});

// 모달창 닫음
$('#closeModal').on('click', ()=>{
	$('#modalBackground').hide();
});


// 영수증 다운로드
$('#downloadBill').on('click', ()=>{
	var fileName = $('#modalOrderNumber>span').html();
	var modal = document.querySelector("#modalBackground");

	$('#modal').addClass('html2canvas');

	domtoimage.toJpeg(modal)
	.then(function(image){
		var canvasTag = document.getElementById('canvasTag');
		canvasTag.href = image;
		canvasTag.download = fileName + '.jpg';
		canvasTag.click();
	})
	.then(function(){
		$('#modal').removeClass('html2canvas');
	});
});


/*
$('#downloadBill').on('click', ()=>{
	var fileName = $('#modalOrderNumber>span').html();
	var modal = document.querySelector("#modal");
	
	$('#modal').addClass('html2canvas');

	html2canvas(modal).then(function(image){
		var canvasTag = document.getElementById('canvasTag');
		canvasTag.href = image.toDataURL('imgae/png');
		canvasTag.download = fileName + '.png';
		canvasTag.click();
	}).then(function(){
		$('#modal').removeClass('html2canvas');
	});
});
*/