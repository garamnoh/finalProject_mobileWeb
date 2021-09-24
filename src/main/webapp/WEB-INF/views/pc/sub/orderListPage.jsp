<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/pc/css/pc_orderList.css">

<c:forEach var='order' items='${businessOrderList }'>
    <div id="orderBox">
    	<input type='hidden' id='paramRecipient' value='${order.id }'>
    	<input type='hidden' id='paramOrderNo' value='${order.orderNo }'>
    	<div id='customerInfoBox'>
	        <span id="orderNo">주문번호 - [ <c:out value='${order.orderNo }'/> ]</span>
	        <span id="customerId">( 고객아이디 : <c:out value='${order.id }'/> )</span>
    	</div>
        <img id='sendComplete' src='${path }/resources/image/icon/icon_check.png'>
    </div>
    <div id='orderDetailBox'>
    	<div id='orderDetail'>
    		<span id='productName'>제품명</span>
    		<span id='selectedOption'>옵션</span>
    		<span id='extraShot'>샷추가</span>
    		<span id='quantity'>수량</span>
    	</div>
    	<div id='orderDetailResult'></div>
    </div>
</c:forEach>

<script src='${path }/resources/pc/js/pc_orderList.js'></script>

