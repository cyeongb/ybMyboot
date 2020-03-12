package com.google.ybMyboot.hr.certificate.to;

import com.google.ybMyboot.base.to.BaseTO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class CertificateTO extends BaseTO {
	private String empCode, empName, deptName, requestDate, useDate, usageCode, 
	usageName, etc, approvalStatus, rejectCause;	
	 
	


}

