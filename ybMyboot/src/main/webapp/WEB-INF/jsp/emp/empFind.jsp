<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
font{
	font-size: 15px;
	font-weight: bold; 
}

</style>
<script type="text/javascript">
	var emplist = [];   // ------->수정!!!!!!!!!!
	
	$(document).ready(function(){
		$( "#dept" ).selectmenu();
		$( "#detail_tab" ).tabs();
		$( "#findtab" ).tabs();
		
		$("#find").click(function(){
			findgrid($("#dept").val()); //전체부서,회계,인사,전산,보안
		})

		function findgrid(dept){ 
			$.ajax({
				url:'${pageContext.request.contextPath}/emp/list.do',
				data:{
					"method" : "emplist",
					"value"	: dept    
				},
				dataType:"json",
				success : function(data){
					if(data.errorCode < 0){
						var str = "내부 서버 오류가 발생했습니다\n";
						str += "관리자에게 문의하세요\n";
						str += "에러 위치 : " + $(this).attr("id");
						str += "에러 메시지 : " + data.errorMsg;
						alert(str);
						return;
					}
					emplist = data.list;
					showEmpListGrid();   //뿌려주는 함수 호출
				}
			});
		}
				    function showEmpListGrid(){
					var columnDefs = [
// 					      {headerName: "사원코드", field: "empCode",hide: true  },
					      {headerName: "사원코드", field: "empCode"},
					      {headerName: "사원명", field: "empName" },
					      {headerName: "부서", field: "deptName" },
					      {headerName: "직급", field: "position" },
					      {headerName: "성별", field: "gender",hide: true },
// 					      {headerName: "전화번호", field: "mobileNumber",hide: true },
					      {headerName: "전화번호", field: "mobileNumber" },
					      {headerName: "이메일", field: "email" },
					      {headerName: "거주지", field: "address",hide: true },
					      {headerName: "최종학력", field: "lastSchool",hide: true },
					      {headerName: "사진", field: "imgExtend",hide: true },
					      {headerName: "생년월일", field: "birthdate",hide: true }
					  	];    
				     gridOptions = {
					    		columnDefs: columnDefs,
					    		rowData: emplist,
 					    	    onCellClicked : function(node) {  //데이터를 들고 있다가 클릭하면 <div>나오게끔 구현.
 					    	    	
 					    	    	$("#fN").html(node.data.empName);      // 밑에꺼 제이쿼리로 바꿈 
 					                $("#fD").html(node.data.deptName);
 					                $("#fP").html(node.data.position);
 					                $("#fE").html(node.data.email);
 					                $("#fM").html(node.data.mobileNumber);
 					                $("#fB").html(node.data.birthdate);
 					                $("#fA").html(node.data.address);
 					                $("#fS").html(node.data.lastSchool);
 					    	    						    	    						    	    	
//  					    	    	document.getElementById('fcode').innerHTML=node.data.empCode;
//  					    	    	document.getElementById('fN').innerHTML=node.data.empName;
//  					    	    	document.getElementById('fD').innerHTML=node.data.deptName;
//  					    	    	document.getElementById('fP').innerHTML=node.data.position;
//  					    	    	document.getElementById('fE').innerHTML=node.data.email;
//  					    	    	document.getElementById('fM').innerHTML=node.data.mobileNumber;
//  					    	    	document.getElementById('fB').innerHTML=node.data.birthdate;
//  					    	    	document.getElementById('fA').innerHTML=node.data.address;
//  					    	    	document.getElementById('fS').innerHTML=node.data.lastSchool;
									var empCode = node.data.empCode;
									var profile = node.data.imgExtend;  //이미지 확장자가 뭘로 저장되어있는지
									// 사진 경로  src를 세팅해줌
									document.getElementById('profileImg').setAttribute("src","${pageContext.request.contextPath}/profile/"+empCode+"."+profile);
						    	}
					     }
					    $('#findgrid').children().remove();  //그리드를 지우고 새로고침하는 형식
						var eGridDiv = document.querySelector('#findgrid');
						new agGrid.Grid(eGridDiv, gridOptions);	//그리드 생성
						gridOptions.api.sizeColumnsToFit();
				
				}
	});		 

</script>

</head>

<body>
<table>
<tr>
	<td >
		
			<div id="findtab" style="width:600px; height: 400px;">
				<ul>
					<li><a href="#findtab1">사원검색</a></li>
				</ul>
				<div id="findtab1">
				<select id="dept">
					<option value="전체부서">전체부서</option>
					<option value="회계팀">회계팀</option>
					<option value="인사팀">인사팀</option>
					<option value="전산팀">전산팀</option>
					<option value="보안팀">보안팀</option>
				</select>
				<input type="button" class="ui-button ui-widget ui-corner-all" value="조회" id="find">
				<hr>
				<div id="findgrid" style="height: 260px; width:550px" class="ag-theme-balham"></div>
			</div>
			</div>
		
			

	</td>
	<td>
		
			<div id="detail_tab" style="width:600px; height: 400px;">
				<ul>
					<li><a href="#detail_tab1">상세정보</a></li>
				</ul>
				<div id="detail_tab1">
				<div style="display: inline-block;" >
					 <img id="profileImg" src="${pageContext.request.contextPath}/profile/profile.png" width="200px" height="250px">
				</div>
				<div style=" display: inline-block; position:absolute; margin-left: 50px; margin-top: 30px;" >
				<font>사원코드 : </font> <font id="fcode"></font><br/><br/>
					<font>이름 : </font> <font id="fN"></font><br/><br/>
					<font>부서 : </font> <font id="fD"></font><br/>
					<font>직급 : </font> <font id="fP"></font><br/><br/> 
					<font>e-mail : </font> <font id="fE"></font><br/>
					<font>휴대전화 : </font> <font id="fM"></font><br/>
					<font>생년월일 : </font> <font id="fB"></font><br/>
					<font>거주지 : </font> <font id="fA"></font><br/>
					<font>최종학력 : </font> <font id="fS"></font><br/>
					
					<!-- IMG_EXTEND -->
					
				</div>
				</div>
			</div>
		
	</td>
</tr>
</table>
	
</body>
	
</html>