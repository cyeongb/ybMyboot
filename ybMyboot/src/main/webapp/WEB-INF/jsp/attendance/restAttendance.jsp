<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- ==================================[외출,조퇴신청 /조회]============================================== -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#restAttd_tabs {
	display: inline-block;
}

/* 
td{
	border:1px solid navy;
} 
*/

table{
	z-index: 100;
}
input{
	z-index: 500;
}

</style>

<script>
	var empCode = "${sessionScope.code}";
	var startTime = 0;
	var endTime = 0;
	var restAttdList = [];
	var requestDate = getDay();
	
	
	$(document).ready(function() {
		
	//	$("#selectRestAttdType").trigger("click");
		
		
		$("#restAttd_tabs").tabs();
		showRestAttdListGrid();
		$("#selectRestAttd").click(function() {
			getCodeRest("DAC004","ADC003","ADC005", "selectRestAttd", "selectRestAttdCode");
		})
		
 		

		
		
		/* 시간 선택 함수 */
		$("#restAttd_startT").timepicker({
			step: 5,            
			timeFormat: "H:i",    
			minTime: "8:00am",
			maxTime: "11:59pm"	
		});
		$("#restAttd_endT").timepicker({
			step: 5,            
			timeFormat: "H:i",    
			minTime: "8:00am",
			maxTime: "11:59pm"	
		});
	  	
	  
		
		$("#search_startD").click(getDatePicker($("#search_startD")));
		$("#search_endD").click(getDatePicker($("#search_endD")));
		// -------------------------------------------------------->>>>>>>>>
// 		$("#search_restAttdList_Btn").trigger().click(function(){   [1]
// 			findrestAttdList();
			
// 		})
// 		;
		
		
// 		$("#search_restAttdList_Btn").click(function(){               [2]
// 			var attdtype = $("#selectRestAttdType").val();
// 			if(attdtype.equals(""))
//  				{alert("근태구분명을 선택하셈"); return false; }
//  			else{ findrestAttdList();}
			
//  		});
// ------------------------------------------<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		
		 $("#search_restAttdList_Btn").click(findrestAttdList); // 조회버튼
		 
		 $("#selectRestAttdType").click(function() {
	 			getCodeRest("DAC004","ADC003","ADC005", "selectRestAttdType", "selectRestAttdTypeCode");
	 		})
	 		
		 // -----------근태외 삭제버튼
		$("#delete_restAttd_Btn").click(function(){  
			
			if(selectedRowData[0].approvalStatus=='승인'){
				alert("승인된 건은 삭제할 수 없습니다. 승인취소 처리를 해 주세요");
				return;
			}
			
			var flag = confirm("선택한 근태외신청을 정말 삭제하시겠습니까?");
			if(flag)
				removeRestAttdList();
		});
		
		
		$("#restAttd_startD").click(getDatePicker($("#restAttd_startD")));
		
		$("#restAttd_startD").change(function(){ // 근태외신청 시작일 
			if($("#selectRestAttdCode").val().trim()=="DAC004"||$("#selectRestAttdCode").val().trim()=="ADC003"||$("#selectRestAttdCode").val().trim()=="ADC005"){
			  	// 조퇴,공외출,사외출이라면
			    $("#restAttd_endD").val($(this).val()); // 시작일과 종료일을 같게한다
			    toDay = $("#restAttd_startD").val();
			};
			$("#restAttd_endD").datepicker("option","minDate",$(this).val());
			if($("#restAttd_endD").val()!="")
				calculateNumberOfDays();
		}); 
		
		
//		$("#restAttd_endD").click(getDatePicker($("#restAttd_endD")));
		$("#restAttd_endD").prop("disabled" ,true);    //버튼 비활성화
		$("#restAttd_endD").change(function(){ // 근태외신청 종료일
			$("#restAttd_startD").datepicker("option","maxDate",$(this).val());
			if($("#restAttd_startD").val()!="")
				calculateNumberOfDays();
		}); 
		
		$("#btn_regist").click(registrestAttd);
		
		/* 사용자 기본 정보 넣기 */
		$("#restAttd_emp").val("${sessionScope.id}");
		$("#restAttd_dept").val("${sessionScope.dept}");
		$("#restAttd_position").val("${sessionScope.position}");
	})
	
	
	
	/* timePicker시간을 변경하는 함수 */
	function convertTimePicker(){
		startTime = $("#restAttd_startT").val().replace(":","");
		endTime = $("#restAttd_endT").val().replace(":","");
		
 		if(startTime.indexOf("00")==0){
 			startTime = startTime.replace("00","24");
		}
 		if(endTime.indexOf("00")==0){
			endTime = endTime.replace("00","24");
		}
	}
	
	/* 오늘 날자를 RRRR-MM-DD 형식으로 리턴하는 함수 */
	function getDay(){
	    var today = new Date();
	    var rrrr = today.getFullYear();
	    var mm = today.getMonth()+1;
	    var dd = today.getDate();
	    var searchDay = rrrr+"-"+mm+"-"+dd;
		return searchDay;
	}
	
	
	/* 근태외목록 조회버튼  */
	function findrestAttdList(){		
		var startVar = $("#search_startD").val().trim();
		var endVar = $("#search_endD").val().trim();
		var code = $("#selectRestAttdTypeCode").val().trim();
		
		console.log(code)
		
		if(code == ""){
			alert("근태 구분명 입력은 필수입니다.");
			return;
		}
		if(endVar=="" || startVar==""){
			alert("조회할 날짜를 입력해 주세요")
			return;
		}
		
		 $.ajax({
			url:"${pageContext.request.contextPath}/attendance/restAttendance.do",
			data:{
				"method" : "findRestAttdList",
				"empCode" : empCode,
				"startDate" : startVar,
				"endDate" : endVar,
				"code":code
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

				restAttdList = data.restAttdList;

				
				/* 시간형태변경포문부분 */
				for(var index in restAttdList){
					restAttdList[index].startTime = getRealTime(restAttdList[index].startTime);
					restAttdList[index].endTime = getRealTime(restAttdList[index].endTime);
				}  

				showRestAttdListGrid();
			}
		}); 
	}
	
	/* 숫자로 되있는 시간을 시간형태로  */
	function getRealTime(time){
		var hour = Math.floor(time/100);
		if(hour==25) hour=1; 
		var min = time-(Math.floor(time/100)*100);
		if(min.toString().length==1) min="0"+min; //분이 1자리라면 앞에0을 붙임
		if(min==0) min="00";
		return hour + ":" + min;
	}
	
	
	
	
	/* 삭제버튼 눌렀을 때 실행되는 함수 */
    function removeRestAttdList(){
		var selectedRowData=gridOptions.api.getSelectedRows();

/* 		$.each(selectedRowIds, function(index, id){ //클릭한 회원들을 each로 풀어서 id를 얻음
			var data = $("#restAttdList_grid").getRowData(id); //얻은 아이디로 조회목록 해당아이디 직원의 모든데이터를 가져옴
			if(selectedRowData[0].approvalStatus!='승인')	//가져온 데이터의 승인여부가 '승인'이 아닐경우에 배열에 담음 
				selectedRowData.push(data);
		});
		
 */		
		if(selectedRowData.length == 0){ //배열에 담긴 데이터가 없을때에 발생하는 alert
			alert("삭제할 항목을 선택해 주세요");
			return;
		}
		var sendData = JSON.stringify(selectedRowData); //삭제할 목록들이 담긴 배열

		$.ajax({
			url : "${pageContext.request.contextPath}/attendance/restAttendance.do",
			data : {
				"method" : "removeRestAttdList",
				"sendData" : sendData
			},
			dataType : "json",
			success : function(data) {
				if(data.errorCode < 0){
					alert("정상적으로 삭제되지 않았습니다");
				} else {
					alert("삭제되었습니다");
				}
				location.reload();
			}
		});
    }
	
	
	/* 근태외신청 그리드 띄우는 함수 */
