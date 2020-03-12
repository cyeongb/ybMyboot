package com.google.ybMyboot.hr.salary.to;

import com.google.ybMyboot.base.to.BaseTO;

import lombok.Data;
import lombok.EqualsAndHashCode;


@Data
@EqualsAndHashCode(callSuper = false)
public class BaseSalaryTO extends BaseTO {
	private String positionCode, position, baseSalary,	hobongRatio;
		
}
