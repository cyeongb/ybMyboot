<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>일근태기록/조회</title>
<style type="text/css">
#dayAttdrequest_tabs {
   width: 40%;
   height: 420px;
   display: inline-block;
   position: absolute;
   top: 180%;
   left: 100px;
}

#dayAttdList_tabs {
   width: 45%;
   height: 420px;
   display: inline-block;
   position: absolute;
   top: 180%;
   left: 46%;
}

input[type=text]:not (#timePicker ) {
   width: 180px;
   height: 10px;
}

.small_Btn {
   width: auto;
   height: auto;
   fontSize: 15px;
}

#clock {
   margin: auto;
}
</style>

<script>
   var empCode = "${sessionScope.code}";
   var currentHours = 0;    // 시계의 시간
   var currentMinute = 0;   // 시계의 분
   var amPm;             // 시계의 AM,PM
   var conversionDate = 0; // timePicker의 :를 제거하고 자정 이후의 시간을 변환한 값   
   var dayAttdList = [];    // 근태목록
   var holidayList = [];    // 휴일목록
   var isHoliday = false;    // 휴일여부
   var isEarlyOut=false ;    // 조퇴여부
   var restTypeCode=[];    // 근태외코드   
   var earlyOutTime = 0;    // 조퇴시간
   var leaveTime=[];      // 외출

   
$(document).ready(function(){   
   var today=$.datepicker.formatDate($.datepicker.ATOM,new Date()); // 바로 오늘 날짜 뜨게      
   $("#applyDay").val(today);
   
   printClock();             // 시계표시함수 호출
   findDayAttdList("today");    // 시작하자마자 오늘 날짜의 근태목록을 조회목록 grid에 띄움
   //showDayAttdListGrid();    // 여기서 뿌려줄 필요  X <== findDayAttdList("today"); 안에서 뿌려준다.

   $(":text:not(#timePicker)").button();     // timePicker가 아닌 form들을 바꿔줌. - : 선택자 
     $("#timePicker").button().css({width : "70px",height : "15px"});;
   $(".small_Btn").button();

   $("#dayAttdrequest_tabs").tabs();       // tab 기능으로 바꿔줌 -- <li><a href="#해당div">탭 이름</a></li>
   $("#dayAttdList_tabs").tabs();

    getDatePicker($("#applyDay"));          // 적용일자
    getDatePicker($("#searchDay"));       // 조회일자

   $("#dayAttdrequest_col").click(function(){    //일근태기록 탭을 클릭하면 조회목록 grid의 row값을 오늘 근태목록으로 바꿈
       findDayAttdList("today");
   })

   $("#attdTypeName").click(function(){    // 근태명 입력창
         getCode("CO-09","attdTypeName","attdTypeCode");
   });

   $("#registDayAttd_Btn").click(registDayAttd);          // 기록하기 버튼  
   $("#search_dayAttdList_Btn").click(findDayAttdList);    // 조회버튼
   $("#delete_dayAttd_Btn").click(function(){             // 삭제버튼   
      //var flag = confirm("선택한 근태신청을 정말 삭제하시겠습니까?");
         //if(flag){ 
            removeDayAttdList(); 
         //   }
        });
  
   $("#timePicker").click(function(){       // timePicker
      $(this).timepicker({
                      step: 5,                  //시간간격 : 5분
                      timeFormat: "H:i",         //시간:분 으로표시
                      minTime: "00:00am",
                      maxTime: "23:55pm" 
                        });
     })

     $("#timeCheck_Btn").click(function(){    //시계기록 눌렀을 때 시계시간, clock 넘기기
      var checkHours = $("#clock").text().split(" ")[0].substring(0,2); 
      var checkMinute = $("#clock").text().split(" ")[0].substring(3,5);       
      registDayAttd("Clock",checkHours+checkMinute);
      })
      
     $("#applyDay").change(function(){      // 적용일자를 바꿨을 때 조회목록 grid의 row값을 해당 날짜목록으로 바꿈
        findDayAttdList("applyDay");
     });
 });

   
