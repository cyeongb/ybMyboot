<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>일근태관리</title>
<style type="text/css">
input[type=text] {
   width: 150px;
   height: 10px;
   z-index: 100;
}

table{
   z-index: 90;
}     


</style>
<script>
var dayAttdMgtList = [];

   $(document).ready(function(){      

      $(".small_Btn").button();

      $(".comment_div").css({fontSize : "0.7em"});

      $("#dayAttendance_tabs").tabs().css({
         margin:"10px"
      });

      getDatePicker($("#searchDay"));
      $("#search_dayAttdMgtList_Btn").click(findDayAttdMgtList);
      $("#finalize_dayAttdMgt_Btn").click(finalizeDayAttdMgt);
      $("#cancel_dayAttdMgt_Btn").click(cancelDayAttdMgt);
      showDayAttdMgtListGrid();
      findDayAttdMgtList("today");
   });

   

   /* 일근태관리 목록 조회버튼 함수 */
   function findDayAttdMgtList(check){      
      var searchDay = $("#searchDay").val();
      
      if(check=="today"){ //해당 함수를 부를때에 today라는 글자가 변수로 넘어오면 오늘 날짜를 searchDay변수에 담아 ajax실행
          var today = new Date();
          var rrrr = today.getFullYear();
          var mm = today.getMonth()+1;
          var dd = today.getDate();
          searchDay = rrrr+"-"+mm+"-"+dd;
      }      
      
      $.ajax({
         url:"${pageContext.request.contextPath}/attendance/dayAttendanceManage.do",
         data:{
            "method" : "findDayAttdMgtList",
            "applyDay" : searchDay,
            "dept" : "${sessionScope.dept}"
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

            dayAttdMgtList = data.dayAttdMgtList;

             for(var index in dayAttdMgtList){
               dayAttdMgtList[index].attendTime = getRealTime(dayAttdMgtList[index].attendTime);
               dayAttdMgtList[index].quitTime = getRealTime(dayAttdMgtList[index].quitTime);
               dayAttdMgtList[index].lateHour = getRealKrTime(dayAttdMgtList[index].lateHour);
               dayAttdMgtList[index].leaveHour = getRealKrTime(dayAttdMgtList[index].leaveHour);
               dayAttdMgtList[index].workHour = getRealKrTime(dayAttdMgtList[index].workHour);
               dayAttdMgtList[index].overWorkHour = getRealKrTime(dayAttdMgtList[index].overWorkHour);
               dayAttdMgtList[index].nightWorkHour = getRealKrTime(dayAttdMgtList[index].nightWorkHour);
               dayAttdMgtList[index].publicLeaveHour = getRealKrTime(dayAttdMgtList[index].publicLeaveHour);
               dayAttdMgtList[index].privateLeaveHour = getRealKrTime(dayAttdMgtList[index].privateLeaveHour);
            }

            showDayAttdMgtListGrid();
         }
      });
   }

   
    /* 일근태관리 목록 그리드 띄우는 함수 */
    function showDayAttdMgtListGrid(){
      var columnDefs = [
             {headerName: "사원코드", field: "empCode",hide:true },
            {headerName: "사원명", field: "empName"},
            {headerName: "적용일", field: "applyDays" },
             {headerName: "일근태구분코드", field: "dayAttdCode",hide:true},
            {headerName: "일근태구분명", field: "dayAttdName"},
            {headerName: "출근시각", field: "attendTime"},
            {headerName: "퇴근시각", field: "quitTime"},
            {headerName: "지각여부", field: "lateWhether"},
            {headerName: "외출시간", field: "leaveHour"},
            {headerName: "사외출시간", field: "privateLeaveHour"},
            {headerName: "공외출시간", field: "publicLeaveHour"},   
            {headerName: "정상근무시간", field: "workHour"},
            {headerName: "연장근무시간", field: "overWorkHour"},
            {headerName: "심야근무시간", field: "nightWorkHour"},
            {headerName: "마감여부", field: "finalizeStatus"},
            {headerName: "상태", field: "status",hide:true}
      ];      
   gridOptions = {
         columnDefs: columnDefs,
         rowData: dayAttdMgtList,
         defaultColDef: { 
            editable: false, 
            width: 100,
            sortable: true,
              filter: true,
              resizable: true
            },
         rowSelection: 'single', /* 'single' or 'multiple',*/
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
   $('#dayAttdMgtList_grid').children().remove();    
   var eGridDiv = document.querySelector('#dayAttdMgtList_grid');
   new agGrid.Grid(eGridDiv, gridOptions);   
 }

    
    /* 마감처리 함수 */
    function finalizeDayAttdMgt(){
       console.log("마감 처리 시작");
       var dayAttdMonthData = 0; // 일근태관리의 월 데이터 
       console.log("dayAttdMonthData:" + dayAttdMonthData);
       var monthAttdFinalizeStatus = "N"; // 해당 일근태 관리의 월에 따른 월근태관리의 마감 여부 
       console.log("monthAttdFinalizeStatus: "+ monthAttdFinalizeStatus);
       
       
       gridOptions.api.forEachNode( function(rowNode, index) {
          var dateData = rowNode.data.applyDays;
          dayAttdMonthData = dateData.substring(0,dateData.lastIndexOf("-")); //YYYY-MM
          console.log(dayAttdMonthData)
          if(dateData.substring(5,6)==0) // 월에 0이 들어가 있다면   ex]2018-08  //YYYY-*M*M-DD
            dayAttdMonthData = replaceLast(dayAttdMonthData,0,""); // 0을 제거한다  ex]2018-8 //YYYY-M      
       });

       
      $.ajax({ // 월근태 목록을 가져온다
         url:"${pageContext.request.contextPath}/attendance/monthAttendanceManage.do",
         data:{
            "method" : "findMonthAttdMgtList",
            "applyYearMonth" : dayAttdMonthData
         },
         dataType:"json",
         async: false, // 동기처리를 하지 않으면 전역 변수 monthAttdFinalizeStatus에 값이 할당되기 전에 취소 작업이 일어남
         success : function(data){
            if(data.errorCode < 0){
               var str = "내부 서버 오류가 발생했습니다\n";
               str += "관리자에게 문의하세요\n";
               str += "에러 위치 : " + $(this).attr("id");
               str += "에러 메시지 : " + data.errorMsg;
               alert(str);
               return;
            }
   
            $.each(data.monthAttdMgtList, function(i, elt) {
                monthAttdFinalizeStatus = elt.finalizeStatus;
                return false;
            })
            
         }
      });
       
       if(monthAttdFinalizeStatus=="N"){ // 월근태 관리의 마감 상태가 N과 같다면 일근태 마감 처리를 한다
          for(var index in dayAttdMgtList){
            dayAttdMgtList[index].finalizeStatus = "Y";
            dayAttdMgtList[index].status = "update";
         }

         var sendData = JSON.stringify(dayAttdMgtList);
         
         console.log(sendData);

         $.ajax({
            url : "${pageContext.request.contextPath}/attendance/dayAttendanceManage.do",
            data : {
               "method" : "modifyDayAttdList",
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
       }else if(monthAttdFinalizeStatus=="Y"){
         alert("해당 월의 근태관리가 마감되었습니다\n데이터의 마감을 하시고자 하는 경우에는\n해당 월의 근태관리 마감을 취소하시고 시도해주세요")
      }
   }

    /* 마감취소 함수 */
    function cancelDayAttdMgt(){
       var dayAttdMonthData = 0; // 일근태관리의 월 데이터 
       var monthAttdFinalizeStatus = "N"; // 해당 일근태 관리의 월에 따른 월근태관리의 마감 여부 
       
       gridOptions.api.forEachNode( function(rowNode, index) {
             var dateData = rowNode.data.applyDays;
             dayAttdMonthData = dateData.substring(0,dateData.lastIndexOf("-")); //YYYY-MM
             console.log(dayAttdMonthData)
             if(dateData.substring(5,6)==0) // 월에 0이 들어가 있다면   ex]2018-08  //YYYY-*M*M-DD
               dayAttdMonthData = replaceLast(dayAttdMonthData,0,""); // 0을 제거한다  ex]2018-8 //YYYY-M      
          });
     
      $.ajax({ // 월근태 목록을 가져온다
         url:"${pageContext.request.contextPath}/attendance/monthAttendanceManage.do",
         data:{
            "method" : "findMonthAttdMgtList",
            "applyYearMonth" : dayAttdMonthData
         },
         dataType:"json",
         async: false, // 동기처리를 하지 않으면 전역 변수 monthAttdFinalizeStatus에 값이 할당되기 전에 취소 작업이 일어남
         success : function(data){
            if(data.errorCode < 0){
               var str = "내부 서버 오류가 발생했습니다\n";
               str += "관리자에게 문의하세요\n";
               str += "에러 위치 : " + $(this).attr("id");
               str += "에러 메시지 : " + data.errorMsg;
               alert(str);
               return;
            }
   
            $.each(data.monthAttdMgtList, function(i, elt) {
                monthAttdFinalizeStatus = elt.finalizeStatus;
                return false;
            })
            
         }
      });
 
       if(monthAttdFinalizeStatus=="N"){ //월근태 관리의 마감 상태가 N과 같다면 일근태 마감 취소 작업을 한다 
          for(var index in dayAttdMgtList){
            dayAttdMgtList[index].finalizeStatus = "N";
            dayAttdMgtList[index].status = "update";
         }
   
         var sendData = JSON.stringify(dayAttdMgtList);
   
         $.ajax({
            url : "${pageContext.request.contextPath}/attendance/dayAttendanceManage.do",
            data : {
               "method" : "modifyDayAttdList",
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
       }else if(monthAttdFinalizeStatus=="Y"){
         alert("해당 월의 근태관리가 마감되었습니다\n데이터의 마감을 취소하시고자 하는 경우에는\n해당 월의 근태관리 마감을 취소하시고 시도해주세요")
      }
   }

   /* 0000단위인 시간을 00:00(실제시간)으로 변환하는 함수 */
   function getRealTime(time){
      var hour = Math.floor(time/100); 
      if(hour==25) hour=1; //데이터 베이스에 넘길때는 25시로 받고나서 grid에 표시하는건 1시로
      var min = time-(Math.floor(time/100)*100);
      if(min.toString().length==1) min="0"+min; //분이 1자리라면 앞에0을 붙임
      if(min==0) min="00";
      return hour + ":" + min;
   }

   /* 0000단위인 시간을 (00시간00분) 형식으로 변환하는 함수 */
   function getRealKrTime(time){
      var hour = Math.floor(time/100);
      if(hour==25) hour=1;
      var min = time-(Math.floor(time/100)*100);
      if(min==0) min="00";
      return hour + "시간" + min + "분";
   }

   /* 날짜 조회창 함수 */
   function getDatePicker($Obj, maxDate) {
         $Obj.datepicker({
            changeMonth : true,
            changeYear : true,
            dateFormat : "yy-mm-dd",
            dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
            monthNamesShort : [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" ],
            yearRange: "1980:2020",
            maxDate : (maxDate==null? "+100Y" : maxDate)
         });
   }

   /* replacefirst는 있는데 last가 없어서 구현 */
   function replaceLast(str, regex, replacement) {
           var regexIndexOf = str.lastIndexOf(regex);
           if(regexIndexOf == -1){
               return str;
           }else{
              /* 넘어오는 regex가 number타입이기 때문에 length가 안먹힘 그래서 toString으로 문자열로 변경후 사용 */
               return str.substring(0, regexIndexOf) + replacement + str.substring(regexIndexOf + regex.toString().length);
           }
   }

</script>
</head>
<body>
   <div id="dayAttendance_tabs">
      <ul>
         <li>
            <a href="#dayAttendance_tab">일근태관리</a>
         </li>
      </ul>
      <div id="dayAttendance_tab">
         조회일자 <input type=text id="searchDay" class="small_Btn" readonly>
         <button class="small_Btn" id="search_dayAttdMgtList_Btn">조회하기</button>
         <br />
         <br />
         <button class="small_Btn" id="finalize_dayAttdMgt_Btn">전체마감하기</button>
         <button class="small_Btn" id="cancel_dayAttdMgt_Btn">전체마감취소</button>
         <br />
         <br />
      <div id="dayAttdMgtList_grid" style="height: 300px; width:1100px" class="ag-theme-balham"></div>
         <div id="dayAttdMgtList_pager"></div>
      </div>
   </div>
</body>
</html>