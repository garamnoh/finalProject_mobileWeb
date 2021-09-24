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
    
    <title>enrollInfo</title>
    
    <!-- font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap">

    <!-- style -->
    <link rel="stylesheet" href="${path }/resources/css/common/reset.css">
    <link rel="stylesheet" href="${path }/resources/css/member/enrollInfo.css">

    <!-- jQuery -->
    <script src='${path }/resources/js/common/jquery-3.6.0.min.js'></script>
    
    <!-- 주소찾기 API -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>
<body>
	<input type='hidden' id='path' value='${path }'>
 	<!-- 전체 컨테이너 -->
    <div id="container">
        <!-- 취소 버튼 -->
        <div id="cancel">
            <img src="${path }/resources/image/icon/icon_cancel.png" alt="">
        </div>
        
        <!-- 회원정보 입력 -->
        <div id='enrollInfoContainer'>
            <div id="enrollInfoTitle">
                <span>회원정보 입력</span>
            </div>
        </div>
        <!-- 회원 정보 상세 -->
        <form id="enrollInfoDetail" action='${path }/enroll/enrollMember.do' method='post'>
            <div class="infoBox">
                <input type="text" name='id' id="id" placeholder='아이디' required>
                <span class='usable'>&nbsp;사용 &nbsp;가능</span>
                <span class='unusable'>&nbsp;사용 &nbsp;불가</span>
            </div>
            <div class="infoBox">
                <input type="password" name='password' id="password" placeholder='비밀번호(4글자 이상)' required>
            </div>
            <div class="infoBox">
                <input type="password" id="passwordCheck" placeholder='비밀번호 확인' required>
                <span class='usable'>일치</span>
                <span class='unusable'>불일치</span>
            </div>
            <div class="infoBox" id='multiBox'>
                <input type="tel" name='idNo' id="idNo" placeholder='생년월일' required>
                <span>-</span>
                <div id="genderBox">
                    <input type="number" name='gender' id="gender" placeholder='' required>
                    <input type="text" id='etc' placeholder='● ● ● ● ● ●' readonly>
                </div>
            </div>
            <div class="infoBox">
                <input type="text" name='name' id="name" placeholder='이름' required>
            </div>
            <div class="infoBox">
                <input type="text" name='nickname' id="nickname" placeholder='별명' required>
            </div>
            <div class="infoBox">
                <input type="tel" name='phone' id="phone" placeholder='전화번호' required>
                <span class='usable'>&nbsp;사용 &nbsp;가능</span>
                <span class='unusable'>&nbsp;사용 &nbsp;불가</span>
            </div>
            <div class="infoBox" id='infoEmail'>
            	<c:choose>
            		<c:when test='${requestScope.email ne null }'>
		                <input type="email" name='email' id="email" placeholder='이메일' value='${requestScope.email }' required>
            		</c:when>
					<c:otherwise>
	            		<input type="email" name='email' id="email" placeholder='이메일' required>
                <span class='usable'>&nbsp;사용 &nbsp;가능</span>
                <span class='unusable'>&nbsp;사용 &nbsp;불가</span>
					</c:otherwise>
            	</c:choose>
            </div>
            <div class="infoBox" id='addrBox'>
                <input type="text" name='address' id="address" placeholder='주소' required readonly>
                <img src='${path }/resources/image/icon/icon_home_black.png'>
            </div>
            <button type='submit' id='enrollSubmit'></button>
        </form>

        <!-- 버튼 컨테이너 -->
        <div id="buttonContainer">
            <div id="enrollButton">
                <span>회원 가입</span>
            </div>
        </div>
    </div>
    <script src='${path }/resources/js/member/enrollInfo.js'></script>
</body>
</html>