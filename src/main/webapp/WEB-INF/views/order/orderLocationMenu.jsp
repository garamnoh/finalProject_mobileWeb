<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<c:forEach var='sList' items='${storeList }' varStatus='vs'>
	<div class="resultBox">
	    <div class="resultText">
	        <span class="title"><c:out value='${sList.storeName }'/></span>
	        <c:choose>
	        	<c:when test='${sList.type eq "general" }'>
	        		<span class="distance"><fmt:formatNumber value='${sList.distance }' pattern='###,###,### m'/></span>
	        	</c:when>
	        	<c:when test='${sList.type eq "dt" }'>
	        		<span class="distance"><strong style='color:#00704A;'>DT</strong>&nbsp;&nbsp;<strong>.</strong>&nbsp;&nbsp;<fmt:formatNumber value='${sList.distance }' pattern='###,###,### m'/></span>
	        	</c:when>
	        	<c:when test='${sList.type eq "reserve" }'>
	        		<span class="distance"><strong style='color:#906C51;'>RESERVE</strong>&nbsp;&nbsp;<strong>.</strong>&nbsp;&nbsp;<fmt:formatNumber value='${sList.distance }' pattern='###,###,### m'/></span>
	        	</c:when>
	        </c:choose>
	    </div>
	    <div class='resultAddress'>
	        <span class="address"><c:out value='${sList.storeAddress }'/></span>
	    </div>
	</div>
</c:forEach>

<script src='${path }/resources/js/order/orderLocationMenu.js'></script>
