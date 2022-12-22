<%@page contentType="text/html; charset=utf-8"%>
<%@page import="java.util.*, model.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel=stylesheet href="<c:url value='/css/modal.css' />"
	type="text/css">
<link rel=stylesheet href="<c:url value='/css/task.css' />"
	type="text/css">	
<title>StudySet: ${studyGroup.groupName}_과제 홈</title>
<style>
.black_bg {
	display: none;
	position: absolute;
	content: "";
	width: 100%;
	height: 107%;
	background-color: rgba(0, 0, 0, 0.5);
	top: 0;
	left: 0;
	z-index: 1;
}
.txt {
	color:white;
	text-align:center;
	font-size:20px;
	padding-right:10px;
	padding-bottom:30px;
}
.scroll {
	position: absolute;
	width: 80%;
	height: 70%;
	left: 221px;
	top: 309px;
	bottom: -154px;
	background: #CBD1CA;
	border-radius: 20px;
	overflow: auto;
	scrollbar-width: thin;
}
.scroll::-webkit-scrollbar {
	width: 10px;
}
.scroll::-webkit-scrollbar-thumb {
	background-color: #2f3542;
	border-radius: 10px;
}
.scroll::-webkit-scrollbar-track {
	background-color: grey;
	border-radius: 10px;
	box-shadow: inset 0px 0px 5px white;
}
</style>
<script>
	window.onload = function() {

		function onClick() {
			document.querySelector('.modal_wrap').style.display = 'block';
			document.querySelector('.black_bg').style.display = 'block';
		}
		function offClick() {
			document.querySelector('.modal_wrap').style.display = 'none';
			document.querySelector('.black_bg').style.display = 'none';
		}

		document.getElementById('modal_btn').addEventListener('click', onClick);
		document.querySelector('.modal_close').addEventListener('click',
				offClick);
	};
</script>
</head>
<body leftmargin="0" bgcolor="#DFE5DD">
	<br>
	<table style="width: 100%; border-collapse: collapse">
		<tr>
			<td rowspan='2' style="text-align: left; width: 130px;"><a
				href="<c:url value='http://localhost:8080/StudySet/user/group/list' />">
					<img src="<c:url value='/images/studysetlogo.png'/>" width="130px" />
			</a></td>
			<td class="title" style="text-align: left; vertical-align: top;"><br>
				<br> <br> &nbsp;&nbsp;&nbsp;&nbsp;${studyGroup.groupName}
				스터디</td>
		</tr>
		<tr>
			<td class="title">&nbsp;&nbsp;&nbsp;&nbsp;과제</td>
			<td>
				<p id="modal_btn" class="btn">
					<a href="#modal1" rel="modal:open" type="button"
						class="txt">과제생성</a>
				<div class="black_bg"></div>
				</p>
			</td>
		</tr>
		<tr>
			<td style="height: 30px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3"><jsp:include page="../menu.jsp" flush="false" /></td>
		</tr>
		<tr>
			<td style="overflow: auto;" class="scroll">
				<table
					style="border-collapse: collapse; border-spacing: 0; width: 90%; margin-left: 58px; margin-top: 15px;">
					<c:forEach var="task" items="${list}">
						<tr valign="top">
							<td colspan="4" class="contents"
								style="margin-bottom: 10px; vertical-align: middle"><a
								style="left:30px;"
								href="<c:url value='/group/task/detail'>
								<c:param name="taskId" value="${task.taskId}" />
								</c:url>">&nbsp;&nbsp;&nbsp;&nbsp;${task.name}</a></td>
							<td class="contentsTime2"
								style="vertical-align: middle; text-align: -webkit-center;">
								&nbsp;&nbsp;&nbsp;&nbsp;제출기한:&nbsp;&nbsp;<fmt:parseDate
									value="${task.startDate}" pattern="yyyy-MM-dd"
									var="parsedRegDate" type="date" /> <fmt:formatDate
									value="${parsedRegDate}" pattern="yyyy/MM/dd" />&nbsp;&nbsp;~&nbsp;&nbsp;
								<fmt:parseDate value="${task.endDate}" pattern="yyyy-MM-dd"
									var="parsedRegDate" type="date" /> <fmt:formatDate
									value="${parsedRegDate}" pattern="yyyy/MM/dd" />
							</td>
						</tr>
						<tr style="height: 10px;">
							<td></td>
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>
	</table>
	<div style="display: none; height: 550px;" class="modal_wrap">
		<!--스터디생성 모달창 영역-->
		<div class="modal_close">
			<a href="#">close</a>
		</div>
		<div align="center">
			<jsp:include page="create.jsp"></jsp:include>
		</div>
	</div>
</body>
</html>