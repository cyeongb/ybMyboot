package com.google.ybMyboot.hr.salary.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.google.ybMyboot.hr.salary.to.BaseSalaryTO;
@Mapper
public interface BaseSalaryDAO {
	public ArrayList<BaseSalaryTO> selectBaseSalaryList();
	public void updateBaseSalary(BaseSalaryTO baseSalary);
	public void updatePosition(BaseSalaryTO position);
	public void insertPosition(BaseSalaryTO position);
	public void deletePosition(BaseSalaryTO position);
}
