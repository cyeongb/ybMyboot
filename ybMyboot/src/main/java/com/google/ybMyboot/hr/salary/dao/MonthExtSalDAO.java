package com.google.ybMyboot.hr.salary.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.google.ybMyboot.hr.salary.to.MonthExtSalTO;
@Mapper
public interface MonthExtSalDAO {
	public ArrayList<MonthExtSalTO> selectMonthExtSalList(String applyYearMonth, String empCode);
}
