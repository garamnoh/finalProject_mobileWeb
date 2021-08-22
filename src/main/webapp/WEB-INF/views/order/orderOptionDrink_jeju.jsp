<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/css/order/order.css">
<link rel="stylesheet" href="${path }/resources/css/order/orderOption.css">

<jsp:include page='/WEB-INF/views/common/header.jsp'/>
<jsp:include page='/WEB-INF/views/order/orderHeader.jsp'/>

<!-- menu list -->
<div class="menuListContainer" id='menuOption'>
	<c:forEach var='menu' items='${menuList }'>
		<div class="menuList" id='new'>
			<input type='hidden' id='productId' value='<c:out value="${menu.productId }"/>'>
		    <img src="${path }/resources/image/menu/drink/${menu.productImg}" alt="" class="menuImg">
		    <div class="menuText">
		        <span class="menuKo"><c:out value='${menu.productName }'/></span>
		        <span class="menuEn"><c:out value='${menu.productNameEn }'/></span>
		        <span class="menuPrice"><fmt:formatNumber value='${menu.productPrice }' pattern='###,### 원'/></span>
		    </div>
		</div>
	</c:forEach>
</div>

<jsp:include page='/WEB-INF/views/order/orderFooter.jsp'/>

<script src='${path }/resources/js/order/order.js'></script>
<script src='${path }/resources/js/order/orderOption.js'></script>

<jsp:include page='/WEB-INF/views/common/footer.jsp'/>