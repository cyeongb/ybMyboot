package com.google.ybMyboot.hr.salary.controller;

import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.google.gson.Gson;
import com.google.ybMyboot.hr.salary.sf.SalaryServiceFacade;
import com.google.ybMyboot.hr.salary.to.MonthSalaryTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@RestController
public class monthSalaryController {
	@Autowired
	private SalaryServiceFacade salaryServiceFacade;

	public ModelAndView findMonthSalary(@RequestParam("applyYearMonth")String applyYearMonth,@RequestParam("empCode")String empCode
			,ModelMap modelMap,ModelAndView modelAndView){
		  if(log.isDebugEnabled()) {
			  log.debug("findMonthSalary - 시작");
			  }
			MonthSalaryTO monthSalary = salaryServiceFacade.findMonthSalary(applyYearMonth,empCode);
			modelMap.put("monthSalary", monthSalary);
		    modelAndView = new ModelAndView("jsonView", modelMap);
		    return modelAndView;
	}
	
	public ModelAndView findYearSalary(@RequestParam("applyYear")String applyYear,@RequestParam("empCode")String empCode
			,ModelMap modelMap,ModelAndView modelAndView){
		  if(log.isDebugEnabled()) {
			  log.debug("findYearSalary - 시작");
			  }
			ArrayList<MonthSalaryTO> yearSalary = salaryServiceFacade.findYearSalary(applyYear, empCode);
			modelMap.put("yearSalary", yearSalary);
		
		   modelAndView = new ModelAndView("jsonView", modelMap);
		   return modelAndView;
	}

	public void modifyMonthSalary(@RequestParam("sendData")String sendData){
		 if(log.isDebugEnabled()) {
			  log.debug("modifyMonthSalary - 시작");
			  }
			Gson gson = new Gson();
			MonthSalaryTO monthSalary = gson.fromJson(sendData, MonthSalaryTO.class);
			salaryServiceFacade.modifyMonthSalary(monthSalary);
	}
	

     @ExceptionHandler(Exception.class)
	  public Object exeption(Exception e) {
		log.error(e);
		log.error(e.getMessage());
		return "error:" + e;
	}
}