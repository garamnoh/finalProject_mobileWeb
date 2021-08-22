<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<link rel="stylesheet" href="${path }/resources/css/other/other.css">

<jsp:include page='/WEB-INF/views/common/header.jsp'/>

<!-- 계정 정보 -->
<div id="otherContainer">
    <span id="otherTitle">계정 정보</span>
    <div id="otherButtons">
        <div class="button">
            <div class="buttonName userName"><c:out value='${loginMember.name }'/></div>
        </div>
        <div class="button">
            <div class="buttonName userNickname"><c:out value='${loginMember.nickname }'/></div>
            <div id='editBox' class=''>
	            <input type='text' id='nickname' value='' placeholder='새로운 별명을 입력하세요'>
	            <div id='ok'>사용가능</div>
	            <div id='no'>사용불가</div>
            </div>
            <img src="${path }/resources/image/icon/icon_edit.png" alt="" class="editImg" id='editNickname'>
            <img src="${path }/resources/image/icon/icon_check.png" alt="" class="editImg" id='doneNickname'>
        </div>
        <div class="button">
            <div class="buttonName userPhone"><c:out value='${loginMember.phone }'/></div>
            <%-- <img src="${path }/resources/image/icon/icon_edit.png" alt="" class="editImg"> --%>
        </div>
        <div class="button">
            <div class="buttonName userAddress"><c:out value='${loginMember.address }'/></div>
            <%-- <img src="${path }/resources/image/icon/icon_edit.png" alt="" class="editImg"> --%>
        </div>
    </div>
</div>

<!-- Line -->
<div class="line"></div>

<!-- 이용내역 -->
<div id='history'>
	<div id='historyTitle'>
		<img src='${path }/resources/image/icon/icon_history.png'>
		<span>이용 내역</span>
	</div>
	<img src='${path }/resources/image/icon/icon_next.png'>
</div>

<!-- 회원 탈퇴 -->
<div id="deleteAccount">
    <div id="deleteAccountButton">
        <span>회원 탈퇴</span>
    </div>
</div>

<!-- 로그아웃 버튼 -->
    <div id="logoutButtonContainer">
        <div id="logoutButton">
            <span>LOGOUT</span>
        </div>
    </div>
</div>

<script src='${path }/resources/js/other/other.js'></script>

<jsp:include page='/WEB-INF/views/common/footer.jsp'/>