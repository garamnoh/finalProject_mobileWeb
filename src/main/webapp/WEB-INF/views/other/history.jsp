<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/css/other/history.css">

<jsp:include page='/WEB-INF/views/common/header.jsp'/>

<!-- 계정 정보 -->
<div id="historyContainer">
    <span id="historyTitle">이용 내역</span>
    <div id="historySearchContainer">
		<input type='date' value='' id='startDate'>
		<span>-</span>
		<input type='date' value='' id='endDate'>
    </div>
</div>

<!-- 이용 내역 검색 결과 -->
<div id="historyResultContainer"></div>


<script src='${path }/resources/js/other/history.js'></script>

<jsp:include page='/WEB-INF/views/common/footer.jsp'/>