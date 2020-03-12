package com.google.ybMyboot.hr.emp.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.google.ybMyboot.hr.emp.to.LicenseInfoTO;
@Mapper
public interface LicenseInfoDAO {
	public ArrayList<LicenseInfoTO> selectLicenseList(String empCode);
	public void insertLicenseInfo(LicenseInfoTO licenscInfo);
	public void updateLicenseInfo(LicenseInfoTO licenscInfo);
	public void deleteLicenseInfo(LicenseInfoTO licenscInfo);
}
