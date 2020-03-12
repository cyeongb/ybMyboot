package com.google.ybMyboot.hr.attd.controller;


import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.google.ybMyboot.hr.attd.sf.AttdServiceFacade;
import com.google.ybMyboot.hr.attd.to.RestAttdTO;
import lombok.extern.log4j.Log4j2;

@Log4j2
@RestController
@RequestMapping("/attendance/attendanceApproval")
public class AttdApprovalController {
	@Autowired
	private AttdServiceFacade attdServiceFacade;

	@GetMapping
	public ModelAndView findRestAttdListByDept(@RequestParam("startDate")String startDate,@RequestParam("endDate")String endDate,
			@RequestParam("deptName")String deptName, ModelAndView modelAndView, ModelMap modelMap){
		if(log.isDebugEnabled()) {
			log.debug("findRestAttdListByDept - 시작");
			}
			ArrayList<RestAttdTO> restAttdList = attdServiceFacade.findRestAttdListByDept(deptName, startDate, endDate);
			modelMap.put("restAttdList", restAttdList);

		modelAndView = new ModelAndView("jsonView", modelMap);
		return modelAndView;
	}
	
	@PutMapping
	public ModelAndView modifyRestAttdList(@RequestParam("sendData")String sendData,ModelAndView modelAndView){
		if(log.isDebugEnabled()) {
			log.debug("modifyRestAttdList - 시작");
			}
			Gson gson = new Gson();
			ArrayList<RestAttdTO> restAttdList = gson.fromJson(sendData, new TypeToken<ArrayList<RestAttdTO>>(){}.getType());			
			attdServiceFacade.modifyRestAttdList(restAttdList);
		    return modelAndView;
	}
	
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		System.out.println(e);
		log.debug(e.getMessage());
		return "error:" + e;
	}

}
