<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- -----------------### 근태관리 ### -### 결재승인관리 페이지 ###----------------- -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>근태외승인</title>
<style type="text/css">
input[type=text] {
	width: 150px;
	height: 10px;
}

.small_Btn {
	width: auto;
	height: auto;
	font-size: 15px;
}

input{
	z-index: 100;
}
table{
	z-index: 90;
}
</style>
<script>
var restAttdList = [];

	$(document).ready(function(){

		$("input:text").button();
		$(".small_Btn").button();

		$(".comment_div").css({fontSize : "0.7em"});
		$("#attdList_tabs").tabs().css({margin:"10px"});

		getDatePicker($("#search_restAttd_startDate"));
		getDatePicker($("#search_restAttd_endDate"));
		
		showRestAttdListGrid(); // 근태외신청목록 그리드

		findRestAttdList("모든부서"); //신청일자가 오늘인 근태외신청을 바로 보여준다
		
		$("#search_restAttd_deptName").click(function(){  //조회부서
			getCode("CO-07","search_restAttd_deptName","search_restAttd_deptCode");  //CO-07 : 부서 , 조회부서 - 부서명, 조회부서 - 부서코드
		}); // 부서선택
		
		$("#search_restAttd_startDate").change(function(){ //신청일자의 시작일
			$("#search_restAttd_endDate").datepicker("option","minDate",$(this).val());  //*datepicker : 웹프로그램에서 날짜를 선택할 수 있는 자스 달력 위젯.
																					//  
		}); // 시작일
		
		$("#search_restAttd_endDate").change(function(){
			$("#search_restAttd_startDate").datepicker("option","maxDate",$(this).val());
		}); // 종료일
		
		$("#search_restAttdList_Btn").click(findRestAttdList); // 조회하기
	    $("#approval_restAttd_Btn").click(approvalRestAttd); // 승인버튼
		$("#cancel_restAttd_Btn").click(cancelRestAttd); // 보류버튼
		$("#reject_restAttd_Btn").click(rejectRestAttd); // 반려버튼
		$("#update_restAttd_Btn").click(modifyRestAttd); // 확정버튼
		//---------------- 삭제버튼 누르면,
// 		 $("#delete_restAttd_Btn").click(function(){ 
// 	         var flag = confirm("선택한 항목을 정말 삭제하시겠습니까?");
// 	         if(flag)
// 	        	 removeRestAttd();
// 	      });
		
	});

    /* 근태외신청 그리드 띄우는 함수 */
    function showRestAttdListGrid(){
    		var columnDefs = [
    		      {headerName: "사원코드", field: "empCode",hide:true },  //hidden
    		      {headerName: "사원명", field: "empName",checkboxSelection: true},
    		      {headerName: "일련번호", field: "restAttdCode",hide:true },  //시퀀스번호 hidden
    		      {headerName: "근태구분코드", field: "restTypeCode",hide:true},  //hidden
    		      {headerName: "근태구분명", field: "restTypeName"},
    		      {headerName: "신청일자", field: "requestDate"},
    		      {headerName: "시작일", field: "startDate"},
    		      {headerName: "종료일", field: "endDate"},
    		      {headerName: "시작시간", field: "startTime"},
    		      {headerName: "종료시간", field: "endTime"},
    		      {headerName: "일수", field: "numberOfDays"},
    		 //     {headerName: "경비", field: "cost"},
    		      {headerName: "사유", field: "cause"},
    		      {headerName: "승인여부", field: "approvalStatus",editable:false},
    		      {headerName: "반려사유", field: "rejectCause",editable:true},
    		      {headerName: "상태", field: "status",hide:true}
    		];      
      	gridOptions = {
      			
      			columnDefs: columnDefs,
      			rowData: restAttdList,
      			defaultColDef: { editable: false, width: 100 },
      			rowSelection: 'single', /* 'single' or 'multiple',*/
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
      		    //더블클릭해서 반려이면 수정 불가
      		   onCellDoubleClicked: function (event){
                   if(event.data.approvalStatus == "반려"){
                      gridOptions.api.stopEditing();
                   };
                },
                
                onCellClicked: function (event){
                    if(event.data.approvalStatus == "반려"){
                       gridOptions.api.stopEditing();
                    };
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

	/* 근태외목록 조회버튼 함수 */
	function findRestAttdList(allDept){
	    var deptName = $("#search_restAttd_deptCode").val().trim();
	    var startDate = $("#search_restAttd_startDate").val().trim();
	  
		if(allDept=="모든부서"){ //넘어온값이 '모든부서'와 같다면 
		    deptName = allDept; //deptName를 모든부서로 바꾸고

		    var today = new Date();
		    var rrrr = today.getFullYear();
		    var mm = today.getMonth()+1;
		    var dd = today.getDate();
		    startDate= rrrr+"-"+mm+"-"+dd; //시작일을 오늘날짜로 넘긴다
		    
		    
		    if(startDate == ""){   //0번방이 널일 때로 수정함 !!!
				alert(" 날짜를 선택해 주세요!!!");
				return;
			}
		}
		
		$.ajax({
			url:"${pageContext.request.contextPath}/attendance/attendanceApproval.do",
			data:{
				//"method" : "findRestAttdListByDept",
				"deptName" : deptName,
				"startDate" : startDate,
				"endDate" : $("#search_restAttd_endDate").val()
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
				
				for(var index in restAttdList){
					restAttdList[index].startTime = getRealTime(restAttdList[index].startTime);
					restAttdList[index].endTime = getRealTime(restAttdList[index].endTime);
				}

				showRestAttdListGrid();
			}
		});
	}
	
	/* 근태외 확정버튼 눌렀을 때 실행되는 함수 */
	function modifyRestAttd(){
		var sendData = JSON.stringify(restAttdList);
		var rowNode = gridOptions.api.getSelectedNodes();
	//	console.log(rowNode[0].data);
		if(rowNode == ""){   //0번방이 널일 때로 수정함 !!!
			alert("확정 할 항목을 선택해 주세요");
			return;
		}
		$.ajax({
			url : "${pageContext.request.contextPath}/attendance/attendanceApproval.do",
			data : {
			//	"method" : "modifyRestAttdList",
				"sendData" : sendData
			},
			dataType : "json",
			success : function(data) {
				if(data.errorCode < 0){
					alert("확정에 실패했습니다");
				} else {
					alert("확정되었습니다");
				}
				location.reload();
			}
		});
	}

	/* 근태외 승인버튼 함수 */
   function approvalRestAttd(){
      var rowNode = gridOptions.api.getSelectedNodes(); 
      //console.log(rowNode[0].data);
      if(rowNode == ""){
         alert("승인할 항목을 선택해 주세요");
         return;
      }
 
      alert("승인 하시겠습니까?");
      rowNode[0].setDataValue('rejectCause', "");
      rowNode[0].setDataValue('approvalStatus',"승인");
      rowNode[0].setDataValue('status', "update");
      console.log(rowNode[0].data);
   }
	
	/* 근태외 보류버튼 함수 */
	function cancelRestAttd(){
		var rowNode = gridOptions.api.getSelectedNodes();
		if(rowNode == ""){ //0번방이 널일 때로 수정함 !!!
			alert("보류할  항목을 선택해 주세요");
			return;
		}
	
		if(rowNode != ""){
		confirm("승인을 보류하시겠습니까?");
		}
		rowNode[0].setDataValue('approvalStatus', "보류");
		rowNode[0].setDataValue('status', "update");
		console.log(rowNode[0].data);
		
	};	
	/* 근태외 반려버튼 함수 */
	function rejectRestAttd(){
		var rowNode = gridOptions.api.getSelectedNodes();
		console.log(rowNode)
		if(rowNode == ""){ //0번방이 널일 때로 수정함 !!!
			alert("반려할  항목을 선택해 주세요");
			return;
		}
		if(rowNode !=" "){
			confirm("반려처리는 취소 불가합니다. 계속 하시겠습니까?");
		
	//	console.log("rowNode[0].data::");
	//	console.log(rowNode.data =="rejectCause");  // =="rejectCause"
		//----------> 반려사유 필수로 넣기
		rowNode[0].setDataValue('approvalStatus', "반려"); //반려 오타고침..원래 알인데???
		rowNode[0].setDataValue('status', "update");
		}
	}
	

	
	/* 근태외 삭제 버튼 함수*/
// 	function removeRestAttd(){
//  		var rowNode = gridOptions.api.getSelectedNodes();
//  		if(rowNode == null){ //0번방이 널일 때로 수정함 !!!
//  			alert("삭제할  항목을 선택해 주세요");
//  			return;
//  		}
//  		rowNode.setDataValue('approvalStatus', "삭제"); 
//  		rowNode.setDataValue('status', "delete");
// 		var selectedRowData=gridOptions.api.getSelectedRows();

// 		var sendData = JSON.stringify(selectedRowData); //삭제할 목록들이 담긴 배열

// 			$.ajax({
// 				url : "${pageContext.request.contextPath}/attendance/attendanceApproval.do",
// 				data : {
// 					"method" : "removeRestAttdList",
// 					"sendData" : sendData
// 				},
// 				dataType : "json",
// 				success : function(data) {
// 					if(data.errorCode < 0){
// 						alert("삭제오류");
// 						return;
// 					} else {
// 						confirm("삭제되었습니다");
						
// 					}
// 					location.reload();
// 				}
// 			});

// 	}
	

	
	/* 0000단위인 시간을 00:00(실제시간)으로 변환하는 함수 */
	function getRealTime(time){
		var hour = Math.floor(time/100);
		if(hour==25) hour=1; //데이터 베이스에 넘길때는 25시로 받고나서 grid에 표시하는건 1시로
		var min = time-(Math.floor(time/100)*100);
		if(min.toString().length==1) min="0"+min; //분이 1자리라면 앞에0을 붙임
		if(min==0) min="00";
		return hour + ":" + min;
	}

	/* 날짜 조회창 함수 */
	function getDatePicker($Obj, maxDate) {
			$Obj.datepicker({
				defaultDate : "d",
				changeMonth : true,
				changeYear : true,
				dateFormat : "yy-mm-dd",
				dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
				monthNamesShort : [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" ],
				yearRange: "1980:2020",
				showOptions: "up",
				maxDate : (maxDate==null? "+100Y" : maxDate)
			});
	}

	/* 코드 선택창 띄우는 함수 */
	  function getCode(code,inputText,inputCode){
		option="width=220; height=200px; left=300px; top=300px; titlebar=no; toolbar=no,status=no,menubar=no,resizable=no, location=no";
		window.open("${pageContext.request.contextPath}/base/codeWindow.html?code="
						+code+"&inputText="+inputText+"&inputCode="+inputCode,"newwins",option);
}
</script>
</head>
<body>
	<div id="attdList_tabs">
		<ul>
			<li><a href="#restAttdList_tab">근태외신청목록</a></li>
		</ul>
		<div id="restAttdList_tab">
			조회부서 <input type=text id="search_restAttd_deptName" readonly>
			<input type=hidden id="search_restAttd_deptCode">
			신청일자 <input type=text id="search_restAttd_startDate" readonly>
			~ <input type=text id="search_restAttd_endDate" readonly>
			<button class="small_Btn" id="search_restAttdList_Btn">조회하기</button><br />
			<br />
			<br /><br />
			<button class="small_Btn" id="approval_restAttd_Btn">승인</button>
			<button class="small_Btn" id="cancel_restAttd_Btn">보류</button>
			<button class="small_Btn" id="reject_restAttd_Btn">반려</button>
			<button class="small_Btn" id="update_restAttd_Btn">확정</button>
			<!--  <button class="small_Btn" id="delete_restAttd_Btn">삭제</button>-->
			<br /><br /><br />
		<div id="restAttdList_grid" style="height: 300px; width:1000px" class="ag-theme-balham"></div>
			<div id="restAttdList_pager"></div>
		</div>
	</div>
</body>
</html>