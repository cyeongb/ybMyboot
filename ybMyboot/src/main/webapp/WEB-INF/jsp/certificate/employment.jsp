<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- ----------------------------------###############   재직증명서신청/발급   ##############-------------------------------------------- -->
<!--  재직증명서는 어떤 직장에 다니고있는지 회사가 보증하는 증명서로, 재직사실을 확인하는 용도로 쓰인다.
       재직증명서에는 재직기간, 업무종류, 지위,임금등의 사항이 기재되어있다. 재직증명서를 발급할 수 있는 근로자는 30일 이상 근무한 자 이다. -->
<script>
var empCode = "${sessionScope.code}";   //세션에서 가져온 사원코드
var usage = "";   //용도
var requestDay = "";  //신청일
var useDay = "";   //사용일
var eMail= "";   //이메일
var certificateRequestList=[];

$(document).ready(function(){
   /*------------------------------- 재직증명서 신청  */
   $("#deptName").val("${sessionScope.dept}")
   
   $("#usage").click(function(){
      getCode('CO-16',"usage","usageCode");   //CO-16 : 증명서 용도
   });      
   
   showCertificateListGrid();
   
   $("#employment").tabs();  
   
   var today=$.datepicker.formatDate($.datepicker.ATOM,new Date());      //ATOM: yy-mm-dd형식으로 
   $("#requestDate").val(today);   //신청일을 오늘날짜로 
   
   
/* 신청탭 -------------------------- 재직증명서 조회,발급,취소 */
   
   /* 신청, 사용 날짜 */
    getDatePicker($("#requestDate"));      //시작날짜
   $("#requestDate").change(function(){
         $("#endDate").datepicker("option","minDate",$(this).val());         //option : 창 띄울 때   설정하는 옵션들?
      }); 
   
      getDatePicker($("#endDate"));     //종료날짜 
      $("#endDate").change(function(){
         $("#requestDate").datepicker("option","maxDate",$(this).val());                  
      }); 
      
      /* 재직증명서 신청 버튼  */
      $("#issuance_employmen_Btn").click(requireCertificate);
      
      /* 재직증명서 삭제 버튼 */
      $("#delete_employmen_Btn").click(function(){
         var flag = confirm("재직증명서 신청을 취소하시겠습니까?");
         if(flag)
            removeCertificateList(); //삭제
      });

      
/* 조회탭 */
      /* 조회 날짜 */   
      getDatePicker($("#search_startDate"));
      $("#search_startDate").change(function(){ 
         $("#search_endDate").datepicker("option","minDate",$(this).val());
      }); 
      
      getDatePicker($("#search_endDate"));
      $("#search_endDate").change(function(){ 
         $("#search_startDate").datepicker("option","maxDate",$(this).val());
      });                 
     
      /* 재직증명서 조회 버튼 */
      $("#search_employmentList_Btn").click(findCertificateList);  
      
      /* 재직증명서 발급 버튼 */
      $("#print_certificate").click(printWorkInfoReport);
      
      /*e-mail전송*/
      $("#send_Btn").click(sendEmail); 
   
});

