package com.google.ybMyboot.hr.salary.sf;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.google.ybMyboot.hr.salary.applicationService.SalaryApplicationService;
import com.google.ybMyboot.hr.salary.to.BaseDeductionTO;
import com.google.ybMyboot.hr.salary.to.BaseExtSalTO;
import com.google.ybMyboot.hr.salary.to.BaseSalaryTO;
import com.google.ybMyboot.hr.salary.to.MonthSalaryTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class SalaryServiceFacadeImpl implements SalaryServiceFacade{
	@Autowired
	private SalaryApplicationService salaryApplicationService;

	@Override
	public ArrayList<BaseSalaryTO> findBaseSalaryList() {		
		  if(log.isDebugEnabled()) {
			  log.debug("findBaseSalaryList - 시작");
			  }	
		ArrayList<BaseSalaryTO> baseSalaryList=salaryApplicationService.findBaseSalaryList();
			return baseSalaryList;	
	}
	
	@Override
	public void modifyBaseSalaryList(ArrayList<BaseSalaryTO> baseSalaryList) {
		 if(log.isDebugEnabled()) {
			  log.debug("modifyBaseSalaryList - 시작");
			  }		
		salaryApplicationService.modifyBaseSalaryList(baseSalaryList);					
	}
	
	@Override
	public ArrayList<BaseDeductionTO> findBaseDeductionList() {
		 if(log.isDebugEnabled()) {
			  log.debug("findBaseDeductionList - 시작");
			  }			
		ArrayList<BaseDeductionTO> baseDeductionList=salaryApplicationService.findBaseDeductionList();
			return baseDeductionList;
	}
	
	@Override
	public void batchBaseDeductionProcess(ArrayList<BaseDeductionTO> baseDeductionList) {
		 if(log.isDebugEnabled()) {
			  log.debug("batchBaseDeductionProcess - 시작");
			  }			
		salaryApplicationService.batchBaseDeductionProcess(baseDeductionList);
	}
	
	@Override
	public ArrayList<BaseExtSalTO> findBaseExtSalList() {
		if(log.isDebugEnabled()) {
			  log.debug("findBaseExtSalList - 시작");
			  }		
		ArrayList<BaseExtSalTO> baseExtSalList=salaryApplicationService.findBaseExtSalList();
			return baseExtSalList;
	}	
	@Override
	public void modifyBaseExtSalList(ArrayList<BaseExtSalTO> baseExtSalList) {
		if(log.isDebugEnabled()) {
			  log.debug("modifyBaseExtSalList - 시작");
			  }			
		salaryApplicationService.modifyBaseExtSalList(baseExtSalList);
	}

	@Override
	public MonthSalaryTO findMonthSalary(String ApplyYearMonth, String empCode) {
		if(log.isDebugEnabled()) {
			  log.debug("findMonthSalary - 시작");
			  }		
		MonthSalaryTO monthSalary=salaryApplicationService.findMonthSalary(ApplyYearMonth, empCode);
			return monthSalary;	
	}

	@Override
	public ArrayList<MonthSalaryTO> findYearSalary(String applyYear, String empCode) {
		if(log.isDebugEnabled()) {
			  log.debug("findYearSalary - 시작");
			  }			
		ArrayList<MonthSalaryTO> monthSalary=salaryApplicationService.findYearSalary(applyYear, empCode);
			return monthSalary;
	}
	
	@Override
	public void modifyMonthSalary(MonthSalaryTO monthSalary) {
		if(log.isDebugEnabled()) {
			  log.debug("modifyMonthSalary - 시작");
			  }		
		salaryApplicationService.modifyMonthSalary(monthSalary);
	}
	
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		log.error(e);
		log.error(e.getMessage());
		return "error:" + e;
	}

	
}
