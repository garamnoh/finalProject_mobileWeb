<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/css/order/orderLocationMap.css">

<div id='map'>
	<!-- 현재 지도의 중심 좌표 -->
	<input type='hidden' id='homeLatitude' value='${loginMember.locationLat }'>
	<input type='hidden' id='homeLongitude' value='${loginMember.locationLng }'>
	<input type='hidden' id='latitude' value=''>
	<input type='hidden' id='longitude' value=''>
	<div id='searchCurrentLocation'>
		<img src='${path }/resources/image/etc/map_marker_search.png'>
	</div>
</div>

<script src='${path }/resources/js/order/orderLocationMap.js'></script>
