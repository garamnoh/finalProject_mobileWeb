/* js_인덱스화면 */
const path = $('#path').val();

// 페이지 이동
$('#enrollContainer span').on('click', (e)=>{
	var value = $(e.target).attr('id');
	console.log(value);
	switch(value){
		case 'searchId' : location.assign(path + '/member/searchIdPage.do'); break;
		case 'searchPassword' : location.assign(path + '/member/searchPasswordPage.do'); break;
		case 'enroll' : location.assign(path + '/enroll/enrollPage.do'); break;
	}
});


// 로그인
$('#loginButton').on('click', ()=>{
	$('#loginSubmitButton').trigger('click');
});


// 카카오 ///////////////////////////////////////////////////////////////////
// 카카오 초기화
$(document).ready(function(){
	Kakao.init('75e6bd6ea6ef68dd35982ed190f6985b');
	console.log(Kakao.isInitialized());
});

// 카카오로그인
$('#kakaoLoginButton').on('click', ()=>{
	Kakao.Auth.authorize({
		redirectUri: 'http://rclass.iptime.org:9999/21PM_STARBUCKS_final/member/kakaoLogin.do'
	});
});
///////////////////////////////////////////////////////////////////////////

window.onpageshow = function(e){
	if(e.persisted){
		console.log('onpageshow');
		location.replace(path + "/");
	}
}