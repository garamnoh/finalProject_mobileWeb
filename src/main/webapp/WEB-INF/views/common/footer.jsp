<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

	</div>
    <!-- footer navigation bar -->
    <div id="navBarContainer">
    	<input type='hidden' id='navButton' value='<c:out value="${button }"/>'>
        <div class="iconBox" id='home'>
            <img src="${path }/resources/image/icon/icon_home_white.png" alt="" id='home'>
            <span id='home'>Home</span>
        </div>
        <div class="iconBox" id='pay'>
            <img src="${path }/resources/image/icon/icon_pay_white.png" alt="" id='pay'>
            <span id='pay'>Pay</span>
        </div>
        <div class="iconBox" id='order'>
            <img src="${path }/resources/image/icon/icon_order_white.png" alt="" id='order'>
            <span id='order'>Order</span>
        </div>
        <div class="iconBox" id='gift'>
            <img src="${path }/resources/image/icon/icon_gift_white.png" alt="" id='gift'>
            <span id='gift'>Gift</span>
        </div>
        <div class="iconBox" id='other'>
            <img src="${path }/resources/image/icon/icon_other_white.png" alt="" id='other'>
            <span id='other'>Other</span>
        </div>
    </div>
    <input type='hidden' id='path' value='${path }'>
    <script src='${path }/resources/js/common/footer.js'></script>
</body> 
</html>