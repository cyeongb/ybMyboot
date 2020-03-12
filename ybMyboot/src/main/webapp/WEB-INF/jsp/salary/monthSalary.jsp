<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>개인급여조회</title>
<style>
</style>
<script>
var monthSalary = [];
var yearSalary = [];
var monthSalaryGridData = [];
var empCode = "${sessionScope.code}";

   $(document).ready(function(){

       showYearSalaryGrid();
       showMonthDeductionListGrid();
      showMonthExtSalListGrid();
      showMonthSalaryGrid();

      
      $("#request_Btn").click(printWorkInfoReport);
      
      $("#yearSalary_col").click(function(){ //연급여조회 탭을 누르면
         $("#deduction_tabs").hide(); //공제, 초과수당 grid를 숨긴다
      })

      $("#monthSalary_col").click(function(){ //월급여조회 탭을 누르면
         $("#deduction_tabs").show(); //공제, 초과수당 grid를 보여준다
      })
      
      
      // input:text에 버튼 형식의 css 씌움
      $("input:text").button().css({
         width:"150px",
         height:"10px"
      });


      // tabs css
      $("#salary_tabs").tabs().css({
         width:"1300px",
         height:"400px",
         padding:"10px",
         margin:"10px",
      });    


      $("#deduction_tabs").tabs().css({
         width:"1300px",
         height:"300px",
         margin:"10px 10px 10px 0px",
      });

      // 적용연월 셀렉터
      $("#searchYearMonth").selectmenu();
      var year = '2020';//(new Date()).getFullYear();  월급여 테이블 데이터가 2019년 08월만 있어 연도 2019로 고정해둠
      for(var i=1; i<=12; i++){
         
         $("#searchYearMonth").append($("<option />").val(year+"-"+i).text(year+"년 "+i+"월"));
      }

      
      $("#searchYear").selectmenu();
      var curYear = (new Date()).getFullYear();
      var i = curYear - 5;
      for(i; i < curYear + 1; i++) //현재 연도에 -5~+5년까지 조회 가능하게함
         $("#searchYear").append($("<option />").val(i).text(i+"년"));
      
      // 월급여 조회하기 버튼
      $("#monthSearch_Btn").click(findMonthSalary);

      // 연급여 조회하기 버튼
      $("#yearSearch_Btn").click(findYearSalary);
      
      // 마감 버튼
      $("#finalize_Btn").click(finalizeMonthSalary);

      // 마감취소 버튼
      $("#cancel_Btn").click(cancelMonthSalary);

   });
   
   
   /* 급여명세서 */
   function printWorkInfoReport(){
      applyMonth = $("#searchYearMonth").val();
      
         window.open(
               "${pageContext.request.contextPath }/base/empReport.do?method=requestMonthSalary&empCode="+empCode+"&applyMonth="+applyMonth,
               "급여명세서",
               "width=1280, height=1024");
   }


   /* 월급여 조회하기 */
   function findMonthSalary(){
      if($("#searchYearMonth").val()==""){
         alert("적용 연월을 선택해 주세요");
         return;
      }      
      $.ajax({
         url:"${pageContext.request.contextPath}/salary/monthSalary.do",
         data:{
            "method" : "findMonthSalary",
            "applyYearMonth" : $("#searchYearMonth").val(),
            "empCode" : empCode
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
            
             monthSalary = data.monthSalary;

             /* 가져온 데이터들중에 금액과 관련된 데이터에 콤마,'원'을 붙임 */
            $.each(monthSalary.monthDeductionList, function(i, elt) {
               monthSalary.monthDeductionList[i].price = numberWithCommas(monthSalary.monthDeductionList[i].price)+"원";
            });

            $.each(monthSalary.monthExtSalList, function(i, elt) {
               monthSalary.monthExtSalList[i].price = numberWithCommas(monthSalary.monthExtSalList[i].price)+"원";
            });
            

            monthSalary.realSalary = numberWithCommas(monthSalary.realSalary)+"원";
            monthSalary.salary = numberWithCommas(monthSalary.salary)+"원";
            monthSalary.totalDeduction = numberWithCommas(monthSalary.totalDeduction)+"원";
            monthSalary.totalExtSal = numberWithCommas(monthSalary.totalExtSal)+"원";
            monthSalary.totalPayment = numberWithCommas(monthSalary.totalPayment)+"원";

            /* monthSalary 통째로 그리드에 넣으면 인식이 안됨 그래서 따로 빼서 객체화시켜 집어넣음 */
            monthSalaryGridData.push({
               "empCode":monthSalary.empCode, 
                "applyYearMonth":monthSalary.applyYearMonth,
                "salary":monthSalary.salary,
                "totalExtSal":monthSalary.totalExtSal,
                "totalPayment":monthSalary.totalPayment,
                "totalDeduction":monthSalary.totalDeduction,
                "realSalary":monthSalary.realSalary,
                "cost":monthSalary.cost,
                "unusedDaySalary":monthSalary.unusedDaySalary,
                "finalizeStatus":monthSalary.finalizeStatus
            });

            /* 데이터를 가져와서 일련의 작업 후 바로 그리드 재호출 */
            showMonthSalaryGrid(); 
            showMonthDeductionListGrid();
            showMonthExtSalListGrid();
            
            monthSalary = {};
            yearSalary = {};
            monthSalaryGridData = [];
         }
      });
      
   }

   /* 연급여 조회하기 */
   function findYearSalary(){
      if($("#searchYear").val()==""){
         alert("적용 연도를 선택해 주세요");
         return;
      }
      $.ajax({
         url:"${pageContext.request.contextPath}/salary/monthSalary.do",
         data:{
            "method" : "findYearSalary",
            "applyYear" : $("#searchYear").val(),
            "empCode" : empCode
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
            if(data.yearSalary==""){
               alert("해당 연도의 마감 완료된 급여 정보가 존재하지 않습니다");
            }else{

               yearSalary = data.yearSalary;
               
               $.each(yearSalary, function(i, elt) {
                   yearSalary[i].realSalary = numberWithCommas(yearSalary[i].realSalary)+"원";
                   yearSalary[i].salary = numberWithCommas(yearSalary[i].salary)+"원";
                   yearSalary[i].totalDeduction = numberWithCommas(yearSalary[i].totalDeduction)+"원";
                   yearSalary[i].totalExtSal = numberWithCommas(yearSalary[i].totalExtSal)+"원";
                   yearSalary[i].totalPayment = numberWithCommas(yearSalary[i].totalPayment)+"원";
               });
               
               showYearSalaryGrid();
               monthSalary = {};
               yearSalary = {};
               monthSalaryGridData = [];
            }
         }
      });
   }

   /* 숫자 3자리마다 콤마를 찍는 정규표현식 */
   function numberWithCommas(won) {
       return won.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
   }

    /* 마감처리 함수 */
    function finalizeMonthSalary(){
      monthSalary.finalizeStatus = "Y";
      monthSalary.empCode=empCode;
      monthSalary.applyYearMonth=$("#searchYearMonth").val();
      
      var sendData = JSON.stringify(monthSalary);
      
      $.ajax({
         url : "${pageContext.request.contextPath}/salary/monthSalary.do",
         data : {
            "method" : "modifyMonthSalary",
            "sendData" : sendData
         },
         dataType : "json",
         success : function(data) {
            if(data.errorCode < 0){
               alert("마감을 실패했습니다");
            } else {
               alert("마감처리 되었습니다");
            }
            location.reload();
         }
      });
   }
    
    /* 마감취소 처리 함수 */
    function cancelMonthSalary(){
      monthSalary.finalizeStatus = "N";
      monthSalary.empCode=empCode;
      monthSalary.applyYearMonth=$("#searchYearMonth").val();
      
      var sendData = JSON.stringify(monthSalary);
      
      $.ajax({
         url : "${pageContext.request.contextPath}/salary/monthSalary.do",
         data : {
            "method" : "modifyMonthSalary",
            "sendData" : sendData
         },
         dataType : "json",
         success : function(data) {
            if(data.errorCode < 0){
               alert("마감취소에 실패했습니다");
            } else {
               alert("취소처리 되었습니다");
            }
            location.reload();
         }
      });
   }
    
    /* 월급여조회 그리드 */
   function showMonthSalaryGrid(){
      var columnDefs = [
            {headerName: "사원코드", field: "empCode",hide:true },
            {headerName: "적용연월", field: "applyYearMonth",hide:true},
            {headerName: "본 급여", field: "salary" },
            {headerName: "초과수당합계", field: "totalExtSal"},
            {headerName: "총 급여", field: "totalPayment"},
            {headerName: "공제금액합계", field: "totalDeduction"},
            {headerName: "차인지급액", field: "realSalary"},
            {headerName: "경비지급액", field: "cost"},
            {headerName: "연차미사용수당", field: "unusedDaySalary"},
            {headerName: "마감여부", field: "finalizeStatus"}
      ];      
   gridOptions = {
         columnDefs: columnDefs,
         rowData: monthSalaryGridData,
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
          onCellEditingStarted: function (event) {
              console.log('cellEditingStarted');
          }, 
   };   
   $('#monthSalary_grid').children().remove();    
   var eGridDiv = document.querySelector('#monthSalary_grid');
   new agGrid.Grid(eGridDiv, gridOptions);   
}

   /* 연급여조회 그리드 */
    function showYearSalaryGrid() {
      var columnDefs = [
            {headerName: "사원코드", field: "empCode",hide:true },
            {headerName: "적용연월", field: "applyYearMonth",hide:true},
            {headerName: "본 급여", field: "salary" },
            {headerName: "초과수당합계", field: "totalExtSal"},
            {headerName: "총 급여", field: "totalPayment"},
            {headerName: "공제금액합계", field: "totalDeduction"},
            {headerName: "차인지급액", field: "realSalary"}
      ];     
   gridOptions = {
         columnDefs: columnDefs,
         rowData: yearSalary,
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
          onCellEditingStarted: function (event) {
              console.log('cellEditingStarted');
          }, 
   };   
   $('#yearSalary_grid').children().remove();    
   var eGridDiv = document.querySelector('#yearSalary_grid');
   new agGrid.Grid(eGridDiv, gridOptions);   
}

    
   /* 공제내역 그리드 */
   function showMonthDeductionListGrid(){
      var columnDefs = [
            {headerName: "사원코드", field: "empCode",hide:true },
            {headerName: "적용연월", field: "applyYearMonth"},
            {headerName: "공제항목코드", field: "deductionCode" },
            {headerName: "공제항목명", field: "deductionName"},
            {headerName: "공제금액", field: "price"},
      ];      
   gridOptions = {
         columnDefs: columnDefs,
         rowData: monthSalary.monthDeductionList,
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
          onCellEditingStarted: function (event) {
              console.log('cellEditingStarted');
          }, 
   };   
   $('#monthDeductionList_grid').children().remove();    
   var eGridDiv = document.querySelector('#monthDeductionList_grid');
   new agGrid.Grid(eGridDiv, gridOptions);   
}

   /* 초과수당내역 그리드 */
   function showMonthExtSalListGrid(){
      var columnDefs = [
            {headerName: "사원코드", field: "empCode",hide:true },
            {headerName: "적용연월", field: "applyYearMonth"},
            {headerName: "초과수당코드", field: "extSalCode" },
            {headerName: "초과수당명", field: "deductionName"},
            {headerName: "금액", field: "price"},
      ];      
   gridOptions = {
         columnDefs: columnDefs,
         rowData: monthSalary.monthExtSalList,
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
          onCellEditingStarted: function (event) {
              console.log('cellEditingStarted');
          }, 
   };   
   $('#monthExtSalList_grid').children().remove();    
   var eGridDiv = document.querySelector('#monthExtSalList_grid');
   new agGrid.Grid(eGridDiv, gridOptions);   
}
</script>
</head>
<body>
<div id="salary_tabs">
      <ul>
         <li id = "monthSalary_col">
            <a href="#monthSalary_tab">월급여조회</a>
         </li>
         <li id = "yearSalary_col">
            <a href="#yearSalary_tab">연급여조회</a>
         </li>
      </ul>
      <div id="monthSalary_tab">
         조회 월 <select id="searchYearMonth"></select>
         <input type="button" class="ui-button ui-widget ui-corner-all" id="monthSearch_Btn" value="조회하기"/><br /><br />
         <input type="button" class="ui-button ui-widget ui-corner-all" id="finalize_Btn" value="마감"/>
         <input type="button" class="ui-button ui-widget ui-corner-all" id="cancel_Btn" value="마감취소"/>
         <input type="button" class="ui-button ui-widget ui-corner-all" id="request_Btn" value="발급"/><br /><br />
         <div id="monthSalary_grid" style="height: 230px; width:1200px" class="ag-theme-balham"></div>
      </div>
      <div id="yearSalary_tab">
         조회 연도 <select id="searchYear"></select><input type="button" class="ui-button ui-widget ui-corner-all" id="yearSearch_Btn" value="조회하기"/>
         <div>마감 완료된 월의 급여 정보만 출력됩니다</div>
         <div id="yearSalary_grid" style="height: 250px; width:1200px" class="ag-theme-balham"></div>
      </div>
</div>

<div id="deduction_tabs">
      <ul>
         <li>
            <a href="#deduction_tabs">공제내역</a>
         </li>
         <li>
            <a href="#ext_sal_tabs">초과수당내역</a>
         </li>
      </ul>
      <div id="deduction_tabs">
         <div id="monthDeductionList_grid" style="height: 230px; width:1200px" class="ag-theme-balham"></div>
         <div id="monthDedcutionList_pager"></div>
      </div>
      <div id="ext_sal_tabs">
         <div id="monthExtSalList_grid" style="height: 230px; width:1200px" class="ag-theme-balham"></div>
         <div id="monthExtSalList_pager"></div>
      </div>
</div>
</body>
</html>