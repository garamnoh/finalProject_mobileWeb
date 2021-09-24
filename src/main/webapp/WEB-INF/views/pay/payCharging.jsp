<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/css/pay/payCharging.css">

<jsp:include page='/WEB-INF/views/common/header.jsp'/>

<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>

	<!-- 카드 정보 -->
	<div id="cardContainer">
	    <span id="chargingText">충전</span>
	    <div id="cardInfo">
	        <img src="${path }/resources/image/card/${myCardInfo.cardImg }" alt="" id="cardImg">
	        <div id="cardInfoText">
	        	<input type='hidden' id='myCardBalance' value='${myCardInfo.balance }'>
	            <span id="cardBalanceText">카드 잔액</span>
	            <span id="cardNumber">****-****-**<c:out value='${fn:substring(myCardInfo.cardNo, 12, 19) }'/></span>
	            <span id="cardBalance"><fmt:formatNumber value='${myCardInfo.balance }' pattern='###,###,### 원'/></span>
	        </div>
	    </div>
	</div>

	<!-- line -->
	<div class="line"></div>

	<!-- 충전 금액 -->
	<div id="chargingContainer">
	    <div id="chargingPrice">
	    	<input type='hidden' id='chargingPriceTemp' value=''>
	        <span id="text">충전 금액</span>
	        <span id="price"></span>
	    </div>
	    <div id="chargingBox">
	        <div id="firstLine">
	            <div id='one' class='chargingBoxClass'><span id='one'>1만원</span></div>
	            <div id='three' class='chargingBoxClass'><span id='three'>3만원</span></div>
	            <div id='five' class='chargingBoxClass'><span id='five'>5만원</span></div>
	            <div id='seven' class='chargingBoxClass'><span id='seven'>7만원</span></div>
	        </div>
	        <div id="secondLine">
	            <div id='nine' class='chargingBoxClass'><span id='nine'>9만원</span></div>
	            <div id='other' class='chargingBoxClass'><span id='other'>다른 금액</span></div>
	            <input type='number' id='otherPrice' min='0' value=''>
	        </div>
	    </div>
	</div>

	<!-- line -->
	<div class="line"></div>

	<!-- 결제 수단 -->
	<div id="paymentTypeContainer">
	    <span id="text">결제 수단</span>
	    <div id="paymentType">
	        <div class="radio">
	        	<!-- 결제시 필요한 정보 모음 -->
	        	<input type='hidden' id='userName' value='<c:out value="${loginMember.name }"/>'>
	        	<input type='hidden' id='userPhone' value='<c:out value="${loginMember.phone }"/>'>
	        	<input type='hidden' id='userEmail' value='<c:out value="${loginMember.email }"/>'>
	        	
	        	<!-- ----------------- -->
	            <input type="radio" id="credit" name='paymentType'>
	            <label for="credit">신용카드</label>
	        </div>
	        <div class="radio">
	            <input type="radio" id="simple" name='paymentType'>
	            <label for="simple">Kakao Pay</label>
	        </div>
	    </div>
	</div>

	<!-- 결제 버튼 -->
    <div id="paymentButtonContainer">
        <div id="paymentTextBox">
        	<input type='hidden' id='totalChargingPrice' value=''>
            <span id="paymentText">충전 후 예상 총 카드 잔액</span>
            <span id="paymentPrice"></span>
        </div>
        <div id="paymentButton">
            <span>충전하기</span>
        </div>
    </div>
</div>

<script src='${path }/resources/js/pay/payCharging.js'></script>

<jsp:include page='/WEB-INF/views/common/footer.jsp'/>