function showRestAttdListGrid(){
	var columnDefs = [
	      {headerName: "사원코드", field: "empCode",hide:true },
	      {headerName: "일련번호", field: "restAttdCode",hide:true },
	      {headerName: "근태구분코드", field: "restTypeCode",hide:true},
	      {headerName: "근태구분명", field: "restTypeName",checkboxSelection: true},
	      {headerName: "신청일자", field: "requestDate"},
	      {headerName: "시작일", field: "startDate"},
	      {headerName: "종료일", field: "endDate"},
	      {headerName: "일수", field: "numberOfDays"},
	      {headerName: "시작시간", field: "startTime"},
	      {headerName: "종료시간", field: "endTime"},
	      {headerName: "사유", field: "cause"},
	      {headerName: "승인여부", field: "approvalStatus"},
	      {headerName: "반려사유", field: "rejectCause"}
	];    
	gridOptions = {
			columnDefs: columnDefs,
			rowData: restAttdList,
			defaultColDef: { editable: false, width: 100 },
			rowSelection: 'multiple', /* 'single' or 'multiple',*/
			enableColResize: true,
			enableSorting: true,
			enableFilter: true,
			enableRangeSelection: true,
			suppressRowClickSelection: false,
			animateRows: true,
			suppressHorizontalScroll: true,
			localeText: {noRowsToShow: '조회 결과가 없습니다.'},
			getRowStyle: function (param) {
		        if (param.node.rowPinned) {
		            return {'font-weight': 'bold', background: '#dddddd'};
		        }
		        return {'text-align': 'center'};
		    },
		    getRowHeight: function(param) {
		        if (param.node.rowPinned) {
		            return 30;
		        }
		        return 24;
		    },
		    // GRID READY 이벤트, 사이즈 자동조정 
		    onGridReady: function (event) {
		        event.api.sizeColumnsToFit();
		    },
		    // 창 크기 변경 되었을 때 이벤트 
		    onGridSizeChanged: function(event) {
		        event.api.sizeColumnsToFit();
		    },
		    onCellEditingStarted: function (event) {
		        console.log('cellEditingStarted');
		    }, 
	};   
	$('#restAttdList_grid').children().remove();	 
	var eGridDiv = document.querySelector('#restAttdList_grid');
	new agGrid.Grid(eGridDiv, gridOptions);	
 }	 
	
	
	
	/* 일수 계산 함수  */
	function calculateNumberOfDays(){
	    var startStr = $("#restAttd_startD").val();
		var endStr = $("#restAttd_endD").val();
		if($("#selectRestAttdCode").val().trim()=="ASC006"||$("#selectRestAttdCode").val().trim()=="ASC007"){
		    $("#restAttd_day").val(0.5);
		}else if($("#selectRestAttdCode").val().trim()=="ASC001"||$("#selectRestAttdCode").val().trim()=="ASC004"||$("#selectRestAttdCode").val().trim()=="ASC005"){
			
			$.ajax({ 
				url:"${pageContext.request.contextPath}/base/holidayList.do",
				data:{
					"method" : "findWeekDayCount",
					"startDate" : startStr,
					"endDate" : endStr
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
					$("#restAttd_day").val(data.weekdayCount);
				}
			});
			
		}else{ // 그 외에는 주말 및 공휴일을 포함한 일자를 가져온다
			var startMs = (new Date(startStr)).getTime();
			var endMs = (new Date(endStr)).getTime();
			var numberOfDays = (endMs-startMs)/(1000*60*60*24)+1;
			$("#restAttd_day").val(numberOfDays);
		}
	}
	

	/* 코드선택 창 띄우기 */
	function getCodeRest(code1,code2,code3, inputText, inputCode) {
		option = "width=220; height=200px; left=300px; top=300px; titlebar=no; toolbar=no,status=no,menubar=no,resizable=no, location=no";
		window.open(
				"${pageContext.request.contextPath}/base/codeWindow.html?code1="
						+ code1 +"&code2="+code2+"&code3="+code3+ "&inputText=" + inputText + "&inputCode="
						+ inputCode, "newwins", option);
	}
	
	/* 달력띄우기 */
	function getDatePicker($Obj) {
		$Obj.datepicker({
			defaultDate : "d",
			changeMonth : true,
			changeYear : true,
			dateFormat : "yy/mm/dd",
			dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
			monthNamesShort : [ "1", "2", "3", "4", "5", "6", "7", "8", "9",
					"10", "11", "12" ],
			yearRange : "1980:2020"
		});
	}
	
	/* 신청 버튼  */
	function registrestAttd(){
		convertTimePicker();
		
		   if($("#selectRestAttd").val().trim()==""){
				alert("근태외구분 선택은 필수사항입니다");
				return ;
		}
		   if($("#restAttd_startD").val().trim()=="" || $("#restAttd_endD").val().trim()==""){
				alert("신청일자 미입력");
				return ;
		}
		   
		   if($("#restAttd_startT").val().trim()=="" || $("#restAttd_endT").val().trim()==""){
				alert("시간 미입력");
				return ;
		}
		   
		   
		
		var restAttdList = {
				"empCode" : empCode,
				"restTypeCode" : $("#selectRestAttdCode").val(),
				"restTypeName" : $("#selectRestAttd").val(),
				"requestDate" : requestDate,
				"startDate" : $("#restAttd_startD").val(),
				"endDate" : $("#restAttd_endD").val(),
				"numberOfDays" : $("#restAttd_day").val(),
				"cause" : $("#restAttd_cause").val(),
				"approvalStatus" : '승인대기',
				"startTime" : startTime,
				"endTime" : endTime
			};
		
		
		var sendData = JSON.stringify(restAttdList);  //---------------- 신청하기
		
		$.ajax({
			url : "${pageContext.request.contextPath}/attendance/restAttendance.do",
			data : {
				"method" : "registRestAttd",
				"sendData" : sendData
			},
			dataType : "json",
			success : function(data) {
				
				
				if(data.errorCode < 0){
					alert("신청을 실패했습니다");
				} else {
					alert("신청되었습니다");
				}
				location.reload();
			}
		});
	}
	
