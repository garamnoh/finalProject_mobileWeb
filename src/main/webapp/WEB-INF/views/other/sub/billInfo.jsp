<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<!-- 매장 정보 -->
<div id='modalStoreInfo'>
	<div id='modalStoreId'>
		<span>[매장코드]</span>
		<span><c:out value='${order[0].STORE_ID }'/></span>
	</div>
	<div id='modalStoreName'>
		<span>[매&nbsp;&nbsp;장&nbsp;&nbsp;명]</span>
		<span><c:out value='${order[0].STORE_NAME }'/></span>
	</div>
	<div id='modalStoreTel'>
		<span>[전화번호]</span>
		<span><c:out value='${order[0].STORE_TEL }'/></span>
	</div>
	<div id='modalStoreAddress'>
		<span><c:out value='${order[0].STORE_ADDRESS }'/></span>
	</div>
</div>

<hr class='dotLine'></hr>

<!-- 주문 번호 -->
<div id='modalOrderNumber'>
	<span><c:out value='${order[0].ORDER_NO }'/></span>
</div>

<hr class='dotLine'></hr>

<!-- 제품 정보 -->
<c:forEach var='billInfo' items='${order }'>
	<div id='modalProductInfo'>
		<span><c:out value='${billInfo.PRODUCT_NAME }'/></span>
		<div id='selectedOptionBox'>
			<c:choose>
				<c:when test='${fn:contains(billInfo.SELECTED_OPTION, "TALL") }'>
					<span id='selectedOption'><c:out value='${billInfo.SELECTED_OPTION }'/></span>
					<div id='selectedOptionValue'>
						<span id='price'><fmt:formatNumber value='${billInfo.PRODUCT_PRICE }' pattern='###,###,###'/></span>
						<span id='quantity'><c:out value='${billInfo.QUANTITY }'/></span>
						<span id='totalPrice'><fmt:formatNumber value='${billInfo.PRODUCT_PRICE * billInfo.QUANTITY }' pattern='###,###,###'/></span>
					</div>
				</c:when>
				<c:when test='${fn:contains(billInfo.SELECTED_OPTION, "GRANDE") }'>
					<span id='selectedOption'><c:out value='${billInfo.SELECTED_OPTION }'/></span>
					<div id='selectedOptionValue'>
						<span id='price'><fmt:formatNumber value='${billInfo.PRODUCT_PRICE + 500 }' pattern='###,###,###'/></span>
						<span id='quantity'><c:out value='${billInfo.QUANTITY }'/></span>
						<span id='totalPrice'><fmt:formatNumber value='${(billInfo.PRODUCT_PRICE + 500) * billInfo.QUANTITY }' pattern='###,###,###'/></span>
					</div>
				</c:when>
				<c:when test='${fn:contains(billInfo.SELECTED_OPTION, "VENTI") }'>
					<span id='selectedOption'><c:out value='${billInfo.SELECTED_OPTION }'/></span>
					<div id='selectedOptionValue'>
						<span id='price'><fmt:formatNumber value='${billInfo.PRODUCT_PRICE +1000 }' pattern='###,###,###'/></span>
						<span id='quantity'><c:out value='${billInfo.QUANTITY }'/></span>
						<span id='totalPrice'><fmt:formatNumber value='${(billInfo.PRODUCT_PRICE + 1000) * billInfo.QUANTITY }' pattern='###,###,###'/></span>
					</div>
				</c:when>
				<c:otherwise>
					<span id='selectedOption'><c:out value='${billInfo.PRODUCT_NAME }'/></span>
					<div id='selectedOptionValue'>
						<span id='price'><fmt:formatNumber value='${billInfo.PRODUCT_PRICE }' pattern='###,###,###'/></span>
						<span id='quantity'><c:out value='${billInfo.QUANTITY }'/></span>
						<span id='totalPrice'><fmt:formatNumber value='${billInfo.PRODUCT_PRICE * billInfo.QUANTITY }' pattern='###,###,###'/></span>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		<c:if test='${billInfo.EXTRA_SHOT ne 0 }'>
			<div id='extraShotBox'>
				<span id='extraShotText'>EXTRA SHOT</span>
				<div id='extraShotValue'>
					<span id='extraShotPrice'>500</span>
					<span id='extraShotQuantity'><c:out value='${billInfo.EXTRA_SHOT }'/></span>
					<span id='extraShotTotalPrice'><fmt:formatNumber value='${billInfo.EXTRA_SHOT * 500 }' pattern='###,###,###'/></span>
				</div>
			</div>
		</c:if>
	</div>
</c:forEach>

<hr class='dotLine'></hr>

<!-- 합계 -->
<div id='finalPriceBox'>
	<span>합계</span>
	<span id='finalPrice'></span>
</div>
<div id='couponBox'>
	<span>쿠폰</span>
	<span id='coupon'>0</span>
</div>

<hr class='dotLine'></hr>

<!-- 결제금액 -->
<div id='paymentPriceBox'>
	<span>결제금액</span>
	<span id='paymentPrice'></span>
</div>

<hr class='dotLine'></hr>

<div id='cardInfoBox'>
	<div id='cardInfo'>
		<span>카드 종류</span>
		<span><c:out value='${order[0].PAYMENT_TYPE }'/></span>
	</div>
	<div id='cashReceiptInfo'>
		<span>현금 영수증</span>
		<span><c:out value='${order[0].CASH_RECEIPT }'/></span>
	</div>
</div>

<hr class='dotLine'></hr>

<div id='additionalInfo'>
	<span>wi-fi : STARBUCKS</span>
	<span>스타벅스 웹사이트와 앱을 통해</span>
	<span>스타벅스 카드를 등록해보세요</span>
	<span>다양한 혜택을 누리실 수 있습니다.</span>
</div>

<script>
	var billInfo = new Array();
	<c:forEach var='billInfo' items='${order }'>
		billInfo.push({
			price:'${billInfo.PRODUCT_PRICE }',
			option:'${billInfo.SELECTED_OPTION }',
			addedPrice:'${billInfo.ADDED_PRICE }',
			quantity:'${billInfo.QUANTITY }',
			extraShot:'${billInfo.EXTRA_SHOT }',
		});
	</c:forEach>
	
	$(document).ready(function(){
		new Promise(function(resolve, reject){
			var finalPrice = 0;
			$.each(billInfo, (i, e)=>{
				finalPrice += ((e.price * 1 + e.addedPrice * 1) + (e.extraShot * 500)) * e.quantity;
			});
			resolve(finalPrice);
		}).then(function(value){
			$('#finalPrice').html(priceFormat(value));
			var coupon = $('#coupon').html();
			$('#paymentPrice').html(priceFormat(value - coupon));
		});
	});
	
	// function: 숫자 -> 가격 형식으로 변환
	function priceFormat(number) {
		return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
</script>