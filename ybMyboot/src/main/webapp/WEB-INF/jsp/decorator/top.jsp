<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
<link rel="stylesheet"
	href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
<link rel="stylesheet"
	href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">
<link rel="stylesheet"
	href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-fresh.css">
<link rel="stylesheet"
	href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-material.css">

<style>
.google {
	onclick: "${pageContext.request.contextPath }/main.html";
	animation: fadein 2s;
	-webkit-animation: fadein 2s; /*크롬 */
}

@
-webkit-keyframes fadein {
	/* Safari and Chrome */ from { opacity:0;
	
}

to {
	opacity: 1;
}

}
#home {
	onclick: "${pageContext.request.contextPath }/main.html";
}

#divTag1 {
	margin-left: 50px;
}

#divTag2 {
	margin-left: 50px;
}

#divTag3 {
	margin-left: 380px;
}

font {
	/* font-family :' '; */
	font-weight: bold;
}

#divTag1 {
	width: 750px;
	height: 200px;
}
</style>
<!-- 지도 api ~~ 사용자의 위치를 사용하기위해 sensor=true-->
<!--  이건 무료배포판이기때문에 키없이 사용 가능함. 키발급받으려면 할 수있는데 좀 복잡함... -->
<!--  그래서 보는데 제한이있음  구글맵으로 볼 수있는 스타일이 여러개가있는데 한정되어있다.(roadmap밖에 못봄 )-->


<script src="http://maps.googleapis.com/maps/api/js?sensor=true"></script>
  
<script>

function initialize() {  //함수


  var LatLng = new google.maps.LatLng(37.500004, 127.036432);
  var  markerTitle="Google ";   //현재 위치마커에 마우스 오버했을 때 나타나는 정보
  var  markerMaxWidth=300  //마커를 클릭했을 때 나타나는 말풍선의 크기
  
  var mapProp = {  //위치를 나타낼 객체 생성

    center: LatLng, // 위치, 위도와 경도를 받아서 처음 보여줄 중심 지역 설정.

    zoom:14, // 어느정도까지 세세하게 볼 것인지.

    mapTypeId:google.maps.MapTypeId.ROADMAP   //ROADMAP / SATELLITE/HYBRID,TERRAIN 설정가능.

  };

  // map 변수에 맵을 담기위한 설정.(div 태그안에 mapProp 파라미터를 담음)
  var map=new google.maps.Map(document.getElementById("divTag1"),mapProp); 
  

  var infowindow=new google.maps.InfoWindow({    //정보창 : 맵에 팝업창으로 정보를 표시.
	  content:"Hello Google World!"   
	//  maxWizzzdth:markerMaxWidth
	  
  });
  

  var marker = new google.maps.Marker({  //맵에 단일 위치를 표시. 

	position: LatLng,   

	map: map,
	
	title:markerTitle   //마우스오버하면 타이틀 나타남.
	
  });
  
   marker.setMap(map);  //마커 표시
   infowindow.open(map,marker);  //정보창 표시
  
}
google.maps.event.addDomListener(window, 'load', initialize);  //Dom 리스너를 추가해서 페이지가 로드될 때, initialize() 함수가 실행된다.




