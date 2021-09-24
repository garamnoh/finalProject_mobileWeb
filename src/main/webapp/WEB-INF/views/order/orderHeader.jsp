<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<!-- Order header -->
<div id="orderHeader">
    <span id="orderText">Order</span>
    <div id="menuContainer">
        <div class="menuBox" id='default'>
            <span class="menuText" id='default'>음료</span>
        </div>
        <div class="menuBox" id='food'>
            <span class="menuText" id='food'>푸드</span>
        </div>
        <div class="menuBox" id='md'>
            <span class="menuText" id='md'>상품</span>
        </div>  
    </div>
</div>

<script src='${path }/resources/js/order/orderHeader.js'></script>