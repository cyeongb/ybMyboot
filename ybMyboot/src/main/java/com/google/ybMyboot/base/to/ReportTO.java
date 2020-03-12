package com.google.ybMyboot.base.to;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class ReportTO {
	private String empCode;
	private String empName;
	private String hiredate;
	private String occupation;
	private String employmentType;
	private String position;
	private String address;
	private String detailAddress;
	private String deptName;

	
}
