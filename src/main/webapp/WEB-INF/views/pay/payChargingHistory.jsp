<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/css/pay/payChargingHistory.css">

<jsp:include page='/WEB-INF/views/common/header.jsp'/>

<div id="selectCardHeader">
    <span id="selectCardText">Card</span>
</div>

<div id='myCardInfoContainer'>
    <div id="myCardInfo">
        <img src="${path }/resources/image/card/${cardInfo.cardImg }" alt="" id="cardImg">
        <div id="myCardInfoText">
        	<div id='myCardInfoTextBox'>
	        	<span id='cardName'><c:out value='${fn:toUpperCase(cardInfo.cardName) }'/></span>
	            <span id="cardNumber">****-****-**<c:out value='${fn:substring(cardInfo.cardNo, 12, 19) }'/></span>
	            <span id="cardBalance"><fmt:formatNumber value='${cardInfo.balance }' pattern='###,###,### 원'/></span>
        	</div>
        </div>
    </div>
</div>

<div id='tempBox'>
	<div class='chargingLine'></div>
</div>

<!-- 이용 내역 -->
<div id="historyContainer">
	<c:forEach var='chargingList' items='${chargingHistory }'>
		<c:choose>
			<c:when test='${chargingList.payment eq "Y" }'>
				<div id="historyBox" style='border:1px solid #BB4C41'>
					<div>
						<span id="date"><fmt:formatDate value='${chargingList.chargingDate }' pattern='YYYY년 MM월 dd일 (E)'/></span>
						<span id="price"><fmt:formatNumber value='${chargingList.price }' pattern='###,###,###원'/></span>
					</div>
					<img src='${path }/resources/image/icon/icon_payment.png'>
				</div>
			</c:when>
			<c:otherwise>
				<div id="historyBox" style='border:1px solid #00704A'>
					<div>
						<span id="date"><fmt:formatDate value='${chargingList.chargingDate }' pattern='YYYY년 MM월 dd일 (E)'/></span>
						<span id="price"><fmt:formatNumber value='${chargingList.price }' pattern='###,###,###원'/></span>
					</div>
					<img src='${path }/resources/image/icon/icon_savings.png'>
				</div>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</div>

<script src='${path }/resources/js/pay/payChargingHistory.js'></script>

<jsp:include page='/WEB-INF/views/common/footer.jsp'/>