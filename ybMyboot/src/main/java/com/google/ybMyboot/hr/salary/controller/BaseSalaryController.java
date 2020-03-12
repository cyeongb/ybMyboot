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
import com.google.ybMyboot.hr.salary.to.BaseSalaryTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@RestController
public class BaseSalaryController {
	@Autowired
	private SalaryServiceFacade salaryServiceFacade;

	public ModelAndView findBaseSalaryList(ModelMap modelMap, ModelAndView modelAndView) {
		  if(log.isDebugEnabled()) {
			  log.debug("findBaseSalaryList - 시작");
			  }
		ArrayList<BaseSalaryTO> baseSalaryList = salaryServiceFacade.findBaseSalaryList();
		modelMap.put("baseSalaryList", baseSalaryList);
		modelMap.put("errorMsg", "success");
		modelMap.put("errorCode", 0);
		modelAndView = new ModelAndView("jsonView", modelMap);
		return modelAndView;
	}

	public void modifyBaseSalaryList(@RequestParam("sendData") String sendData) {
		  if(log.isDebugEnabled()) {
			  log.debug("modifyBaseSalaryList - 시작");
			  }
		Gson gson = new Gson();
		ArrayList<BaseSalaryTO> baseSalaryList = gson.fromJson(sendData, new TypeToken<ArrayList<BaseSalaryTO>>() {
		}.getType());
		salaryServiceFacade.modifyBaseSalaryList(baseSalaryList);
	}

	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		log.error(e);
		log.error(e.getMessage());
		return "error:" + e;
	}
}