</script>
</head>

<body>

	<div id="restAttd_tabs" style="width: 900px; height: 600px">
		<ul>
			<li><a href="#restAttdAttd_tab">근태외신청</a></li>
			<li><a href="#restAttdSerach_tab">근태외조회</a></li>
		</ul>
		<div id="restAttdAttd_tab">
			<font>근태외 구분 </font>
				<input id="selectRestAttd"	class="ui-button ui-widget ui-corner-all" readonly placeholder="선택하세요" required> 
				<input type="hidden" id="selectRestAttdCode" name="restAttdCode">
			<hr>
			<table>
				<tr>
					<td><font>신청자 </font></td>
					<td><input id="restAttd_emp" class="ui-button ui-widget ui-corner-all" readonly></td>
				</tr>
				<tr><td><h3> </h3></td></tr>
				<tr>
					<td><font>부서 </font></td>
					<td><input id="restAttd_dept" class="ui-button ui-widget ui-corner-all" readonly></td>
					
					<td><font>직급</font></td>
					<td><input id="restAttd_position" class="ui-button ui-widget ui-corner-all" readonly></td>
				</tr>
				<tr><td><h3> </h3></td></tr>
				<tr>
					<td><font>시작일</font></td>
					<td><input id="restAttd_startD" class="ui-button ui-widget ui-corner-all" readonly></td>
				
					<td><font>종료일</font></td>  
					<td><input id="restAttd_endD" class="ui-button ui-widget ui-corner-all" readonly></td>
				</tr>
				<tr><td><h3> </h3></td></tr>
				<tr>
					<td><font>시작시간</font></td>
					<td><input id="restAttd_startT" class="ui-button ui-widget ui-corner-all" name="timePicker1" placeholder="시간선택" maxlength="4"></td>
				
					<td><font>종료시간</font></td>
					<td><input id="restAttd_endT" class="ui-button ui-widget ui-corner-all" name="timePicker2" placeholder="시간선택" maxlength="4"></td>
				</tr>
				<tr><td><h3> </h3></td></tr>
				<tr>
					<td><font>일수</font></td>
					<td><input id="restAttd_day" class="ui-button ui-widget ui-corner-all" readonly></td>
