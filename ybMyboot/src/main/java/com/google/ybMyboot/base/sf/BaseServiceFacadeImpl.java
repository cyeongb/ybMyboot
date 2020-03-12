package com.google.ybMyboot.base.sf;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ExceptionHandler;
import com.google.ybMyboot.base.applicationService.BaseApplicationService;
import com.google.ybMyboot.base.exception.IdNotFoundException;
import com.google.ybMyboot.base.exception.PwMissMatchException;
import com.google.ybMyboot.base.to.CodeTO;
import com.google.ybMyboot.base.to.DeptTO;
import com.google.ybMyboot.base.to.DetailCodeTO;
import com.google.ybMyboot.base.to.HolidayTO;
import com.google.ybMyboot.base.to.ReportTO;
import com.google.ybMyboot.hr.emp.applicationService.EmpApplicationService;
import com.google.ybMyboot.hr.salary.to.BaseSalaryTO;
import lombok.extern.log4j.Log4j2;


@Log4j2
@Service
public class BaseServiceFacadeImpl implements BaseServiceFacade {
	@Autowired
	private BaseApplicationService baseApplicationService;
	@Autowired
	private EmpApplicationService empApplicationService;

	@Override
	public boolean login(String name, String empCode) throws IdNotFoundException, PwMissMatchException {
		if(log.isDebugEnabled()) {
			log.debug("login -  시작");
			log.debug("empcode:"+empCode);
			log.debug("name:"+name);
		
		}
		boolean check = baseApplicationService.loginEmployee(name, empCode);
		return check;

	}

	@Override
	public ArrayList<DetailCodeTO> findDetailCodeList(String codetype) {
		if(log.isDebugEnabled()) {
			log.debug("findDetailCodeList - 시작");
			log.debug("codeType:"+codetype);
		}

		ArrayList<DetailCodeTO> detailCodeto = baseApplicationService.findDetailCodeList(codetype);
		return detailCodeto;
	}

	@Override
	public ArrayList<DetailCodeTO> findDetailCodeListRest(String code1, String code2, String code3) {
		if(log.isDebugEnabled()) {
			log.debug("findDetailCodeListRest - 시작");
	
		}
		ArrayList<DetailCodeTO> detailCodeto = baseApplicationService.findDetailCodeListRest(code1, code2, code3);

		return detailCodeto;
	}

	@Override
	public ArrayList<HolidayTO> findHolidayList() {
		if(log.isDebugEnabled()) {
			log.debug("findHolidayList - 시작");
		}
		ArrayList<HolidayTO> holidayList = baseApplicationService.findHolidayList();

		return holidayList;

	}

	@Override
	public String findWeekDayCount(String startDate, String endDate) {
		if(log.isDebugEnabled()) {
			log.debug("findWeekDayCount - 시작");
		}
		String weekdayCount = baseApplicationService.findWeekDayCount(startDate, endDate);

		return weekdayCount;

	}

	@Override
	public void registEmpImg(String empCode, String imgExtend) {
		if(log.isDebugEnabled()) {
			log.debug("registEmpImg - 시작");
		}
		baseApplicationService.registEmpImg(empCode, imgExtend);

	}

	@Override
	public void batchDeptProcess(ArrayList<DeptTO> deptto) {
		if(log.isDebugEnabled()) {
			log.debug("batchDeptProcess - 시작");
		}
		baseApplicationService.batchDeptProcess(deptto);

	}

	@Override
	public ArrayList<BaseSalaryTO> findPositionList() {
		if(log.isDebugEnabled()) {
			log.debug("findPositionList - 시작");
		}
		ArrayList<BaseSalaryTO> positionList = empApplicationService.selectPositionList();

		return positionList;
	}

	@Override
	public void modifyPosition(ArrayList<BaseSalaryTO> positionList) {
		if(log.isDebugEnabled()) {
			log.debug("modifyPosition - 시작");
		}
		baseApplicationService.modifyPosition(positionList);

	}

	@Override
	public ArrayList<CodeTO> findCodeList() {
		if(log.isDebugEnabled()) {
			log.debug("findCodeList - 시작");
		}
		ArrayList<CodeTO> codeto = baseApplicationService.findCodeList();
		return codeto;
	}

	@Override
	public void registCodeList(List<HolidayTO> holyday) {
		if(log.isDebugEnabled()) {
			log.debug("registCodeList - 시작");
		}
		baseApplicationService.registCodeList(holyday);

	}

	@Override
	public ReportTO viewReport(String empCode) {
		if(log.isDebugEnabled()) {
			log.debug("viewReport - 시작");
		}
		ReportTO to = baseApplicationService.viewReport(empCode);

		return to;
	}

	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		System.out.println(e);
		log.debug(e.getMessage());
		return "error:" + e;
	}

}
