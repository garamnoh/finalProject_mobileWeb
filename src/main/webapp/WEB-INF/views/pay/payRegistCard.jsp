<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/css/pay/payRegistCard.css">

<jsp:include page='/WEB-INF/views/common/header.jsp'/>

<div id="registCardHeader">
    <span id="registCardText">Card</span>
</div>

<div id='registCardInfoContainer'>
	<c:forEach var='card' items='${cardList }' varStatus="status">
	    <div id="registCardInfo">
        	<span id='cardName'><c:out value='${fn:toUpperCase(card.cardName) }'/></span>
	        <div id="registCardImage">
		        <img src="${path }/resources/image/card/${card.cardImg }" alt="" id="cardImg">
	        	<div id='registCard'>
	        		<!-- <span>발급</span> -->
	        		<c:choose>
	        			<c:when test='${fn:contains(myCards, card.cardId) }'>
	        				<span>보유중</span>
	        			</c:when>
	        			<c:otherwise>
	        				<input type='hidden' value='${card.cardId }'>
		        			<img src='${path }/resources/image/icon/icon_check.png'>
		        		</c:otherwise>
	        		</c:choose>
        		</div>
	        </div>
	    </div>
	    <c:if test='${status.count ne cardList.size() }'>
	    	<div class='line'></div>
    	</c:if>
	</c:forEach>
</div>

<script src='${path }/resources/js/pay/payRegistCard.js'></script>

<jsp:include page='/WEB-INF/views/common/footer.jsp'/>