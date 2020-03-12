<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
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
	<c:set var="name" value="${sessionScope.id}님" />
</c:if>


<div id="loginInfo" align="right">	
		<font color="gray">현재접속자수 : ${applicationScope.ac} 명</font><br>	
		<font color="gray">${dept} ${position}</font><font> ${name}</font>
</div>

<div id="loginInfo" align="right">
	<c:if test="${empty sessionScope.id}">
		<a id="loginaTag"
			href='${pageContext.request.contextPath}/loginForm.html'> <!-- formaction? -->
			<input type="button" value="L o g i n" />
		</a>
		<br>
	</c:if>
	
	<c:if test="${not empty sessionScope.id}">
		<a id="logoutaTag" href='${pageContext.request.contextPath}/logout.do'>
			<input type="button" value="Log-Out"  />
		</a>
	</c:if>
</div>

<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
<style>
.ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover{
background:mediumpurple;
border:1px solid gray;
color:mistyrose;
}

.ui-widget-header {
border:1px solid gray;
background:darkmagenta;
}

.ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default, .ui-button, html .ui-button.ui-state-disabled:hover, html .ui-button.ui-state-disabled:active{

background:mediumpurple;
border:1px solid gray;
opacity:0.2rem;
color:white;
}

body {
	font-family: Arial, Helvetica, sans-serif;
	margin: 0;
}

.navbar {
	overflow: hidden;
	background-color: "";
}

.navbar a {
	float: left;
	font-size: 16px;
	color: gray;
	text-align: center;
	padding: 14px 16px;
	text-decoration: none;
}

.navbar a:hover, .subnav:hover .subnavbtn {
    transition: all 0.3s ease-in-out; 
   -webkit-transform:scale(1.3);
   -moz-transform:scale(1.2);
   -ms-transform:scale(1.2);   
   -o-transform:scale(1.2);
   }
   
/*    .navbar a:hover, .subnav:hover .subnavbtn .subnav-content { */
/*     transition: all 0.3s ease-in-out;  */
/*    -webkit-transform:scale(1.3); */
/*    -moz-transform:scale(1.2); */
/*    -ms-transform:scale(1.2);    */
/*    -o-transform:scale(1.2); */
/*    } */
   


.subnav {
	float: left;
	overflow: hidden;
}

.subnav .subnavbtn {
	font-size: 16px;
	border: none;
	outline: none;
	color: gray;
	padding: 14px 16px;
	background-color: inherit;
	font-family: inherit;
	margin: 0;
}

.navbar a:hover, .subnav:hover .subnavbtn {
	background-color: gray;
}

.subnav-content {
	display: none;
	position: absolute;
	left: 0;
	background-color: gray;
	width: 100%;
	z-index: 1;
}

.subnav-content a {
	float: left;
	color: white;
	text-decoration: none;
}

.subnav-content a:hover {
	background-color: gray;
	color: black;
}

.subnav:hover .subnav-content {
	display: block;
}
</style>

<script>
	$(document).ready(
			function() {

				var id = "${sessionScope.id}";
				var position = "${sessionScope.position}";
				var dept = "${sessionScope.dept}";

				/* showMenuList();  */
				$('nav li').hover(function() {
					$('ul', this).stop().toggle();
				});
				
				/* 로그인이 되지 않으면 기능 메뉴기능 사용불가 */
				$("a").click(
						function() {
							if (position == "") {
								if ($(this).attr("id") != "loginaTag" && $(this).attr("id") != "logoutaTag" 
									&& $(this).attr("id") != "emp0" && $(this).attr("id") != "error") {
									alert("로그인을 해주세요");
									location.replace('${pageContext.request.contextPath}/loginForm.html');
									return false;
								}
							}/* else if (position != "팀장" && position != "대리" && position != "사원" || dept != "인사팀") {
							                if ($(this).attr("id") == "emp1"
							                    || $(this).attr("id") == "emp2"
							                    || $(this).attr("id") == "emp0"
							                    || $(this).attr("id") == "loginaTag"
							                    || $(this).attr("id") == "emp3"
							                    || $(this).attr("id") == "emp4"
							                    || $(this).attr("id") == "logoutaTag"
							                    || $(this).attr("id") == "emp5"
							                    || $(this).attr("id") == "emp6"
							                    || $(this).attr("id") == "emp7") {
							              } else {
							                 alert("권한이 없습니다");
							                 return false;
							              }
							           } */
						});
				
				
				if (dept == "인사팀") {
					$("#dTag").css("visibility", "visible");
					$("#dTag1").css("visibility", "visible");
					$("#dTag2").css("visibility", "visible");
					$("#dTag3").css("visibility", "visible");
					$("#dTag4").css("visibility", "visible");
					$("#dTag5").css("visibility", "visible");
				}
				if(dept !="인사팀" && dept!=""){
					$("#dTag").css("visibility", "visible");
					$("#dTag3").css("visibility", "visible");
	
				}
			});

	/* 	 function showMenuList() {
	 $.ajax({
	 url : "${pageContext.request.contextPath}/base/menuList.do",
	 dataType : "json",
	 success : function(dataSet) {
	 var menuList = dataSet.menuList;
	 $.each(menuList, function(index, menu) {

	 if (menu.superMenuCode == "") {
	 $("<li />", {
	 id : menu.menuCode + "_li"
	 }).appendTo($(".menu_ul"));

	 $("<a />", {
	 id : menu.menuCode,
	 text : menu.menuName,
	 href : "#"
	 }).appendTo($("#" + menu.menuCode + "_li"));

	 $("<ul />", {
	 id : menu.menuCode + "_ul"
	 }).appendTo($("#" + menu.menuCode + "_li"));

	 } else {
	 $("<li />", {
	 id : menu.menuCode + "_li"
	 }).appendTo($("#" + menu.superMenuCode + "_ul"));

	 $("<a />", {
	 href : "#",
	 text : menu.menuName
	 }).click(function() {
	 var permitted = false;
	 for(var index in userMenuList)
	 if(userMenuList[index].menuCode==menu.menuCode)
	 permitted = true;
	 if(permitted)
	 location.href = "${pageContext.request.contextPath}"+menu.menuUrl;
	 else
	 alert("해당 메뉴를 이용하실 권한이 없습니다");  
	 }).appendTo($("#" + menu.menuCode + "_li"));

	 }
	 });

	 },
	 error : function(a, b, c) {
	 alert(b);
	 }

	 });
	 }  */
