package com.google.ybMyboot.base.dao;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;
import com.google.ybMyboot.base.to.HolidayTO;
@Mapper
public interface HolidayDAO {
	public ArrayList<HolidayTO> selectHolidayList();
	String selectWeekDayCount(String startDate, String endDate);
	public void updateCodeList(HolidayTO holyday);
	public void insertCodeList(HolidayTO holyday);
	public void deleteCodeList(HolidayTO holyday);
}
