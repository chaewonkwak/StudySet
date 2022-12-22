<%@page contentType="text/html; charset=utf-8"%>
<%@page import="java.util.*, model.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel=stylesheet href="<c:url value='/css/user.css' />"
	type="text/css">
<link rel=stylesheet href="<c:url value='/css/modal.css' />"
	type="text/css">
<link rel=stylesheet href="<c:url value='/css/font.css' />" type="text/css">
<title>StudySet</title>
<script>
	window.onload = function() {
		//나중에 반복문 처리
		const modal = document.querySelectorAll('.modal_wrap');

		function onClick() {
			const item = modal.item(0);
			item.style.display = 'block';
	        document.querySelector('.black_bg').style.display ='block';
		}
		function onClick2() {
			const item = modal.item(1);
			item.style.display = 'block';
	        document.querySelector('.black_bg').style.display ='block';
		}
	    function onClick3() {
	        const item = modal.item(2);
	        item.style.display = 'block';
	        document.querySelector('.black_bg').style.display ='block';
	      }
		function offClick() {
			const item = modal.item(0);
			item.style.display = 'none';
			document.querySelector('.black_bg').style.display ='none';
		}
		function offClick2() {
			const item = modal.item(1);
			item.style.display = 'none';
			document.querySelector('.black_bg').style.display ='none';
		}
		function offClick3() {
			const item = modal.item(2);
			item.style.display = 'none';
			document.querySelector('.black_bg').style.display ='none';
		}

		document.getElementById('modal_btn').addEventListener('click', onClick);
		document.getElementById('modal_btn2').addEventListener('click', onClick2);
	    document.getElementById('modal_btn3').addEventListener('click', onClick3);
		document.querySelector('.modal_close').addEventListener('click', offClick);
		document.querySelector('.modal_close2').addEventListener('click', offClick2);
		document.querySelector('.modal_close3').addEventListener('click', offClick3);
	};

	function search() {
		if (event.keyCode == 13) {
			searchForm.submit();
		}
	}
</script>
<style>
.item:hover{background-color: powderblue;
border: 3px solid black;
.black_bg{
    display: none;
    position: absolute;
    content: "";
    width: 100%;
    height: 100%;
    background-color:rgba(0, 0, 0, 0.35);
    top:0;
    left: 0;
    z-index: 1;
}
</style>
</head>
<body bgcolor="099987">
	<c:if test="${ param.registerSuccess eq false}">
		<script>
			alert('이미 존재하는 그룹입니다.');
			history.replaceState({}, null, location.pathname);
		</script>
	</c:if>
	<c:if test="${ param.registerSuccess eq true}">
		<script>
			alert('새로운 그룹이 생성되었습니다.');
			history.replaceState({}, null, location.pathname);
		</script>
	</c:if>
	<c:if test="${ param.joinGroupSuccess eq false}">
		<script>
			alert('존재하지 않는 그룹입니다.');
			history.replaceState({}, null, location.pathname);
		</script>
	</c:if>
	<c:if test="${ param.alreadyJoinGroup eq true}">
		<script>
			alert('이미 가입한 그룹입니다.');
			history.replaceState({}, null, location.pathname);
		</script>
	</c:if>
	<c:if test="${ param.joinGroupSuccess eq true}">
		<script>
			alert('그룹 가입이 완료되었습니다.');
			history.replaceState({}, null, location.pathname);
		</script>
	</c:if>
	<table style="width: 100%">
		<tr>
			<td>
				<table style="width: 90%; border: 1; margin: auto;">
					<tr height="100px">
						<td style="text-align: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<img height="100px"
							src="<c:url value='/images/studysetlogo.png' />" />
						</td>
						<td align="right">
						<a href="<c:url value='/user/logout' />">
								<img src="<c:url value='/images/logout.png'/>" />
						</a> 
						</td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td style="text-align: left;"><h2>&nbsp;&nbsp;${loginmember.getUserName()}님의
								스터디</h2></td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<div style="float: right; width: 20%;">
								<p id="modal_btn2" class="btn">
									<a href="#modal" rel="modal:open" type="button"
										style="color: white;">&nbsp; 스터디 가입</a>
									<div class= "black_bg"></div>
								</p>
							</div>
							<div style="float: right; width: 20%;">
								<p id="modal_btn" class="btn">
									<a href="#modal" rel="modal:open" type="button"
										style="color: white;">&nbsp;스터디 생성</a>
									<div class= "black_bg"></div>
								</p>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2"><form name="searchForm"
								action="<c:url value='/user/group/list'/>">
								<table
									style="width: 100%; height: 650px; background-color: #C8E8E4; border-radius: 20px;">
									<tr>
										<td style="text-align: center; height: 100px;"><input
											type="text" placeholder="스터디를 검색해주세요" name="studyName"
											class="searchField" onkeypress="search();" /></td>
			                           <td style="text-align: center; height: 100px;">
			                              <p id="modal_btn3">
			                              <input type="text" placeholder="그룹원을 검색해주세요" name="memberName" class="searchField" href="#modal" rel="modal:open" readonly/>
			                              <div class= "black_bg"></div>
			                           </p> 
			                           </td>
									</tr>
									<tr>
										<td valign="top">
											<div style="overflow: auto; height: 600px;" class="scroll">
												<table width="100%">
															<c:forEach var="group" items="${joinList}">
																<tr>
																	<td style="height: 10px" class="item"><a
																		href="<c:url value='/group'><c:param name="groupId" value="${group.groupId}" />
                                          </c:url>">&nbsp;●&nbsp;${group.groupName}</a>
																	</td>
																</tr>
															</c:forEach>
														
												</table>
											</div>
										</td>
									</tr>
								</table>
							</form></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<div style="display: none; height: 460px;" class="modal_wrap">
		<!--스터디생성 모달창 영역-->
		<div class="modal_close">
			<a href="#">close</a>
		</div>
		<div align="center">
			<jsp:include page="makeGroup.jsp"></jsp:include>
		</div>
	</div>
	<div style="display: none; height: 270px;" class="modal_wrap">
		<!--스터디가입 모달창 영역-->
		<div class="modal_close2">
			<a href="#">close</a>
		</div>
		<div align="center">
			<jsp:include page="joinGroup.jsp"></jsp:include>
		</div>
	</div>
	<div class="modal_wrap" style="<c:if test='${searching eq null}'>display: none;</c:if>
   	<c:if test='${searching eq true}'>display: block;</c:if> height: 450px;">
      <!--그룹원 검색 모달창 영역-->
      <div class="modal_close3">
         <a href="#">close</a>
      </div>
      <div align="center">
         <jsp:include page="searchMember.jsp"></jsp:include> 
      </div>
	</div>
</body>
</html>