package com.google.ybMyboot.hr.attd.to;

import com.google.ybMyboot.base.to.BaseTO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class DayAttdMgtTO extends BaseTO{
	private String empCode;
	private String empName;
	private String applyDays; 
	private String dayAttdCode;
	private String dayAttdName;
	private String attendTime;
	private String HalfHolidayStatus;
	private String quitTime;
	private String lateWhether;
	private String leaveHour;
	private String workHour;
	private String earlyLeaveHour;
	private String overWorkHour;
	private String nightWorkHour;
	private String finalizeStatus;
	private String privateLeaveHour;
	private String publicLeaveHour;


}

