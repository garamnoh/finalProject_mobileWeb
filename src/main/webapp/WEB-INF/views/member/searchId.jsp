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
    
    <title>searchId</title>
    
    <!-- font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap">

    <!-- style -->
    <link rel="stylesheet" href="${path }/resources/css/common/reset.css">
    <link rel="stylesheet" href="${path }/resources/css/member/searchId.css">

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
                <span>아이디 찾기</span>
                <span>서비스 입니다.</span>
                <span>아래 정보를 입력해 주세요.</span>
            </div>    
        </div>

        <!-- 아이디 찾기 컨테이너 -->
        <div id="searchIdContainer">
            <input type="text" name='name' id="name" placeholder='이름' required>
            <input type="tel" name='idNo' id="idNo" placeholder='생년월일' required>
            <input type='tel' name='phone' id='phone' placeholder='핸드폰번호' required>
        </div>

        <!-- 검색 결과 컨테이너 -->
        <div id="searchResultContainer">
            <span>검색결과</span>  
        </div>

        <!-- 버튼 컨테이너 -->
        <div id="buttonContainer">
            <div id="searchIdButton">
                <span>아이디 찾기</span>
            </div>
        </div>
    </div>
    <script src='${path }/resources/js/member/searchId.js'></script>
</body>
</html>