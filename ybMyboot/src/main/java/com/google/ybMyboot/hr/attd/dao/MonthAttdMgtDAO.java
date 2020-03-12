package com.google.ybMyboot.hr.attd.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.google.ybMyboot.hr.attd.to.MonthAttdMgtTO;

@Mapper
public interface MonthAttdMgtDAO {
	public HashMap<String, Object> batchMonthAttdMgtProcess(String applyYearMonth);
	public void updateMonthAttdMgtList(MonthAttdMgtTO monthAttdMgt);
}
