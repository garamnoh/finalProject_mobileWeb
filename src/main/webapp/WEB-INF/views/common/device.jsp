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
    <title>device</title>
    
    <!-- font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap">

    <!-- style -->
    <link rel="stylesheet" href="${path }/resources/css/common/reset.css">

    <!-- jQuery -->
    <script src='${path }/resources/js/common/jquery-3.6.0.min.js'></script>
</head>
<body>
	<form id='deviceForm' action='${path }/home.do' method='POST'>
		<input type='hidden' name='device' id='device'>
	</form>
    <script>
    	// navigator.platform
       	$(document).ready(function(){
    		var device = "win16|win32|win64|mac|macintel";
    		
    		if(navigator.platform) {
	            if(device.indexOf(navigator.platform.toLowerCase()) < 0) {
	                console.log('MOBILE');
	                $('#device').val('mobile');
	                $('#deviceForm').submit();
	            } else {
	                console.log('PC');
	                $('#device').val('pc');
	                $('#deviceForm').submit();
	            }
	        }
    	});
    	
    	
    	// navigator.userAgent
/*       	$(document).ready(function(){
    		var mobileBrower = /Android|WebOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
    		console.log("mobile", /Android|WebOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent));
    		
    		if(mobileBrower) { 
    			$('#device').val('mobile'); 
    			$('#deviceForm').submit(); 
   			}
    		else { 
    			$('#device').val('pc'); 
    			$('#deviceForm').submit(); 
   			}
    	}); */
	</script>
</body>
</html>