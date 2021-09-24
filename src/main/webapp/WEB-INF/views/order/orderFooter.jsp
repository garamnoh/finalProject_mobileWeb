<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>
<c:set var='store' value='${selectedStore }'/>

<!-- location button -->
<div id="locationButtonContainer">
    <div id="searchLocation">
    	<c:choose>
    		<c:when test='${store != null }'>
		        <span id="locationText"><c:out value='${store.storeName }'/></span>
    		</c:when>
    		<c:otherwise>
		        <span id="locationText">주문할 매장을 선택해 주세요</span>
    		</c:otherwise>
    	</c:choose>
        <img src="${path }/resources/image/icon/icon_other_white.png" alt="">
    </div>
    <div id="basket">
        <img src="${path }/resources/image/icon/icon_shopping_outline.png" alt="" id="basketImg">
        <span id="basketCount">0</span>
    </div>
</div>

<script src='${path }/resources/js/order/orderFooter.js'></script>
