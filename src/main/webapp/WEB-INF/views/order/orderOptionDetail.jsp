<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/css/order/orderDetail.css">

<jsp:include page='/WEB-INF/views/common/header.jsp'/>

<!-- 제품 정보 -->
<div id="detailInfo">
    <div id="imgBox">
        <img src="${path }/resources/image/menu/${productInfo.category }/${productInfo.productImg }" alt="" id="detailImg">
    </div>
    <div id="textInfo">
        <div id="titleBox">
            <div id="titleInfo">
                <span id="title"><c:out value='${productInfo.productName }'/></span>
                <span id="price"><fmt:formatNumber value='${productInfo.productPrice }' pattern='###,###,### 원'/></span>
            </div>
            <span id="titleInfoEn"><c:out value='${productInfo.productNameEn }'/></span>
        </div>
        <!-- Option Id: O001 이면 HOT/ICED 버튼 표시 -->
       	<c:if test='${productInfo.optionId eq "O001" }'>
	        <div id='option'>
	        	<div id='hot'>HOT</div>
	        	<div id='iced'>ICED</div>
	        </div>
       	</c:if>
       	<c:choose>
	       	<c:when test='${productInfo.category eq "drink" and productInfo.productNameEn ne "espresso" and productInfo.productNameEn ne "conpanna" and productInfo.productNameEn ne "macchiato" }'>
		       	<div id='size'>
		       		<div class='sizeBox' id='tall'>
		       			<img src='${path }/resources/image/icon/icon_cup_.png'>
		       			<span>Tall</span>
		       		</div>
		       		<div class='sizeBox' id='grande'>
		       			<img src='${path }/resources/image/icon/icon_cup_.png'>
		       			<span>Grande</span>
		       		</div>
		       		<div class='sizeBox' id='venti'>
		       			<img src='${path }/resources/image/icon/icon_cup_.png'>
		       			<span>Venti</span>
		       		</div>
		       	</div>
	       	</c:when>
			<c:otherwise>
                <div id="infoBox">
                    <span id="info"><c:out value='${productInfo.productName }'/> 제품은 ○○○ 입니다.</span>
                </div>
       		</c:otherwise>
       	</c:choose>
   	    <c:if test='${fn:contains(productInfo.type, "espresso")}'>
			<div id='shotBox'>
				<span>에스프레소 샷(추가)</span>
				<div id='shot'>
					<img src='${path }/resources/image/icon/icon_minus_outline.png' id='removeShot'>
					<span id='shotQuantity'>0</span>
					<img src='${path }/resources/image/icon/icon_plus_outline.png' id='addShot'>
				</div>
			</div> 
    	</c:if>
    </div>
</div>

<!-- 주문 버튼 -->
<form id="orderButtonContainer">
    <!-- 수량 및 가격 -->
    <div id="priceInfoContainer">
        <div id="amountContainer">
            <img src="${path }/resources/image/icon/icon_minus_outline.png" alt="" id="minusImg">
            <div id="count">
                <span>1</span>
            </div>
            <img src="${path }/resources/image/icon/icon_plus_outline.png" alt="" id="plusImg">
        </div>
        <div id="price">
        	<input type='hidden' id='productId' value='<c:out value="${productInfo.productId }"/>'>
        	<input type='hidden' id='productName' value='<c:out value="${productInfo.productName }"/>'>
        	<input type='hidden' id='productImg' value='<c:out value="${productInfo.productImg }"/>'>
        	<input type='hidden' id='productPrice' value='<c:out value="${productInfo.productPrice }"/>'>
        	<input type='hidden' id='totalPrice' value='<c:out value="${productInfo.productPrice }"/>'>
        	<input type='hidden' id='productQuantity' value='1'>
        	<input type='hidden' id='productShotQuantity' value='0'>
        	<input type='hidden' id='category' value='<c:out value="${productInfo.category }"/>'>
        	<c:choose>
        		<c:when test='${productInfo.category eq "drink" }'>
		        	<input type='hidden' id='productSize' value='tall'>
        		</c:when>
        		<c:otherwise>
		        	<input type='hidden' id='productSize' value='none'>
        		</c:otherwise>
        	</c:choose>
   	       	<c:choose>
	   	       	<c:when test='${productInfo.optionId eq "O001" }'>
	        		<input type='hidden' id='productOption' value=''>
	        	</c:when>
				<c:otherwise>
	        		<input type='hidden' id='productOption' value='none'>
				</c:otherwise>   	       	
   	       	</c:choose>
            <span><fmt:formatNumber value='${productInfo.productPrice }' pattern='###,###,### 원'/></span>
        </div>
    </div>
    <!-- 버튼들 -->
    <div id="orderButtonsContainer">
    	<c:choose>
    		<c:when test='${favorite eq true }'>
		        <img src="${path }/resources/image/icon/icon_like_filled.png" alt="" id="likeButton">
    		</c:when>
    		<c:when test='${favorite eq false }'>
		        <img src="${path }/resources/image/icon/icon_like_outline.png" alt="" id="unlikeButton">
    		</c:when>
    	</c:choose>
        <div id="buttons">
            <div id="basketButton">
                <span>담기</span>
            </div>
        </div>
    </div>
</form>

<script src='${path }/resources/js/order/orderOptionDetail.js'></script>

<jsp:include page='/WEB-INF/views/common/footer.jsp'/>