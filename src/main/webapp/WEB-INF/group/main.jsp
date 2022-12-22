<%@page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel=stylesheet href="<c:url value='/css/group.css'/>"
	type="text/css">
<link rel=stylesheet href="<c:url value='/css/modal.css'/>"
	type="text/css">

<title>StudySet: ${studyGroup.groupName}</title>
<style>
.btn {
   background-color: rgba(255, 255, 255, 0.8);
   color: white;
   width: 120px;
   height: 50px;
   border-radius: 10px;
   font-size: 18px;
   border:0;
}
.btn1{
   background-color: #FFFFFF;
   color: black;
   font-family: Arial;
   font-size: 16px;
   font-style: bold;
   height:30px;
   width:120px;
   border:1;
   border-radius:5px;
}
.black_bg{
    display: none;
    position: absolute;
    content: "";
    width: 100%;
    height: 107%;
    background-color:rgba(0, 0, 0, 0.5);
    top:0;
    left: 0;
    z-index: 1;
}
</style>
<script>
function leave() {
	var result = confirm("정말 " + '${studyGroup.groupName}' + "을 탈퇴하시겠습니까?");
	if(result){
	    alert("수고하셨어요! 2023년에도 화이팅!!");
	    leaveGroup.submit();
	    
	}else{
	    alert("정말 감사합니다. 앞으로도 열심히 공부해요~");
	}
};
    window.onload = function() {
 
    function onClick() {
        document.querySelector('.modal_wrap').style.display ='block';
        document.querySelector('.black_bg').style.display ='block';
    }   
    function offClick() {
        document.querySelector('.modal_wrap').style.display ='none';
        document.querySelector('.black_bg').style.display ='none';
        history.replaceState({}, null, '/StudySet/group/main');
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
						</a> <br>
						<br></td>
					</tr>
					<tr>
						<td><jsp:include page="menu.jsp" flush="false" /></td>
					</tr>
				</table>
			</td>
			<td style="vertical-align: top">
				<table style="width: 100%; padding: 20px;">
					<!-- 이 테이블 안에 메인 화면 구성하면 될듯 -->
					<tr>
						<td colspan="2">
							<h2>&nbsp;&nbsp;${studyGroup.groupName}</h2>
							<h4 style="color: gray">
								&nbsp;&nbsp;
								<c:choose>
									<c:when test="${studyGroup.groupCategory eq 1}">프로그래밍</c:when>
									<c:when test="${studyGroup.groupCategory eq 2}">외국어</c:when>
									<c:when test="${studyGroup.groupCategory eq 3}">디자인</c:when>
									<c:when test="${studyGroup.groupCategory eq 4}">취업</c:when>
									<c:when test="${studyGroup.groupCategory eq 5}">경영</c:when>
									<c:when test="${studyGroup.groupCategory eq 5}">기타</c:when>
								</c:choose>
							</h4>
						</td>
					</tr>
					<tr>
						<td><h4>${studyGroup.groupDescription}</h4></td>
						<td style="text-align:right; padding-right:10%;">
		                  <form name="leaveGroup" action="<c:url value='/group/leave' />"> 
			                  <input type="button" value="그룹 탈퇴 하기" style="font-size:15px; color:black; font-weight:bold;" class="btn"
			                     onClick="leave()" />
		                   </form>
						</td>
					</tr>
					<tr>
	                  <td><input type="button" value="가입 코드 보기" style="font-size:15px; color:black; font-weight:bold;" class="btn"
	                     onClick="alert('${studyGroup.code}')" /><br><br></td>
	                  <td>
	                     <div style="float: right; margin-right: 120px; width: 20%;">
	                        <p id="modal_btn" class="btn">
	                           <a href="#modal" rel="modal:open" type="button" style="font-size:17px; font-weight:bold;">&nbsp;&nbsp;그룹원 검색</a>
	                                 <div class="black_bg"></div>
	                             </p>
	                     </div>
	                     <br><br>
	                  </td>
					</tr>
					<tr>
						<td width="50%">
							<table class="tb">
								<tr style="height: 30px;">
									<td style="vertical-align: top;">
										<h3>&nbsp;&nbsp;주요 전달 사항</h3>
									</td>
								</tr>
								<tr>
									<td style="vertical-align: top; padding: 20px;">
										<table style="width:80%; border-spacing:5px;">
											<tr>
												<td class="notice" style="background-color:orange">
													<b>1월 2일 월요일 오전 4:00 - 6:00 서버 점검으로 인해 접속이 지연될 수 있습니다. 이용에 불편을 드려 죄송합니다.</b><br><br>
													<name style="color:#696969">서버관리자</name>
												</td>
											</tr>
											<tr>
												<td class="notice"><b>스터디셋 이벤트 진행 중!</b><br><br>
													<name style="color:#696969">스터디셋운영진</name></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table class="tb">
								<tr>
									<td style="vertical-align: top;"><h3>&nbsp;&nbsp;Quick
											Notes</h3></td>
								</tr>
								<tr>
									<td>
									<form name="note" action="<c:url value='/group'/>">
									<textarea name="quickNote" rows="30" cols="100" style="border: none; background: transparent;"></textarea>
									</form>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<div
		style="<c:if test='${searching eq null}'>display: none;</c:if>
	<c:if test='${searching eq true}'>display: block;</c:if> height: 300px;"
		class="modal_wrap">
		<!--모달창 영역-->
		<div class="modal_close">
			<a href="#">close</a>
		</div>
		<div align="center">
			<jsp:include page="search.jsp"></jsp:include>
		</div>
	</div>
</body>
</html>