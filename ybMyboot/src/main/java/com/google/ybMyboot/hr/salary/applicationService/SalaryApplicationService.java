package com.google.ybMyboot.hr.salary.applicationService;

import java.util.ArrayList;

import com.google.ybMyboot.hr.salary.to.BaseDeductionTO;
import com.google.ybMyboot.hr.salary.to.BaseExtSalTO;
import com.google.ybMyboot.hr.salary.to.BaseSalaryTO;
import com.google.ybMyboot.hr.salary.to.MonthSalaryTO;

public interface SalaryApplicationService {
	
	public ArrayList<BaseSalaryTO> findBaseSalaryList();
	public void modifyBaseSalaryList(ArrayList<BaseSalaryTO> baseSalaryList);

	public ArrayList<BaseDeductionTO> findBaseDeductionList();
	public void batchBaseDeductionProcess(ArrayList<BaseDeductionTO> baseDeductionList);

	public ArrayList<BaseExtSalTO> findBaseExtSalList();
	public void modifyBaseExtSalList(ArrayList<BaseExtSalTO> baseExtSalList);

	public MonthSalaryTO findMonthSalary(String applyYearMonth, String empCode);
	public ArrayList<MonthSalaryTO> findYearSalary(String applyYear, String empCode);
	public void modifyMonthSalary(MonthSalaryTO monthSalary);
	
}
