package com.google.ybMyboot.hr.certificate.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.google.ybMyboot.hr.certificate.to.CertificateTO;

@Mapper
public interface CertificateDAO {
	
	public void insertCertificateRequest(CertificateTO certificate);
	public ArrayList<CertificateTO>selectCertificateList(String empCode, String startDate, String endDate);
	public void deleteCertificate(CertificateTO certificate);
	public ArrayList<CertificateTO> selectCertificateListByAllDept(String requestDate);
	public ArrayList<CertificateTO> selectCertificateListByDept(String deptName, String startDate, String endDate);
	public void updateCertificate(CertificateTO certificate);
	
}

