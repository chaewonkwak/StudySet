<%@page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel=stylesheet href="<c:url value='/css/memo.css' />"
	type="text/css">
<link rel=stylesheet href="<c:url value='/css/font.css' />"
	type="text/css">
<title>진행상황</title>
<style>
.tb {
	background-color: #c0c0c0;
	border-radius: 20px;
	width: 400px;
	height: 600px;
	text-align: top;
}

.notice {
	vertical-align: top;
	height: 80px;
	background-color: #ff8080;
	padding-left: 20px;
	padding-top: 20px;
	box-shadow: 2px 2px gray;
	font-size: 15px;
	font-style: bold;
}

[contenteditable="true"]:empty:before {
	content: attr(placeholder);
}

div[contenteditable=true] {
	color: #696969;
	padding: 5px;
}
</style>
<script>
	function gc() {
		form1.submit();
	}
</script>
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
						<td colspan="${count}">
							<h2>&nbsp;&nbsp;${studyGroup.groupName}</h2>
							<h4 style="color: gray">&nbsp;&nbsp; 진행상황</h4> <br> <br>
						</td>
					</tr>
					<tr>
						<td style="float: left; overflow-x: auto; white-space: nowrap;">
						<form name="form1" method="POST" action="<c:url value='/group/memo'>
						<c:param name="groupId" value="${group.groupId}" />
						<c:param name="userId" value="${loginmember.userId}" />
					</c:url>">
							<table>
								<tr>
									<c:forEach items="${groupMemberList}" var="member">
											<c:set var="i" value="${i+1}" />
											<td>
												<div>
													<table style="border-spacing: 5px; table-layout: fixed"
														class="tb">
														<tr>
															<td><h2>${member.userName}</h2></td>
														</tr>
														<c:if test="${member.userId eq loginmember.userId}">
														<tr>
															<td style="text-align:right;">
															<input type="button" value="메모 등록" onClick="gc()"></td>
														</tr>
														</c:if>
														<c:if test="${member.userId ne loginmember.userId}">
														<tr>
															<td style="text-align:right;">
															<input type="button" value="등록 불가" onClick="gc()"></td>
														</tr>
														</c:if>
														<tr>
															<td>
																<div class="scroll" style="height: 560px; overflow-y: scroll;">
																	<table
																		style="padding: 5px; table-layout: fixed; width: 370px;">
																		<tr>
																		<c:if test="${member.userId eq loginmember.userId}">
																			<td class="notice"
																				style="background-color:${colorArr[i-1]}; overflow-y: auto; ">
																				
																				<textarea style="background-color:transparent;" name="memoContents" rows="5" cols="40" placeholder="add a new note.." onfocus="this.placeholder=''" onblur="this.placeholder='add a new notes..'"></textarea> <br>
																				
																				<br>
																			</td>
																			</c:if>
																		</tr>
																		<c:forEach items="${memoList}" var="memo">
																			<c:if test="${memo.userId eq member.userId}">
																				<tr>
																					<td class="notice"
																						style="background-color:${colorArr[i-1]}; overflow-y: auto; ">
																						${memo.memoContents}</td>
																				</tr>
																			</c:if>
																		</c:forEach>
																	</table>
																</div>
															</td>
														</tr>
													</table>
												</div>
											</td>
											<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
									</c:forEach>
								</tr>
							</table></form>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>