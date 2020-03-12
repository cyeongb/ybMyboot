package com.google.ybMyboot.hr.salary.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.google.ybMyboot.hr.salary.to.MonthDeductionTO;
@Mapper
public interface MonthDeductionDAO {
	public ArrayList<MonthDeductionTO> selectMonthDeductionList(String applyYearMonth, String empCode);
}
