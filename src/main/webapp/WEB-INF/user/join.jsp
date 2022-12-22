<%@page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="model.dao.*" %>
<html>
<head>  
<title>StudySet 회원가입</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel=stylesheet href="<c:url value='/css/user.css' />" type="text/css">
<link rel=stylesheet href="<c:url value='/css/font.css' />" type="text/css">
<style type="text/css">
.info{
font-size: 7px;
color: red;
}

.checkBtn{
color:black;
background-color:#C1BDBD;
border-radius:5px;
border:0px;
width:70px;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>   
    function setEmailDm(){
        form.email.value+=form.emailDomain.value;
    } 
    
    function checkPwd(){
    	if (form.password.value == "") {
			alert("비밀번호를 입력하십시오.");
			form.password.focus();
			return false;
		}
    	if (form.password.value != form.password2.value) {
			alert("비밀번호가 일치하지 않습니다.");
			form.name.focus();
			return false;
		}
    	else
    		alert("확인 완료");
    }
    
    
	function userCreate() {
		if (form.userId.value == "") {
			alert("사용자 ID를 입력하십시오.");
			form.userId.focus();
			return false;
		}
		if (form.password.value == "") {
			alert("비밀번호를 입력하십시오.");
			form.password.focus();
			return false;
		}
		
		if (form.password.value != form.password2.value) {
			alert("비밀번호가 일치하지 않습니다.");
			form.name.focus();
			return false;
		}
		
		if (form.name.value == "") {
			alert("이름을 입력하십시오.");
			form.name.focus();
			return false;
		}
		
		var emailExp = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		if (emailExp.test(form.email.value) == false) {
			alert("이메일 형식이 올바르지 않습니다.");
			form.email.focus();
			return false;
		}
		
		var phoneExp = /^\d{2,3}\d{3,4}\d{4}$/;
		if (phoneExp.test(form.phone.value) == false) {
			alert("전화번호 형식이 올바르지 않습니다.");
			form.phone.focus();
			return false;
		}
		if(form.phone.value.length != 11){
			alert("전화번호 형식이 올바르지 않습니다.");
			form.phone.focus();
			return false;
		}
		
		if (form.chkbtn.value == false) {
			alert("개인정보 활용 약관을 확인해주세요.");
				return false;
		}
		form.submit();
	}

	function userList(targetUri) {
		form.action = targetUri;
		form.submit();
	}
	
	function checkId(){
		if (form.userId.value == "") {
			alert("사용자 ID를 입력하십시오.");
			form.userId.focus();
			return false;
		}
		form.method = "GET";
		form.submit();
	}
</script>
</head>
<body bgcolor="099987">
	<!-- 화면 로드 시 서버로부터 커뮤니티 목록을 가져와 commSelect 메뉴 생성 -->
	<br>
	<!-- registration form  -->
	<form name="form" method="POST"
		action="<c:url value='/user/register' />">
		<table style="width: 100%">
			<tr>
				<td align="center">
				<a href="<c:url value='/main'/>"><img src="<c:url value='/images/studysetlogo.png' />" /></a>		
				<br><br>
					<table class="tableForm" style="width: 40%">
						<tr height="70">
							<td colspan="2" style="text-align: center"><b>회원가입</b></td>
						</tr>
						<tr height="50">
							<td align="center">ID</td>
							<td style="padding-left: 10">
							<input type="text" style="width: 70%" name="userId" class="input-field"
								maxlength="15" value="${param.userId}"> 
								&nbsp;&nbsp;<input type="button"
								value="중복체크" onClick="checkId()" class="checkBtn">
								<c:if test="${ExistId eq true}"><br><span class="info">존재하는 아이디 입니다.</span></c:if>
								<c:if test="${ExistId eq false}"><br><span class="info">사용 가능한 아이디 입니다.</span></c:if>
								</td>
						</tr>
						<tr height="50">
							<td align="center">비밀번호</td>
							<td style="padding-left: 10">
							<input type="password"	style="width: 70%" name="password" class="input-field"
								maxlength="20" value="${param.password}"></td>
						</tr>
						<tr height="50">
							<td align="center">비밀번호 확인</td>
							<td style="padding-left: 10"><input type="password"
								style="width: 70%" name="password2" class="input-field"
								maxlength="20"> &nbsp;&nbsp;<input type="button"
								value="확인" onClick="checkPwd()" class="checkBtn" value="${password}"></td>
						</tr>
						<tr height="50">
							<td align="center">이름</td>
							<td style="padding-left: 10"><input type="text"
								style="width: 70%" name="name" 
								class="input-field" maxlength="20" value="${param.name}"></td>
						</tr>
						<tr height="50">
							<td align="center">전화번호</td>
							<td style="padding-left: 10"><input type="text" style="width: 70%" name="phone"
								class="input-field" maxlength="11" value="${param.phone}"> &nbsp;&nbsp;</td>
						</tr>
						<tr height="50">
							<td align="center">생년월일</td>
							<td style="padding-left: 10"><input name="birth" type="date"
								style="width: 70%" max="2077-06-20" min="1900-01-01"
								value="2022-11-17" class="input-field" value="${param.birth}"></td>
						</tr>
						<tr height="50">
							<td align="center">이메일</td>
							<td style="padding-left: 10"><input type="text"
								style="width: 70%" name="email" class="input-field"
								maxlength="50" value="${param.email}">
								<select name="emailDomain" title="이메일 주소 선택" onChange="setEmailDm()">
									<option value="">직접입력</option>
									<option value="@naver.com">naver.com</option>
									<option value="@nate.com">nate.com</option>
									<option value="@gmail.com">gmail.com</option>
									<option value="@yahoo.com">yahoo.com</option>
									<option value="@hanmail.net">hanmail.net</option>
							</select></td>
						</tr>
						<tr height="50">
							<td></td>
						</tr>
					</table> <br>
					<table style="width: 40%">
						<tr>
							<td align="center"><input name="chkbtn" type="checkbox"> 개인정보 수집 및
								이용 동의<br> <br> <input type="button" value="가입"
								onClick="userCreate()" class="btn"></td>
						</tr>
					</table></td>
			</tr>
		</table>
	</form>
</body>
</html>