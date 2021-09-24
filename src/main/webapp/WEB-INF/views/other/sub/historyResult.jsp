<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<c:forEach var='order' items='${orderList }'> 
    <div id="historyBox">
    	<input type='hidden' value='${order.ORDER_NO }' id='orderNumber'>
        <span id="location"><c:out value='${order.STORE_NAME }'/></span>
        <span id="date"><fmt:formatDate value='${order.PAYMENT_DATE }' pattern='YYYY년 MM월 dd일 (E)'/></span>
        <span id="price"><fmt:formatNumber value='${order.TOTAL_PRICE }' pattern='###,###,###원'/></span>
        <c:choose>
        	<c:when test='${order.PAYMENT_TYPE eq "starbucks" }'>
        		<img src='${path }/resources/image/icon/icon_starbucks_.png' id='paymentTypeImage'>
        	</c:when>
        	<c:otherwise>
        		<img src='${path }/resources/image/icon/icon_kakaopay_.png' id='paymentTypeImage'>
        	</c:otherwise>
        </c:choose>
    </div>
</c:forEach>

<script src='${path }/resources/js/other/historyResult.js'></script>
