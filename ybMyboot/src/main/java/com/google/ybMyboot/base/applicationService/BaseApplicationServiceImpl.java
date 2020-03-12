package com.google.ybMyboot.base.applicationService;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ExceptionHandler;
import com.google.ybMyboot.base.dao.CodeDAO;
import com.google.ybMyboot.base.dao.DeptDAO;
import com.google.ybMyboot.base.dao.DetailCodeDAO;
import com.google.ybMyboot.base.dao.HolidayDAO;
import com.google.ybMyboot.base.dao.ReportDAO;
import com.google.ybMyboot.base.exception.IdNotFoundException;
import com.google.ybMyboot.base.exception.PwMissMatchException;
import com.google.ybMyboot.base.to.CodeTO;
import com.google.ybMyboot.base.to.DeptTO;
import com.google.ybMyboot.base.to.DetailCodeTO;
import com.google.ybMyboot.base.to.HolidayTO;
import com.google.ybMyboot.base.to.ReportTO;
import com.google.ybMyboot.hr.emp.applicationService.EmpApplicationService;
import com.google.ybMyboot.hr.emp.to.EmpTO;
import com.google.ybMyboot.hr.salary.dao.BaseSalaryDAO;
import com.google.ybMyboot.hr.salary.to.BaseSalaryTO;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Component
//@Repository
public class BaseApplicationServiceImpl implements BaseApplicationService {
	
	@Autowired
	private EmpApplicationService empApplicationService ;	
	@Autowired
	private DetailCodeDAO detailCodeDAO ; 
	@Autowired
	private HolidayDAO holidayDAO ;
	@Autowired
	private DeptDAO deptDAO ;
	@Autowired
	private BaseSalaryDAO baseSalaryDAO ;
	@Autowired
	private CodeDAO codeDAO ;
	@Autowired
	private ReportDAO reportDAO ;

	//@SuppressWarnings("unused")
	@Override
	public boolean loginEmployee(String name, String empCode) throws IdNotFoundException, PwMissMatchException {

		if(log.isDebugEnabled()) {
			log.debug("loginEmployee - 시작");
		}
		EmpTO emp = empApplicationService.selectEmp(name); 

		if (emp == null) {			
			throw new IdNotFoundException("사원명이 존재하지 않습니다");
		} else {
			if (emp.getEmpCode().equals(empCode)) {				
				return true;
			} else {				
				throw new PwMissMatchException("사원번호를 확인해주세요");
			}
		}
	}

	@Override
	public ArrayList<DetailCodeTO> findDetailCodeList(String codetype) {
		if(log.isDebugEnabled()) {
			log.debug("findDetailCodeList - 시작");
		}
		
		ArrayList<DetailCodeTO> detailCodeList = null;
		detailCodeList = detailCodeDAO.selectDetailCodeList(codetype);		
		return detailCodeList;
	}
	
	@Override
	public void registEmpCode(EmpTO empto) {
		if(log.isDebugEnabled()) {
			log.debug("registEmpCode - 시작");
		}
	
		DetailCodeTO detailCodeto = new DetailCodeTO();
		detailCodeto.setDetailCodeNumber(empto.getEmpCode());
		detailCodeto.setDetailCodeName(empto.getEmpName());
		detailCodeto.setCodeNumber("CO-17");
		detailCodeto.setDetailCodeNameusing("N");
		detailCodeDAO.registDetailCode(detailCodeto);	
	}

	@Override
	public void deleteEmpCode(EmpTO empto) {
		if(log.isDebugEnabled()) {
			log.debug("deleteEmpCode - 시작");
		}
	
		DetailCodeTO detailCodeto = new DetailCodeTO();
		detailCodeto.setDetailCodeNumber(empto.getEmpCode());
		detailCodeto.setDetailCodeName(empto.getEmpName());
		detailCodeDAO.deleteDetailCode(detailCodeto);
	}

	@Override
	public ArrayList<DetailCodeTO> findDetailCodeListRest(String code1, String code2, String code3) {
		if(log.isDebugEnabled()) {
			log.debug("findDetailCodeListRest - 시작");
		}
		ArrayList<DetailCodeTO> detailCodeList = detailCodeDAO.selectDetailCodeListRest(code1, code2, code3);
		
		return detailCodeList;
	}

	@Override
	public ArrayList<HolidayTO> findHolidayList() {
		if(log.isDebugEnabled()) {
			log.debug("findHolidayList - 시작");
		}
		ArrayList<HolidayTO> holidayList = holidayDAO.selectHolidayList();
		
		return holidayList;
	}

