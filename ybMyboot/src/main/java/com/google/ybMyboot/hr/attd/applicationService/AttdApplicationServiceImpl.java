package com.google.ybMyboot.hr.attd.applicationService;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.google.ybMyboot.common.aop.DataAccessExceptionAdvice;
import com.google.ybMyboot.common.to.ResultTO;
import com.google.ybMyboot.hr.attd.dao.DayAttdDAO;
import com.google.ybMyboot.hr.attd.dao.DayAttdMgtDAO;
import com.google.ybMyboot.hr.attd.dao.MonthAttdMgtDAO;
import com.google.ybMyboot.hr.attd.dao.RestAttdDAO;
import com.google.ybMyboot.hr.attd.to.DayAttdMgtTO;
import com.google.ybMyboot.hr.attd.to.DayAttdTO;
import com.google.ybMyboot.hr.attd.to.MonthAttdMgtTO;
import com.google.ybMyboot.hr.attd.to.RestAttdTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Component
public class AttdApplicationServiceImpl implements AttdApplicationService{
	@Autowired
	private DayAttdDAO dayAttdDAO;
	@Autowired
	private RestAttdDAO restAttdDAO ;
	@Autowired
	private DayAttdMgtDAO dayAttdMgtDAO ;
	@Autowired
	private MonthAttdMgtDAO monthAttdMgtDAO ;
	
	

	@Override
	public ArrayList<DayAttdTO> findDayAttdList(String empCode, String applyDay) {
		if(log.isDebugEnabled()) {
			log.debug("findDayAttdList - 시작");
			}
		ArrayList<DayAttdTO> dayAttdList=dayAttdDAO.selectDayAttdList(empCode, applyDay);
		return dayAttdList;
	}

	@Override
	public ResultTO registDayAttd(DayAttdTO dayAttd) {
		if(log.isDebugEnabled()) {
			log.debug("registDayAttd - 시작");
			}
		ResultTO resultTO=dayAttdDAO.batchInsertDayAttd(dayAttd);
		
		/*
		 * if(Integer.parseInt(resultTO.getErrorCode()) < 0){ throw new
		 * DataAccessException(resultTO.getErrorMsg()); }
		 */
		return resultTO;
	}

	@Override
	public void removeDayAttdList(ArrayList<DayAttdTO> dayAttdList) {
		if(log.isDebugEnabled()) {
			log.debug("removeDayAttdList - 시작");
			}
		for(DayAttdTO dayAttd : dayAttdList){
			dayAttdDAO.deleteDayAttd(dayAttd);
		}
	}
	
	@Override
	public ArrayList<RestAttdTO> findRestAttdListByToday(String empCode, String toDay) {
		if(log.isDebugEnabled()) {
			log.debug("findRestAttdListByToday - 시작");
			}
		ArrayList<RestAttdTO> restAttdList = restAttdDAO.selectRestAttdListByToday(empCode, toDay);
		
		return restAttdList;
	}

	@Override
	public void modifyDayAttdMgtList(ArrayList<DayAttdMgtTO> dayAttdMgtList) {
		if(log.isDebugEnabled()) {
			log.debug("modifyDayAttdMgtList - 시작");
			}
		for(DayAttdMgtTO dayAttdMgt : dayAttdMgtList){
			if(dayAttdMgt.getStatus().equals("update")){
			dayAttdMgtDAO.updateDayAttdMgtList(dayAttdMgt);
			}
			
		}		
	}

	@Override
	public ArrayList<MonthAttdMgtTO> findMonthAttdMgtList(String applyYearMonth) {
		if(log.isDebugEnabled()) {
			log.debug("findMonthAttdMgtList - 시작");
			}
		HashMap<String, Object> resultMap = monthAttdMgtDAO.batchMonthAttdMgtProcess(applyYearMonth);
	//	ResultTO resultTO = (ResultTO) resultMap.get("resultTO");
		
	//	if(Integer.parseInt(resultTO.getErrorCode()) < 0)throw new DataAccessException(resultTO.getErrorMsg());
		
		
		@SuppressWarnings("unchecked")
		ArrayList<MonthAttdMgtTO> monthAttdMgtList = (ArrayList<MonthAttdMgtTO>) resultMap.get("monthAttdMgtList");
		return monthAttdMgtList;
	}
	
