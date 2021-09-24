/* js_아이디 찾기 */
const path = $('#path').val();

/* 취소 버튼 */ const cancelButton = $('#container #cancel');
// 취소 버튼(X)
$(cancelButton).on('click', (e)=>{
	location.replace(path + '/');
});

// 아이디 찾기
$('#searchIdButton').on('click', ()=>{
	// input parameter
	var name = $('#searchIdContainer>#name').val();
	var idNo = $('#searchIdContainer>#idNo').val();
	var phone = $('#searchIdContainer>#phone').val();
	
	if(name.length==0 || idNo.length==0 || phone.length==0){
		alert('정보를 입력해 주세요');
	} else {
		$.ajax({
			url: path + '/member/searchId.do',
			type: 'post',
			data: {
				'name': name,
				'idNo': idNo,
				'phone' : phone
			},
			success: (data)=>{
				if(data['result']==1){
					$('#searchResultContainer span').text(data['resultId']);
					$('#searchResultContainer span').attr('style', 'color:#00704a;');
					$('#searchResultContainer').attr('style', 'border:1px solid #00704a;');
				} else{
					$('#searchResultContainer span').text('회원 정보가 없습니다.');
					$('#searchResultContainer span').attr('style', 'color:#000000;');
					$('#searchResultContainer').attr('style', 'border:1px solid #dddcdc;');
				}
			}
		});
	}
});