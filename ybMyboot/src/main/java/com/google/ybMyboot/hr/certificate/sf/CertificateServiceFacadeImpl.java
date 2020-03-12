package com.google.ybMyboot.hr.certificate.sf;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.google.ybMyboot.hr.certificate.applicationService.CertificateApplicationService;
import com.google.ybMyboot.hr.certificate.to.CertificateTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class CertificateServiceFacadeImpl implements CertificateServiceFacade{

	@Autowired
	private CertificateApplicationService certificateApplicationService;
	
	
	@Override
	public void registRequest(CertificateTO certificate) {
		if(log.isDebugEnabled()) {
			log.debug("registRequest - 시작");
			}

		certificateApplicationService.registRequest(certificate);
				
	}
	@Override
	public ArrayList<CertificateTO> findCertificateList(String empCode, String startDate, String endDate) {
		if(log.isDebugEnabled()) {
			log.debug("findCertificateList - 시작");
			}
		
			ArrayList<CertificateTO> certificateList=certificateApplicationService.findCertificateList(empCode, startDate, endDate);
			return certificateList;
		
	}
	@Override
	public void removeCertificateRequest(ArrayList<CertificateTO> certificateList) {
		if(log.isDebugEnabled()) {
			log.debug("removeCertificateRequest - 시작");
			}
		certificateApplicationService.removeCertificateRequest(certificateList);
		
		
	}
	@Override
	public ArrayList<CertificateTO> findCertificateListByDept(String deptName, String startDate, String endDate) {
		if(log.isDebugEnabled()) {
			log.debug("findCertificateListByDept - 시작");
			}
		ArrayList<CertificateTO> certificateList=certificateApplicationService.findCertificateListByDept(deptName, startDate, endDate);
		return certificateList;
		
	}
	
	@Override
	public void modifyCertificateList(ArrayList<CertificateTO> certificateList) {
		if(log.isDebugEnabled()) {
			log.debug("modifyCertificateList - 시작");
			}
		certificateApplicationService.modifyCertificateList(certificateList);
		
	}	
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		log.error(e);
		log.error(e.getMessage());
		return "error:" + e;
	}
}
