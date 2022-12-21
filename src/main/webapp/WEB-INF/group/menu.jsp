<%@page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<style>
.menuItem{
	height: 140px;
	text-align: center;
}
.menuItem:hover{
	height: 200px;
	background-color: white;
	color:white;
}
.menuItem a{
	color:black;
	font-size: 1.2rem;
	font-weight: bold;
	text-decoration:none;
}
.menuItem a::after:hover{
	color:blue;
	font-size: 1.2rem;
	font-weight: bold;
	text-decoration:underline;
}
</style>
</head>
<body>
	<form>
	<table style="width:130px; background-color:#72C6A5" >
		<tr class="menu"><td class="menuItem"><a href="<c:url value='/group/main' />">홈</a></td></tr>
		<tr><td class="menuItem" ><a href="<c:url value='/schedule/calendar' />">일정</a></td></tr>
		<tr><td class="menuItem"><a href="<c:url value='/group/task/main' />">과제</a></td></tr>
		<tr><td class="menuItem"><a href="<c:url value='/group/memo/memo' />">진행상황</a></td></tr>
		<tr><td class="menuItem"><a href="<c:url value='/group/money/dues' />">회비</a></td></tr>
	</table>
	</form>
</body>
</html>