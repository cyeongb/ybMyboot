package com.google.ybMyboot.hr.certificate.applicationService;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.google.ybMyboot.hr.certificate.dao.CertificateDAO;
import com.google.ybMyboot.hr.certificate.to.CertificateTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Component
public class CertificateApplicatonServiceImpl implements CertificateApplicationService{

	@Autowired
	private CertificateDAO certificateDAO ;

	@Override
	public void registRequest(CertificateTO certificate) {		
		if(log.isDebugEnabled()) {
			log.debug("registRequest - 시작");
			}
		certificateDAO.insertCertificateRequest(certificate);
	}
	@Override
	public ArrayList<CertificateTO> findCertificateList(String empCode, String startDate, String endDate) {
		if(log.isDebugEnabled()) {
			log.debug("findCertificateList - 시작");
			}		
		ArrayList<CertificateTO> certificateList=certificateDAO.selectCertificateList(empCode, startDate, endDate);
				return certificateList;
	}
	@Override
	public void removeCertificateRequest(ArrayList<CertificateTO> certificateList) {
		if(log.isDebugEnabled()) {
			log.debug("removeCertificateRequest - 시작");
			}
		for(CertificateTO certificate : certificateList) {
			certificateDAO.deleteCertificate(certificate);
		}
	}
	@Override
	public ArrayList<CertificateTO> findCertificateListByDept(String deptName, String startDate, String endDate) {
		if(log.isDebugEnabled()) {
			log.debug("findCertificateListByDept - 시작");
			}
		ArrayList<CertificateTO> certificateList = null;
		
		if(deptName.equals("모든부서")) {
			certificateList = certificateDAO.selectCertificateListByAllDept(startDate);
		}else {
			certificateList = certificateDAO.selectCertificateListByDept(deptName, startDate, endDate);
		}
		return certificateList;
	}
	@Override
	public void modifyCertificateList(ArrayList<CertificateTO> certificateList) {
		if(log.isDebugEnabled()) {
			log.debug("modifyCertificateList - 시작");
			}
		for(CertificateTO certificate : certificateList) {
			
			if(certificate.getStatus().equals("update")) {
				certificateDAO.updateCertificate(certificate);
			}
		}
		
	}
	
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		log.error(e);
		log.error(e.getMessage());
		return "error:" + e;
	}

}
