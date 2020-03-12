package com.google.ybMyboot.hr.attd.applicationService;

import java.util.ArrayList;

import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;

import com.google.ybMyboot.common.to.ResultTO;
import com.google.ybMyboot.hr.attd.to.DayAttdMgtTO;
import com.google.ybMyboot.hr.attd.to.DayAttdTO;
import com.google.ybMyboot.hr.attd.to.MonthAttdMgtTO;
import com.google.ybMyboot.hr.attd.to.RestAttdTO;

public interface AttdApplicationService {
	public ArrayList<DayAttdTO> findDayAttdList(String empCode, String applyDay);
	public ResultTO registDayAttd(DayAttdTO dayAttd);
	public void removeDayAttdList(ArrayList<DayAttdTO> dayAttdList);

	public ArrayList<DayAttdMgtTO> findDayAttdMgtList(String applyDay, String dept);
	public void modifyDayAttdMgtList(ArrayList<DayAttdMgtTO> dayAttdMgtList);
	public ArrayList<MonthAttdMgtTO> findMonthAttdMgtList(String applyYearMonth);
	public void modifyMonthAttdMgtList(ArrayList<MonthAttdMgtTO> monthAttdMgtList);
	
	public ArrayList<RestAttdTO> findRestAttdList(String empCode, String startDate, String endDate, String code);
	public ArrayList<RestAttdTO> findRestAttdListByDept(String deptName, String startDate, String endDate);
	public ArrayList<RestAttdTO> findRestAttdListByToday(String empCode, String toDay);

	public void registRestAttd(RestAttdTO restAttd);
	public void modifyRestAttdList(ArrayList<RestAttdTO> restAttdList);
    public void removeRestAttdList(ArrayList<RestAttdTO> restAttdList);
}

