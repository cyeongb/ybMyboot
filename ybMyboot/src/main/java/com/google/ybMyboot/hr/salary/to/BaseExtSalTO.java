package com.google.ybMyboot.hr.salary.to;

import com.google.ybMyboot.base.to.BaseTO;

import lombok.Data;
import lombok.EqualsAndHashCode;


@Data
@EqualsAndHashCode(callSuper = false)
public class BaseExtSalTO  extends BaseTO{
	private String extSalCode,
	extSalName,
	ratio;
}
