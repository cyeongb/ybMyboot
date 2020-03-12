package com.google.ybMyboot.hr.attd.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.ui.ModelMap;

import com.google.ybMyboot.hr.attd.to.DayAttdMgtTO;
@Mapper
public interface DayAttdMgtDAO {
	public HashMap<String, Object> batchDayAttdMgtProcess(String applyDay , String dept);
	public ModelMap updateDayAttdMgtList(DayAttdMgtTO dayAttdMgt);
}
