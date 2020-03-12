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
import com.google.ybMyboot.hr.attd.to.DayAttdTO;
import lombok.extern.log4j.Log4j2;

@Log4j2
@RestController
@RequestMapping("/attendance/dayAttendance")
public class DayAttdController {
	@Autowired
	private AttdServiceFacade attdServiceFacade;

	@GetMapping
	public ArrayList<DayAttdTO> findDayAttdList(@RequestParam("applyDay") String applyDay,
			@RequestParam("empCode") String empCode, ModelMap modelMap, ModelAndView modelAndView) {
		if (log.isDebugEnabled()) {
			log.debug("findDayAttdList - 시작");
		}
		return attdServiceFacade.findDayAttdList(empCode, applyDay);

	}

	@PostMapping
	public ModelMap registDayAttd(@RequestParam("sendData") String sendData, ModelAndView modelAndView
			,ModelMap modelMap, Gson gson) {
		if (log.isDebugEnabled()) {
			log.debug("registDayAttd - 시작");
		}
		DayAttdTO dayAttd = gson.fromJson(sendData, DayAttdTO.class);	
		
		modelMap.put("empCode",dayAttd.getEmpCode());
		modelMap.put("attdTypeCode",dayAttd.getAttdTypeCode());
		modelMap.put("attdTypeName",dayAttd.getAttdTypeName());
		modelMap.put("applyDay",dayAttd.getApplyDay());
		modelMap.put("time",dayAttd.getTime());
		modelMap.put("errorCode","0");
		modelMap.put("errorMsg","errorMsg");
		
		
		attdServiceFacade.registDayAttd(dayAttd);
		
		return modelMap;
	}

	@DeleteMapping
	public void removeDayAttdList(@RequestParam("sendData") String sendData,Gson gson) {
		if (log.isDebugEnabled()) {
			log.debug("removeDayAttdList - 시작");
		}
	
		ArrayList<DayAttdTO> dayAttdList = gson.fromJson(sendData, new TypeToken<ArrayList<DayAttdTO>>() {
		}.getType());
	   attdServiceFacade.removeDayAttdList(dayAttdList);

	}

	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		log.error(e);
		log.error(e.getMessage());
		return "error:" + e;
	}

}
