<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/css/order/payment.css">

<jsp:include page='/WEB-INF/views/common/header.jsp'/>

<div id="paymentHeader">
    <span id="paymentText">결제</span>
</div>

<!-- payment Info -->
<input type='hidden' id='recipientStoreId' value='${selectedStore.storeId }'>
<div id='paymentContainer'>
	<div id='storeInfoContainer'>
		<span>주문 매장</span>
		<span id='paymentStore'><c:out value='${selectedStore.storeName }'/></span>
	</div>
	<div id='priceInfoContainer'>
		<span>결제 금액</span>
		<span id='paymentPrice'><c:out value='${totalPrice }'/></span>
	</div>
	<div id='productInfoContainer'>
		<img src='${path }/resources/image/menu/${cartList[0].category }/${cartList[0].productImg }'>
		<span id='productInfoName'><c:out value='${cartList[0].productName }'/></span>
		<c:if test='${totalQuantity > 1 }'>
			<span>&nbsp;외&nbsp;</span>
			<span><c:out value='${totalQuantity - 1 }'/></span>
			<span>건</span>
		</c:if>
	</div>

	<!-- line -->
	<div class="line"></div>
	
	<!-- 결제 수단 -->
	<div id="paymentTypeContainer">
	    <span id="text">결제 수단</span>
	    <div id="paymentType">
   	        <div class="radio">
	            <input type="radio" id="starbucks" name='paymentType'>
	            <label for="starbucks">스타벅스 카드</label>
	        </div>
	        <div class="radio">
	            <input type="radio" id="simple" name='paymentType'>
	            <label for="simple">Kakao Pay</label>
	        </div>
	    </div>
	</div>
	
	<!-- line -->
	<div class="line"></div>
	
	<!-- 결제 수단별 화면 표시 -->
	<div id='paymentTypeResultContainer'></div>
</div>


<!-- paymentButton -->
<div id="finalPaymentButtonContainer">
    <div id="finalPayment">결제하기</div>
</div>

<!-- 장바구니 내용 자바스크립트에서 사용 -->
<script>
	var cart = new Array();
	<c:forEach var='cart' items='${cartList}'>
		cart.push({
			name:'${cart.productName}',
			image:'${cart.productImg}',
			price:'${cart.productPrice}',
			quantity:'${cart.productQuantity}',
			extraShot:'${cart.extraShot}',
			size:'${cart.productSize}',
			option:'${cart.productOption}',
			category:'${cart.category}'
		});
	</c:forEach>
	
	var totalPrice = 0;
	var price = 0;
	
	$.each(cart, (i, e)=>{
		// 음료 사이즈별 가격 변경
		if(e.size == "tall" || e.size=="none") price = e.price * 1;
		else if(e.size == "grande") price = e.price * 1 + 500;
		else price = e.price * 1 + 1000;
		
		// 음료 수량 별 가격 저장
		price = (price + (e.extraShot * 500)) * e.quantity;
		
		// 총 음료 가격 저장
		totalPrice += price;
	});
	
	var totalQuantity = ${totalQuantity };
	var userId = '${loginMember.id }';
</script>

<script src='${path }/resources/js/order/payment.js'></script>

<jsp:include page='/WEB-INF/views/common/footer.jsp'/>