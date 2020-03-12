package com.google.ybMyboot.hr.certificate.sf;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.google.ybMyboot.hr.certificate.to.CertificateTO;

@Service
public interface CertificateServiceFacade {
	
	public void registRequest(CertificateTO certificate);	
	public ArrayList<CertificateTO> findCertificateList(String empCode, String startDate, String endDate);
	public void removeCertificateRequest(ArrayList<CertificateTO> certificateList);
	public ArrayList<CertificateTO> findCertificateListByDept(String deptName, String startDate, String endDate);
	public void modifyCertificateList(ArrayList<CertificateTO> certificateList);
	
}
