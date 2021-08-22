const path = $('#path').val();

// 로그인 페이지 이동
$('#signIn').on('click', ()=>{
	location.assign(path + '/pc/member/loginPage.do');
});

// 로그아웃
$('#signOut').on('click', ()=>{
	location.replace(path + '/pc/member/logout.do');
});




///////////////////////////////////////////////////////////////////////////////////////////////////////
// 사업자 회원 화면
///////////////////////////////////////////////////////////////////////////////////////////////////////
$(document).ready(function(){
	var isBusinessMember = $('#isBusinessMember').val();

	// 사업자 로그인을 한경우
	if( !isBusinessMember == false ){
		$.ajax({
			url: path + '/pc/business/getOrderList.do',
			success: (data)=>{
				$('#businessListContainer').html('');
				$('#businessListContainer').append(data);
			}
		});
	}
});

// 주문버튼
$('#orderListButton').on('click', ()=>{
	location.replace(path + '/');
});

// 완료버튼