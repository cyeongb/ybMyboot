package com.google.ybMyboot.hr.salary.applicationService;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ExceptionHandler;
import com.google.ybMyboot.common.to.ResultTO;
import com.google.ybMyboot.hr.salary.dao.BaseDeductionDAO;
import com.google.ybMyboot.hr.salary.dao.BaseExtSalDAO;
import com.google.ybMyboot.hr.salary.dao.BaseSalaryDAO;
import com.google.ybMyboot.hr.salary.dao.MonthDeductionDAO;
import com.google.ybMyboot.hr.salary.dao.MonthExtSalDAO;
import com.google.ybMyboot.hr.salary.dao.MonthSalaryDAO;
import com.google.ybMyboot.hr.salary.to.BaseDeductionTO;
import com.google.ybMyboot.hr.salary.to.BaseExtSalTO;
import com.google.ybMyboot.hr.salary.to.BaseSalaryTO;
import com.google.ybMyboot.hr.salary.to.MonthSalaryTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Component
public class SalaryApplicationServiceImpl implements SalaryApplicationService{
	@Autowired
	private MonthDeductionDAO monthDeductionDAO;
	@Autowired
	private MonthExtSalDAO monthExtSalDAO;
	@Autowired
	private MonthSalaryDAO monthSalaryDAO;
	@Autowired
	private BaseDeductionDAO baseDeductionDAO;
	@Autowired
	private BaseExtSalDAO baseExtSalDAO;
	@Autowired
	private BaseSalaryDAO baseSalaryDAO;

	
	@Override
	public MonthSalaryTO findMonthSalary(String applyYearMonth, String empCode) {
		  if(log.isDebugEnabled()) {
			  log.debug("findMonthSalary - 시작");
			  }

		HashMap<String, Object> resultMap = monthSalaryDAO.batchMonthSalaryProcess(applyYearMonth, empCode);
	//	ResultTO resultTO = (ResultTO) resultMap.get("resultTO");
//		if(Integer.parseInt(resultTO.getErrorCode()) < 0){
//			throw new DataAccessException(resultTO.getErrorMsg());
//		}
		MonthSalaryTO monthSalary = (MonthSalaryTO) resultMap.get("monthSalary");
		monthSalary.setMonthDeductionList(monthDeductionDAO.selectMonthDeductionList(applyYearMonth, empCode));
		monthSalary.setMonthExtSalList(monthExtSalDAO.selectMonthExtSalList(applyYearMonth, empCode));

		
		return monthSalary;
	}
	@Override
	public ArrayList<MonthSalaryTO> findYearSalary(String applyYear, String empCode) {
		 if(log.isDebugEnabled()) {
			  log.debug("findYearSalary - 시작");
			  }
		ArrayList<MonthSalaryTO> yearSalary = monthSalaryDAO.selectYearSalary(applyYear, empCode);
		return yearSalary;
	}
	@Override
	public void modifyMonthSalary(MonthSalaryTO monthSalary) {
		if(log.isDebugEnabled()) {
			  log.debug("modifyMonthSalary - 시작");
			  }
		monthSalaryDAO.updateMonthSalary(monthSalary);
	}
	@Override
	public ArrayList<BaseDeductionTO> findBaseDeductionList() {
		if(log.isDebugEnabled()) {
			  log.debug("findBaseDeductionList - 시작");
			  }
		ArrayList<BaseDeductionTO> baseDeductionList = baseDeductionDAO.selectBaseDeductionList();
		return baseDeductionList;
	}
	@Override
	public void batchBaseDeductionProcess(ArrayList<BaseDeductionTO> baseDeductionList) {
		if(log.isDebugEnabled()) {
			  log.debug("batchBaseDeductionProcess - 시작");
			  }
		for(BaseDeductionTO baseDeduction : baseDeductionList){
			switch(baseDeduction.getStatus()){
				case "insert" :
					baseDeductionDAO.insertBaseDeduction(baseDeduction);
					break;
				case "update" :
					baseDeductionDAO.updateBaseDeduction(baseDeduction);
					break;
				case "delete" :
					baseDeductionDAO.deleteBaseDeduction(baseDeduction);
					break;
			}
		}	
	}
	@Override
	public ArrayList<BaseSalaryTO> findBaseSalaryList() {
		if(log.isDebugEnabled()) {
			  log.debug("findBaseSalaryList - 시작");
			  }
		ArrayList<BaseSalaryTO> baseSalaryList = baseSalaryDAO.selectBaseSalaryList();
		return baseSalaryList;
	}
	@Override
	public void modifyBaseSalaryList(ArrayList<BaseSalaryTO> baseSalaryList) {
		if(log.isDebugEnabled()) {
			  log.debug("modifyBaseSalaryList - 시작");
			  }
		for(BaseSalaryTO baseSalary : baseSalaryList){
			if(baseSalary.getStatus().equals("update"))
				baseSalaryDAO.updateBaseSalary(baseSalary);
		}
	}
	@Override
	public ArrayList<BaseExtSalTO> findBaseExtSalList() {
		if(log.isDebugEnabled()) {
			  log.debug("findBaseExtSalList - 시작");
			  }
		ArrayList<BaseExtSalTO> baseExtSalList = baseExtSalDAO.selectBaseExtSalList();
		return baseExtSalList;
	}
	@Override
	public void modifyBaseExtSalList(ArrayList<BaseExtSalTO> baseExtSalList) {
		if(log.isDebugEnabled()) {
			  log.debug("modifyBaseExtSalList - 시작");
			  }
		for(BaseExtSalTO baseExtSal : baseExtSalList){
			if(baseExtSal.getStatus().equals("update"))
				baseExtSalDAO.updateBaseExtSal(baseExtSal);
		}		
	}
	
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		log.error(e);
		log.error(e.getMessage());
		return "error:" + e;
	}
}