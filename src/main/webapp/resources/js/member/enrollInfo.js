const path = $('#path').val();

// 아이디 확인
$('#id').on('keyup', (e)=>{
	var id = $(e.target).val();
	$.ajax({
		url: path + '/enroll/confirmIdDuplication.do',
		type: 'POST',
		data: {'id': id},
		success: (data)=>{
			if(id.length > 0){
				if(data > 0) {
					$(e.target).parent().find('.usable').hide();
					$(e.target).parent().find('.unusable').show();
					$(e.target).removeClass('checked');
				} else {
					$(e.target).parent().find('.usable').show();
					$(e.target).parent().find('.unusable').hide();
					$(e.target).addClass('checked');
				}
			}
		}
	});
	if(id.length < 1){
		$(e.target).parent().find('span').hide();
	}
});

// 핸드폰번호 확인
$('#phone').on('keyup', (e)=>{
	var phone = $(e.target).val();
	$.ajax({
		url: path + '/enroll/confirmPhoneDuplication.do',
		type: 'POST',
		data: {'phone': phone},
		success: (data)=>{
			if(phone.length >= 10){
				if(phone.length >=10 && phone.length <= 11 && data > 0) {
					$(e.target).parent().find('.usable').hide();
					$(e.target).parent().find('.unusable').show();
					$(e.target).removeClass('checked');
				} else {
					$(e.target).parent().find('.usable').show();
					$(e.target).parent().find('.unusable').hide();
					$(e.target).addClass('checked');
				}
			}
		}
	});
	if(phone.length < 10){
		$(e.target).parent().find('span').hide();
	}
});

// 이메일 확인
$('#email').on('focusout', (e)=>{
	var email = $(e.target).val();
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

	$.ajax({
		url: path + '/enroll/confirmEmailDuplication.do',
		type: 'POST',
		data: {'email': email},
		success: (data)=>{
			if(email.match(regExp) == null || data > 0){
				$(e.target).parent().find('.usable').hide();
				$(e.target).parent().find('.unusable').show();
				$(e.target).removeClass('checked');
			} else {
				$(e.target).parent().find('.usable').show();
				$(e.target).parent().find('.unusable').hide();
				$(e.target).addClass('checked');
			}
		}
	}).done(function(){
		if(email.length == 0){
			console.log("email",email.includes('@'));
			console.log($('#infoEmail span'));
			$('#infoEmail span').hide();
		}
	});
});

// 비밀번호 확인
$('#passwordCheck').on('keyup', (e)=>{
	var password = $('#password').val();
	var passwordCheck = $('#passwordCheck').val();
	
	if(passwordCheck.length > 3 && password == passwordCheck){
		$(e.target).parent().find('.usable').show();
		$(e.target).parent().find('.unusable').hide();
		$('#password').addClass('checked');
		console.log($('#password').hasClass('checked'));
	} else{
		$(e.target).parent().find('.usable').hide();
		$(e.target).parent().find('.unusable').show();
		$('#password').removeClass('checked');
	}
	if(passwordCheck.length < 4){
		$(e.target).parent().find('span').hide();
	}
});

// 회원 가입
$('#enrollButton').on('click', ()=>{
	if($('#id').hasClass('checked') == true
	   && $('#password').hasClass('checked') == true 
	   && $('#email').hasClass('checked') == true
	   && $('#phone').hasClass('checked') == true){
	   
		   $('#enrollSubmit').trigger('click');
	} else {
		alert('입력 정보를 확인해 주세요');
	}
});


/* 취소 버튼 */ const cancelButton = $('#container #cancel');
// 취소 버튼(X)
$(cancelButton).on('click', ()=>{
	location.replace(path + '/');
});


// 주소 찾기
$('#addrBox>img').on('click', ()=>{
	new daum.Postcode({
	    oncomplete: function(data) {
	        var addr = ''; // 주소 변수
	        var extraAddr = ''; // 참고항목 변수
	
	        if (data.userSelectedType === 'R') { 
	        	// 사용자가 도로명 주소를 선택했을 경우
	            addr = data.roadAddress;
	        } else { 
	        	// 사용자가 지번 주소를 선택했을 경우(J)
	            addr = data.jibunAddress;
	        }
	
	        // 우편번호와 주소 정보를 해당 필드에 넣는다.
	        document.getElementById("address").value = addr;
	    }
	}).open();
});