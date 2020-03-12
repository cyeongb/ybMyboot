<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>휴일목록</title>
<script>
	// 휴일목록을 담을 배열 
	var holidayList = [];
	var emptyInfo = {};
	var lastId = 0;
	var addrowData;
	$(document).ready(function() {

		// 휴일목록 탭 등록   
		$("#holidayListTabs").tabs()
		$("#add_Btn").click(addGridRow);
		$("#remove_Btn").click(removeGirdRow);
		$("#save_Btn").click(saveGridRow);

		$.ajax({
			url : "${pageContext.request.contextPath}/base/holidayList.do",
			dataType : "json",
			data : {
				method : "findHolidayList"
			},
			success : function(data) {
				holidayList = data.holidayList;
				emptyInfo = data.emptyHoilday;
				var columnDefs = [
				      {headerName: "일자", field: "applyDay" },
				      {headerName: "휴일명", field: "holidayName" },
				      {headerName: "비고", field: "note" },
				      {headerName: "상태", field: "status"}
				];    
				gridOptions = {
						columnDefs: columnDefs,
						rowData: holidayList,
						defaultColDef: { editable: true, width: 100 },
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
		    		    // 창 크기 변경 되었을 때 이벤트 
		    		    onGridSizeChanged: function(event) {
		    		        event.api.sizeColumnsToFit();
		    		    },
		    		    onCellEditingStarted: function (event) {
		    		        console.log('cellEditingStarted');
		    		    },
		    		    onCellEditingStopped: function (event) {
		    		        console.log('cellEditingStopped');
		    		        console.log(event.data.status);
		    		        console.log(event.data);
							if (event.data.status == "normal"){event.data.status = "update"}
					  			console.log(event.data.status);	
		    		    },    
		    	};   
					 
				var eGridDiv = document.querySelector('#holidayListGrid');
				new agGrid.Grid(eGridDiv, gridOptions);	
			 }	
		});
	});

	// 그리드에 행 추가하는 함수
	function createNewRowData() {
		var newData = {
				applyDay : "1",
				holidayName : "2",
				note  : "3",
			 	status   : "insert"
		};
	    return newData;
	}	
		
	function addGridRow() {
	    var newItem = createNewRowData();
	    gridOptions.api.updateRowData({add: [newItem]});
	    getRowData();
	}
	
	function getRowData() {
		addrowData = [];
	    gridOptions.api.forEachNode( function(node) {
	        addrowData.push(node.data);
	    });
	    console.log('Row Data:');
	    console.log(addrowData);
	}	 

	/* 그리드에 행 삭제 (주석은 행 추가하는거 참조)*/
	function removeGirdRow() {
	    var selectedData = gridOptions.api.getSelectedRows();
		var selectedData0 = selectedData[0]; 
	    if(selectedData0.status == "normal"){
	    	selectedData0.status = 'delete'
		}	
		console.log('delete Data:');
		console.log(selectedData0.status); 
	    console.log(selectedData);
	    getRowData();
	}	
	
	/* 저장 버튼을 눌렀을 때 실행되는 함수 */
	function saveGridRow() {
		if(addrowData != null){
			var sendData = JSON.stringify(addrowData);
			alert(sendData);
		}else{
			var sendData = JSON.stringify(holidayList);
			alert(sendData);
		}
	
		$('#holidayListGrid').children().remove();
		$.ajax({
			url : "${pageContext.request.contextPath}/base/holidayList.do",
			data : {
				"method" : "regitCodeList",
				"sendData" : sendData
			},
			dataType : "json",
			success : function(sendData) {
				console.log(sendData);
				if (sendData.errorCode < 0) {
					alert("저장에 실패했습니다");
				} else {
					alert("저장되었습니다");
				}
				var eGridDiv = document.querySelector('#holidayListGrid');
				new agGrid.Grid(eGridDiv, gridOptions);	
				console.log(sendData);
				location.reload();
			}
		});
	}
	
</script>
</head>
<body>
	<div id="holidayListTabs" style="display: inline-block;">
		<ul>
			<li><a href="#holidayList_tab">휴일목록</a></li>
		</ul>
		<div id="holidayList_tab">
			<input type="button" value="추가" class="ui-button ui-widget ui-corner-all" id="add_Btn"> 
				<input type="button" value="삭제" class="ui-button ui-widget ui-corner-all" id="remove_Btn"> 
				<input type="button" value="저장" class="ui-button ui-widget ui-corner-all" id="save_Btn"> <br />
			<div id="holidayListGrid" style="height: 600px; width:500px" class="ag-theme-balham"></div>
		</div>
	</div>
</body>
</html>