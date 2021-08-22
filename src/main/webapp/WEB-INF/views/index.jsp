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
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover, user-scalable=no">
    <meta name="author" content="garamNoh">
    
    <!-- 모바일 주소창 자동숨김 -->
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    
    <title>starbucks</title>
    
    <!-- font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap">
    
    <!-- favicon -->
    <link rel="shortcut icon" href="${path }/resources/images/icon/logo/favicon.ico" type="image/x-icon" />
	<link rel="icon" href="${path }/resources/images/icon/logo/favicon.ico" type="image/x-icon" />

    <!-- style -->
    <link rel="stylesheet" href="${path }/resources/css/common/reset.css">
    <link rel="stylesheet" href="${path }/resources/css/common/index.css">
    
    <!-- jQuery -->
    <script src='${path }/resources/js/common/jquery-3.6.0.min.js'></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
</head>
<body>
	<input type='hidden' id='path' value='${path }'>
    <!-- 전체 컨테이너 -->
    <div id="container">
        
        <!-- 로고 컨테이너 -->
        <div id='logoContainer'>
            <img src="${path }/resources/image/logo/logo.png" alt="">
            <div id="logoText">
                <span>안녕하세요.</span>
                <span>스타벅스입니다.</span>
                <span>회원서비스를 위해서 로그인해주세요.</span>
            </div>    
        </div>

        <!-- 로그인 input 컨테이너 -->
        <form id="loginContainer" action='${path }/member/login.do' method='post'>
            <input type="text" name='id' id="id" placeholder='Id' value='admin' required>
            <input type="password" name='password' id="password" placeholder='Password' value='1234' required>
            <button type="submit" id="loginSubmitButton"></button>
        </form>

        <!-- 아이디 / 비밀번호 찾기 및 회원가입 컨테이너 -->
        <div id="enrollContainer">
            <span class='text' id='searchId'>아이디 찾기</span>
            <span class="line">|</span>
            <span class='text' id='searchPassword'>비밀번호 찾기</span>
            <span class="line">|</span>
            <span class='text' id='enroll'>회원가입</span>
        </div>
        <!-- 로그인 버튼 컨테이너 -->
        <div id="loginButtonContainer">
            <div id="kakaoLoginButton">
                <img src="${path }/resources/image/login/kakao_img.png" alt="">
                <span>Login with Kakao</span>
                <img src="${path }/resources/image/login/kakao_img.png" alt="">
            </div>
            <div id="loginButton">
                <span>Login</span>
            </div>
        </div>
    </div>
    <script src='${path }/resources/js/common/index.js'></script>
</body>
</html>