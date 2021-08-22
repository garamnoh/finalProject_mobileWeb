const path = $('#path').val();

// 체크 상태 변경
    /* 전체 동의 */ const completeAgreement = $('#checkContainer #completeAgreement');
    /* 체크 아이콘 */ const checkIcon = $('#checkContainer img.checkIcon');
    /* 체크 버튼 */ const checkEach = $('#checkContainer .checkEach');
    /* 다음 버튼 */ const enrollButton = $('#buttonContainer #enrollButton');
    /* 취소 버튼 */ const cancelButton = $('#container #cancel');

// 전체 동의 체크박스
$(completeAgreement).on('click', (e)=>{
    if($(e.target).is(':checked')) {
        $(checkIcon).addClass('checked');
        $(checkEach).prop('checked', true);
    } else {
        $(checkIcon).removeClass('checked');
        $(checkEach).prop('checked', false);
    }

    // 다음 버튼 on / off
    if($('.requiredAgreement:checked').length == 2) {
    	$(enrollButton).addClass('checked');
    	$('#enrollButton>span').addClass('checked');
    } else {
    	$(enrollButton).removeClass('checked');
    	$('#enrollButton>span').removeClass('checked');    
    }
});

// 체크 버튼 작동
$('.checkEach').on('click', (e)=>{
    if($(e.target).is(':checked')) $(e.target).next().children().addClass('checked');
    else $(e.target).next().children().removeClass('checked');
    console.log($('.checkEach:checked').length);

    // 전체 동의 버튼 on / off
    if($('.checkEach:checked').length < 3) {
        $(completeAgreement).prop('checked', false);
        $(completeAgreement).next().children().removeClass('checked');
    }

    // 다음 버튼 on / off
    if($('.requiredAgreement:checked').length == 2) {
    	$(enrollButton).addClass('checked');
    	$('#enrollButton>span').addClass('checked');
    } else {
    	$(enrollButton).removeClass('checked');
    	$('#enrollButton>span').removeClass('checked'); 
    }
});

// 다음 버튼
$(enrollButton).on('click', (e)=>{
    if($(e.target).is('.checked')) location.assign(path + '/enroll/enrollInfoPage.do');
    else alert('필수 동의에 체크해주세요.');
});

// 취소 버튼(X)
$(cancelButton).on('click', (e)=>{
	location.replace(path + '/');
});