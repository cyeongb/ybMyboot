<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CODE</title>
   <link rel="stylesheet" href="${pageContext.request.contextPath}/script/jquery-ui/jquery-ui.min.css">
   <script src="${pageContext.request.contextPath}/script/jquery/jquery-3.3.1.min.js"></script>
   <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
     <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
  <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
  <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">
<script>
//code="+code+"&inputText="+inputText+"&inputCode="+inputCode

//getCode("CO-09","attdTypeName","attdTypeCode");
   $(document).ready(function(){
      if("${param.code}"==""){
         showCode();
      }else{
         showdept();
      }
      var pre = opener.document; //부모창
      
      function showdept(){
         
      var columnDefs = [
               {headerName: "코드번호", field: "detailCodeNumber" },
               {headerName: "코드명", field: "detailCodeName" },
         ];       
      
         gridOptions = {
            columnDefs: columnDefs,
            defaultColDef: { 
               editable: false, 
               width: 100,
               sortable: true,
                 filter: true,
                 resizable: true
               },
            rowData: null,
            rowSelection: 'single', /* 'single' or 'multiple',*/
            onRowClicked: function(event){
               console.log(event);
               if("${param.inputCode}"!=""){
               $("#${param.inputCode}", opener.document).val(event.data.detailCodeNumber);
               }
               
               $("#${param.inputText}", opener.document).val(event.data.detailCodeName);
                  window.close();
               },
            enableRangeSelection: true,
            suppressRowClickSelection: false,
            animateRows: true,
            suppressHorizontalScroll: true,
            localeText: {noRowsToShow: '조회 결과가 없습니다.'},
            
         }  
            axios.post('/ybMyboot/base/codeList.do',
                   null,
                   {
                  params: {
                  code: "${param.code}",
                  method: "detailCodelist"
                  },
                  headers: {'content-type': 'application/json'}
                   }
            ).then( response => {
                 detailCodelist = response.data.detailCodeList;
                 console.log(detailCodelist)
               gridOptions.api.setRowData(detailCodelist);   
            }
            ).catch( error => { 
            console.log(error);
            });
         
      var gridDiv = document.querySelector('#grid');
      new agGrid.Grid(gridDiv, gridOptions);
      
      }
      
      function showCode(){
         
         var columnDefs = [
            {headerName: "코드번호", field: "detailCodeNumber" },
             {headerName: "코드명", field: "detailCodeName" },
            ];       
         
            gridOptions = {
               columnDefs: columnDefs,
               defaultColDef: { 
                  editable: false, 
                  width: 100,
                  sortable: true,
                    filter: true,
                    resizable: true
                  },
                  rowData: null,
                  onRowClicked: function(event){
                     console.log(event);
                     if("${param.inputCode}"!=""){
                     $("#${param.inputCode}", opener.document).val(event.data.detailCodeNumber);
                     }
                     
                     $("#${param.inputText}", opener.document).val(event.data.detailCodeName);
                        window.close();
                     },
               rowSelection: 'single', /* 'single' or 'multiple',*/
               enableRangeSelection: true,
               suppressRowClickSelection: false,
               animateRows: true,
               suppressHorizontalScroll: true,
               localeText: {noRowsToShow: '조회 결과가 없습니다.'},
               
            }  
               axios.post('/ybMyboot/base/codeList.do',
                      null,
                      {
                     params: {
                        code1:"${param.code1}",
                        code2:"${param.code2}",
                        code3:"${param.code3}",
                        method:"detailCodelistRest"
                     },
                     headers: {'content-type': 'application/json'}
                      }
               ).then( response => {
                  detailCodelist = response.data.detailCodeList;
                    console.log(response.data);
                  gridOptions.api.setRowData(detailCodelist);   
               }
               ).catch( error => { 
               console.log(error);
               });
            
         var gridDiv = document.querySelector('#grid');
         new agGrid.Grid(gridDiv, gridOptions);
         
         }
   });

</script>
</head>
<body>
<div>
   <div id="grid" style="height:300px;width:300px;" class="ag-theme-balham"></div>
</div>
</body>
</html>