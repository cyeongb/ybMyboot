package com.google.ybMyboot.hr.emp.applicationService;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.google.ybMyboot.base.applicationService.BaseApplicationService;
import com.google.ybMyboot.base.dao.DeptDAO;
import com.google.ybMyboot.base.to.DeptTO;
import com.google.ybMyboot.hr.emp.dao.CareerInfoDAO;
import com.google.ybMyboot.hr.emp.dao.EducationInfoDAO;
import com.google.ybMyboot.hr.emp.dao.EmpDAO;
import com.google.ybMyboot.hr.emp.dao.FamilyInfoDAO;
import com.google.ybMyboot.hr.emp.dao.LicenseInfoDAO;
import com.google.ybMyboot.hr.emp.dao.WorkInfoDAO;
import com.google.ybMyboot.hr.emp.to.CareerInfoTO;
import com.google.ybMyboot.hr.emp.to.EducationInfoTO;
import com.google.ybMyboot.hr.emp.to.EmpTO;
import com.google.ybMyboot.hr.emp.to.FamilyInfoTO;
import com.google.ybMyboot.hr.emp.to.LicenseInfoTO;
import com.google.ybMyboot.hr.emp.to.WorkInfoTO;
import com.google.ybMyboot.hr.salary.applicationService.SalaryApplicationService;
import com.google.ybMyboot.hr.salary.to.BaseSalaryTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Component
//@Repository
public class EmpApplicationServiceImpl implements EmpApplicationService {
	@Autowired
	SalaryApplicationService salaryApplicationService;
	@Autowired
	BaseApplicationService baseApplicationService;	
	@Autowired
	private EmpDAO empDAO ;
	@Autowired
	private WorkInfoDAO workInfoDAO ;
	@Autowired
	private CareerInfoDAO careerInfoDAO ;
	@Autowired
	private EducationInfoDAO educationInfoDAO ;
	@Autowired
	private LicenseInfoDAO licenseInfoDAO ;
	@Autowired
	private FamilyInfoDAO familyInfoDAO ;
	@Autowired
	private DeptDAO deptDAO ;	
	
	@Override
	public EmpTO selectEmp(String name) {	
		if(log.isDebugEnabled()) {
			log.debug("selectEmp - 시작");
			}

		EmpTO empto = empDAO.selectEmp(name);		
		return empto;
	}
	@Override
	public String findLastEmpCode() {	
		if(log.isDebugEnabled()) {
			log.debug("findLastEmpCode - 시작");
			}
		String empCode = empDAO.selectLastEmpCode();		
		return empCode;
	}

	@Override
	public void registEmployee(EmpTO empto){	
		if(log.isDebugEnabled()) {
			log.debug("registEmployee - 시작");
			}
		empDAO.registEmployee(empto);
		baseApplicationService.registEmpCode(empto);			
	}

	@Override
	public ArrayList<EmpTO> findEmployeeListByDept(String deptName) {	
		if(log.isDebugEnabled()) {
			log.debug("findEmployeeListByDept - 시작");
			}
		ArrayList<EmpTO> empList = null;	
		
		if (deptName.equals("전체부서")) {
			empList = empDAO.selectEmpList();
		} else if (deptName.substring(deptName.length()-1, deptName.length()).equals("팀")) {
			empList = empDAO.selectEmpListD(deptName);
		} else {
			empList = empDAO.selectEmpListN(deptName);
		}		
		return empList;
	}

	@Override
	public EmpTO findAllEmployeeInfo(String empCode) {
		if(log.isDebugEnabled()) {
			log.debug("findAllEmployeeInfo - 시작");
			}
		EmpTO empTO = empDAO.selectEmployee(empCode);

		ArrayList<WorkInfoTO> workInfoList = workInfoDAO.selectWorkList(empCode);
		ArrayList<CareerInfoTO> careerInfoList = careerInfoDAO.selectCareerList(empCode);
		ArrayList<EducationInfoTO> educationInfoList = educationInfoDAO.selectEducationList(empCode);
		ArrayList<LicenseInfoTO> licenseInfoList = licenseInfoDAO.selectLicenseList(empCode);
		ArrayList<FamilyInfoTO> familyInfoList = familyInfoDAO.selectFamilyList(empCode);
		empTO.setWorkInfoList(workInfoList);
		empTO.setCareerInfoList(careerInfoList);
		empTO.setEducationInfoList(educationInfoList);
		empTO.setLicenseInfoList(licenseInfoList);
		empTO.setFamilyInfoList(familyInfoList);
		
		return empTO;
	}

