package com.google.ybMyboot.hr.emp.to;

import java.util.ArrayList;

import com.google.ybMyboot.base.to.BaseTO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class EmpTO extends BaseTO{
	private String empCode,empName,birthdate,gender,mobileNumber,address,
	detailAddress,postNumber,email,lastSchool,imgExtend,position,deptName;
	

	private ArrayList<WorkInfoTO> workInfoList;
	private ArrayList<CareerInfoTO> careerInfoList;
	private ArrayList<EducationInfoTO> educationInfoList;
	private ArrayList<FamilyInfoTO> familyInfoList;
	private ArrayList<LicenseInfoTO> licenseInfoList;



}
