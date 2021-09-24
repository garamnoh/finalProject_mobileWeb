<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body{display:flex; justify-content:center; align-items:center; height:100vh;}
	body>div{display:flex; flex-direction:column; justify-content:center;}
	body>div>img{width:300px; margin-bottom: 20px;}
	body>div>span{font-size: 50px; font-weight: 600; color: #dddcdc; text-align: center;}
</style>
</head>
<body>
	<div>
		<img src='${path }/resources/image/etc/errorPage.png'>
		<span>Error Page</span>
	</div>
</body>
</html> 