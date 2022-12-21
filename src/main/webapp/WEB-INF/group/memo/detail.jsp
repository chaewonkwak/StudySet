<%@page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel=stylesheet href="<c:url value='/css/memo.css' />"
	type="text/css">
<title>진행상황-상세</title>
</head>
<body leftmargin="0" bgcolor="#DFE5DD">
	<br>
	<table style="width: 100%; border-collapse: collapse">
		<tr>
			<td rowspan='2' style="text-align: left; width: 130px;"><img
				src="<c:url value='/images/studysetlogo.png'/>" width="100%" /></td>
			<td style="text-align: left; vertical-align: top;"><br> <br>
				<br> &nbsp;&nbsp;&nbsp;&nbsp;스터디</td>
		</tr>
		<tr>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;진행상황</td>
		</tr>
		<tr>
			<td style="height: 30px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;그룹원이름</td>
		</tr>
		<tr>
			<td colspan="3"><jsp:include page="../menu.jsp" flush="false" /></td>
		</tr>
		<div>
			<div name="back" class="memo_back">메모 작성~~~</div>
		</div>
		<form>
			<td class="comment_td"><input type="text" name="comment"
				placeholder="피드백을 남겨주세요." class="comment_input">
				<button type="submit" class="comment_submit">↑</button> <label
				class="annonymous"><input type="checkbox" name="ann_box"
					value="annonymous" class="ann_box">익명</label></td>
		</form>
	</table>
</body>
</html>