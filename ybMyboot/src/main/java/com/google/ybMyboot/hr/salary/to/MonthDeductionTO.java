package com.google.ybMyboot.hr.salary.to;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class MonthDeductionTO {
	private String empCode, applyYearMonth, deductionCode, deductionName, price;

}

