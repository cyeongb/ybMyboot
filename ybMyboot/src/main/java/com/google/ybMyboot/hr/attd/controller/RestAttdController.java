package com.google.ybMyboot.hr.attd.controller;

import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
@RequestMapping("/attendance/restAttendance")
public class RestAttdController  {
	@Autowired
	private AttdServiceFacade attdServiceFacade ;

//	@GetMapping
//	public ModelAndView findRestAttdListByToday(@RequestParam("empCode")String empCode,@RequestParam("toDay")String toDay,
//			ModelMap modelMap,ModelAndView modelAndView) {
//		if(log.isDebugEnabled()) {
//			log.debug("findRestAttdListByToday - 시작");
//			}
//
//			ArrayList<RestAttdTO>  restAttdList = attdServiceFacade.findRestAttdListByToday(empCode, toDay);
//			modelMap.put("restAttdList", restAttdList);
//	
//		modelAndView = new ModelAndView("jsonView", modelMap);
//		return modelAndView;
//	}

	
	@PostMapping
	public void registRestAttd(@RequestParam("sendData")String sendData,ModelMap modelMap){
		if(log.isDebugEnabled()) {
			log.debug("findRestAttdListByToday - 시작");
			}
			Gson gson = new Gson();
			RestAttdTO restAttd = gson.fromJson(sendData, RestAttdTO.class);
			attdServiceFacade.registRestAttd(restAttd);

	}

	@GetMapping
	public ModelMap findRestAttdList(@RequestParam("empCode")String empCode,@RequestParam("startDate")String startDate,
			@RequestParam("endDate")String endDate,@RequestParam("code")String code,ModelMap modelMap) {
		if(log.isDebugEnabled()) {
			log.debug("findRestAttdList - 시작");
			}
			ArrayList<RestAttdTO> restAttdList = attdServiceFacade.findRestAttdList(empCode, startDate, endDate, code);
	
			modelMap.put("restAttdList", restAttdList);
			return modelMap;
	}

	@DeleteMapping
	public void removeRestAttdList(@RequestParam("sendData")String sendData) {
		if(log.isDebugEnabled()) {
			log.debug("removeRestAttdList - 시작");
			}
			Gson gson = new Gson();
			ArrayList<RestAttdTO> restAttdList = gson.fromJson(sendData, new TypeToken<ArrayList<RestAttdTO>>() {}.getType());
			attdServiceFacade.removeRestAttdList(restAttdList);
	

	}
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		log.error(e);
		log.error(e.getMessage());
		return "error:" + e;
	}
}
