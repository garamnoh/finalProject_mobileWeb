const path = $('#path').val();

/* 취소 버튼 */ const cancelButton = $('#container #cancel');
// 취소 버튼(X)
$(cancelButton).on('click', (e)=>{
	location.replace(path + '/');
});

// 인증메일 보내기
$('#sendVerificationCode').on('click', ()=>{
	var id = $('#searchPasswordContainer #id').val();
	var email = $('#searchPasswordContainer #email').val();
	
	if(id.length==0 || email.length==0) {
		alert('정보를 입력해주세요.');
	} else {
		$.ajax({
			url: path + '/member/checkInfo.do',
			type: 'post',
			data: {
				'id': id,
				'email': email
			},
			success: (data)=>{
				if(data['result'] == 0) {
					$('#searchResultContainer span').text("회원정보를 다시 확인해주세요.");
					$('#searchResultContainer span').attr('style', 'color:#000000;');
					$('#searchResultContainer').attr('style', 'border:1px solid #dddcdc;');
				} else {
					$('#searchResultContainer span').text("인증번호를 입력해주세요");
					$('#searchResultContainer span').attr('style', 'color:#00704a;');
					$('#searchResultContainer').attr('style', 'border:1px solid #00704a;');
					
					$('#verificationCodeResult').on('click', ()=>{
						var verificationCode = $('#verificationCode').val();
						
						if(verificationCode == data['verificationCode']) {
							$('#before').slideUp();
							$('#after').slideDown();
							$('#searchPasswordButton').addClass('checked');
							$('#searchPasswordButton>span').addClass('checked');
							$('#searchResultContainer span').text("인증이 완료되었습니다.");
							
						} else {
							$('#searchResultContainer span').text("인증번호를 다시 확인해주세요.");
							$('#searchResultContainer span').attr('style', 'color:#000000;');
							$('#searchResultContainer').attr('style', 'border:1px solid #dddcdc;');
						}
					});
				}
			}
		});
	}
});

// 비밀번호 변경
$('#searchPasswordButton').on('click', (e)=>{
	if($(e.target).is('.checked')){
		var id = $('#searchPasswordContainer #id').val();
		var password = $('#after>#password').val();
		var passwordCheck = $('#after>#passwordCheck').val();
		
		if(password.length==0 || passwordCheck.length==0) {
			$('#searchResultContainer span').text("비밀번호를 입력해주세요.");
			$('#searchResultContainer span').attr('style', 'color:#000000;');
			$('#searchResultContainer').attr('style', 'border:1px solid #dddcdc;');
		} else if(password != passwordCheck) {
			$('#searchResultContainer span').text("비밀번호를 확인 후 다시 입력해주세요.");
			$('#searchResultContainer span').attr('style', 'color:#000000;');
			$('#searchResultContainer').attr('style', 'border:1px solid #dddcdc;');
		} else if(password == passwordCheck) {
			$.ajax({
				url: path + '/member/changePassword.do',
				data: {
					'id': id,
					'password': password
				},
				success: (data)=>{
					var result = data['result'];
					
					if(result == 1) {
						$('#searchResultContainer span').text("비밀번호 변경이 완료되었습니다.");
						$('#searchResultContainer span').attr('style', 'color:#00704a;');
						$('#searchResultContainer').attr('style', 'border:1px solid #00704a;');
					} else {
						$('#searchResultContainer span').text("비밀번호 변경에 실패했습니다.");
						$('#searchResultContainer span').attr('style', 'color:tomato;');
						$('#searchResultContainer').attr('style', 'border:1px solid tomato;');
					}
				}
			});
		}
	} else {
		alert('인증을 진행해주세요.');
	}
});