function requireCertificate(){  // ------------------------> 재직증명서 신청   
   var check=false;  //승인여부
   var requestDate=$("#requestDate").val();  //신청일
   var useDate=$("#endDate").val();  //사용일
   var usageCode=$("#usageCode").val();   //용도
   var etc=$("#etc").val();     //비고
   var empcode="${sessionScope.code}";
   
   var certificateList={
         "empCode":empCode,         
         "requestDate": requestDate,
         "useDate": useDate,
         "usageCode": usageCode,
         "etc":etc,
         "approvalStatus":"승인대기"         
   }
   //----------------------------------- >>>>>>>>추가
   if(empcode.trim()==""){
		alert("현재 재직중인 사원이 아닙니다");
		return ;
}
   
   if($("#endDate").val().trim()==""){
		alert("사용기한을 입력하세요");
		return ;
}
   if($("#usageCode").val().trim()==""){
		alert("용도를 입력하세요");
		return ;
}
   //------------------------------------<<<<<<<<<<<<
   
   var sendData=JSON.stringify(certificateList);   
    
    $.ajax({
           url : "${pageContext.request.contextPath}/certificate/certificate.do",
           data:{
              "method":"registRequest",
              "sendData":sendData
           },
           dataType:'json',
           success:function(data){
        	   console.log("data::")
        	   console.log(data)
              if(data.errorCode<0){
                 var error=/unique constraint/;   //unique제약조건에 위배되는 경우
                 if(error.test(data.errorMsg)){
                    alert("해당날짜에 신청한 재직증명서가 있습니다");
                 }else{
                    var str = "내부 서버 오류가 발생했습니다\n";
                  str += "관리자에게 문의하세요\n";
                  str += "에러 위치 : " + $(this).attr("id");
                  str += "에러 메시지 : " + data.errorMsg;
                  alert(str);   
                 }                 
              }else{
                 alert("재직증명서를 신청했습니다");
              }
              location.reload();  //새로고침처럼 현재페이지를 리로드할 수 있다.
           }
        });    
}

function findCertificateList(){ // 재직증명서신청조회버튼
   var startVar = $("#search_startDate").val(); //시작날짜
   var endVar = $("#search_endDate").val(); //종료날짜

   //alert(startVar);
   if($("#search_startDate").val().trim() == "" || $("#search_endDate").val().trim() == ""){
   	alert("날짜를 선택해 주세요");
   	return;
   }
   
    $.ajax({
      url:"${pageContext.request.contextPath}/certificate/certificate.do",
      data:{
         "method" : "findCertificateList",
         "empCode" : empCode,  //session으로 사원코드가져옴 
         "startDate" : startVar, // 시작날짜
         "endDate" : endVar,   //종료날짜      
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
         certificateRequestList = data.certificateList; 
         console.log("재직증명서 요청한 리스트::");
         console.log(certificateRequestList);
         showCertificateListGrid();
         
      }
   }); 
}