/* 시계 만드는 함수 */
function printClock() {    
   var clock = $("#clock");                 // 출력할 장소 선택
    var currentDate = new Date();            // 현재시간
    var calendar = currentDate.getFullYear() + "-" + (currentDate.getMonth()+1) + "-" + currentDate.getDate()          // 현재 날짜 //2020-1-17
    amPm = 'AM';                      // 초기값 AM
    currentHours = addZeros(currentDate.getHours(),2); 
    currentMinute = addZeros(currentDate.getMinutes() ,2); 
    var currentSeconds = addZeros(currentDate.getSeconds(),2);
     
    if(currentHours >= 12){             // 시간이 12보다 클 때 PM으로 세팅
       amPm = 'PM';
        currentHours = addZeros(currentHours,2);
    }
     
    currentSeconds = '<span style="font-size:25px">'+currentSeconds+'</span>'; 

    clock.html(currentHours+":"+currentMinute+":"+currentSeconds +" <span style='font-size:50px;'>"+ amPm+"</span>");    //날짜를 출력해 줌
     
    //setTimeout("printClock()",1000);       // 1초마다 printClock() 함수 호출 // 되도록이면 밑에껄로 호출해라?
    setTimeout(printClock, 1000);
}


function addZeros(num, digit) {          // 시계 자릿수 맞춰주기 // 9시 일경우 09시로 만들어줌 
   var zero = '';
    num = num.toString();
    if (num.length < digit) {
       for (i = 0; i < digit - num.length; i++) {
        zero += '0';
       }
    }
    return zero + num;
}


/* 일근태목록 조회버튼 함수 */ 
function findDayAttdList(check){
   var searchDay = "";
   
   if(check=="today"){                // 해당 함수를 부를때에 today라는 글자가 변수로 넘어오면 오늘 날짜를 searchDay변수에 담아 ajax실행
      var today = new Date();         
       var rrrr = today.getFullYear();
       var mm = today.getMonth()+1;
       var dd = today.getDate();
       searchDay = rrrr+"-"+mm+"-"+dd;
   }else if(check=="applyDay"){         // #applyDay의 값이 바뀔때 #applyDay의 해당 날짜를 받아와서 searchDay변수에 담는다. // 새로 추가함
      searchDay = $("#applyDay").val();
   }else{                           // 일근태조회 탭에서 조회를 클릭할 때 #searchDay의 해당 날짜를 받아와서 searchDay변수에 담는다. 
      searchDay = $("#searchDay").val();
   }
   
   $.ajax({
            url:"${pageContext.request.contextPath}/attendance/dayAttendance.do",
            data:{
        //     "method"    : "findDayAttdList",
             "empCode"    : empCode,
             "applyDay"   : searchDay
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
                  //console.log(data);
                  
                   dayAttdList = data.dayAttdList;
                   for(var index in dayAttdList){
                	   dayAttdList[index].applyDay = getRealDay(dayAttdList[index].time, dayAttdList[index].applyDay);
                       dayAttdList[index].time = getRealTime(dayAttdList[index].time); // 1500 -> 15:00
                          
                   }
                   showDayAttdListGrid();
            }
     });
}


/* 0000단위인 시간을 00:00(실제시간)으로 변환하는 함수 */
function getRealTime(time){
     var hour = Math.floor(time/100);
     if(hour>=25) 
        hour-=24;                   //데이터 베이스에 넘길때는 25시로 받고나서 grid에 표시하는건 1시로
     var min = time-(Math.floor(time/100)*100);
     if(min.toString().length==1) 
        min="0"+min;                //분이 1자리라면 앞에 0을 붙임
     if(min==0) 
        min="00";
     return hour + ":" + min;
}

/* 2400시 이상일때 날짜를 다음날로 출력해줌*/
function getRealDay(time, applyDay){
   var hour = Math.floor(time/100);   
   var date = new Date(applyDay+'/00:00:00');
     if(hour>=24) {
      date.setDate(date.getDate()+1)
      applyDay = date.getFullYear()+'/' + ('0'+(date.getMonth()+1)).slice(-2) + '/' + ('0' + date.getDate()).slice(-2);   
     }
     return applyDay;
}


