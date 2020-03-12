package com.google.ybMyboot.hr.emp.applicationService;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.google.ybMyboot.base.to.DeptTO;
import com.google.ybMyboot.hr.emp.to.EmpTO;
import com.google.ybMyboot.hr.salary.to.BaseSalaryTO;

@Service
public interface EmpApplicationService {
	public EmpTO selectEmp(String name);
	public String findLastEmpCode();
	public EmpTO findAllEmployeeInfo(String empCode);
	public ArrayList<EmpTO> findEmployeeListByDept(String deptName);
	public void registEmployee(EmpTO emp);
	public void modifyEmployee(EmpTO emp);
	public void deleteEmpList(ArrayList<EmpTO> empList);
	public ArrayList<DeptTO> findDeptList();	
	public ArrayList<BaseSalaryTO> selectPositionList();
}

