package com.google.ybMyboot.base.sf;
import java.util.ArrayList;
import java.util.List;

import org.springframework.ui.Model;

import com.google.ybMyboot.base.exception.IdNotFoundException;
import com.google.ybMyboot.base.exception.PwMissMatchException;
import com.google.ybMyboot.base.to.CodeTO;
import com.google.ybMyboot.base.to.DeptTO;
import com.google.ybMyboot.base.to.DetailCodeTO;
import com.google.ybMyboot.base.to.HolidayTO;
import com.google.ybMyboot.base.to.ReportTO;
import com.google.ybMyboot.hr.salary.to.BaseSalaryTO;


public interface BaseServiceFacade {
	public boolean login(String name, String empCode)throws IdNotFoundException, PwMissMatchException;  //로그인(이름,사원번호)
	public ArrayList<DetailCodeTO> findDetailCodeList(String codetype);
	public ArrayList<DetailCodeTO> findDetailCodeListRest(String code1,String code2,String code3);
	public ArrayList<HolidayTO> findHolidayList();
	public String findWeekDayCount(String startDate, String endDate);
	public void registEmpImg(String empCode, String imgExtend);
	public void batchDeptProcess(ArrayList<DeptTO> deptto);
	public ArrayList<BaseSalaryTO> findPositionList();
	public void modifyPosition(ArrayList<BaseSalaryTO> positionList);
	public ArrayList<CodeTO> findCodeList();
	void registCodeList(List<HolidayTO> holyday);
	public ReportTO viewReport(String empCode);

}