	@Override
	public ArrayList<RestAttdTO> findRestAttdListByDept(String deptName, String startDate, String endDate) {
		if(log.isDebugEnabled()) {
			log.debug("findRestAttdListByDept - 시작");
			}
		ArrayList<RestAttdTO> restAttdList = null;

		if(deptName.equals("모든부서")) 	restAttdList = restAttdDAO.selectRestAttdListByAllDept(startDate);

			restAttdList = restAttdDAO.selectRestAttdListByDept(deptName, startDate, endDate);
		
		return restAttdList;
	}
	
	
	@Override
	public void registRestAttd(RestAttdTO restAttd) {
		if(log.isDebugEnabled()) {
			log.debug("registRestAttd - 시작");
			}
		restAttdDAO.insertRestAttd(restAttd);		
	}
	
	@Override
	public ArrayList<RestAttdTO> findRestAttdList(String empCode, String startDate, String endDate, String code) {
		if(log.isDebugEnabled()) {
			log.debug("findRestAttdList - 시작");
			}
		ArrayList<RestAttdTO> restAttdList=null;
		
		if(code == "") restAttdList = restAttdDAO.selectRestAttdList(empCode, startDate, endDate);
		
			restAttdList = restAttdDAO.selectRestAttdListCode(empCode, startDate, endDate, code);
		return restAttdList;
	}
	
	@Override
	public void removeRestAttdList(ArrayList<RestAttdTO> restAttdList) {
		if(log.isDebugEnabled()) {
			log.debug("removeRestAttdList - 시작");
			}
		for(RestAttdTO restAttd : restAttdList){
			restAttdDAO.deleteRestAttd(restAttd);
		}		
	}

	@Override
	public void modifyRestAttdList(ArrayList<RestAttdTO> restAttdList) {
		if(log.isDebugEnabled()) {
			log.debug("modifyRestAttdList - 시작");
			}
		for(RestAttdTO restAttd : restAttdList){
			if(restAttd.getStatus().equals("update")){
				restAttdDAO.updateRestAttd(restAttd);
			}
		}		
	}
	
	@Override
	public ArrayList<DayAttdMgtTO> findDayAttdMgtList(String applyDay, String dept) {
		if(log.isDebugEnabled()) {
			log.debug("findDayAttdMgtList - 시작");
			}
		HashMap<String, Object> resultMap = dayAttdMgtDAO.batchDayAttdMgtProcess(applyDay, dept);
	//	ResultTO resultTO = (ResultTO) resultMap.get("resultTO");
	//	if(Integer.parseInt(resultTO.getErrorCode()) < 0) throw new DataAccessException(resultTO.getErrorMsg());
		
		@SuppressWarnings("unchecked")
		ArrayList<DayAttdMgtTO> dayAttdMgtList = (ArrayList<DayAttdMgtTO>) resultMap.get("dayAttdMgtList");
		return dayAttdMgtList;
	}
	
	@Override
	public void modifyMonthAttdMgtList(ArrayList<MonthAttdMgtTO> monthAttdMgtList) {
		if(log.isDebugEnabled()) {
			log.debug("modifyMonthAttdMgtList - 시작");
			}
		for(MonthAttdMgtTO monthAttdMgt : monthAttdMgtList){
			if(monthAttdMgt.getStatus().equals("update"))
				monthAttdMgtDAO.updateMonthAttdMgtList(monthAttdMgt);
			
		}		
	}
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		System.out.println(e);
		log.debug(e.getMessage());
		return "error:" + e;
	}


}
