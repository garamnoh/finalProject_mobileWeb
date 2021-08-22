<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/css/gift/gift.css">

<jsp:include page='/WEB-INF/views/common/header.jsp'/>

<!-- 적립 정보 컨테이너 -->
<div id="giftContainer">
	<img src='${path }/resources/image/etc/comming_soon.png'>
</div>

<script src='${path }/resources/js/home/home.js'></script>

<jsp:include page='/WEB-INF/views/common/footer.jsp'/>