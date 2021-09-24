<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<!DOCTYPE html> 
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover, user-scalable=no">
    <meta name="author" content="garamNoh">
    
    <!-- 모바일 주소창 자동숨김 -->
    <meta name="mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    
    <title>starbucks</title>
    
    <!-- font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap">
    
    <!-- favicon -->
    <link rel="shortcut icon" href="${path }/resources/images/icon/logo/favicon.ico" type="image/x-icon" />
	<link rel="icon" href="${path }/resources/images/icon/logo/favicon.ico" type="image/x-icon" />

    <!-- style -->
    <link rel="stylesheet" href="${path }/resources/css/common/reset.css">
    <link rel='stylesheet' href="${path }/resources/css/common/common.css">
    <link rel='stylesheet' href='${path }/resources/css/common/modalNoti.css'>
    
    <!-- jQuery -->
    <script src='${path }/resources/js/common/jquery-3.6.0.min.js'></script>
    <script src='${path }/resources/js/common/html2canvas.js'></script>
    <script src='${path }/resources/js/common/dom-to-image.js'></script>
    
    <!-- sockJS -->
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<script src='${path }/resources/js/common/websocket.js'></script>
    
</head>
<body>
	<input type='hidden' id='path' value='${path }'>
	
    <!-- haerder 사용자 정보 -->
    <div id="userInfoContainer">
        <div id="userText">
            <span id="userName"><c:out value='${loginMember.nickname }'/></span>
            <span> 님, 반갑습니다.</span>
        </div>
        <div id="icons">
            <img src="${path }/resources/image/icon/icon_shopping.png" alt="" id="shopping">
            <img src="${path }/resources/image/icon/icon_dot_green.png" id="shoppingAlert">
            <img src="${path }/resources/image/icon/icon_notification.png" alt="" id="notification">
            <img src="${path }/resources/image/icon/icon_dot_red.png" id="notificationAlert">
        </div>
    </div>

	<!-- modal 전자영수증 -->
	<a id='canvasTag' type='image/png'></a>
	<div id='modalBackground'>
	 	<div id='modal'>
	 		<div id='modalHeader'>
 	 			<div id='modalTitle'>전자영수증</div>
	 			<div>
		 			<img src='${path }/resources/image/icon/icon_download.png' id='downloadBill'>
		 			<img src='${path }/resources/image/icon/icon_cancel.png' id='closeModal'>
	 			</div>
	 		</div>
	 		<div class='line'></div>
	 		<div id='modalContentContainer'></div>
	 	</div>
	</div>
	
	<!-- modal Notification -->
	<div id='modalBackgroundNoti'>
	 	<div id='modalNoti'>
	 		<div id='modalHeaderNoti'>
 	 			<div id='modalTitleNoti'>Notification</div>
	 			<div>
		 			<img src='${path }/resources/image/icon/icon_cancel.png' id='closeModalNoti'>
	 			</div>
	 		</div>
	 		<div class='line'></div>
	 		<div id='modalContentContainerNoti'>
	 			<jsp:include page='/WEB-INF/views/common/sub/notificationList.jsp'/>
	 		</div>
	 	</div>
	</div>
	
	<!-- slideUp Notification -->
	<div id='slideUpNoti'>
		<img src='${path }/resources/image/icon/icon_cancel_white.png' id='closeSlideUpNoti'>
		<div id='slideUpNotiBox'>
			<div id='temp'>
				<input type='hidden' id='notiOrderNo' value=''>
				<span id='slideUpNotiRecipient'></span>
				<span id='slideUpNotiTitle'></span>
				<span id='slideUpNotiContent'></span>
				<span id='slideUpNotiDate'></span>
			</div>
		</div>
	</div>
    
    <div id='container'>
    <script src='${path }/resources/js/common/header.js'></script>
    