package com.google.ybMyboot.base.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.google.ybMyboot.base.sf.BaseServiceFacade;
import com.google.ybMyboot.base.to.ReportTO;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

@RestController
public class EmpReportController {
		
		@Autowired
	   private BaseServiceFacade baseServiceFacade;   
	    
		//재직증명서 신청
		@RequestMapping("/certificate/certificate")  //.do?
	public ModelAndView requestEmployment(@RequestParam("empCode")String empCode,@RequestParam("usage")String usage,@RequestParam("requestDay")String requestDay,
			@RequestParam("useDay")String useDay,ModelMap modelMap,ModelAndView modelAndView,HttpServletResponse response) throws JRException, IOException {  

	    
	         ReportTO to=baseServiceFacade.viewReport(empCode); //to  에 값넣음
	         	         
	         JasperReport jasperReport = JasperCompileManager.compileReport("C://Program Files//Apache Software Foundation//Tomcat 9.0//webapps//ybMyboot//report//employment.jrxml");
	         JRDataSource datasource = new JREmptyDataSource(); //가상레코드
	        
	         modelMap.put( "empName", to.getEmpName());
	         modelMap.put( "hiredate", to.getHiredate());
	         modelMap.put( "occupation", to.getOccupation());
	         modelMap.put( "employmentType", to.getEmploymentType());
	         modelMap.put( "position", to.getPosition());
	         modelMap.put( "address", to.getAddress());
	         modelMap.put( "detailAddress", to.getDetailAddress());
	         modelMap.put( "deptName", to.getDeptName());
	         modelMap.put( "usage", usage);
	         modelMap.put( "date", requestDay);
	         modelMap.put( "end", useDay);
	         
	          OutputStream outputStream = null;    
	          
	      // 결과가 올바로 넘어 왔는지 출력으로 확인
	      for (String key: modelMap.keySet()) { 
	    	  System.out.println(key);
	    	  System.out.println(modelMap.get(key)); 
	      }

			JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, modelMap, datasource); 
				
			  outputStream = response.getOutputStream(); 

			  response.setContentType("application/pdf");
			  JasperExportManager.exportReportToPdfStream(jasperPrint, outputStream);  			
			  outputStream.flush();  //출력
			  
	      return modelAndView; 
	   } 
	   
	
	   
	   
		 @RequestMapping("/base/empReport")  //.do?
	   public ModelAndView requestMonthSalary(@RequestParam("emoCode")String empCode,@RequestParam("applyMonth")String applyMonth
			   ,ModelMap map, HttpServletResponse response,HttpServletRequest request, ModelAndView modelAndView) throws JRException, IOException { //월급여신청
	    
	      InputStream inputStream = null;
	      OutputStream outputStream = null;
	     
	         inputStream = new FileInputStream(request.getServletContext().getRealPath("/report/SalaryStatement.jrxml"));
	         JasperDesign jasperDesign = JRXmlLoader.load(inputStream); // 실행파일을 읽어와서 제스퍼 디자인에 담아 컴파일 리포트의 인자값으로 넣는다.
	         JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
	         JRDataSource datasource = new JREmptyDataSource(); //가상레코드
	
	         JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, map, datasource); //맵에 담았던 값과 제스퍼 리포트를 인자값에 넣어서 JasperPrint를 실행한다.
	        outputStream = response.getOutputStream();
	         response.setContentType("application/pdf");
	         JasperExportManager.exportReportToPdfStream(jasperPrint, outputStream);
	         outputStream.flush();
	
	   
	      return modelAndView;
	   }
		 
		 @ExceptionHandler(Exception.class)
			public Object exeption(Exception e) {
				System.out.println(e);
				return "error:" + e;
			}
}