<!-- 					<td><font>증명서</font></td>증명서 !!! -->
<!-- 					<td>		 -->
<!-- 					<input type="file"  id="restAttd_certi" class="ui-button ui-widget ui-corner-all" readonly> -->
<!-- 					</td> -->
				</tr>
				<tr><td><h3> </h3></td></tr>
				<tr>
					<td><font>사유</font></td>
					<td colspan="3" ><input id="restAttd_cause" style="width:490px" class="ui-button ui-widget ui-corner-all" ></td>
				</tr>
			</table>
			<hr>
			<input type="button" class="ui-button ui-widget ui-corner-all" id="btn_regist" value="신청">
			<input type="reset" class="ui-button ui-widget ui-corner-all" value="취소">
		</div>
		
		
		<div id="restAttdSerach_tab">
		<table>
		<tr><td colspan="2"><center><h3>조회범위 선택</h3></center></td></tr>
		<tr><td><h3>구분</h3></td><td><input id="selectRestAttdType" class="ui-button ui-widget ui-corner-all"  placeholder="근태구분" readonly>
			<input type="hidden" id="selectRestAttdTypeCode" >
		</td></tr>
		<tr>
			<td>
				<input type=text class="ui-button ui-widget ui-corner-all" id="search_startD" readonly placeholder="조회 시작일">~
			</td>
			<td>
				<input type=text class="ui-button ui-widget ui-corner-all" id="search_endD" readonly placeholder="조회 종료일">
			</td>
		</tr>
		<tr><td><h3> </h3></td></tr>
		<tr>
			<td colspan="2">
				<center>
				<button class="ui-button ui-widget ui-corner-all" id="search_restAttdList_Btn">조회하기</button>
				<button class="ui-button ui-widget ui-corner-all" id="delete_restAttd_Btn">삭제하기</button>
				</center>
			</td>
		</tr>
		</table>
		<hr>
		<div id="restAttdList_grid" style="height: 230px; width:800px" class="ag-theme-balham"></div>
		<div id="restAttdList_pager"></div>
		</div>
	</div>
</body>
</html>