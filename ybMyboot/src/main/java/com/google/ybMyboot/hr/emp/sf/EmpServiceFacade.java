package com.google.ybMyboot.hr.emp.sf;

import java.util.ArrayList;
import java.util.List;

import org.springframework.ui.Model;

import com.google.ybMyboot.base.to.DeptTO;
import com.google.ybMyboot.hr.emp.to.EmpTO;

public interface EmpServiceFacade {
	public EmpTO getEmp(String name); //selectEmp
	public String findLastEmpCode();
	public EmpTO findAllEmpInfo(String empCode);	
	public List<EmpTO> findEmpList(String dept); //findEmployeeListByDept
	public void registEmployee(EmpTO empto);
	public void modifyEmployee(EmpTO emp);
	public void deleteEmpList(ArrayList<EmpTO> empList);
	public ArrayList<DeptTO> findDeptList();
	
}
