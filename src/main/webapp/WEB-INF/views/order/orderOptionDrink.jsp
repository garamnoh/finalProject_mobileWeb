<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/css/order/order.css">

<div class="menuList" id='new'>
    <img src="${path }/resources/image/menu/drink/new_strawberry_blended.jpg" alt="" class="menuImg">
    <div class="menuText">
        <span class="menuKo">NEW</span>
    </div>
</div>
<div class="menuList" id='reserve'>
    <img src="${path }/resources/image/menu/drink/reserve_shakerato_affogato.jpg" alt="" class="menuImg">
    <div class="menuText">
        <span class="menuKo">리저브</span>
        <span class="menuEn">Reserve</span>
    </div>
</div>
<div class="menuList" id='espresso'>
    <img src="${path }/resources/image/menu/drink/espresso_flatwhite.jpg" alt="" class="menuImg">
    <div class="menuText">
        <span class="menuKo">에스프레소</span>
        <span class="menuEn">Espresso</span>
    </div>
</div>
<div class="menuList" id='jeju'>
    <img src="${path }/resources/image/menu/drink/jeju_greentangerine_lemonade.jpg" alt="" class="menuImg">
    <div class="menuText">
        <span class="menuKo">제주</span>
        <span class="menuEn">Jeju</span>
    </div>
</div>
<div class="menuList" id='blended'>
    <img src="${path }/resources/image/menu/drink/blended_espresso.jpg" alt="" class="menuImg">
    <div class="menuText">
        <span class="menuKo">블렌디드</span>
        <span class="menuEn">Blended</span>
    </div>
</div>
<div class="menuList" id='coldbrew'>
    <img src="${path }/resources/image/menu/drink/coldbrew_vanilla.jpg" alt="" class="menuImg">
    <div class="menuText">
        <span class="menuKo">콜드브루</span>
        <span class="menuEn">Cold Brew</span>
    </div>
</div>
<div class="menuList" id='tea'>
    <img src="${path }/resources/image/menu/drink/tea_chamomile.jpg" alt="" class="menuImg">
    <div class="menuText">
        <span class="menuKo">차</span>
        <span class="menuEn">Tea</span>
    </div>
</div>

<script src='${path }/resources/js/order/orderOptionDrink.js'></script>