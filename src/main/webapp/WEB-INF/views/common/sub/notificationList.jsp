<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<c:forEach var='notification' items='${notificationList }' varStatus='status'>
	<div id='notificationBox'>
		<span id='notificationTitle'>[<c:out value='${notification.productName }'/>] <c:out value='${notification.notificationTitle }'/></span>
		<span id='notificationContent'><c:out value='${notification.notificationContent }'/></span>
		<span id='notificationDate'><c:out value='${notification.notificationDate }'/></span>
	</div>
	<c:if test='${status.count ne notificationList.size() }'>
		<div class='line'></div>
	</c:if>
</c:forEach>