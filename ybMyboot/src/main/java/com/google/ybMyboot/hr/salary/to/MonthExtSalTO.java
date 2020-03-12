package com.google.ybMyboot.hr.salary.to;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class MonthExtSalTO {
	private String monthExtSalCode,
	applyYearMonth,
	empCode,
	extSalCode,
	extSalName,
	price;

}
