package com.google.ybMyboot.hr.emp.sf;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.google.ybMyboot.base.to.DeptTO;
import com.google.ybMyboot.hr.emp.applicationService.EmpApplicationService;
import com.google.ybMyboot.hr.emp.to.EmpTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class EmpServiceFacadeImpl implements EmpServiceFacade {
	
	@Autowired
	private EmpApplicationService empApplicationService;	
   
	@Override
	public EmpTO getEmp(String name) {
		  if(log.isDebugEnabled()) {
			  log.debug("getEmp - 시작");
			  }		
		EmpTO empto = null;
		empto = empApplicationService.selectEmp(name);
		return empto;
	}

	@Override
	public String findLastEmpCode() {	
		 if(log.isDebugEnabled()) {
			  log.debug("findLastEmpCode - 시작");
			  }	
		String empCode = empApplicationService.findLastEmpCode();
		return empCode;		
	}

	@Override
	public void registEmployee(EmpTO empto) {
		if(log.isDebugEnabled()) {
			  log.debug("registEmployee - 시작");
			  }	
		empApplicationService.registEmployee(empto);	
	}

	@Override
	public List<EmpTO> findEmpList(String dept) {
		if(log.isDebugEnabled()) {
			  log.debug("findEmpList - 시작");
			  }	
		ArrayList<EmpTO> empList = empApplicationService.findEmployeeListByDept(dept);
		return empList;
	}

	@Override
	public EmpTO findAllEmpInfo(String empCode) {
		if(log.isDebugEnabled()) {
			  log.debug("findAllEmpInfo - 시작");
			  }	
		EmpTO empTO = empApplicationService.findAllEmployeeInfo(empCode);
		return empTO;
	}

	@Override
	public void modifyEmployee(EmpTO emp) {
		if(log.isDebugEnabled()) {
			  log.debug("modifyEmployee - 시작");
			  }	
		empApplicationService.modifyEmployee(emp);			
	}

	@Override
	public void deleteEmpList(ArrayList<EmpTO> empList) {
		if(log.isDebugEnabled()) {
			  log.debug("deleteEmpList - 시작");
			  }	
		empApplicationService.deleteEmpList(empList);
	}

	@Override
	public ArrayList<DeptTO> findDeptList() {
		if(log.isDebugEnabled()) {
			  log.debug("findDeptList - 시작");
			  }
		ArrayList<DeptTO> deptList = empApplicationService.findDeptList();		
		return deptList;
	}
	
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		log.error(e);
		log.error(e.getMessage());
		return "error:" + e;
	}

}
