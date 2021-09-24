<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/css/order/order.css">

<jsp:include page='/WEB-INF/views/common/header.jsp'/>
<jsp:include page='/WEB-INF/views/order/orderHeader.jsp'/>

<!-- menu list -->
<div class="menuListContainer" id='menuOption'>
	<jsp:include page='/WEB-INF/views/order/orderOptionDrink.jsp'/>
</div>

<jsp:include page='/WEB-INF/views/order/orderFooter.jsp'/>

<script src='${path }/resources/js/order/order.js'></script>

<jsp:include page='/WEB-INF/views/common/footer.jsp'/>