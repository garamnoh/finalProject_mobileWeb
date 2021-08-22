<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/css/order/paymentTypeStarbucks.css">

<div id="paymentTypeResult">
	<c:choose>
		<%-- 카드가 없는 경우 --%>
		<c:when test='${loginMember.cardSeq eq 0 }'>
			<%-- 카드 이미지 --%>
			<div id='cardBox'>
				<div id='imgBox'>
					<img src="${path }/resources/image/card/card_empty.png" class='cardImg cardEmpty'>
					<span>카드 등록</span>
				</div>
				<div id='textBox'>
					<span>Starbucks 카드가 없습니다.</span>
					<span>카드를 등록하세요</span>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<input type='hidden' value='${loginMember.cardSeq }' id='paymentCardSeq'>
			<input type='hidden' value='${myCardInfo.balance }' id='balance'>
			<input type='hidden' value='${loginMember.phone }' id='phoneNumber'>
		    <img src="${path }/resources/image/card/${myCardInfo.cardImg }" alt="" id="cardImg">
		    <div id="cardInfoText">
		    	<input type='hidden' id='myCardBalance' value='${myCardInfo.balance }'>
		        <span id="cardBalanceText">카드 잔액</span>
		        <span id="cardNumber">****-****-**<c:out value='${fn:substring(myCardInfo.cardNo, 12, 19) }'/></span>
		        <span id="cardBalance">
		        	<fmt:formatNumber value='${myCardInfo.balance }' pattern='###,###,###원'/>
		        	&nbsp;<span id='isEnough'></span>
		       	</span>
		    </div>
		   	<img src='${path }/resources/image/icon/icon_charge.png' id='chargingIcon'>
		</c:otherwise>
	</c:choose>
</div>

<c:if test='${loginMember.cardSeq ne 0 }'>
	<div id='cashReceiptContainer'>
		<span>현금영수증</span>
		<input type='checkbox' id='receiptCheckBox'>
		<label id='receiptMyInfo' for='receiptCheckBox'>내 정보</label>
		<input type='tel' id='receiptInputBox' value=''>
	</div>
</c:if>

<script>
	var balance = $('#balance').val();
</script>

<script src='${path }/resources/js/order/paymentTypeStarbucks.js'></script>