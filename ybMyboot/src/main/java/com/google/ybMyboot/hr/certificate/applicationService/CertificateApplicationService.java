package com.google.ybMyboot.hr.certificate.applicationService;

import java.util.ArrayList;

import com.google.ybMyboot.hr.certificate.to.CertificateTO;

public interface CertificateApplicationService {
	public void registRequest(CertificateTO certificate);
	public void removeCertificateRequest(ArrayList<CertificateTO> certificateList);
	public void modifyCertificateList(ArrayList<CertificateTO> certificateList);
	public ArrayList<CertificateTO> findCertificateList(String empCode, String startDate,String endDate);
	public ArrayList<CertificateTO> findCertificateListByDept(String deptName, String startDate, String endDate);
}
