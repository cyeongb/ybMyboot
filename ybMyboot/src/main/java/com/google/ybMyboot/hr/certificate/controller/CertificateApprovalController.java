package com.google.ybMyboot.hr.certificate.controller;

import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.google.ybMyboot.hr.certificate.sf.CertificateServiceFacade;
import com.google.ybMyboot.hr.certificate.to.CertificateTO;
import lombok.extern.log4j.Log4j2;



@RestController
@Log4j2
@RequestMapping("/certificate/certificateApproval")
public class CertificateApprovalController{
	@Autowired
	private CertificateServiceFacade certificateServiceFacade;

	@GetMapping
	public ModelAndView findCertificateListByDept(@RequestParam("deptName")String deptName,@RequestParam("startDate")String startDate
			,@RequestParam("endDate")String endDate,ModelMap modelMap,ModelAndView modelAndView) {
		if(log.isDebugEnabled()) {
			log.debug("findCertificateListByDept - 시작");
			}
			ArrayList<CertificateTO> certificateList = certificateServiceFacade.findCertificateListByDept(deptName, startDate, endDate);
			modelMap.put("certificateList", certificateList);
	
		modelAndView = new ModelAndView("jsonView", modelMap);
		return modelAndView;
	}
	
	@PutMapping
	public void modifyCertificateList(@RequestParam("sendData")String sendData,
			ModelAndView modelAndView) {
		if(log.isDebugEnabled()) {
			log.debug("modifyCertificateList - 시작");
			}
			Gson gson = new Gson();
			ArrayList<CertificateTO> certificateList = gson.fromJson(sendData, new TypeToken<ArrayList<CertificateTO>>(){}.getType());
			certificateServiceFacade.modifyCertificateList(certificateList);
			
		
	}
	
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		log.error(e);
		log.error(e.getMessage());
		return "error:" + e;
	}
}
