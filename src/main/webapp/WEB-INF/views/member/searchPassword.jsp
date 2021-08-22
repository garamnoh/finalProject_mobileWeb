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
    
    <title>searchPassword</title>
    
    <!-- font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap">

    <!-- style -->
    <link rel="stylesheet" href="${path }/resources/css/common/reset.css">
    <link rel="stylesheet" href="${path }/resources/css/member/searchPassword.css">

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
                <span>비밀번호 찾기</span>
                <span>서비스 입니다.</span>
                <span>아래 정보를 입력해 주세요.</span>
            </div>    
        </div>

        <!-- 비밀번호 찾기 컨테이너 -->
        <div id="searchPasswordContainer">
        	<div id='before'>
	            <input type="text" name='id' id="id" placeholder='아이디'>
	            <div id='sendVerificationCodeContainer'>
		            <input type="email" name='email' id="email" placeholder='이메일'>
		            <img id='sendVerificationCode' src='${path }/resources/image/icon/icon_sendMessage.png'>
	            </div>
	            <div id='verificationCodeResultContainer'>
		            <input type='tel' name='verificationCode' id='verificationCode' placeholder='인증번호'>
		            <img id='verificationCodeResult' src='${path }/resources/image/icon/icon_check.png'>
	            </div>
        	</div>
            <div id='after'>
	            <input type='password' name='password' id='password' placeholder='새로운 비밀번호'>
	            <input type='password' id='passwordCheck' placeholder='비밀번호 확인'>
            </div>
        </div>

        <!-- 검색 결과 컨테이너 -->
        <div id="searchResultContainer">
            <span>인증해주세요.</span>  
        </div>

        <!-- 버튼 컨테이너 -->
        <div id="buttonContainer">
            <div id="searchPasswordButton">
                <span>비밀번호 변경</span>
            </div>
        </div>
    </div>
    <script src='${path }/resources/js/member/searchPassword.js'></script>
</body>
</html>