	@Override
	public void batchDeptProcess(ArrayList<DeptTO> deptto) {
		if(log.isDebugEnabled()) {
			log.debug("batchDeptProcess - 시작");
		}
		DetailCodeTO detailCodeto = new DetailCodeTO();

		for (DeptTO dept : deptto) {
			switch (dept.getStatus()) {

			case "update":
				deptDAO.updateDept(dept);
				detailCodeto.setDetailCodeNumber(dept.getDeptCode());
				detailCodeto.setDetailCodeName(dept.getDeptName());
				detailCodeto.setCodeNumber("CO-07");
				detailCodeto.setDetailCodeNameusing("Y");
				detailCodeDAO.updateDetailCode(detailCodeto);
				break;

			case "insert":
				deptDAO.registDept(dept);
				detailCodeto.setDetailCodeNumber(dept.getDeptCode());
				detailCodeto.setDetailCodeName(dept.getDeptName());
				detailCodeto.setCodeNumber("CO-07");
				detailCodeto.setDetailCodeNameusing("Y");
				detailCodeDAO.registDetailCode(detailCodeto);
				break;

			case "delete":
				deptDAO.deleteDept(dept);
				detailCodeto.setDetailCodeNumber(dept.getDeptCode());
				detailCodeto.setDetailCodeName(dept.getDeptName());
				detailCodeDAO.deleteDetailCode(detailCodeto);
				break;

			case "normal":
				break;
			}
		}
	}

	@Override
	public void modifyPosition(ArrayList<BaseSalaryTO> positionList) {
		if(log.isDebugEnabled()) {
			log.debug("modifyPosition - 시작");
		}
		if (positionList != null && positionList.size() > 0) {
			for (BaseSalaryTO position : positionList) {
				DetailCodeTO detailCodeto = new DetailCodeTO();
				switch (position.getStatus()) {

				case "update":
					baseSalaryDAO.updatePosition(position);
					detailCodeto.setDetailCodeNumber(position.getPositionCode());
					detailCodeto.setDetailCodeName(position.getPosition());
					detailCodeto.setCodeNumber("CO-04");
					detailCodeto.setDetailCodeNameusing("Y");
					detailCodeDAO.updateDetailCode(detailCodeto);
					break;

				case "insert":
					baseSalaryDAO.insertPosition(position);
					detailCodeto.setDetailCodeNumber(position.getPositionCode());
					detailCodeto.setDetailCodeName(position.getPosition());
					detailCodeto.setCodeNumber("CO-04");
					detailCodeto.setDetailCodeNameusing("Y");
					detailCodeDAO.registDetailCode(detailCodeto);
					break;

				case "delete":
					baseSalaryDAO.deletePosition(position);
					detailCodeto.setDetailCodeNumber(position.getPositionCode());
					detailCodeto.setDetailCodeName(position.getPosition());
					detailCodeDAO.deleteDetailCode(detailCodeto);
					break;
				}
			}
		}		
	}

	@Override
	public String findWeekDayCount(String startDate, String endDate) {
		if(log.isDebugEnabled()) {
			log.debug("findWeekDayCount - 시작");
		}
		String weekdayCount = holidayDAO.selectWeekDayCount(startDate, endDate);
		return weekdayCount;
	}

	@Override
	public void registEmpImg(String empCode, String imgExtend) {
		if(log.isDebugEnabled()) {
			log.debug("registEmpImg - 시작");
		}
		EmpTO emp = empApplicationService.findAllEmployeeInfo(empCode);
		if (emp == null) {
			emp = new EmpTO();
			emp.setEmpCode(empCode);
			emp.setStatus("insert");
		} else {
			emp.setStatus("update");
		}
		emp.setImgExtend(imgExtend);
		empApplicationService.modifyEmployee(emp);
	}

	@Override
	public ArrayList<CodeTO> findCodeList() {
		if(log.isDebugEnabled()) {
			log.debug("findCodeList - 시작");
		}
		ArrayList<CodeTO> codeList = codeDAO.selectCode();

		return codeList;
	}

	@Override
	public void registCodeList(List<HolidayTO> holidayto) {
		if(log.isDebugEnabled()) {
			log.debug("registCodeList - 시작");
		}
		for (HolidayTO holiday : holidayto) {
			switch (holiday.getStatus()) {

			case "update":
				holidayDAO.updateCodeList(holiday);
				break;
			
			case "insert":
				holidayDAO.insertCodeList(holiday);
				break;

			case "delete":
				holidayDAO.deleteCodeList(holiday);
				break;

			}
		}
	}
	//---------------- 아이리포트 !!!!
	@Override
	public ReportTO viewReport(String empCode) {
		if(log.isDebugEnabled()) {
			log.debug("viewReport - 시작");
		}
		 ReportTO to=null;

	 to=reportDAO.selectReport(empCode);
	
		return to;
	}
	
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		System.out.println(e);
		log.debug(e.getMessage());
		return "error:" + e;
	}
	
	
}
