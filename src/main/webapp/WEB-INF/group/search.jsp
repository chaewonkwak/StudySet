<%@page contentType="text/html; charset=utf-8"%>
<%@page import="java.util.*, model.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>그룹원 검색 모달창</title>
<script>
function search{
	form.method="GET";		// member 검색
	form.submit();
}    
</script>
</head>
<body>
	<h2>그룹원 검색</h2>
	<form name="searchForm" method="GET"
		action="<c:url value='/group/member' />">
		<input name="srchMem" type="text" placeholder="그룹원 이름 입력">
		<button>검색</button>
	</form>
	<br>

	<c:choose>
		<c:when test="${findMemberList ne null}">
			<c:forEach var="mem" items="${findMemberList}">
				<hr>${mem.userName} | 
			 연락처: ${mem.phone}&nbsp; <a href="mailto:${mem.email}">${mem.email}</a><br>
				<hr>
			</c:forEach>
		</c:when>
		<c:when test="${findMemberList eq null}">
		검색 결과 없음
		</c:when>
		<c:otherwise>
			그룹원 검색
		</c:otherwise>
	</c:choose>
</body>
</html>