</script>
</head>

<body>
	<div class="navbar" id="dd">
		<a href="${pageContext.request.contextPath}/main.html" id="emp0"> M a i n</a>
		
		<div class="subnav" id="dTag" style="visibility: hidden">
			<button class="subnavbtn">Employee <i class="fa fa-caret-down"></i></button>
			<div class="subnav-content">
				<a href="${pageContext.request.contextPath}/emp/empFind.html" id="emp1">사원기본조회   &nbsp; &nbsp; |</a> 
				<a href="${pageContext.request.contextPath}/attendance/dayAttendance.html" id="emp2">일근태기록/조회   &nbsp; &nbsp; |</a> 
				<a href="${pageContext.request.contextPath}/attendance/restAttendance.html" id="emp3">외출·조퇴신청/조회  &nbsp; &nbsp; |</a> 
				<a href="${pageContext.request.contextPath}/attendance/break.html" id="emp4">휴가신청/조회  &nbsp; &nbsp; |</a> 
				<a href="${pageContext.request.contextPath}/attendance/travel.html" id="emp5">출장·교육신청/조회  &nbsp; &nbsp; |</a> 
				<a href="${pageContext.request.contextPath}/attendance/overwork.html" id="emp6">초과근무신청/조회  &nbsp; &nbsp; |</a> 
				<a href="${pageContext.request.contextPath}/certificate/employment.html" id="emp7">재직증명서신청/발급  &nbsp; &nbsp; |</a>
			</div>			
		</div>
		<div class="subnav" id="dTag3" style="visibility: hidden">
			<button class="subnavbtn">Salary <i class="fa fa-caret-down"></i></button>
			<div class="subnav-content">
				<a href="${pageContext.request.contextPath}/salary/monthSalary.html">월급여조회   &nbsp; &nbsp; |</a>
			</div>
		</div>
		<div class="subnav" id="dTag1" style="visibility: hidden">
			<button class="subnavbtn"> Insa Management <i class="fa fa-caret-down"></i> </button>
			<div class="subnav-content">
				<a href="${pageContext.request.contextPath}/emp/empRegist.html">사원등록   &nbsp; &nbsp; |</a>
				<a href="${pageContext.request.contextPath}/emp/empDetailedView.html">사원상세조회   &nbsp; &nbsp; |</a>
				<a href="${pageContext.request.contextPath}/certificate/certificateApproval.html">재직증명서관리   &nbsp; &nbsp; |</a>
			</div>
		</div>
		
		
		<div class="subnav" id="dTag2" style="visibility: hidden">
			<button class="subnavbtn">Attendance <i class="fa fa-caret-down"></i></button>
			<div class="subnav-content">
				<a href="${pageContext.request.contextPath}/attendance/dayAttendanceManage.html">일근태관리   &nbsp; &nbsp; |</a>
				<a href="${pageContext.request.contextPath}/attendance/monthAttendanceManage.html">월근태관리   &nbsp; &nbsp; |</a>
				<a href="${pageContext.request.contextPath}/attendance/attendanceApproval.html">결재승인관리   &nbsp; &nbsp; |</a>
			</div>
			
		</div>
		
		
		
		<div class="subnav" id="dTag4" style="visibility: hidden">
			<button class="subnavbtn">Salary Management<i class="fa fa-caret-down"></i></button>
			<div class="subnav-content">
				<a href="${pageContext.request.contextPath}/salary/baseSalaryManage.html">급여기준관리   &nbsp; &nbsp; |</a>
				<a href="${pageContext.request.contextPath}/salary/baseDeductionManage.html">공제기준관리   &nbsp; &nbsp; |</a>
				<a href="${pageContext.request.contextPath}/salary/baseExtSalManage.html">초과수당관리   &nbsp; &nbsp; |</a>
			</div>
			
		</div>
		
		<div class="subnav" id="dTag5" style="visibility: hidden">
			<button class="subnavbtn">Others <i class="fa fa-caret-down"></i></button>
			<div class="subnav-content">
				<a href="${pageContext.request.contextPath}/base/deptList.html">부서관리   &nbsp; &nbsp; |</a>
				<a href="${pageContext.request.contextPath}/base/positionList.html">직급관리   &nbsp; &nbsp; |</a>
				<a href="${pageContext.request.contextPath}/base/codeList.html">코드조회   &nbsp; &nbsp; |</a>
				<a href="${pageContext.request.contextPath}/base/holidayList.html">휴일조회   &nbsp; &nbsp; |</a>
			</div>
		</div>
		
	</div>

	<div style="padding: 0 16px"></div>

</body>
<hr>
</html>

