package com.google.ybMyboot.base.controller;

import java.io.IOException;
import java.util.ArrayList;

import org.apache.ibatis.reflection.ExceptionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.google.ybMyboot.base.sf.BaseServiceFacade;
import com.google.ybMyboot.base.to.HolidayTO;

@RestController
@RequestMapping("/base/holidayList")  //.do?
public class HolidayListController  {
	
	@Autowired
	private  BaseServiceFacade baseServiceFacade;


	public ModelMap findHolidayList(ModelMap modelMap) {

			ArrayList<HolidayTO> holidayList = baseServiceFacade.findHolidayList();
			HolidayTO holidayto = new HolidayTO();
			modelMap.addAttribute("holidayList", holidayList);
			modelMap.addAttribute("emptyHoilday", holidayto);
             return modelMap;
	}

	
	public ModelMap findWeekDayCount(@RequestParam("startDate")String startDate,@RequestParam("endDate")String endDate,ModelMap modelMap) {

			String weekdayCount = baseServiceFacade.findWeekDayCount(startDate, endDate);
			modelMap.addAttribute("weekdayCount", weekdayCount);
		    return modelMap;
	}

	public ModelMap regitCodeList(@RequestParam("sendData")String sendData,ModelMap modelMap) throws JsonParseException, JsonMappingException, IOException {
		// TODO Auto-generated method stub

//			Gson gson = new Gson();
//			ArrayList<HolidayTO> holydayList = gson.fromJson(sendData, new TypeToken<ArrayList<HolidayTO>>() {
//			}.getType());
			
			ObjectMapper mapper = new ObjectMapper();
			ArrayList<HolidayTO> holidayList = mapper.readValue(sendData, new TypeReference<ArrayList<HolidayTO>>() {
			});
			baseServiceFacade.registCodeList(holidayList);

        	return modelMap;
	}
	
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		System.out.println(e);
		return "error:" + e;
	}

}
