package com.google.ybMyboot.hr.emp.to;

import com.google.ybMyboot.base.to.BaseTO;

import lombok.Data;
import lombok.EqualsAndHashCode;


@Data
@EqualsAndHashCode(callSuper = false)
public class WorkInfoTO extends BaseTO{
	private String empCode, workInfoDays, hiredate, retireDate, 
	occupation, employmentType, hobong, position, deptName;

}
