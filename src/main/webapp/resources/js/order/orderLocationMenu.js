// 스토어 버튼 클릭 -> orderFooter에 반영
$('#searchResultContainer .resultBox').on('click', (e)=>{
	var store;
	if($(e.target).attr('class') == 'resultBox') store = $(e.target).find('.title').html();
	else store = $(e.target).parents('.resultBox').find('.title').html();
	$.ajax({
		url: path + '/store/storeInfo.do',
		data: {'store': store},
		success: (data)=>{
			$('#locationText').html(data['storeName']);
		}
	});
});