</script>
<script type="text/javascript">
var movieList = [];
var dustColorBean = {};
var emptyBean = {};
var emptyInfo = {};
$(document).ready(function(){
	 $("#home").click(function(){ location.href="<%=request.getContextPath()%>/main.html";});
//    $("#home").click("${pageContext.request.contextPath}/main.html");
	
	
	
  	/*#################    날씨 api   ########################## */
//   var apiURI = "http://api.openweathermap.org/data/2.5/weather?q="+Seoul+"&appid="+"1c24ecf6742a464836b6cf12d13939fb";
<%--   $("#home").click(function(){ location.href="<%=request.getContextPath()%>/main.html";}); --%>
// 	$.ajax({
// 	    url: apiURI,
// 	    dataType: "json",
// 	    type: "GET",
// 	    async: "false",
// 	    success: function(resp) {
// 	    	console.log(resp);
// 	    	console.log("현재온도 : "+ (resp.main.temp- 273.15) );
// 	    	console.log("현재습도 : "+ resp.main.humidity);
// 	    	console.log("날씨 : "+ resp.weather[0].main );
// 	    	console.log("상세날씨설명 : "+ resp.weather[0].description );
// 	    	console.log("날씨 이미지 : "+ resp.weather[0].icon );
// 	    	console.log("바람   : "+ resp.wind.speed );
// 	    	console.log("나라   : "+ resp.sys.country );
// 	    	console.log("도시이름  : "+ resp.name );
// 	    	console.log("구름  : "+ (resp.clouds.all) +"%" ); 
// 				var eGridDiv = document.querySelector('#weather');
// 				new agGrid.Grid(eGridDiv, gridOptions);	
// 				gridOptions.api.sizeColumnsToFit();
	    	
// 	    }
// 	});
  	
// 	var imgURL = "http://openweathermap.org/img/w/" + resp.weather[0].icon + ".png";
// 	 $("html컴포넌트").attr("src", imgURL);
	 
	 /*#################    영화 api   ########################## */
	 // 참고 url::http://www.kobis.or.kr/kobisopenapi/homepg/apiservice/searchServiceInfo.do
//}
//   $.ajax({
// 		url : "${pageContext.request.contextPath}/boxOffice.do",
// 		dataType : "json",
// 		data : {
// 			method : "showBoxOffice"			
// 		},
// 		success : function(data) {					
// 			$.each(data.boxOfficeResult.dailyBoxOfficeList,function(index,id){
// 				movieList.push(id);
// 			});						
// 			 	var columnDefs = [
// 				      {headerName: "순위", field: "rank"},
// 				      {headerName: "제목", field: "movieNm"},
// 				      {headerName: "개봉일", field: "openDt"},
// 				      {headerName: "관객수", field: "audiCnt"},
// 					];    
// 			    var gridOptions = {
// 			    		columnDefs: columnDefs,
// 			    		rowData: movieList,
// 			    	};
// 				var eGridDiv = document.querySelector('#boxOfficeGrid');
// 				new agGrid.Grid(eGridDiv, gridOptions);	
// 				gridOptions.api.sizeColumnsToFit();
			
// 		}
// 	});

/* 			$("#boxOfficeGrid").jqGrid({
				data : movieList,
				datatype : "local",
				colNames : [ "순위", "제목", "개봉일","관객수"],
				colModel : [
				{name : "rank", align : "center", editable : false}
				,{name : "movieNm", align : "center", editable : false}
				,{name : "openDt", align : "center", editable : false}				
				,{name : "audiCnt", align : "center", editable : false}				
				],
				width : 600,
				height : 80,
				rowNum : 100,
				multiboxonly : true,
				editurl : "clientArray",
				cellsubmit : "clientArray",
				caption:"오늘 박스오피스 순위"
			});  */
 
});
</script>

<br />
<br />
<!-- <div> -->
<!--  <div style=float:left; id="divTag1">  -->
<!--  <div id="boxOfficeGrid" style="height: 120px; width:500px" class="ag-theme-balham"></div>	   -->
<!--  </div>  -->
<!--  <div style=float:left; id="divTag1">  -->
<!--  <div id="weather" style="height: 120px; width:500px" class="ag-theme-balham"></div>	   -->
<!--  </div>  -->
<div id="divTag1" class="ag-theme-balham"></div>
<br>
&nbsp;&nbsp;
<div style="color: gray; font-size: 20px;">&nbsp;&nbsp;Google
	Location</div>
&nbsp;&nbsp;&nbsp;&nbsp;
<div style="float: top-center;" id="divTag3">
	<!-- <font style="font-size: 60px; font-weight: bold; color: plum; font-family:' ' "  id="home">Young HR</font>&nbsp; -->
	<img src="${pageContext.request.contextPath }/image/google-logo.png"
		class="google" id="home"
		onclick="${pageContext.request.contextPath }/main.html"></img>
	<!-- <font style="font-size: 60px; font-weight: bold; color: gold; font-family:' ' " id="home">&nbsp;&nbsp;HR</font><br/><br/> -->

</div>

<!-- </div> -->
