<%@page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="model.dao.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel=stylesheet href="<c:url value='/css/task.css' />"
	type="text/css">
<link rel=stylesheet href="<c:url value='/css/modal.css' />"
	type="text/css">
<script>
	function gc() {
		form1.submit();
	}
	function remove() {
		var cmId = document.getElementById("comment_id").value;
		alert('${userId}' + cmId + '${userName}');
	}
</script>
<style>
.comm {
	width: 97.6%;
	background: rgba(179, 224, 143, 0.4);
	border-radius: 10px;
	height: 52px;
}

.comm_con {
	margin-top: 0.5%;
	margin-left: 2%;
	margin-right: 10%;
	margin-bottom: 0.3%;
	background: white;
	border-radius: 8px;
	height: 35px;
}

.scroll {
	overflow: auto;
	height: 600px;
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
.updateBtn{
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
    text-align:center;
}
</style>
<title>${task.name}_${userName}과제</title>
</head>
<body leftmargin="0" bgcolor="#DFE5DD">

<c:if test="${ param.success eq 1}">
<script>
	alert('댓글이 삭제되었습니다.');
	history.replaceState({}, null, location.pathname);
</script>
</c:if>
	<br>
	<table style="width: 100%; border-collapse: collapse">
		<tr>
			<td style="text-align: left; width: 130px;"><a
				href="<c:url value='http://localhost:8080/StudySet/user/group/list' />">
					<img src="<c:url value='/images/studysetlogo.png'/>" width="130px" />
			</a></td>
			<td style="text-align: left"><br> <br> <br>
				<h2>&nbsp;&nbsp;&nbsp;&nbsp;${task.name}_${userName}</h2></td>
			<td><a href="<c:url value='/group/task/submit/update' />"
				class="updateBtn">
					수정하기</a></td>
		</tr>
		<tr>
			<td style="height: 30px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3"><jsp:include page="../menu.jsp" flush="false" /></td>
		</tr>
	</table>
	<table>
		<tr>
			<td>
				<hr>
				<div class="task_back">
					<br> &nbsp;&nbsp;
					<fmt:parseDate value="${submit.submitDate}" pattern="yyyy-MM-dd"
						var="parsedRegDate" type="date" />
					<fmt:formatDate value="${parsedRegDate}" pattern="yyyy/MM/dd" />
					<hr>
					 &nbsp;&nbsp;${submit.submitContents} <br><br><br><br><br><br><br><br><br><br><hr>파일경로:${submit.filePath}<br>     
				</div>
			</td>
		</tr>
	</table>
	<div
		style="position: absolute; height: 25%; left: 12%; top: 69%; overflow: auto;"
		class="scroll">
		<table>
			<c:forEach var="comment" items="${list}">
				<tr valign="top">
					<td class="comm">
						<div class="comm_con">
							<c:if test="${comment.annonymous eq 'Y'.charAt(0)}">&nbsp;&nbsp;익명</c:if>
							<c:if test="${comment.annonymous eq 'N'.charAt(0)}">&nbsp;&nbsp;${comment.userId}</c:if>	
							&nbsp;|&nbsp;&nbsp;${comment.commentContents}
						</div>
					</td>
					<td width="34px"><c:if test='${comment.userId eq loginmember.userId}'>
							<a
								href="<c:url value='/group/comment/remove'>
								<c:param name='userId' value='${userId}' />
								<c:param name='userName' value='${userName }' />
								<c:param name='commentId' value='${comment.commentId}' /></c:url> ">
								<img src="<c:url value='/images/remove.png'/>" />
							</a>
						</c:if></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div
		style="position: absolute; width: 80%; height: 25%; left: 12%; top: 95%;">
		<form name="form1" method="POST" class="comment_td"
			action="<c:url value='/group/task/submit'>
		<c:param name="userId" value="${userId}" />
		<c:param name="userName" value="${userName}" />
		<c:param name="taskId" value="${task.taskId}" />
			<c:param name="taskId" value="${submit.submitId}" /></c:url>">
			<input type="text" name="commentContents" placeholder="피드백을 남겨주세요."
				class="comment_input"><label class="annonymous"> <input
				type="checkbox" name="annonymous" value="1" class="ann_box">
				<input type="checkbox" name="annonymous" value="N" class="ann_box">익명
			</label> <input type="button" onClick="gc()" class="comment_submit" value="↑">
		</form>
	</div>
</body>
</html>