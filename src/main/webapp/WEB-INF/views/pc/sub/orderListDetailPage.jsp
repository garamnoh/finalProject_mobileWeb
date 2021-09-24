<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<c:forEach var='detail' items='${businessOrderDetail }'>
   	<div id='orderResult'>
   		<input type='hidden' id='productCount' value='${businessOrderDetail.size() }'>
   		<input type='hidden' id='firstProductName' value='${businessOrderDetail[0].productName }'>
   		<span id='productName'><c:out value='${detail.productName }'/></span>
   		<span id='selectedOption'><c:out value='${detail.selectedOption }'/></span>
   		<span id='extraShot'><c:out value='${detail.extraShot }'/></span>
   		<span id='quantity'><c:out value='${detail.quantity }'/></span>
   	</div>
</c:forEach>