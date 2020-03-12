package com.google.ybMyboot.hr.salary.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.google.ybMyboot.hr.salary.to.MonthSalaryTO;
@Mapper
public interface MonthSalaryDAO {
	public ArrayList<MonthSalaryTO> selectYearSalary(String applyYear, String empCode); 
	public HashMap<String, Object> batchMonthSalaryProcess(String applyYearMonth, String empCode);
	public void updateMonthSalary(MonthSalaryTO monthSalary); 
}
