package com.google.ybMyboot.hr.salary.to;

import java.util.ArrayList;

import lombok.Data;
import lombok.EqualsAndHashCode;


@Data
@EqualsAndHashCode(callSuper = false)
public class MonthSalaryTO {
	private String empCode,applyYearMonth,salary,totalExtSal,totalPayment,totalDeduction,realSalary,cost,unusedDaySalary,finalizeStatus;
	private ArrayList<MonthDeductionTO> monthDeductionList;
	private ArrayList<MonthExtSalTO> monthExtSalList;
	
}
