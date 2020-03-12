<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<c:set var="dept" value="" />
<c:if test="${ not empty sessionScope.id}">
	<c:set var="dept" value="${sessionScope.dept}" />
</c:if>

<c:set var="position" value="" />
<c:if test="${ not empty sessionScope.id}">
	<c:set var="position" value="${sessionScope.position}" />
</c:if>

<c:set var="name" value="Guest" />
<c:if test="${ not empty sessionScope.id}">
	<c:set var="name" value="${sessionScope.id}" />
</c:if>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
/* #decorator {
	background-image:
		url("${pageContext.request.contextPath}/image/joker1.jpg");
	background-repeat: no-repeat;
	background-position: center;
	background-size: 35% 50%;
} */

#dTag {	
}

#myimg{
width:350px;
height:300px;
}

#dTagStyle2 .font{
width:50px;
}
</style>

</head>

<body>
	<br />
	<br />
	<br />
	<br />
	<br />
	<div id="dTagStyle1">
<%-- 		<font color="white">${name} ${position}님</font> --%>
	</div>
	
	<div id="dTagStyle2">
		<font color="white">Hello</font>
		<font color="blue">G</font>
		<font color="red">o</font>
		<font color="yellow">o</font>
		<font color="blue">g</font>
		<font color="green">l</font>
		<font color="red">e</font>
		<font color="white">World!</font>
	</div><br>
	<img alt="등록된 사진이 없습니다." id="myimg" src="${pageContext.request.contextPath}/image/냥2.gif"  />
	
	<script>
		document.getElementById("dTagStyle1").style.font = "bold 45px 휴먼고딕체";
		document.getElementById("dTagStyle2").style.font = "bold 45px 휴먼고딕체";
	</script>
	
</body>
</html>