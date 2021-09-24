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
    
    <title>starbucks</title>
    
    <!-- font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap">
    
    <!-- favicon -->
    <link rel="shortcut icon" href="${path }/resources/images/logo/favicon.ico" type="image/x-icon" />
	<link rel="icon" href="${path }/resources/images/logo/favicon.ico" type="image/x-icon" />

    <!-- style -->
    <link rel="stylesheet" href="${path }/resources/css/common/reset.css">
    <link rel="stylesheet" href="${path }/resources/pc/css/pc_login.css">
    
    <!-- jQuery -->
    <script src='${path }/resources/js/common/jquery-3.6.0.min.js'></script>
</head>
<body>
	<input type='hidden' id='path' value='${path }'>
    <!-- 헤더 -->
    <header>
        <div id="headerMenu">
            <!-- 로고 -->
            <div id="logo">
                <img src="${path }/resources/image/logo/logo.png" alt="">
            </div>
            <!-- 메뉴 -->
            <div id="headerMenuContainer">
                <!-- 메뉴 첫줄 -->
                <div id="headerMenuFirstLine">
                	<c:choose>
                		<c:when test='${(loginMember ne null) or (businessLoginMember ne null) }'>
		                    <span id='signOut'>Sign Out</span>
                		</c:when>
                		<c:otherwise>
		                    <span id='signIn'>Sign In</span>
                		</c:otherwise>
                	</c:choose>
                </div>
                <!-- 메뉴 두번째 줄 -->
                <div id="headerMenuSecondLine">
                    <span id="coffee">COFFEE</span>
                    <span id="menu">MENU</span>
                    <span id="store">STORE</span>
                </div>
            </div>
        </div>
    </header>

    <!-- 섹션 -->
    <section>
        <div id="loginBox">
            <div id="loginTitle">
                <span>Welcome! 스타벅스커피 코리아에 오신 것을 환영합니다.</span>
            </div>
            <div id="loginLine"></div>
            <div id='loginForm'>
            	<div id='memberTypeBox'>
	            	<input type='checkbox' name='memberType' id='memberType'>&nbsp;
	            	<label for='memberType'>사업자 회원</label>
            	</div>
                <input type="text" name='id' id="id" placeholder='아이디'>
                <input type="password" name='password' id="password" placeholder='비밀번호'>
                <div id="loginLine"></div>
                <input type='button' class='loginButtons' id='businessMemberLoginButton' value='사업자 회원 로그인'>
                <input type="button" class='loginButtons' id="loginButton" value='개인 회원 로그인'>
            </div>
        </div>
    </section>
    
    <!-- 푸터 -->
    <footer>
        <!-- 로그인 전 화면 -->
        <div id="beforeLogin">
            <div id="footerLogo">
                <img src="${path }/resources/image/logo/logo.png" alt="">
                <div id='footerLogoText'>
                    <span>STARBUCKS</span>
                    <span>REWARDS</span>
                </div>
            </div>
            <div id="footerText">
                <span>스타벅스만의 특별한 혜택, <strong>스타벅스 리워드</strong></span>
                <span><strong>스타벅스 회원이세요?</strong> 로그인을 통해 나만의 리워드를 확인해 보세요.</span>
                <span><strong>스타벅스 회원이 아니세요?</strong> 가입을 통해 리워드 혜택을 즐기세요.</span>
                <div id="line"></div>
                <span>카드를 등록하여 스타벅스 리워드 회원이 되신 후, 첫 구매를 하시면 무료 음료쿠폰을 드립니다!</span>
            </div>
            <div id="footerEnroll">
                <div>
                    <span>회원가입</span>
                </div>
            </div>
        </div>
    </footer>
    
    <script src='${path }/resources/pc/js/pc_login.js'></script>
</body>
</html>