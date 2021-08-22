<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/css/order/cart.css">

<jsp:include page='/WEB-INF/views/common/header.jsp'/>

<div id="cartHeader">
    <span id="cartText">Cart</span>
</div>

<!-- cart list -->
<div id='cartContainer'>
	<c:choose>
		<c:when test='${cartList.size() eq 0 }'>
			<div id='emptyBox'>
				<img src='${path }/resources/image/etc/empty_cart.png' id='empty'>
			</div>
		</c:when>
		<c:otherwise>
			<c:forEach var='cart' items='${cartList }' varStatus="status">
				<input type='hidden' id='cartSeq' value='${cart.cartSeq }'>
				<div id='cartList'>
					<img src='${path }/resources/image/icon/icon_cancel.png' id='deleteCartList'>
					<img src='${path }/resources/image/menu/${cart.category }/${cart.productImg}' id='cartProductImg'>
					<div id='cartTextBox'>
						<div id='cartProductName'><c:out value='${cart.productName }'/></div>
						<div id='cartOptionBox'>
							<div id='cartOptions'>
								<c:if test='${cart.productOption ne "none" }'>
									<span id='cartProductOption'><c:out value='${fn:toUpperCase(cart.productOption) }'/></span>
								</c:if>
								<c:if test='${cart.productSize ne "none" }'>
									<span id='cartProductSize'><c:out value='${fn:toUpperCase(cart.productSize) }'/></span>
								</c:if>
								<c:if test='${cart.productOption eq "none" and cart.productSize eq "none" }'>
									<span id='cartProductNameAgain'><c:out value='${cart.productName }'/></span>
								</c:if>
							</div>
							<c:choose>
								<c:when test='${cart.productSize eq "tall" or cart.productSize eq "none" }'>
									<div id='cartProductPrice'><fmt:formatNumber value='${cart.productPrice }' pattern='###,###,###원'/></div>
								</c:when>
								<c:when test='${cart.productSize eq "grande" }'>
									<div id='cartProductPrice'><fmt:formatNumber value='${cart.productPrice + 500 }' pattern='###,###,###원'/></div>
								</c:when>
								<c:otherwise>
									<div id='cartProductPrice'><fmt:formatNumber value='${cart.productPrice + 1000 }' pattern='###,###,###원'/></div>
								</c:otherwise>
							</c:choose>
						</div>
						<div id='cartExtraShotBox'>
							<c:if test='${cart.extraShot ne 0 }'>
								<div id='cartExtraShot'>Extra shot x <c:out value='${cart.extraShot }'/></div>
								<div id='cartExtraShotPrice'><fmt:formatNumber value='${cart.extraShot * 500 }' pattern='###,###,###원'/></div>
							</c:if>
						</div>
					</div>
				</div>
				<div id='cartEachPriceBox'>
					<div id='cartQuantityBox'>
						<c:choose>
							<c:when test='${cart.productQuantity == 1 }'>
								<img src='${path }/resources/image/icon/icon_minus_outline.png' id='cartRemoveQuantity' style='opacity:.5;'>
							</c:when>
							<c:otherwise>
								<img src='${path }/resources/image/icon/icon_minus_outline.png' id='cartRemoveQuantity'>
							</c:otherwise>
						</c:choose>
						<div id='cartProductQuantity'><c:out value='${cart.productQuantity }'/></div>
						<img src='${path }/resources/image/icon/icon_plus_outline.png' id='cartAddQuantity'>
					</div>
					<c:choose>
						<c:when test='${cart.productSize eq "tall" or cart.productSize eq "none" }'>
							<div id='cartEachPrice'><fmt:formatNumber value='${(cart.productPrice + cart.extraShot * 500) * cart.productQuantity }' pattern='###,###,###원'/></div>
						</c:when>
						<c:when test='${cart.productSize eq "grande" }'>
							<div id='cartEachPrice'><fmt:formatNumber value='${((cart.productPrice + 500) + cart.extraShot * 500) * cart.productQuantity }' pattern='###,###,###원'/></div>
						</c:when>
						<c:otherwise>
							<div id='cartEachPrice'><fmt:formatNumber value='${((cart.productPrice + 1000) + cart.extraShot * 500) * cart.productQuantity }' pattern='###,###,###원'/></div>
						</c:otherwise>
					</c:choose>
				</div>
				<c:if test='${status.count ne cartList.size() }'>
					<div id='line'></div>
				</c:if>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</div>

<jsp:include page='/WEB-INF/views/order/orderFooter.jsp'/>
<jsp:include page='/WEB-INF/views/order/orderFooterPay.jsp'/>

<script src='${path }/resources/js/order/cart.js'></script>

<jsp:include page='/WEB-INF/views/common/footer.jsp'/>