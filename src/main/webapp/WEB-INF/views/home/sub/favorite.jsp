<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<c:if test='${favoriteList.size() ne 0 }'>
	<div id="favoriteContainer">
	    <span id="favoriteText">Favorite</span>
	    <div id="favoriteBox">
	        <div id="favoriteScrollBox">
				<c:forEach var='favorite' items='${favoriteList }'>
					<div id="favoriteProduct">
						<input type='hidden' id='productId' value='${favorite.productId }'>
						<img src="${path }/resources/image/menu/${favorite.category }/${favorite.productImg }" alt="">
						<span><c:out value='${favorite.productName }'/></span>
					</div>
				</c:forEach>
	        </div>
	    </div>
	</div>
</c:if>

<script src='${path }/resources/js/home/favorite.js'></script>