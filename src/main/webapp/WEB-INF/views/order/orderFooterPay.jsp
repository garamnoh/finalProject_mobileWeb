<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>
<c:set var='store' value='${selectedStore }'/>

<!-- finalOrder button -->
<form id="finalOrderButtonContainer" method='post' action='${path }/order/cart/moveToPaymentPage.do'>
	<input type='hidden' value='${store.storeName }' id='selectedStore'>
	<input type='hidden' name='totalQuantity' value='' id='totalQuantity'>
	<input type='hidden' name='totalPrice' value='' id='totalPrice'>
	<input type='hidden' name='cartList' value='${cartList }' id='cartList'>
    <div id="totalPriceBox">
    	<div id='totalQuantity'>총 <span></span>개</div>
    	<div id='totalPriceDiv'></div>
    </div>
    <div id="finalOrder">주문하기</div>
</form>

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
</script>
<script src='${path }/resources/js/order/orderFooterPay.js'></script>