<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/css/pay/pay.css">

<jsp:include page='/WEB-INF/views/common/header.jsp'/>

<div id="cardContainer">
	<c:choose>
		<%-- 카드가 없는 경우 --%>
		<c:when test='${loginMember.cardSeq eq 0 }'>
			<%-- 카드 이미지 --%>
			<div id='cardBox'>
				<img src="${path }/resources/image/card/card_empty.png" class='cardImg cardEmpty'>
				<span class='cardEmpty'>카드를 등록하세요</span>
			</div>
		</c:when>
		
		<%-- 카드가 있는 경우 --%>
		<c:otherwise>
			<%-- 카드 이미지 --%>
			<div id='cardBox'>
				<img src="${path }/resources/image/card/${myCardInfo.cardImg }" alt="" class="cardImg">
				<div id='newCard'>new</div>
				<div id='editCard'>edit</div>
			</div>
			<%-- 카드 정보 --%>
			<div id="cardInfo">
			    <span id='cardBalance'><fmt:formatNumber value='${myCardInfo.balance }' pattern='###,###,###원'/></span>
			    <span id='cardName'><c:out value='${fn:toUpperCase(myCardInfo.cardName) }'/></span>
			</div>

			<%-- 바코드 생성 --%>
			<div id='generateBarcode'>
				<input type='hidden' value='${myCardInfo.cardNo }' id='cardNo'>
				<input type='hidden' value='${loginMember.id }' id='memberId'>
				<img src="${path }/resources/image/etc/barcode.png" alt="" id="generateBarcodeImg"> 
				<img src='${path }/resources/image/icon/icon_plus_outline.png' id='plusImg'>
			</div>
			
			<%-- 카드 바코드 --%>
			<div id="barcode">
			    <img src="${path }/resources/image/etc/barcode.png" alt="" id="barcodeImg">                
			    <span id="barcodeInfo">****-****-**<c:out value='${fn:substring(myCardInfo.cardNo, 12, 19) }'/></span>
			</div>
			
			<%-- 바코드 유효 정보 --%>
			<div id="barcodeUsable">
			    <span id='barcodeText'>바코드 유효시간 &nbsp;</span>
			    <span id="usableTime">00:00</span>
			</div>
			
			<%-- 충전 --%>
			<div id="chargeContainer">
			    <img src="${path }/resources/image/icon/icon_charge.png" alt="" id="chargeImg">
			    <span id="chargeText">충전</span>
			</div>
		</c:otherwise>
	</c:choose>
</div>

<script src='${path }/resources/js/pay/pay.js'></script>

<jsp:include page='/WEB-INF/views/common/footer.jsp'/>