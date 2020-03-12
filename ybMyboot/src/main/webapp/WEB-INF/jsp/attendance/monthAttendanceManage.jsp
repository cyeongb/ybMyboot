
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="width: 1579px; ">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>월근태관리</title>
<style type="text/css">
input[type=text] {
   width: 150px;
   height: 10px;
}

.ag-center-cols-viewport{
overflow-x: scroll !important;
}

.ag-theme-balham  {
    box-sizing: content-box !important;
    }

</style>
<script>




var monthAttdMgtList = [];

   $(document).ready(function(){

       showMonthAttdMgtListGrid();
       
      $("input:text").button();
      $(".small_Btn").button();

      $(".comment_div").css({fontSize : "0.7em"});

      $("#monthAttendance_tabs").tabs().css({margin:"10px"});

      $("#search_monthAttdMgtList_Btn").click(function(){
    	  
//     	  if($("#searchYearMonth").val().trim()==""){
//     		  alert("날짜를 선택해주세요");
//     		  return;
//     	  }
    	  findMonthAttdMgtList();
      });
      $("#finalize_monthAttdMgt_Btn").click(finalizeMonthAttdMgt);
      $("#cancel_monthAttdMgt_Btn").click(cancelMonthAttdMgt);
      
      $("#searchYearMonth").selectmenu();
      var year = (new Date()).getFullYear();
      for(var i=1; i<=12; i++)
         $("#searchYearMonth").append($("<option />").val(year+"-"+i).text(year+"년 "+i+"월"));
   });

   /* 월근태관리 목록 조회버튼 함수 */
   function findMonthAttdMgtList(){
      if($("#searchYearMonth").val()==""){
         alert("적용연월을 선택해 주세요");
         return;
      }

      $.ajax({
         url:"${pageContext.request.contextPath}/attendance/monthAttendanceManage.do",
         data:{
            "method" : "findMonthAttdMgtList",
            "applyYearMonth" : $("#searchYearMonth").val()
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

            monthAttdMgtList = data.monthAttdMgtList;

             for(var index in monthAttdMgtList){
                monthAttdMgtList[index].workHour = getRealTime(monthAttdMgtList[index].workHour);
                monthAttdMgtList[index].overWorkHour = getRealTime(monthAttdMgtList[index].overWorkHour);
                monthAttdMgtList[index].nightWorkHour = getRealTime(monthAttdMgtList[index].nightWorkHour);
                monthAttdMgtList[index].holidayWorkHour = getRealTime(monthAttdMgtList[index].holidayWorkHour);
                monthAttdMgtList[index].holidayOverWorkHour = getRealTime(monthAttdMgtList[index].holidayOverWorkHour);
                monthAttdMgtList[index].holidayNightWorkHour = getRealTime(monthAttdMgtList[index].holidayNightWorkHour);
            }
            
            showMonthAttdMgtListGrid();
         }
      });
   }

    /* 월근태관리 목록 그리드 띄우는 함수 */
    function showMonthAttdMgtListGrid(){
      var columnDefs = [
            {headerName: "사원코드", field: "empCode" },
            {headerName: "사원명", field: "empName"},
            {headerName: "적용연월", field: "applyYearMonth" },
            {headerName: "기준근무일수", field: "basicWorkDays"},
            {headerName: "평일근무일수", field: "weekdayWorkDays"},
            {headerName: "기준근무시간", field: "basicWorkHour"},
            {headerName: "실제근무시간", field: "workHour"},
            {headerName: "연장근무시간", field: "overWorkHour"},
            {headerName: "심야근무시간", field: "nightWorkHour"},
            {headerName: "휴일근무일수", field: "holidayWorkDays"},
            {headerName: "휴일근무시간", field: "holidayWorkHour"},
            {headerName: "지각일수", field: "lateDays"},
            {headerName: "결근일수", field: "absentDays"},
            {headerName: "반차일수", field: "halfHolidays"},
            {headerName: "휴가일수", field: "holidays"},
            {headerName: "마감여부", field: "finalizeStatus"},
            {headerName: "상태", field: "status",hide:true}
      ];      
   gridOptions = {
         columnDefs: columnDefs,
         rowData: monthAttdMgtList,
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
   $('#monthAttdMgtList_grid').children().remove();    
   var eGridDiv = document.querySelector('#monthAttdMgtList_grid');
   new agGrid.Grid(eGridDiv, gridOptions);   
}

    /* 마감처리 함수 */
    function finalizeMonthAttdMgt(){
      for(var index in monthAttdMgtList){
         monthAttdMgtList[index].finalizeStatus = "Y";
         monthAttdMgtList[index].status = "update";
      }

      var sendData = JSON.stringify(monthAttdMgtList);

      $.ajax({
         url : "${pageContext.request.contextPath}/attendance/monthAttendanceManage.do",
         data : {
            "method" : "modifyMonthAttdList",
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

    /* 마감취소 함수 */
    function cancelMonthAttdMgt(){
      for(var index in monthAttdMgtList){
         monthAttdMgtList[index].finalizeStatus = "N";
         monthAttdMgtList[index].status = "update";
      }

      var sendData = JSON.stringify(monthAttdMgtList);

      $.ajax({
         url : "${pageContext.request.contextPath}/attendance/monthAttendanceManage.do",
         data : {
            "method" : "modifyMonthAttdList",
            "sendData" : sendData
         },
         dataType : "json",
         success : function(data) {
            if(data.errorCode < 0){
               alert("마감취소를 실패했습니다");
            } else {
               alert("마감취소처리 되었습니다");
            }
            location.reload();
         }
      });
   }

   /* 0000단위인 시간을 (00시간00분) 형식으로 변환하는 함수 */
   function getRealTime(time){
      var hour = Math.floor(time/100); 
      if(hour==25) hour=1; //데이터 베이스에 넘길때는 25시로 받고나서 grid에 표시하는건 1시로
      var min = time-(Math.floor(time/100)*100);
      if(min.toString().length==1) min="0"+min; //분이 1자리라면 앞에0을 붙임
      if(min==0) min="00";
      return hour + ":" + min;
   }
</script>
</head>
<body>
   <div id="monthAttendance_tabs" >
      <ul>
         <li>
            <a href="#monthAttendance_tab">월근태관리</a>
         </li>
      </ul>
      <div id="monthAttendance_tab">
         조회월 <select id="searchYearMonth"></select>
         <button class="ui-button ui-widget ui-corner-all" id="search_monthAttdMgtList_Btn">조회하기</button>
<!--          <br /> -->
<!--          <br /> -->
         <button class="ui-button ui-widget ui-corner-all" id="finalize_monthAttdMgt_Btn">전체마감하기</button>
         <button class="ui-button ui-widget ui-corner-all" id="cancel_monthAttdMgt_Btn">전체마감취소</button>
         <br />
         <br />
         <br>
         <div id="monthAttdMgtList_grid" style="height: 300px; width:1420px" class="ag-theme-balham"></div>
         <div id="monthAttdMgtList_pager"></div>
      </div>
   </div>
</body>
</html>