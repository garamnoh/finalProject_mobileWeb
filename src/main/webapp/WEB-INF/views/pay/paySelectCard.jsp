<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/css/pay/paySelectCard.css">

<jsp:include page='/WEB-INF/views/common/header.jsp'/>

<div id="selectCardHeader">
    <span id="selectCardText">Card</span>
</div>

<div id='myCardInfoContainer'>
	<c:forEach var='card' items='${myCardList }' varStatus="status">
	    <div id="myCardInfo">
	    	<input type='hidden' value='${card.cardSeq }' id='cardSeqValue'>
	        <img src="${path }/resources/image/card/${card.cardImg }" alt="" id="cardImg">
	        <div id="myCardInfoText">
	        	<div id='myCardInfoTextBox'>
		        	<span id='cardName'><c:out value='${fn:toUpperCase(card.cardName) }'/></span>
		            <span id="cardNumber">****-****-**<c:out value='${fn:substring(card.cardNo, 12, 19) }'/></span>
		            <span id="cardBalance"><fmt:formatNumber value='${card.balance }' pattern='###,###,### 원'/></span>
	        	</div>
	        	<div id='chargingHistorySearchingBox'>
		        	<span>충전 및 이용 내역</span>
		        	<img src='${path }/resources/image/icon/icon_next.png'>
	        	</div>
	        </div>
	    </div>
	    <c:if test='${status.count ne myCardList.size() }'>
	    	<div class='line'></div>
    	</c:if>
	</c:forEach>
</div>

<script src='${path }/resources/js/pay/paySelectCard.js'></script>

<jsp:include page='/WEB-INF/views/common/footer.jsp'/>