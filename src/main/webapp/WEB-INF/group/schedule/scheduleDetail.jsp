<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ĳ�� �󼼺���</title>
</head>
<body>
	<form name="editSchedulefrm" method="POST"
		action="<c:url value = '/schedule/calendar/detail' /> ">
		<p>
		<h2>���� �����ϱ�</h2>
		</p>
		<table style="width: 80%;" class="table">
			<tr>
				<td style="text-align: center;"><input type="text"
					placeholder="���� ����" name="sTitle" id="title" maxlength="20"> &nbsp;
					&nbsp;�߿� ����<input type="checkbox" name="importance" value="1"><br></td>
			</tr>
			<tr>
				<td><br>
				<h4>��¥</h4> <input type="date" name="sDate" class="inputField2" style="width: 500px; height: 30px;" 
				<c:if test='${param.date ne null}'>value="{param.date}"</c:if>></td>
			</tr>
			<tr>
				<td>
					<h4>�ð�</h4> <input class="inputField" type="time" name="startTime" style="width: 200px; height: 30px;">
					~ <input type="time" class="inputField" name="endTime" style="width: 200px; height: 30px;">
				</td>
			</tr>
			<tr>
				<td>
					<h4>���</h4> <input type="text" name="location" class="inputField"
					style="width: 500px; height: 30px;">
				</td>
			</tr>
			<tr>
				<td><br>
				<h4>���� ����</h4> <textarea class="inputField2" name="description"
						maxlength="80" style="width: 100%; height: 100px;"></textarea></td>
			</tr>
			<tr>
				<td align="center"><button onClick="submit()">����</button></td>
			</tr>
		</table>
	</form>
</body>
</html>