<%@page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel=stylesheet href="<c:url value='/css/memo.css' />"
	type="text/css">
<title>진행상황</title>
<style>
.notice{
	vertical-align: top;
	height:80px;
	background-color: #ff8080;
	padding-left:20px;
	padding-top:20px;
	box-shadow: 2px 2px gray;
	font-size: 15px;
	font-style: bold;
}
</style>
</head>
<body leftmargin="0" bgcolor="#DFE5DD">
	<br>
	<table style="width: 100%; border-collapse: collapse">
		<tr>
			<td style="vertical-align: top; text-align: left; width: 130px;">
				<!-- 왼쪽 사이드(로고, 메뉴) 구성 -->
				<table>
					<tr>
						<td><a
							href="<c:url value='http://localhost:8080/StudySet/user/group/list' />">
								<img src="<c:url value='/images/studysetlogo.png'/>"
								width="130px" />
						</a> <br> <br></td>
					</tr>
					<tr>
						<td><jsp:include page="../menu.jsp" flush="false" /></td>
					</tr>
				</table>
			</td>
			<td style="vertical-align: top">
				<table style="width: 100%; padding: 20px;">
					<!-- 메인화면 -->
					<tr>
						<td>
							<h2>&nbsp;&nbsp;${studyGroup.groupName}</h2>
							<h4 style="color: gray">&nbsp;&nbsp; 진행 상황</h4>
						</td>
					</tr>
					<tr>
						<td style="padding-left: 40px; padding-right:40px; float: left; min-width: 100%;">
							<div style="display:flex; position: relative; flex-grow:1; padding-bottom: 180px;">
								<div style="position:absolute; background:#DFE5DD; height: 42px; padding-top:8px; z-index: 85; display: flex; box-shadow: white -3px 0px 0px; min-width: 100%;">
									<div style="height: calc(100% + 17px); background: ivory; width: 20px; margin-left: -20px; margin-top: -17px;">
										<div style="display:flex; align-items:center; font-size:14px; width:260px; padding-left:5px; padding-right:5px; margin-right: 10px; margin-bottom:0px; box-sizing:content-box; flex-shrink:0; cursor: pointer;">
											<div style="display: block;">${loginmember.userName}</div>
										</div>
									<%
									int count = (int)request.getAttribute("count");
									for (int i = 0; i < count; i++ ) {
										%>
										<div style="display:flex; align-items:center; font-size:14px; width:260px; padding-left:5px; padding-right:5px; margin-right: 10px; margin-bottom:0px; box-sizing:content-box; flex-shrink:0; cursor: pointer;">
											<div style="display: block;">멤버${i+1}</div>
										</div>
									<%
									}
									%>
									</div>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="padding-left: 40px; padding-right:40px; float: left; min-width: 100%;">
							<table style="width:80%; border-spacing:5px;">
								<tr>
									<td class="notice"><b>새로운 메모</b><br><br>
										<name style="color:#696969">add a new note</name></td>
								</tr>
								<tr>
									<td class="notice" style="background-color:orange">
										<b>JDBC란?</b><br><br>
										Java DataBase Connectivity의 약어로, Java Application과 DBMS를 연동하기 위한 API이다. JDBC 드라이버를 사용하면 DBMS에 독립적인 프로그래밍이 가능하다.
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>