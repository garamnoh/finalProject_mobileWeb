const path = $('#path').val();

// 사업자 로그인 전환
$('#memberType').on('click', ()=>{
	var businessMember = $('#memberType').is(':checked');
	if(businessMember) {
		$('#id').val('S0014');
		$('#password').val('pass_s0014');
		$('#loginButton').hide();
		$('#businessMemberLoginButton').show();
	} else {
		$('#loginButton').show();
		$('#businessMemberLoginButton').hide();
	}
});

// 개인 회원 로그인
$('#loginButton').on('click', ()=>{
	var id = $('#id').val();
	var password = $('#password').val();
	
	$.ajax({
		url: path + '/pc/member/login.do',
		type: 'POST',
		data: {
			'id': id,
			'password': password		
		},
		success: (data)=>{
			if(data) location.replace(path + '/');
			else alert("로그인 정보를 확인해주세요");
		}
	});
});

// 사업자 회원 로그인
$('#businessMemberLoginButton').on('click', ()=>{
	var id = $('#id').val();
	var password = $('#password').val();
	
	$.ajax({
		url: path + '/pc/member/businessMemberLogin.do',
		type: 'POST',
		data: {
			'storeId': id,
			'password': password
		},
		success: (data)=>{
			if(data) location.replace(path + '/');
			else alert("로그인 정보를 확인해주세요");
		}
	});
});