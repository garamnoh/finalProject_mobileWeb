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
    <link rel="shortcut icon" href="${path }/resources/image/logo/favicon.ico" type="image/x-icon" />
	<link rel="icon" href="${path }/resources/image/logo/favicon.ico" type="image/x-icon" />

    <!-- style -->
    <link rel="stylesheet" href="${path }/resources/css/common/reset.css">
    <link rel="stylesheet" href="${path }/resources/pc/css/pc_index.css">
    
    <!-- jQuery -->
    <script src='${path }/resources/js/common/jquery-3.6.0.min.js'></script>
    
    <!-- sockJS -->
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<script src='${path }/resources/js/common/websocket.js'></script>
	
</head>
<body>
	<input type='hidden' id='path' value='${path }'>
	<input type='hidden' id='isBusinessMember' value='${businessLoginMember }'/>
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
                	<c:if test='${businessLoginMember ne null }'>
	                    <span id='MyStarbucks'>
	                    	<strong>[&nbsp;<c:out value='${businessLoginMember.storeId }'/>&nbsp;&nbsp;|&nbsp;&nbsp;<c:out value='${businessLoginMember.storeName }'/>&nbsp;]</strong>
	                    </span>
                	</c:if>
                	<c:if test='${loginMember ne null }'>
	                    <span id='MyStarbucks'>My Starbucks</span>
                	</c:if>
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
        <!-- notification(알림) -->
	    <div id='notificationContainer'>
	    	<div id='temp'>
	    		<div id='temp2'>
		    		<span id='notificationContent'></span>
		    		<span id='confirmButton'>확인</span>
	    		</div>
	    	</div>
	    </div>
	    <c:choose>
	    	<c:when test='${businessLoginMember eq null and loginMember eq null }'>
		        <img src="${path }/resources/image/etc/banner1.png" alt="">
		        <img src="${path }/resources/image/etc/banner2.png" alt="">
		        <img src="${path }/resources/image/etc/banner3.png" alt="">
	    	</c:when>
	    	<c:when test='${businessLoginMember ne null }'>
				<div id='businessListContainer'></div>
	    	</c:when>
	    	<c:otherwise>
		        <img src="${path }/resources/image/etc/banner1.png" alt="">
		        <img src="${path }/resources/image/etc/banner2.png" alt="">
		        <img src="${path }/resources/image/etc/banner3.png" alt="">
	    	</c:otherwise>
	    </c:choose>
    </section>
    
    <!-- 푸터 -->
    <footer>
    	<c:choose>
	    	<c:when test='${(loginMember eq null) and (businessLoginMember eq null)}'>
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
	    	</c:when>
	    	<c:when test='${businessLoginMember ne null }'>
		        <!-- 로그인 후 화면 -->
	    		<div class='afterLogin' id='businessController'>
	    			<span id='orderListButton'>주문</span>
	    			<span id='doneListButton'>완료</span>
	    		</div>
	    	</c:when>
	    	<c:otherwise>
		        <div class='afterLogin'>
		            <div id="rewardBox">
		                <img src="${path }/resources/image/etc/star.png" alt="">
		                <span id=rewardCount>0</span>
		            </div>
		            <div id="userInfoBox">
		                <p><span id='userInfoId'><c:out value='${loginMember.name }'/></span> 님은 현재 &nbsp;<span id="userInfoLevel"><c:out value='${loginMember.membership }'/></span> 입니다.</p>
		                <c:choose>
		                	<c:when test='${loginMember.membership eq "welcome" }'>
				                <p><span id='userInfoLevelUp'>GREEN LEVEL</span>이 되기까지 &nbsp;<span><c:out value='${5 - loginMember.stars }'/></span>개의 별이 필요합니다.</p>
		                	</c:when>
		                	<c:when test='${loginMember.membership eq "green" }'>
				                <p><span id='userInfoLevelUp'>GOLD LEVEL</span>이 되기까지 &nbsp;<span><c:out value='${25 - (loginMember.stars - 5) }'/></span>개의 별이 필요합니다.</p>
		                	</c:when>
		                	<c:when test='${loginMember.membership eq "welcome" }'>
				                <p><span id='userInfoLevelUp'>GOLE LEVEL</span>입니다.</p>
		                	</c:when>
		                </c:choose>
		            </div>
		            <div id="cardInfoBox">
		                <div id='cardInfoText'>
		                    <p>잔액 <span><fmt:formatNumber value='${cardInfo.balance }' pattern='###,###,###'/></span>원</p>
		                </div>
		                <img src="${path }/resources/image/card/${cardInfo.cardImg }" alt="">
		            </div>
		        </div>
	        </c:otherwise>
        </c:choose>
    </footer>
    
    <script src='${path }/resources/pc/js/pc_index.js'></script>
</body>
</html>