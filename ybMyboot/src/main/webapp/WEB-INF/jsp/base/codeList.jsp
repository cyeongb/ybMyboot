<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

 <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
  <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
  <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">

<script>
	$(document).ready(function(){
		codeList = [];  //코드번호(좌측)
		detailCodeList = [];   //상세코드 번호(우측)
		
		// tab css --> .tabs()는 jquery ui인데 하나의 컨텐츠에 여러개의 패널을 적용할 수 잇다(카테고리 처럼)
		$("#codeList_tabs").tabs();
		$("#detailCodeList_tabs").tabs();

		showGrid();   //코드관리정보
		showDetailCodeListGrid();  //상세 코드 그리드 띄우기
		
		
	});
	
	//코드관리정보 불러오기
	function showGrid(){
		$.ajax({
			url:"${pageContext.request.contextPath}/base/codeList.do",
			data:{
			//	"method" : "codelist"
			},
			dataType:"json",
			success : function(data){
				if(data.errorCode < 0){ //data.errorCode가 음수이면 실행 .
					var str = "내부 서버 오류가 발생했습니다\n";
					str += "관리자에게 문의하세요\n";
					str += "에러 위치 : " + $(this).attr("id");
					str += "에러 메시지 : " + data.errorMsg;
					alert(str);
					return;
				}  //data.errorCode가 양수이면 실행 함.

				codeList = data.codeList;  //배열형 codeList에  codelist라는 메서드에서 가지고 온 데이터들을 담는다.
				showCodeGrid();  //코드목록 그리드 띄우는 함수
			}
		});
	}	

    /* 코드목록 그리드 띄우는 함수 */
    function showCodeGrid(){
		var columnDefs = [
		      {headerName: "코드번호", field: "codeNumber" },
		      {headerName: "코드이름", field: "codeName" },
		      {headerName: "수정여부", field: "modifiable" },
		      {headerName: "상태", field: "status"}
		];    
		gridOptions = {
				columnDefs: columnDefs,
				rowData: codeList,
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
	  		    // 창 크기 변경 되었을 때 이벤트 
	  		    onGridSizeChanged: function(event) {
	  		        event.api.sizeColumnsToFit();
	  		    },
	  		    
	  		    onCellClicked : function(node) {
	  		  	console.log(node.data);
					var codeNumber = node.data.codeNumber;
					console.log(codeNumber);
				
				$.ajax({
					url:"${pageContext.request.contextPath}/base/codeList.do",
					data:{
					 	"method" : "detailCodelist",
						"code"	 : codeNumber
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
						
						detailCodeList = data.detailCodeList;
						showDetailCodeListGrid();
					}
				});
			}
	  		    
    	};
		var eGridDiv = document.querySelector('#codeList_grid');
		new agGrid.Grid(eGridDiv, gridOptions);	
    }
	
	//상세 코드 그리드 띄우기
    function showDetailCodeListGrid(){
    	var columnDefs = [
		      {headerName: "상세코드번호", field: "detailCodeNumber" },
		      {headerName: "코드번호", field: "codeNumber" },
		      {headerName: "상세코드이름", field: "detailCodeName" },
		      {headerName: "사용가능여부", field: "detailCodeNameusing" },
		      {headerName: "상태", field: "status"}
		];    
		gridOptions = {
				columnDefs: columnDefs,  //칼럼정보
				rowData: detailCodeList,  //그리드에 들어갈 key+value로 이루어진 json data를 넣어야한다.
				defaultColDef: { editable: false, width: 100 },  //공통으로 적용 될 공통 기본 정의.
				rowSelection: 'single', /* 'single' or 'multiple', row data를 선택하는 경우의 옵션으로 하나만 선택하거나 복수로 선택 가능*/
				enableColResize: true, //칼럼 resize가능 여부
				enableSorting: true, //정렬 옵션 가능 여부
				enableFilter: true,    //필터 옵션 허용 여부
				enableRangeSelection: true,  //정렬 기능 강제 여부로, true이면 정렬이 고정이 된다.
				suppressRowClickSelection: false,   //선택 가능 여부
				animateRows: true,    //열 효과?  
				suppressHorizontalScroll: true,   //가로 스크롤 허용여부, 자동조정으로 되어있으면 필요하지 않다고 함
				localeText: {noRowsToShow: '조회 결과가 없습니다.'},   //데이터가 없을 때 사용자에게 보여주는 메세지
				getRowStyle: function (param) {   //열 스타일 지정 css임.
		        	if (param.node.rowPinned) {
		            	return {'font-weight': 'bold', background: '#dddddd'};
		        	}
		        return {'text-align': 'center'};
		    	},
		    	getRowHeight: function(param) {   //열 높이값을 구함
		        	if (param.node.rowPinned) {  // 받아온 파라미터값의 객체가 행이 고정이면
		          	  return 30;
		        	}
		        return 24;  //고정 아니면 24
		    	},
	  		    // GRID READY 이벤트, 사이즈 자동조정 
	  		    onGridReady: function (event) {   //자스의 onload와 유사한데 ready 이후 필요한 이벤트를 삽입한다.
	  		        event.api.sizeColumnsToFit();  //그리드 자동 사이즈 지정--알맞게
	  		    },
	  		    // 창 크기 변경 되었을 때 이벤트 
	  		    onGridSizeChanged: function(event) {  //그리드 창 사이즈가 변경될 때 발생하는 이벤트
	  		        event.api.sizeColumnsToFit();   //자동으로 사이즈가 알맞게 조정된다.
	  		    }
		}
		// detailCodeList_grid의 전체 자식노드를 지운다.
		$('#detailCodeList_grid').children().remove();
		
		var eGridDiv = document.querySelector('#detailCodeList_grid');
		new agGrid.Grid(eGridDiv, gridOptions);	

    }
</script>
</head>

<body>
	<div id="codeList_tabs" style="display: inline-block;">
		<ul>
			<li><a href="#codeList_tab">코드관리</a></li>
		</ul>
		<div id="codeList_tab">
			<br /> <br />
			<div id="codeList_grid"style="height: 600px; width:500px" class="ag-theme-balham"></div>
		</div>
	</div>
	
	<div id="detailCodeList_tabs" style="display: inline-block;">
		<ul>
			<li><a href="#detailCodeList_tab">상세코드관리</a></li>
		</ul>
		<div id="detailCodeList_tab">
			<br /> <br />
			<div id="detailCodeList_grid"style="height: 600px; width:500px" class="ag-theme-balham"></div>
		</div>
	</div>
</body>
</html>