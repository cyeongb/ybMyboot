<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>

<script>



$(document).ready(function(){
	
	$("#result").css({"color":"#896AB7","text-align":"center","font-weight":"bold","font-size": "large"});
	$("#loginB").keydown(function(key){  
		if(key.keyCode == 13){
			alert("엔터누름")
			login;
		}
		
	});
 	$("#loginB").click(login);
	
});

	function login(){		
		$.ajax({
			url : "${pageContext.request.contextPath}/login",
			data:{
			//	"method":"empLogin",
				"name":$("#empName").val(),
				"empCode":$("#empCode").val() //전체부서/회계팀/인사팀/전산팀
			},
			dataType : "json",
			success : function(data){
				if(data.me=="enter"){
					location.href="main.html"
				}else{
					$("#result").html(data.errorMsg);
				}
			}
		});	  
	}
</script>
</head>
<body>
	<br>
	<center>
		<font color="white" style="font-size: 50px; font-weight: bold;">L o g i n</font>
		<br>
		<br>
		<br>

		<table>
			<tr>
				<td><font color="white">사원명</font></td>
				<td><input class="ui-button ui-widget ui-corner-all" type="text" name="name" id="empName"></td>
			</tr>

			<tr>
				<td><font color="white">사원코드</font></td>
				<td><input class="ui-button ui-widget ui-corner-all" type="password" name="empCode" id="empCode"></td>
			</tr>

			<tr>
				<td colspan="2"><div id="result">&nbsp;</div></td>
			</tr>

			<tr>
				<td colspan="2" align="center">
					<input class="ui-button ui-widget ui-corner-all" type="button" value="로그인" id="loginB" > 
					<input class="ui-button ui-widget ui-corner-all" type="reset" value="취소" id="cancle">
				</td>
			</tr>
		</table>


		<%-- 비밀번호 틀리면 화면이동
	<form action="${pageContext.request.contextPath}/login.do">
	<table>
		<tr>
			<td>사원명</td>
			<td><input class="ui-button ui-widget ui-corner-all" type="text" name="name" id=userID></td>
		</tr>
		<tr>
			<td>사원코드</td>
			<td><input class="ui-button ui-widget ui-corner-all" type="password" name="empCode"></td>
		</tr>
		<tr>
			<td colspan="2">				
				<input class="ui-button ui-widget ui-corner-all" type="submit" value="로그인">
				<input class="ui-button ui-widget ui-corner-all" type="reset" value="취소">
				<div id="result"></div>
			</td>
		</tr>
	</table>
	${requestScope.errormsg}
	</form> --%>
	</center>
</body>
</html>