// 카드 선택
$('#myCardInfoContainer #cardImg').on('click', (e)=>{
	var cardSeq = $(e.target).prev().val();
	
	location.replace(path + '/pay/selectCard.do?cardSeq=' + cardSeq);
});

// 충전 내역 확인
$('#myCardInfoContainer #chargingHistorySearchingBox').on('click', (e)=>{
	// 카드 seq 값 확인
	var cardSeqValue = $(e.target).parents('#myCardInfo').find('#cardSeqValue').val();
	
	// 카드 충전 내역 확인 페이지로 이동
	location.assign(path + '/pay/chargingHistory.do?cardSeq=' + cardSeqValue);
});