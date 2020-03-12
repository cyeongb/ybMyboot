package com.google.ybMyboot.hr.attd.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.google.ybMyboot.common.to.ResultTO;
import com.google.ybMyboot.hr.attd.to.DayAttdTO;

@Mapper
public interface DayAttdDAO {
	public ArrayList<DayAttdTO> selectDayAttdList(String empCode, String applyDay);

	public ResultTO batchInsertDayAttd(DayAttdTO dayAttd);
	
	public void insertDayAttd(DayAttdTO dayAttd);
	public void deleteDayAttd(DayAttdTO dayAttd);
}
