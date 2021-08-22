<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/css/pay/payInfo.css">

<jsp:include page='/WEB-INF/views/common/header.jsp'/>

<div id="backgroundWhite">
    <!-- 카드 정보 -->
    <div id="cardContainer">
        <span id="cardName">Boarding Pass Card</span>
        <div id="cardInfo">
            <img src="../../../resources/image/card/card_boardingpass.png" alt="" id="cardImg">
            <div id="cardInfoText">
                <span id="cardBalanceText">카드 잔액</span>
                <span id="cardNumber">****-****-**80-0453</span>
                <span id="cardBalance">15,000 원</span>
            </div>
        </div>
    </div>
</div>

<!-- 이용 내역 -->
<div id="historyContainer">
    <span id="historyText">이용 내역</span>
    <div id="line"></div>
    <div id="historyBox">
        <span id="location">스타벅스 정자점</span>
        <span id="date">2020. 05. 15 (화)</span>
        <span id="price">12,000 원</span>
    </div>
    <div id="historyBox">
        <span id="location">스타벅스 정자점</span>
        <span id="date">2020. 05. 15 (화)</span>
        <span id="price">12,000 원</span>
    </div>
    <div id="historyBox">
        <span id="location">스타벅스 정자점</span>
        <span id="date">2020. 05. 15 (화)</span>
        <span id="price">12,000 원</span>
    </div>
    <div id="historyBox">
        <span id="location">스타벅스 정자점</span>
        <span id="date">2020. 05. 15 (화)</span>
        <span id="price">12,000 원</span>
    </div>
</div>

<script src='${path }/resources/js/pay/payInfo.js'></script>

<jsp:include page='/WEB-INF/views/common/footer.jsp'/>