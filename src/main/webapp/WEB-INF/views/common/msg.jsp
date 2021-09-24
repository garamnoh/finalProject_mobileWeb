<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt' %>

<c:set var='path' value='${pageContext.request.contextPath }'/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <meta name="author" content="garamNoh">
    <title>msg</title>
    
    <!-- font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap">

    <!-- style -->
    <link rel="stylesheet" href="${path }/resources/css/common/reset.css">

    <!-- jQuery -->
    <script src='${path }/resources/js/common/jquery-3.6.0.min.js'></script>
    
    <!-- sockJS -->
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<script src='${path }/resources/js/common/websocket.js'></script>
</head>

<body>
	<script>
		var msg = '${msg}';
		if(!msg=='none') alert(msg);
		location.replace('${path}${loc}');
	</script>
</body>
</html> 