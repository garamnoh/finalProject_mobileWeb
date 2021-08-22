<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/css/order/order.css">
<link rel="stylesheet" href="${path }/resources/css/order/orderLocation.css">

<jsp:include page='/WEB-INF/views/common/header.jsp'/>

<!-- search Location -->
<div id="searchLocationHeader">
    <div id="searchStore">
    	<input type='hidden' id='mapOrMenu' value='menu'>
        <span id="searchStoreText">매장</span>
        <img src="${path }/resources/image/icon/icon_map.png" alt="" id="searchStoreMapImg">
        <img src="${path }/resources/image/icon/icon_menu.png" alt="" id="searchStoreMenuImg">
    </div>
    <div id='searchInputContainer'>
	    <input type="text" id="searchStoreInput" name="searchStore" placeholder='Store'>
	    <button id='searchStoreInputButton'>검색</button>
    </div>
    <div id="selectButtons">
        <div class="button" id='all'>
            <span class="buttonText" id='all'>가까운 매장</span>
        </div>
        <div class="button" id='dt'>
            <span class="buttonText" id='dt'>Drive Thru</span>
        </div>
        <div class="button" id='reserve'>
            <span class="buttonText" id='reserve'>Reserve</span>
        </div>
    </div>
</div>
<!-- storeInfo Container -->
<div id="searchResultContainer">
	<jsp:include page='/WEB-INF/views/order/orderLocationMenu.jsp'/>
</div>

<jsp:include page='/WEB-INF/views/order/orderFooter.jsp'/>

<jsp:include page='/WEB-INF/views/common/footer.jsp'/>

<!-- 카카오 지도 API & Library -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=75e6bd6ea6ef68dd35982ed190f6985b&libraries=services,clusterer,drawing"></script>
<script src='${path }/resources/js/order/orderLocation.js'></script>
<script src='${path }/resources/js/order/order.js'></script>