/* 삭제버튼 눌렀을 때 실행되는 함수 */
function removeCertificateList(){
   var selectedRowData=gridOptions.api.getSelectedRows();
   
/*    var selectedRowIds=$("#certificateList_grid").getGridParam("selarrrow");
   if(selectedRowIds.length==0){
      alert("취소할 재직증명서 신청을 선택해 주세요");
      return;
   }
   
   var selectedData=[];
   
   $.each(selectedRowIds,function(index,id){
      var data=$("#certificateList_grid").getRowData(id);
      if(data.approvalStatus!="승인"){
         selectedData.push(data);
      }
   });
   
   if(selectedData.length==0){
      alert("승인이 완료되어 신청을 취소할 수 없습니다");
      return;
   } */
   
   var sendData=JSON.stringify(selectedRowData);   
   $.ajax({
      url : "${pageContext.request.contextPath}/certificate/certificate.do",
      data : {
         "method" : "removeCertificateRequest",
         "sendData" : sendData
      },
      dataType : "json",
      success : function(data) {
         if(data.errorCode < 0){
            var str = "내부 서버 오류가 발생했습니다\n";
            str += "관리자에게 문의하세요\n";
            str += "에러 위치 : " + $(this).attr("id");
            str += "에러 메시지 : " + data.errorMsg;
            alert(str);
         } else if(certificateRequestList[0]==null){
        	 alert("조회할 데이터가 없습니다");
         }else{
             findCertificateList();
            alert("삭제되었습니다");
         }
         
      }
   });
}
// ---------------------------------------- 재직증명 데이터 뿌려지는거
function showCertificateListGrid(){
      var columnDefs = [
         {headerName: "사원코드", field: "empCode",hide:true }, //hide:true = 숨김 
         {headerName: "용도", field: "usageName",checkboxSelection: true}, //체크박스옵션
         {headerName: "신청일", field: "requestDate"},
         {headerName: "사용일", field: "useDate"},
         {headerName: "승인여부", field: "approvalStatus"},
         {headerName: "반려사유", field: "rejectCause"},
         {headerName: "비고", field: "etc"}
   ];    
   gridOptions = {
         columnDefs: columnDefs,
         rowData: certificateRequestList,  //재직증명 요청한 리스트
         defaultColDef: { editable: false, width: 100 }, //수정불가
         rowSelection: 'single', /* 'single' or 'multiple',*/
         enableColResize: true, //칼럼크기
         enableSorting: true, //정렬
         enableFilter: false, //필터
         enableRangeSelection: true, //정렬고정
         suppressRowClickSelection: false, //선택허용 여부
         animateRows: true,   //column은 true가 default , row는 false가 defalut ------> row를 움직일 때 쓴다.
         suppressHorizontalScroll: true, //가로스크롤허용 
         localeText: {noRowsToShow: '조회 결과가 없습니다.'}, //데이터가없을경우보여질메세지
         getRowStyle: function (param) {
              if (param.node.rowPinned) {  //파라미터의 데이터가 고정값이면 .. 그리고 rowPinned는 top/bottom만 가능함
                  return {'font-weight': 'bold', background: '#dddd00'};  // #dddddd
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
   $('#certificateList_grid').children().remove();    
   var eGridDiv = document.querySelector('#certificateList_grid');
   new agGrid.Grid(eGridDiv, gridOptions);   
 }


/* DatePicker 함수 */
function getDatePicker($CellId) {
         $CellId.datepicker({
            changeMonth : true,
            changeYear : true,
            dateFormat : "yy-mm-dd",
            showAnim: "fadeIn",
            stepMonths:1,
            gotoCurrent:true,
            duration:"fast",  //달력나타나는 속도
            dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
            monthNamesShort : [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" ],
            yearRange: "1970:2020",
               });
  }
   

/* 코드 선택창 띄우기 */ 
 function getCode(code,inputText,inputCode){
         option="width=220; height=200px; left=300px; top=300px; titlebar=no; toolbar=no,status=no,menubar=no,resizable=no, location=no";
         window.open("${pageContext.request.contextPath}/base/codeWindow.html?code="
                     +code+"&inputText="+inputText+"&inputCode="+inputCode,"newwins",option);
   }

/* 승인된 재직증명서 발급 */
 function printWorkInfoReport(){
      var selectedRowData=gridOptions.api.getSelectedRows();
      var data=selectedRowData[0];
    //  console.log(data.empCode);
    	
    	if(data==""){
    		alert("선택된 재직증명서가 없습니다.");
    		return;
    	}

      if(data.approvalStatus=="승인"){
     	  console.log("empcode:")
          console.log(data.empCode);
         
         empCode=data.empCode;  //사원번호
         usage = data.usageName;   //사용용도
         requestDay = data.requestDate;  //요청날짜
         useDay = data.useDate      //사용날짜
         //신청할때마다 변화는 정보들을 담아서 윈도우화면에 띄운다.
         window.open(    //web.xml 경로와 동일해야 한다.
                "${pageContext.request.contextPath}/base/empReport.do?method=requestEmployment&empCode="
                      +empCode+"&usage="+usage+"&requestDay="+requestDay+
                      "&useDay="+useDay,"재직증명서","width=1280, height=1024");
      }else{
         alert("승인된 재직증명서만 발급가능합니다");
         return;
      }   
         
}



   /*메일전송*/
  function sendEmail(){
     var selectedRowData=gridOptions.api.getSelectedRows();
     var data=selectedRowData[0];
     var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;  //이메일 유효성 체크
     eMail=$("#email_id").val().trim();   //공백제거한 이메일 데이터
     
     
     if(eMail==""){alert("이메일을 입력해주세요"); return;}
     
     if(exptext.test(eMail) ==false){  //자바스크립트 test() string값이 맞으면 true, 아니면 false
  		//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
  		alert("이메일형식이 올바르지 않습니다.");
  		return;
     }

    	
     if(data==null){ alert("재직증명서를선택해주세요"); return;}
     
     if(data.approvalStatus =="승인대기"){ alert("승인된 재직증명서만 전송 가능합니다"); return;}
    else 
    {
    
     
      console.log(data);
      empCode=data.empCode;
      usage = data.usageName;
      requestDay = data.requestDate;
      useDay = data.useDate
      
   
   //alert("뿅"+usage+requestDay+useDay+eMail);
    
    $.ajax({
        url : "${pageContext.request.contextPath }/base/sendEmail.do", //html을 do로수정함 #######
        data:{
           "method":"sendEmail",
           "empCode":empCode,
           "usage":usage,
           "requestDay":requestDay,
           "useDay":useDay,
           "eMail":eMail
        },
        dataType:'json',
        success:function(data){
           alert("메일 전송");
        }
     });

   }


   }
/* /* /* 재직증명서 ireport */


</script>

<div id="employment"  style="width:1200px; position: relative; display: inline-block;">
      <ul>
         <li><a href="#employmentRequest_tab">재직증명서 신청</a></li>
         <li><a href="#employmentList_tab">재직증명서 조회/발급/취소</a></li>
      </ul>
   <div id="employmentRequest_tab"><!-- =======================================[재직증명서 신청 탭]======================================= -->
      <table>
      <tr>
          <td>사원명</td>
          <td>
             <input type="text" class="ui-button ui-widget ui-corner-all" value="${sessionScope.id}" readonly>
           <input type="hidden" id="employmentEmpCode" value="${ssesionScope.code}">      
          </td>       
        <td>부서</td>
         <td><input type="text" id="deptName" class="ui-button ui-widget ui-corner-all" value="${emp.deptName}" readonly></td>
      </tr>   
      
      <tr>
       <td>신청일</td><td><input  class="ui-button ui-widget ui-corner-all"  id="requestDate" readonly></td>
       <td>사용일</td><td><input  class="ui-button ui-widget ui-corner-all"  id="endDate"  readonly required></td>
      
      </tr>

      <tr>
       <td>용도</td><td><input class="ui-button ui-widget ui-corner-all" id="usage" type="text" readonly required placeholder="필수선택입니다">
       <input type="hidden" id="usageCode"></td>
       <td>비고</td>
       <td><input class="ui-button ui-widget ui-corner-all" type="text" id="etc" placeholder="기타메모"></td>
      </tr>    
      
      </table>
      <hr>
      <div>
      <br>
       <input type="button" class="ui-button ui-widget ui-corner-all" id="issuance_employmen_Btn" value="재직증명서 신청" > 
           
      </div>     
       
   </div>
      <div id="employmentList_tab"> <!-- =============================[ 재직증명서 조회/발급/취소 탭]======================================== -->
            <div><h3>신청일자</h3></div>
      <br />
      <input type=text class="ui-button ui-widget ui-corner-all" id="search_startDate" readonly placeholder="시작일"> 부터
      <input type=text class="ui-button ui-widget ui-corner-all" id="search_endDate" readonly placeholder="종료일"> 까지<br/><br/>
      <input type="button" class="ui-button ui-widget ui-corner-all" id="search_employmentList_Btn" value="신청 조회">
      <input type="button" class="ui-button ui-widget ui-corner-all" id="delete_employmen_Btn" value="신청 취소">
      <input type="button" class="ui-button ui-widget ui-corner-all" id="print_certificate" value="재직증명서 발급">
      <input type="email" class="ui-button ui-widget ui-corner-all" id="email_id" placeholder="이메일을입력해주세요">
      <input type="button" class="ui-button ui-widget ui-corner-all" id="send_Btn" value="메일전송">
      <br/><br/>
      <br />
      <div id="certificateList_grid" style="height: 230px; width:800px" class="ag-theme-balham"></div>
      </div>
   </div>