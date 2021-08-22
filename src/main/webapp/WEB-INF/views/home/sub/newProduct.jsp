<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<c:forEach var='newProduct' items='${newProductList }'>
	<div id="newProduct">
		<input type='hidden' id='productId' value='${newProduct.productId }'>
		<img src="${path }/resources/image/menu/${newProduct.category }/${newProduct.productImg }" alt="">
		<span><c:out value='${newProduct.productName }'/></span>
	</div>
</c:forEach>

<script src='${path }/resources/js/home/newProduct.js'></script>