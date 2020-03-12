package com.google.ybMyboot.hr.attd.sf;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.google.ybMyboot.common.to.ResultTO;
import com.google.ybMyboot.hr.attd.applicationService.AttdApplicationService;
import com.google.ybMyboot.hr.attd.to.DayAttdMgtTO;
import com.google.ybMyboot.hr.attd.to.DayAttdTO;
import com.google.ybMyboot.hr.attd.to.MonthAttdMgtTO;
import com.google.ybMyboot.hr.attd.to.RestAttdTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class AttdServiceFacadeImpl implements AttdServiceFacade{
	
	@Autowired
	private AttdApplicationService attdApplicationService;
	
	
	@Override
	public ArrayList<DayAttdTO> findDayAttdList(String empCode, String applyDay) {
		if(log.isDebugEnabled()) {
			log.debug("findDayAttdList - 시작");
			}
	
		ArrayList<DayAttdTO> dayAttdList=attdApplicationService.findDayAttdList(empCode, applyDay);
			return dayAttdList;		
	}
	
	@Override
	public ResultTO registDayAttd(DayAttdTO dayAttd) {	
		if(log.isDebugEnabled()) {
			log.debug("registDayAttd - 시작");
			}
		ResultTO resultTO=attdApplicationService.registDayAttd(dayAttd);
		return resultTO;
	}

	@Override
	public void removeDayAttdList(ArrayList<DayAttdTO> dayAttdList) {
		if(log.isDebugEnabled()) {
			log.debug("removeDayAttdList - 시작");
			}
		attdApplicationService.removeDayAttdList(dayAttdList);
	}
	
	@Override
	public ArrayList<RestAttdTO> findRestAttdList(String empCode, String startDate, String endDate, String code) {
		if(log.isDebugEnabled()) {
			log.debug("findRestAttdList - 시작");
			}	
		ArrayList<RestAttdTO> restAttdList = attdApplicationService.findRestAttdList(empCode, startDate, endDate, code);
			return restAttdList;
	}

	@Override
	public ArrayList<RestAttdTO> findRestAttdListByDept(String deptName, String startDate, String endDate) {
		if(log.isDebugEnabled()) {
			log.debug("findRestAttdListByDept - 시작");
			}		
		ArrayList<RestAttdTO> restAttdList = attdApplicationService.findRestAttdListByDept(deptName, startDate, endDate);
			return restAttdList;		
	}

	@Override
	public ArrayList<RestAttdTO> findRestAttdListByToday(String empCode, String toDay) {
		if(log.isDebugEnabled()) {
			log.debug("findRestAttdListByToday - 시작");
			}		
		ArrayList<RestAttdTO> restAttdList = attdApplicationService.findRestAttdListByToday(empCode,toDay);
			return restAttdList;		
	}

	@Override
	public void registRestAttd(RestAttdTO restAttd) {
		if(log.isDebugEnabled()) {
			log.debug("registRestAttd - 시작");
			}	
		attdApplicationService.registRestAttd(restAttd);		
	}

	@Override
	public void modifyRestAttdList(ArrayList<RestAttdTO> restAttdList) {
		if(log.isDebugEnabled()) {
			log.debug("modifyRestAttdList - 시작");
			}		
		attdApplicationService.modifyRestAttdList(restAttdList);
}
	
	@Override
	public void removeRestAttdList(ArrayList<RestAttdTO> restAttdList) {
		if(log.isDebugEnabled()) {
			log.debug("removeRestAttdList - 시작");
			}	
		attdApplicationService.removeRestAttdList(restAttdList);
	}
	
	@Override
	public ArrayList<DayAttdMgtTO> findDayAttdMgtList(String applyDay, String dept) {
		if(log.isDebugEnabled()) {
			log.debug("findDayAttdMgtList - 시작");
			}	
		ArrayList<DayAttdMgtTO> dayAttdMgtList = attdApplicationService.findDayAttdMgtList(applyDay, dept);
			return dayAttdMgtList;
	}

	@Override
	public void modifyDayAttdMgtList(ArrayList<DayAttdMgtTO> dayAttdMgtList) {
		if(log.isDebugEnabled()) {
			log.debug("modifyDayAttdMgtList - 시작");
			}		
		 attdApplicationService.modifyDayAttdMgtList(dayAttdMgtList);
	}
	
	@Override
	public ArrayList<MonthAttdMgtTO> findMonthAttdMgtList(String applyYearMonth) {
		if(log.isDebugEnabled()) {
			log.debug("findMonthAttdMgtList - 시작");
			}		
		ArrayList<MonthAttdMgtTO> monthAttdMgtList = attdApplicationService.findMonthAttdMgtList(applyYearMonth);
			return monthAttdMgtList;
	}
	
	@Override
	public void modifyMonthAttdMgtList(ArrayList<MonthAttdMgtTO> monthAttdMgtList) {
		if(log.isDebugEnabled()) {
			log.debug("modifyMonthAttdMgtList - 시작");
			}	
		attdApplicationService.modifyMonthAttdMgtList(monthAttdMgtList);
	}
	
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		log.error(e);
		log.error(e.getMessage());
		return "error:" + e;
	}
}
