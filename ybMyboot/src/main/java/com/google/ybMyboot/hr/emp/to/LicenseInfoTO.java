package com.google.ybMyboot.hr.emp.to;

import com.google.ybMyboot.base.to.BaseTO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class LicenseInfoTO extends BaseTO{
	private String empCode, licenseCode,licenseName, getDate, expireDate, licenseLevel, licenseCenter, issueNumber;

	
}
