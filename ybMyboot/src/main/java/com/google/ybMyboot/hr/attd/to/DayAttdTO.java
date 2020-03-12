package com.google.ybMyboot.hr.attd.to;

import com.google.ybMyboot.base.to.BaseTO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class DayAttdTO extends BaseTO{
	private String empCode;
	private String empName;
	private String dayAttdCode;
	private String applyDay;
	private String attdTypeCode;
	private String attdTypeName;
	private String time;

}