/* 일근태목록 정보를 그리드에 뿌려주는 함수 */
function showDayAttdListGrid(){
   var columnDefs = [
      {headerName: "사원코드", field: "empCode", hide:true },
       {headerName: "일련번호", field: "dayAttdCode", hide:true },
       {headerName: "적용일", field: "applyDay", checkboxSelection: true },
       {headerName: "근태구분코드", field: "attdTypeCode", hide:true},
       {headerName: "근태구분명", field: "attdTypeName"},
       {headerName: "시작", field: "time"}
   ];
   gridOptions = {
      columnDefs: columnDefs,
      rowData: dayAttdList,
      defaultColDef: { 
         editable: false, 
         width: 100,
         sortable : true, 
         resizable:true, 
         filter:true 
      },
      rowSelection: 'multiple',   /* 'single' or 'multiple',*/
      // enableColResize: true,   // 구버전으로 사용 안하는걸 추천 위에 resizable:true로 대체
      // enableSorting : true,    // 구버전으로 사용 안하는걸 추천 위에 sortable:true로 대체
      // enableFilter: true,      // 구버전으로 사용 안하는걸 추천 위에 filter:true로 대체
      rowHeight:24,
      enableRangeSelection: true,
      suppressRowClickSelection: false,
      animateRows: true,
      suppressHorizontalScroll: true,
      localeText: {noRowsToShow: '조회 결과가 없습니다.'},   // 데이터가 없을 때 뿌려지는 글
      /*
      getRowStyle: function (param) {               // 스타일지정  ?
         console.log(param)
         if (param.node.rowPinned) {               // 노드의 열고정값이 있으면??? 
             return {'font-weight': 'bold', background: '#dddddd'};
          }
          return {'text-align': 'center'};
      },
      getRowHeight: function(param) {
         if (param.node.rowPinned) {
             return 30;
          }
          return 24;
      },*/
      
      // GRID READY 이벤트, 사이즈 자동조정 
      onGridReady: function (event) {
         event.api.sizeColumnsToFit();
      },
      // 창 크기 변경 되었을 때 이벤트 
      onGridSizeChanged: function(event) {
         event.api.sizeColumnsToFit();
      },
      /*
      onCellEditingStarted: function (event) {   // 수정을 시작하면 출력
         console.log('cellEditingStarted');
      } */
      
   };   
   $('#dayAttdList_grid').children().remove();    
   var eGridDiv = document.querySelector('#dayAttdList_grid');
   new agGrid.Grid(eGridDiv, gridOptions);   
   console.log("dd");
 }    


 /* timePicker시간을 변경하는 함수 */
function convertTimePicker(){
   conversionDate = $("#timePicker").val().replace(":","");
   
   if(conversionDate.indexOf("00")==0){
         conversionDate = $("#timePicker").val().replace(":","").replace("00","24");
   }
//    else if(conversionDate.indexOf("01")==0){
//          conversionDate = $("#timePicker").val().replace(":","").replace("01","25");
//    }
}

 


/* 삭제버튼 눌렀을 때 실행되는 함수 */
   function removeDayAttdList(){
      var selectedRowData=gridOptions.api.getSelectedRows();
      var sendData = JSON.stringify(selectedRowData);
      
      if(selectedRowData == ""){
         alert("삭제할 항목을 선택하세요.");
      } 
      else {
         $.ajax({
            url : "${pageContext.request.contextPath}/attendance/dayAttendance.do",
            data : {
               //   "method" : "removeDayAttdList",
                  "sendData" : sendData
               },
               dataType : "json",
               success : function(data) {
                     if(data.errorCode < 0){
                        alert("정상적으로 삭제되지 않았습니다");
                     } else {
                            alert("삭제되었습니다");
                     }
                     location.reload();  // document.ready()를 한번 더 실행시켜서  findDayAttdList("today") 함수를 실행시킴
               }
         });      
      }

   }


