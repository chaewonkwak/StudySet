<%@page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel=stylesheet href="<c:url value='/css/task.css' />"
	type="text/css">
<title>과제 제출</title>
<script>
	function gc() {
		if (form1.submitContents.value == "") {
			alert("과제를 제출해주세요.");
			form1.submitContents.focus();
			return false;
		}
		alert("과제가 제출되었습니다.");
		form1.submit();
	}
	var now_utc = Date.now()
	var timeOff = new Date().getTimezoneOffset() * 60000;
	var today = new Date(now_utc - timeOff).toISOString().substring(0, 16);
	document.getElementById("DateLocal").setAttribute("max", today);
</script>
<style>
#formInput {
	width: 85%;
	height: 60%;
	border: 0 solid black;
	background-color: #BEEDCD;
	opacity: 0.5;
	border-radius: 5px;
	height: 60%;
	left: 16%;
}

#submitBtn {
	background-color: #F2673B;
	color: white;
	position: absolute;
	border-radius: 10px;
	border: 0;
	outline: 0;
	font-size: 20px;
	height: 45px;
	left: 86%;
	width: 103px;
}

.item {
	height: 10px;
	background-color: #FFFFFF;
	margin: auto;
	border-radius: 20px;
	color: black;
}

.task_submit_back2 {
	position: absolute;
    width: 73%;
    height: 74%;
    left: 15%;
    top: 24%;
    line-height: 30px;
    background: rgba(179, 224, 143, 0.72);
    border-radius: 20px;
    text-align: center;
}

.file_btn {
	box-sizing: border-box;
	position: absolute;
	width: 80%;
	height: 63px;
	left: 12%;
	top: 85%;
	background: #FFFFFF;
	border: 1px solid #000000;
	border-radius: 20px;
	font-family: 'Inter';
	font-style: normal;
	font-weight: 400;
	font-size: 25px;
	line-height: 30px;
	color: #000000;
	border: 1px solid #000000;
	border-radius: 20px;
	z-index: 2;
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
				<form name="form1" method="POST" autocomplete="off"
					action="<c:url value = '/group/task/submit/form'>
					<c:param name="submitId" value="${submit.submitId}" />
					<c:param name="userId" value="${loginmember.userId}" />
					</c:url>">
					<table style="width: 100%; padding: 20px;">
						<tr>
							<td>
								<h2>&nbsp;&nbsp;&nbsp;&nbsp;${task.name}:
									${loginmember.getUserName()}</h2> <input type="button"
								onClick="gc()" id="submitBtn" value="제출하기"></input>
								<div class="task_submit_back2">
									<h3>&nbsp;&nbsp;&nbsp;&nbsp;과제 작성란</h3><hr>
									&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"
										name="submitContents" id="formInput" placeholder="과제를 작성해주세요.">
									<br> <br> <br> <input type="file"
										name="filePath" class="file_btn" value="파일첨부"
										multiple="multiple" />
								</div>
							</td>
						</tr>
					</table>

				</form>
			</td>
		</tr>
	</table>
</body>
</html>