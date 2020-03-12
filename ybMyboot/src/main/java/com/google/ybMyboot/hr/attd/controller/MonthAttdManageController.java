package com.google.ybMyboot.hr.attd.controller;

import java.util.ArrayList;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.google.ybMyboot.hr.attd.sf.AttdServiceFacade;
import com.google.ybMyboot.hr.attd.to.MonthAttdMgtTO;

import lombok.extern.log4j.Log4j2;

@RestController
@Log4j2
@RequestMapping("/attendance/monthAttendanceManage")
public class MonthAttdManageController {
	@Autowired
	private AttdServiceFacade attdServiceFacade;

	public ModelMap findMonthAttdMgtList(@RequestParam("applyYearMonth") String applyYearMonth, ModelMap modelMap) {

		if (log.isDebugEnabled()) {
			log.debug("findMonthAttdMgtList - 시작");
		}

		ArrayList<MonthAttdMgtTO> monthAttdMgtList = attdServiceFacade.findMonthAttdMgtList(applyYearMonth);
		modelMap.put("monthAttdMgtList", monthAttdMgtList);
		return modelMap;
	}

	public void modifyMonthAttdList(@RequestParam("sendData") String sendData, Gson gson) {
		if (log.isDebugEnabled()) {
			log.debug("modifyMonthAttdList - 시작");
		}

		ArrayList<MonthAttdMgtTO> monthAttdMgtList = gson.fromJson(sendData,
				new TypeToken<ArrayList<MonthAttdMgtTO>>() {
				}.getType());
		attdServiceFacade.modifyMonthAttdMgtList(monthAttdMgtList);

	}

	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		log.error(e);
		log.error(e.getMessage());
		return "error:" + e;
	}

}
