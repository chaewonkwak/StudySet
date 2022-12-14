<%@page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html>
<html>
<head>
<title>스터디 가입 모달창</title>
<style>
#formInput {
   width:250px; 
   height:40px;
   border:0 solid black;
   background-color: #F2E03B;
   opacity: 0.5;
   border-radius: 5px;
}
#submitBtn {
   width: 80px;
   height: 35px;
   border-radius: 7px;
   background-color: black;
   color: white;
}
.item {
   height: 10px;
   background-color: #FFFFFF;
   margin: auto;
   border-radius: 20px;
   color: black;
}
.searchField {
   width: 90%;
   font-size: 23px;
   border: 1;
   border-radius: 20px;
   text-align: center;
}
</style>
<script>
function gc2(){
   if (form2.groupName.value == "") {
      alert("그룹명을 입력해주세요.");
      form2.groupName.focus();
      return false;
   }

   if (form2.code.value == "") {
      alert("코드를 입력해주세요.");
      form2.code.focus();
      return false;
   }
   form2.submit();
}
</script>
</head>
<body>
   <form name="form2" method="POST" autocomplete="off" action="<c:url value = '/group/member'/> ">
      <div style="text-align:center;">
            <p>가입할 그룹 이름</p>
            <input type="text" id="formInput" name="groupName"/>
            <p>그룹 코드</p>
            <input type="text" id="formInput" name="code" style="background-color:#E6E6E6;" placeholder="가입 시 필요한 6자리 숫자 코드" maxlength="6"/>
            <br/><br/>
            <input type="button" onClick="gc2()" id="submitBtn" value="가입"></input>                                                      
      </div>
   </form>   
</body>
</html>