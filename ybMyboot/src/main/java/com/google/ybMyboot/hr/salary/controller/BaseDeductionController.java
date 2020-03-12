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
import com.google.ybMyboot.hr.salary.to.BaseDeductionTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@RestController
public class BaseDeductionController  {
	@Autowired
	private SalaryServiceFacade salaryServiceFacade;
	
	public ModelAndView findBaseDeductionList(ModelMap modelMap,ModelAndView modelAndView){
		  if(log.isDebugEnabled()) {
			  log.debug("findBaseDeductionList - 시작");
			  }
			ArrayList<BaseDeductionTO> baseDeductionList = salaryServiceFacade.findBaseDeductionList();
			modelMap.put("baseDeductionList", baseDeductionList);
			BaseDeductionTO emptyBean = new BaseDeductionTO();
			emptyBean.setStatus("insert");
			modelMap.put("emptyBean", emptyBean);
	
		
		modelAndView = new ModelAndView("jsonView", modelMap);
		return modelAndView;
	}
	
	public void batchBaseDeductionProcess(@RequestParam("sendData")String sendData, ModelMap modelMap){
		if(log.isDebugEnabled()) {
			  log.debug("batchBaseDeductionProcess - 시작");
			  }
			Gson gson = new Gson();
			ArrayList<BaseDeductionTO> baseDeductionList = gson.fromJson(sendData, new TypeToken<ArrayList<BaseDeductionTO>>(){}.getType());
			salaryServiceFacade.batchBaseDeductionProcess(baseDeductionList);
	}
	
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		log.error(e);
		log.error(e.getMessage());
		return "error:" + e;
	}
}
