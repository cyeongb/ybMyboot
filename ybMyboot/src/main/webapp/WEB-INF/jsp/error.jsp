<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%-- 	<h1>${requestScope.errorMsg}</h1> --%>
<h1>Error Page</h1>
error code : <span th:text="${code}"></span>
    <br>error msg : <span th:text="${msg}"></span>
    <br>timestamp : <span th:text="${timestamp}"></span>
	<br />
	<a href="${pageContext.request.contextPath}/main.html" id="error"> 메인페이지로 이동 </a>
</body>
</html>