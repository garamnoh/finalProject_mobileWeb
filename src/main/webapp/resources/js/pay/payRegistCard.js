/* js_페이화면 카드 등록 */
// 카드 등록
$('#registCardInfoContainer #registCard>img').on('click', (e)=>{
	var cardId = $(e.target).prev().val();
	
	location.replace(path + '/pay/registCard.do?cardId=' + cardId);
});