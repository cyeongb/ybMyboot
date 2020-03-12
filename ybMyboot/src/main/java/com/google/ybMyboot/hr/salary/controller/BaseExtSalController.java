package com.google.ybMyboot.hr.salary.controller;

import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.google.ybMyboot.hr.salary.sf.SalaryServiceFacade;
import com.google.ybMyboot.hr.salary.to.BaseExtSalTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@RestController
public class BaseExtSalController {
	@Autowired
	private SalaryServiceFacade salaryServiceFacade;

	public ModelAndView findBaseExtSalList(ModelMap modelMap,ModelAndView modelAndView){
		  if(log.isDebugEnabled()) {
			  log.debug("findBaseExtSalList - 시작");
			  }
			ArrayList<BaseExtSalTO> baseExtSalList = salaryServiceFacade.findBaseExtSalList();
			modelMap.put("baseExtSalList", baseExtSalList);	
	    	modelAndView = new ModelAndView("jsonView", modelMap);
		    return modelAndView;
	}

	public void modifyBaseExtSalList(@RequestParam("sendData")String sendData){
		 if(log.isDebugEnabled()) {
			  log.debug("modifyBaseExtSalList - 시작");
			  }
			Gson gson = new Gson();
			ArrayList<BaseExtSalTO> baseExtSalList = gson.fromJson(sendData, new TypeToken<ArrayList<BaseExtSalTO>>(){}.getType());
			salaryServiceFacade.modifyBaseExtSalList(baseExtSalList);
	}
	
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		log.error(e);    
		log.error(e.getMessage());
		return "error:" + e;
	}
}
