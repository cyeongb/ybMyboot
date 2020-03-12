package com.google.ybMyboot.hr.attd.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.google.ybMyboot.hr.attd.to.RestAttdTO;
@Mapper
public interface RestAttdDAO {
	public ArrayList<RestAttdTO> selectRestAttdListByToday(String empCode, String toDay);
	public ArrayList<RestAttdTO> selectRestAttdList(String empCode, String startDate, String endDate);
	public ArrayList<RestAttdTO> selectRestAttdListCode(String empCode, String startDate, String endDate, String code);
	public ArrayList<RestAttdTO> selectRestAttdListByDept(String deptName, String startDate, String endDate);
	public ArrayList<RestAttdTO> selectRestAttdListByAllDept(String applyDay);
	public void insertRestAttd(RestAttdTO restAttd);
	public void updateRestAttd(RestAttdTO restAttd);
	public void deleteRestAttd(RestAttdTO restAttd);
}
