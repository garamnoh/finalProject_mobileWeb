/* js_other화면 */
// 로그아웃
$('#logoutButton').on('click', ()=>{
	location.replace(path + '/member/logout.do');
});

// 회원탈퇴
$('#deleteAccountButton').on('click', ()=>{
	if(confirm("회원탈퇴를 하시겠습니까?")) {
		location.replace(path + '/member/deleteMember.do');
	}
});

// 이용 내역
$('#history').on('click', ()=>{
	location.assign(path + '/other/moveToHistoryPage.do');
});

// 별명 수정
$('#editNickname').on('click', ()=>{
	// 삭제
	$('.userNickname').hide();
	$('#editNickname').hide();
	// 생성
	$('#editBox').fadeIn(1000);
	$('#doneNickname').fadeIn(1000);
});

$('#nickname').on('keyup', (e)=>{
	var nickname = $(e.target).val();
	$.ajax({
		url: path + '/other/checkNickname.do',
		type: 'POST',
		data: {'nickname': nickname},
		success: (data)=>{
			if(nickname.length > 1){
				if(data==false) {
					$(e.target).parent().find('#ok').hide();
					$(e.target).parent().find('#no').show();
					$('#editBox').removeClass('ok');
				} else {
					$(e.target).parent().find('#ok').show();
					$(e.target).parent().find('#no').hide();
					$('#editBox').addClass('ok');
				}
			}
		}
	});
});

$('#doneNickname').on('click', ()=>{
	if($('#editBox').hasClass('ok')) {
		var nickname = $('#nickname').val();
		$.ajax({
			url: path + '/other/editNickname.do',
			type: 'POST',
			data: { 'nickname': nickname },
			success: (data)=>{
				if(data == true){
					$('.userNickname').html(nickname);
					// 삭제
					$('#editBox').hide();
					$('#doneNickname').hide();
					// 생성
					$('.userNickname').fadeIn(1000);
					$('#editNickname').fadeIn(1000);
					// input박스 초기화
					$('#nickname').val('');
					$('#ok').hide();
					$('#no').hide();
				}
			}
		});
	}
});