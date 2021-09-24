<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<!DOCTYPE html> 
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <meta name="author" content="garamNoh">
    
    <!-- 모바일 주소창 자동숨김 -->
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    
    <title>enroll</title>
    
    <!-- font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap">

    <!-- style -->
    <link rel="stylesheet" href="${path }/resources/css/common/reset.css">
    <link rel="stylesheet" href="${path }/resources/css/member/enroll.css">

    <!-- jQuery -->
    <script src='${path }/resources/js/common/jquery-3.6.0.min.js'></script>
</head>
<body>
	<input type='hidden' id='path' value='${path }'>
    <!-- 전체 컨테이너 -->
    <div id="container">
        <!-- 취소 버튼 -->
        <div id="cancel">
            <img src="${path }/resources/image/icon/icon_cancel.png" alt="">
        </div>
        
        <!-- 로고 컨테이너 -->
        <div id='logoContainer'>
            <img src="${path }/resources/image/logo/logo.png" alt="">
            <div id="logoText">
                <span>고객님</span>
                <span>환영합니다.</span>
                <span>회원 가입을 위해서 아래 약관에 동의해 주세요.</span>
            </div>    
        </div>

        <!-- 가입 동의 컨테이너 -->
        <div id="checkContainer">
            <div class="checkBox" id='checkAll'>
                <div class="checkText">
                    <span>약관 전체 동의</span>
                </div>
                <input type="checkBox" id='completeAgreement'>
                <label for="completeAgreement">
                    <img src="${path }/resources/image/icon/icon_check.png" alt="" class="checkIcon">
                </label>
            </div>

            <!-- line -->
            <div class="line"></div>

            <div class="checkBox">
                <div class="checkText">
                    <span>이용약관 동의(필수)</span>
                </div>
                <input type="checkBox" id='requiredAgreement1' class='checkEach requiredAgreement'>
                <label for="requiredAgreement1">
                    <img src="${path }/resources/image/icon/icon_check.png" alt="" class="checkIcon">
                </label>
            </div>
            <div class="checkBox">
                <div class="checkText">
                    <span>개인정보 수집 및 이용 동의(필수)</span>
                </div>
                <input type="checkBox" id='requiredAgreement2' class='checkEach requiredAgreement'>
                <label for="requiredAgreement2">
                    <img src="${path }/resources/image/icon/icon_check.png" alt="" class="checkIcon">
                </label>
            </div>
            <div class="checkBox">
                <div class="checkText">
                    <span>E-mail 및 SMS 광고성 정보 수신 동의(선택)</span>
                    <span id='subText'>다양한 프로모션 소식 및 신규 매장 정보를 보내 드립니다.</span>
                </div>
                <input type="checkBox" id='agreement' class='checkEach'>
                <label for="agreement">
                    <img src="${path }/resources/image/icon/icon_check.png" alt="" class="checkIcon">
                </label>
            </div>
        </div>

        <!-- 버튼 컨테이너 -->
        <div id="buttonContainer">
            <div id="enrollButton">
                <span>다음</span>
            </div>
        </div>
    </div>
    <script src='${path }/resources/js/member/enroll.js'></script>
</body>
</html>