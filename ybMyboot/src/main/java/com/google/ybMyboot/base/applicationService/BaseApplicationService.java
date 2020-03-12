package com.google.ybMyboot.base.applicationService;

import java.util.ArrayList;
import java.util.List;

import com.google.ybMyboot.base.exception.IdNotFoundException;
import com.google.ybMyboot.base.exception.PwMissMatchException;
import com.google.ybMyboot.base.to.CodeTO;
import com.google.ybMyboot.base.to.DeptTO;
import com.google.ybMyboot.base.to.DetailCodeTO;
import com.google.ybMyboot.base.to.HolidayTO;
import com.google.ybMyboot.base.to.ReportTO;
import com.google.ybMyboot.hr.emp.to.EmpTO;
import com.google.ybMyboot.hr.salary.to.BaseSalaryTO;

public interface BaseApplicationService {
	   public boolean loginEmployee(String name, String empCode) throws IdNotFoundException, PwMissMatchException; 

	   public ArrayList<DetailCodeTO> findDetailCodeList(String codetype);
	   public ArrayList<DetailCodeTO> findDetailCodeListRest(String code1, String code2, String code3);

	   public ArrayList<HolidayTO> findHolidayList();
	   public String findWeekDayCount(String startDate, String endDate);

	   public void registEmpImg(String empCode, String imgExtend);

	   public void batchDeptProcess(ArrayList<DeptTO> deptto);
	   public void modifyPosition(ArrayList<BaseSalaryTO> positionList);
	   
	   public void registEmpCode(EmpTO empto);
	   public void deleteEmpCode(EmpTO empto);

	   public ArrayList<CodeTO> findCodeList();

	   public void registCodeList(List<HolidayTO> holidayto);

	   public ReportTO viewReport(String empCode);

	}