<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/css/home/home.css">

<!-- header.jsp -->
<jsp:include page='/WEB-INF/views/common/header.jsp'/> 

<!-- 적립 정보 컨테이너 -->
<div id="rewardContainer">
    <div id="leftContainer">
        <div id="rewardTextBox">
			<input type='hidden' id='chartStars' value='<c:out value="${loginMember.stars }"/>'>
			<input type='hidden' id='chartMembership' value='<c:out value="${loginMember.membership }"/>'>
			<c:choose>
			<c:when test='${loginMember.membership eq "welcome" }'>
			  <span id="rewardCount"><c:out value='${5 - loginMember.stars }'/></span>
			     <img src="${path }/resources/image/icon/icon_star.png" alt="" id="star">
			     <span>until Green Level</span>
			</c:when>
			<c:when test='${loginMember.membership eq "green" }'>
			  <span id="rewardCount" style='color: #00704A;'><c:out value='${25 - (loginMember.stars - 5) }'/></span>
			     <img src="${path }/resources/image/icon/icon_star_green.png" alt="" id="star">
			     <span style='color: #00704A;'>until Gold Level</span>
			</c:when>
			<c:when test='${loginMember.membership eq "gold" }'>
			  <span id="rewardCount" style='color: #CCC050;'><c:out value='${12 - (loginMember.stars - 30) }'/></span>
			     <img src="${path }/resources/image/icon/icon_star_gold.png" alt="" id="star">
			     <span style='color: #CCC050;'>until Free Drink</span>
			</c:when>
			</c:choose>
        </div>
        <div id="chart"></div>
    </div>
    <div id="rightContainer">
		<c:choose>
			<c:when test='${loginMember.membership eq "welcome" }'>
		        <span id="rewardCountBig"><c:out value='${loginMember.stars }'/></span>
		        <span id="split">/</span>
		        <span id="count">5</span>
		        <img src="${path }/resources/image/icon/icon_star.png" alt="" id="starBig">
			</c:when>
			<c:when test='${loginMember.membership eq "green" }'>
		        <span id="rewardCountBig"><c:out value='${loginMember.stars - 5 }'/></span>
		        <span id="split">/</span>
		        <span id="count" style='color: #00704A;'>25</span>
		        <img src="${path }/resources/image/icon/icon_star_green.png" alt="" id="starBig">
			</c:when>
			<c:when test='${loginMember.membership eq "gold" }'>
		        <span id="rewardCountBig"><c:out value='${loginMember.stars - 30 }'/></span>
		        <span id="split">/</span>
		        <span id="count" style='color: #CCC050;'>12</span>
		        <img src="${path }/resources/image/icon/icon_star_gold.png" alt="" id="starBig">
			</c:when>
		</c:choose>
    </div>
</div>

<!-- 메인 배너 -->
<div id="bannerContainer">
    <img src="${path }/resources/image/etc/banner.png" alt="" id='banner'>
</div>

<!-- new product Container -->
<div id="newProductContainer">
    <span id="newText">What's New</span>
    <div id="newBox">
        <div id="scrollBox">
			<!-- New Product Info -->
        </div>
    </div>
</div>

<!-- favorite product Container -->
<div id='addDiv'></div>

<!-- notice -->
<div id="noticeContainer">
    <span id="noticeText">Notice</span>
    <div id="noticeBox" class='first'>
        <div id="noticeItem">
            <img src="${path }/resources/image/notice/notice_joy.jpg" alt="">
            <span>서머 e-프리퀀시</span>
            <span>
                <time>2021-07-11</time>
                <span>~</span>
                <time>2021-09-11</time>
            </span>
        </div>
        <div id="noticeItem">
            <img src="${path }/resources/image/notice/notice_drink.jpg" alt="">
            <span>바밀카쿠 프라푸치노 보너스 스타</span>
            <span>
                <time>2021-07-11</time>
                <span>~</span>
                <time>2021-09-11</time>
            </span>
        </div>
        <div id="noticeItem">
            <img src="${path }/resources/image/notice/notice_card.jpg" alt="">
            <span>스타벅스 현대카드 7~8월 한정혜택</span>
            <span>
                <time>2021-07-01</time>
                <span>~</span>
                <time>2021-08-31</time>
            </span>
        </div>
        <div id="noticeItem">
            <img src="${path }/resources/image/notice/notice_star.jpg" alt="">
            <span>만원당 별 적립 이벤트</span>
            <span>
                <time>2021-01-01</time>
                <span>~</span>
                <time>2021-12-31</time>
            </span>
        </div>
    </div>
</div>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src='${path }/resources/js/home/home.js'></script>

<!-- footer.jsp -->
<jsp:include page='/WEB-INF/views/common/footer.jsp'/>