	@Override
	public void modifyEmployee(EmpTO emp){
		if(log.isDebugEnabled()) {
			log.debug("modifyEmployee - 시작");
			}
		if (emp.getStatus().equals("update")) {
			empDAO.updateEmployee(emp);
		}
		
		if (emp.getWorkInfoList() != null) {
			ArrayList<WorkInfoTO> workInfoList = emp.getWorkInfoList();
			for (WorkInfoTO workInfo : workInfoList) {				
				switch (workInfo.getStatus()) {
				case "insert":
					workInfoDAO.insertWorkInfo(workInfo);
					break;
				case "update":
					workInfoDAO.updateWorkInfo(workInfo);
					break;
				case "delete":
					workInfoDAO.deleteWorkInfo(workInfo);
					break;
				}
			}
		}		
		
		if (emp.getCareerInfoList() != null && emp.getCareerInfoList().size() > 0) {
			ArrayList<CareerInfoTO> careerInfoList = emp.getCareerInfoList();
			for (CareerInfoTO careerInfo : careerInfoList) {
				switch (careerInfo.getStatus()) {
				case "insert":
					careerInfoDAO.insertCareerInfo(careerInfo);
					break;
				case "update":
					careerInfoDAO.updateCareerInfo(careerInfo);
					break;
				case "delete":
					careerInfoDAO.deleteCareerInfo(careerInfo);
					break;
				}
			}
		}		
		
		if (emp.getEducationInfoList() != null && emp.getEducationInfoList().size() > 0) {
			ArrayList<EducationInfoTO> educationInfoList = emp.getEducationInfoList();
			for (EducationInfoTO educationInfo : educationInfoList) {
				switch (educationInfo.getStatus()) {
				case "insert":
					educationInfoDAO.insertEducationInfo(educationInfo);
					break;
				case "update":
					educationInfoDAO.updateEducationInfo(educationInfo);
					break;
				case "delete":
					educationInfoDAO.deleteEducationInfo(educationInfo);
					break;
				}
			}
		}		
		
		if (emp.getLicenseInfoList() != null && emp.getLicenseInfoList().size() > 0) {
			ArrayList<LicenseInfoTO> licenseInfoList = emp.getLicenseInfoList();
			for (LicenseInfoTO licenseInfo : licenseInfoList) {
				switch (licenseInfo.getStatus()) {
				case "insert":
					licenseInfoDAO.insertLicenseInfo(licenseInfo);
					break;
				case "update":
					licenseInfoDAO.updateLicenseInfo(licenseInfo);
					break;
				case "delete":
					licenseInfoDAO.deleteLicenseInfo(licenseInfo);
					break;
				}
			}
		}		
		
		if (emp.getFamilyInfoList() != null && emp.getFamilyInfoList().size() > 0) {
			ArrayList<FamilyInfoTO> familyInfoList = emp.getFamilyInfoList();
			for (FamilyInfoTO familyInfo : familyInfoList) {
				switch (familyInfo.getStatus()) {
				case "insert":
					familyInfoDAO.insertFamilyInfo(familyInfo);
					break;
				case "update":
					familyInfoDAO.updateFamilyInfo(familyInfo);
					break;
				case "delete":
					familyInfoDAO.deleteFamilyInfo(familyInfo);
					break;
				}
			}
		}		
	}

	@Override
	public void deleteEmpList(ArrayList<EmpTO> empList){ 
		if(log.isDebugEnabled()) {
			log.debug("deleteEmpList - 시작");
			}
		for(EmpTO emp : empList){
			  empDAO.deleteEmployee(emp);
			  baseApplicationService.deleteEmpCode(emp);
		  }	
	}

	@Override
	public ArrayList<DeptTO> findDeptList(){
		if(log.isDebugEnabled()) {
			log.debug("findDeptList - 시작");
			}
		ArrayList<DeptTO> deptList = deptDAO.selectDeptList();		
		return deptList;
	}

	@Override
	public ArrayList<BaseSalaryTO> selectPositionList() {
		if(log.isDebugEnabled()) {
			log.debug("selectPositionList - 시작");
			}
		ArrayList<BaseSalaryTO> positionList = salaryApplicationService.findBaseSalaryList();
		return positionList;
	}
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		log.error(e);
		log.error(e.getMessage());
		return "error:" + e;
	}

}
