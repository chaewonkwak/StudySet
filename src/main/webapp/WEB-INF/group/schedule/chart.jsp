<%@page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*, model.*"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<style type="text/css" media="screen">
#our_table {
	
}

th {
	width: 140px;
	background-color: #ccc;
}

#our_table td {
	width: 140px;
	height: 20px;
	text-align: center;
	vertical-align: middle;
}

table td.highlighted {
	background-color: rgba(0, 0, 0, 0.1);
}
</style>
<link rel=stylesheet href="<c:url value='/css/group.css' />" type="text/css">
</head>
<body leftmargin="0" bgcolor="#DFE5DD">
	<br>
	<table style="width: 100%; height: 100%;  border-collapse: collapse">
		<tr>
			<td style="vertical-align: top; text-align: left; width: 130px;">
				<!-- 왼쪽 사이드(로고, 메뉴) 구성 -->
				<table>
					<tr>
						<td>
							<a href="<c:url value='http://localhost:8080/StudySet/user/group/list' />">
							<img src="<c:url value='/images/studysetlogo.png'/>"
							width="130px" /><br> <br></td>
					</tr>
					<tr>
						<td><jsp:include page="../menu.jsp" flush="false" /></td>
					</tr>
				</table>
			</td>
			<td style="vertical-align: top">
				<table style="width: 100%; height: 100%; padding: 60px;">
					<tr>
						<td colspan="2">
							<h1>${studyGroup.groupName}</h1>
							<h2 style="color: gray">일정</h2>
						</td>
					</tr>
				
					<tr><td width="70%"><h2>스캐줄 조정 표&nbsp;&nbsp;&nbsp;&nbsp;</h2></td>
					<td><form action="<c:url value='/schedule/addchart'/>"><button class="btn1">추가하기</button></form></td>
					
					</tr>
					<tr>
						<td colspan="2">
							<table border="1" style="border-collapse: collapse"
								cellpadding="0" cellspacing="1" id="our_table">
								<tr>
									<th>시간(시)</th>
									<th>월</th>
									<th>화</th>
									<th>수</th>
									<th>목</th>
									<th>금</th>
									<th>토</th>
									<th>일</th>
								</tr>
								<c:forEach items="${chart}" var="time" varStatus="i">
									<tr>
										<th>${i.index+1} - ${i.index+2}</th>
										<!-- 안되는 시간만 색칠 -->
										<c:forEach items="${time}" var="day">
											<td style="background-color: rgba(0, 0, 0, 0.${day});"></td>
										</c:forEach>
									</tr>
								</c:forEach>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>