/* 기록버튼 눌렀을 때 실행되는 함수 */ //프로시저로
function registDayAttd(clock,clockTime){   
   //var alertMsg = "조퇴나 외출을 원하시면 근태외 신청을해주세요";
   var clockCheck = clock; //timepicker로 기록할것인지 시계로 기록할것인지 여부를 가릴 변수     
   var checkVar = false; //근태기록 ajax실행 여부를 가릴 변수
   var today = new Date($("#applyDay").val()); //오늘 요일을 가져오기위한 Date객체
   var dayAttd = {};
  
   if($("#applyDay").val().trim()==""){
         alert("적용일을 입력해 주세요");
         return ;
     }  
   if($("#attdTypeName").val().trim()==""){
         alert("근태구분을 입력해 주세요");
         return ;
   }
   convertTimePicker(); // 멤버변수 conversionDate에 timePicker 선택한 시간을 변환    

   /* 날릴 데이터 셋팅 */
   if(clockCheck=="Clock"){// 현시각으로 버튼 클릭
      dayAttd ={
               "empCode" : empCode,
               applyDay : $("#applyDay").val(),
               attdTypeCode : $("#attdTypeCode").val(),
                attdTypeName : $("#attdTypeName").val(),
                time : clockTime    // 매개변수사용
                };
     }else{               // 기록하기  버튼 클릭
      if(conversionDate==""){
         alert("시간을 입력해 주세요");
         return;
      }if(conversionDate.substring(2,4)>=60){ 
          alert("알맞은형식이 아닙니다 "); 
          return;
      }if(conversionDate>1900){
    	  alert("19시 이후 퇴근은 초과근무입니다. 초과근무 신청을 해 주세요");
      }
        dayAttd ={
               "empCode" : empCode, // 사원번호
                applyDay : $("#applyDay").val(), // 적용일자
                attdTypeCode : $("#attdTypeCode").val(), // 근태구분 코드
                attdTypeName : $("#attdTypeName").val(),  //근태구분 이름
                time : conversionDate // 맴버변수 사용
                 };
     }

   var sendData = JSON.stringify(dayAttd);  // json 데이터로 변환
      $.ajax({
            url : "${pageContext.request.contextPath}/attendance/dayAttendance.do",
            data : {
               //   "method" : "registDayAttd",
                  "sendData" : sendData
                  },
            dataType : "json",
            success : function(data) {
                if(data.errorCode < 0){
                   alert(data.errorMsg);
                   
                   
               }else {
                  alert("기록되었습니다");
                  }
                //$("#dayAttdList_tabs").load(location.href + "#dayAttdList_tabs"); // 오른쪽 그리드만 띄우고 싶다 고민중..
                location.reload();
               }
      });         
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

 /* 코드 선택창 띄우는 함수 */
    //getCode("CO-09","attdTypeName","attdTypeCode");
   function getCode(code,inputText,inputCode){
            option="width=220; height=200px; left=300px; top=300px; titlebar=no; toolbar=no,status=no,menubar=no,resizable=no, location=no";
            window.open("${pageContext.request.contextPath}/base/codeWindow.html?code="+code+"&inputText="+inputText+"&inputCode="+inputCode,"newwins",option);
   }
</script>

</head>
<body>
   <div id="dayAttdrequest_tabs">
<!--       <ul> -->
<!--          <li id="dayAttdrequest_col"><a href="#dayAttdrequest_tab_1">일근태기록/조회</a></li> -->
<!--          <li><a href="#dayAttdrequest_tab_2">일근태조회</a></li> -->
<!--       </ul> -->
      <div id="dayAttdrequest_tab_1">
         <div
            style="width: 300px; height: 60px; font-size: 30px; text-align: center;"
            id="clock"></div>
         <table>
            <tr>
               <td>적용일자</td>
               <td><input type=text id="applyDay" readonly></td>
            </tr>
            <tr>
               <td>근태구분</td>
               <td><input type=text id="attdTypeName" readonly> <input type=hidden id="attdTypeCode"></td>
            </tr>
            <tr>
               <td>시각</td>
               <td>
               <input type="text" name="timePicker" placeholder="시간선택" id="timePicker" size="10" maxlength="4"> 
               <input type="button" id="registDayAttd_Btn" class="small_Btn" value="기록하기" />
               </td>
            </tr>
            <tr>
               <td></td>
               <td><input type="button" id="timeCheck_Btn" class="small_Btn" value="현시각기록" /></td>
            </tr>
         </table>
         <br />
      </div>
<!--       <div id="dayAttdrequest_tab_2"> -->
<!--          조회일자 <input type=text id="searchDay" readonly> -->
<!--          <button class="small_Btn" id="search_dayAttdList_Btn">조회하기</button> -->
<!--          <br /> <br /> -->
<!--       </div> -->
   </div>
   <div id="dayAttdList_tabs">
      <ul>
         <li><a href="#dayAttdList_tab_1">조회목록</a></li>
      </ul>
      <div id="dayAttdList_tab_1">
         <br />
         <button class="small_Btn" id="delete_dayAttd_Btn">삭제하기</button>
         <br /> <br />
         <div id="dayAttdList_grid" style="height: 280px; width:420px" class="ag-theme-balham"></div>
          <div id="dayAttdList_pager"></div>
      </div>
   </div>
</body>
</html>