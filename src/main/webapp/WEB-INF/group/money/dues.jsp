<%@page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel=stylesheet href="<c:url value='/css/money.css' />" type="text/css">
<link rel=stylesheet href="<c:url value='/css/modal.css' />" type="text/css">
<link rel=stylesheet href="<c:url value='/css/font.css'/>" type="text/css">
<title>StudySet: ${studyGroup.groupName}</title>
<style>
.black_bg{
    display: none;
    position: absolute;
    content: "";
    width: 100%;
    height: 100%;
    background-color:rgba(0, 0, 0, 0.5);
    top:0;
    left: 0;
    z-index: 1;
}
.test {
	border: 6px;
	background-color: #F2673B;
	position: absolute;
	border-radius: 10px;
	height: 45px;
	left: 90%;
	top: 190px;
	width: 100px;
	text-align:center;
}
.txt {
	color:white;
	text-align:center;
	font-size:20px;
	padding-right:10px;
	padding-bottom:30px;
}
</style>
<script>
	window.onload = function() {

		function onClick() {
			document.querySelector('.modal_wrap').style.display = 'block';
	        document.querySelector('.black_bg').style.display ='block';
		}
		function offClick() {
			document.querySelector('.modal_wrap').style.display = 'none';
			document.querySelector('.black_bg').style.display ='none';
		}

		document.getElementById('modal_btn').addEventListener('click', onClick);
		document.querySelector('.modal_close').addEventListener('click', offClick);
	};
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
					<!-- 이 테이블 안에 메인 화면 구성하면 될듯 -->
					<tr>
						<td colspan="2">
							<h2>&nbsp;&nbsp;${studyGroup.groupName}</h2>
							<h4 style="color: gray">&nbsp;&nbsp; 회비 납부 관리</h4>
						</td>
					</tr>
					<tr>
						<td width="50%" align="left">
						<form action="<c:url value="/group/money/payment"/>">
						<button class="btn2" onclick="submit()">
								<b>사용내역 확인하기</b>
							</button>
							</form> <br></td>
						<td width="50%" align="right" style="padding: 50px">
							<p id="modal_btn" class="test">
								<a href="#modal1" rel="modal:open" type="button" class="txt">입력하기</a>
								<div class="black_bg"></div>
							</p>
						</td>
					</tr>
					<tr>
						<td colspan="2" width="100%" align="left">
							<table class="back">
								<tr style="height: 40px;">
									<td><b>그룹원 이름</b></td>
									<td><b>납부 금액</b></td>
									<td><b>납부 날짜</b></td>
								</tr>
								<tr style="height: 30px;">
									<td colspan="3"><hr style="border: solid 3px black;"></td>
								</tr>
								<tr>
									<td width="100%" colspan="3">
											<c:forEach var="dues" items="${list}">
												<tr class="individualBack">
													<td>${dues.userName}</td>
													<td>${dues.price}</td>
													<td>
													<fmt:parseDate
							                           value="${dues.duesDate}" pattern="yyyy-MM-dd"
							                           var="parsedRegDate" type="date" /> <fmt:formatDate
							                           value="${parsedRegDate}" pattern="yyyy/MM/dd" />
													</td>
												</tr>
												<tr><td></td></tr>
											</c:forEach>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
<div style="display: none; height: 550px;" class="modal_wrap">
	<!--모달창 영역-->
	<div class="modal_close">
		<a href="#">close</a>
	</div>
	<div align="center">
		<jsp:include page="addDues.jsp"></jsp:include>
	</div>
</div>
</body>
</html>