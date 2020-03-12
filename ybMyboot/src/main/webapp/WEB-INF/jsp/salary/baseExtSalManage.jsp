<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
  <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
  <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>초과수당관리</title>
<style type="text/css">
#baseExtSalList_tabs {
margin : auto;
width : 550px;
}

</style>
<script>
	// 전역변수 선언
	var baseExtSalList = [];
	var lastId = 0;
	var gridOptions;	
	$(document).ready(function(){
		/* css 전역 설정 */
		// 작은 버튼들의 css 별도 생성
		$(".small_Btn").css({
			width : "auto",
			height : "auto",
			fontSize : "15px",
			fontFamily : "MD개성체"
		}).button();

		// tab css
		$("#baseExtSalList_tabs").tabs();

		// event handling
		$("#submit_Btn").click(modifyBaseExtSalList);

		// grid setting
		$.ajax({
			url:"${pageContext.request.contextPath}/salary/baseExtSalManage.do",
			data:{
				"method" : "findBaseExtSalList"
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

				baseExtSalList = data.baseExtSalList;
				showBaseExtSalListGrid();
			}
		});
	});

	/* do submit */
	function modifyBaseExtSalList(){
		var sendData = JSON.stringify(baseExtSalList);
		$('#baseSalaryList_grid').children().remove();
		$.ajax({
			url : "${pageContext.request.contextPath}/salary/baseExtSalManage.do",
			data : {
				"method" : "modifyBaseExtSalList",
				"sendData" : sendData
			},
			dataType : "json",
			success : function(data) {
				if(data.errorCode < 0){
					alert("저장에 실패했습니다");
				} else {
					alert("저장되었습니다");
				}
				var eGridDiv = document.querySelector('#baseSalaryList_grid');
				new agGrid.Grid(eGridDiv, gridOptions);	
				console.log(sendData);
				location.reload();
			}
		});
	}

	/* 급여기준목록 그리드 띄우는 함수 aggrid*/
	 function showBaseExtSalListGrid(){
		 var result=[];   
		 var columnDefs = [
		      {headerName: "초과수당코드", field: "extSalCode" },
		      {headerName: "초과수당명", field: "extSalName", cellClass: 'rag-amber' },
		      {headerName: "배율", field: "ratio" },
		      {headerName: "상태", field: "status"}
		    	];    
		gridOptions = {
			columnDefs: columnDefs,
			rowData: baseExtSalList,
			defaultColDef: { editable: true },
			rowSelection: 'single', /* 'single' or 'multiple',*/
		    onCellEditingStopped: function (event) {
		        console.log('cellEditingStopped');
		        console.log(event.data.status);
		        console.log(event.data);
				if (event.data.status == "normal"){event.data.status = "update"}
					console.log(event.data.status);	
		    }
		    		
			    	};
			var eGridDiv = document.querySelector('#baseExtSalList_grid');
			new agGrid.Grid(eGridDiv, gridOptions);	
			gridOptions.api.sizeColumnsToFit();
	 		}

</script>
</head>
<body>
	<div id="baseExtSalList_tabs">
		<ul>
			<li><a href="#baseExtSalList_tab">초과수당관리</a></li>
		</ul>
		<div id="baseExtSalList_tab">
			<button class="ui-button ui-widget ui-corner-all" id="submit_Btn">변경확정</button><br />
			<br />
			<div id="baseExtSalList_grid"style="height: 600px; width:500px" class="ag-theme-balham"></div>
			<div id="baseExtSalList_pager"></div>
		</div>
	</div>
</body>
</html>