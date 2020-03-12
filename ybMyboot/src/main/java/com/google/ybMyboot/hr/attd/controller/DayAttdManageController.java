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
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.google.ybMyboot.hr.attd.sf.AttdServiceFacade;
import com.google.ybMyboot.hr.attd.to.DayAttdMgtTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@RestController
@RequestMapping("/attendance/dayAttendanceManage")
public class DayAttdManageController {
	
	@Autowired
	private AttdServiceFacade attdServiceFacade;

	@GetMapping
	public ModelMap findDayAttdMgtList(@RequestParam("applyDay")String applyDay,@RequestParam("dept")String dept
			,ModelMap modelMap){
		if(log.isDebugEnabled()) {
			log.debug("findDayAttdMgtList - 시작");
			}
	
			ArrayList<DayAttdMgtTO> dayAttdMgtList = attdServiceFacade.findDayAttdMgtList(applyDay, dept);			
			modelMap.put("dayAttdMgtList", dayAttdMgtList);
	    	return modelMap;
	}
	@PutMapping
	public void modifyDayAttdList(@RequestParam("sendData")String sendData,ModelMap modelMap){
		if(log.isDebugEnabled()) {
			log.debug("modifyDayAttdList - 시작");
			}
			Gson gson = new Gson();
			ArrayList<DayAttdMgtTO> dayAttdMgtList = gson.fromJson(sendData, new TypeToken<ArrayList<DayAttdMgtTO>>(){}.getType());
		attdServiceFacade.modifyDayAttdMgtList(dayAttdMgtList);
	

	}
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		log.error(e);
		log.error(e.getMessage());
		return "error:" + e;
	}



}
