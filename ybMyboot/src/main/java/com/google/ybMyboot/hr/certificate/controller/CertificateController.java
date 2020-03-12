package com.google.ybMyboot.hr.certificate.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.google.ybMyboot.hr.certificate.sf.CertificateServiceFacade;
import com.google.ybMyboot.hr.certificate.to.CertificateTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@RestController
@RequestMapping("/certificate/certificate")
public class CertificateController {
	@Autowired
	private CertificateServiceFacade certificateServiceFacade;

	@PostMapping
	public void registRequest(@RequestParam("sendData") String sendData) {
		if (log.isDebugEnabled()) {
			log.debug("registRequest - 시작");
		}
		Gson gson = new Gson();
		CertificateTO certificate = gson.fromJson(sendData, CertificateTO.class);
		certificateServiceFacade.registRequest(certificate);

	}

	@GetMapping
	public ModelAndView findCertificateList(@RequestParam("empCode") String empCode,
			@RequestParam("startDate") String startDate, @RequestParam("endDate") String endDate, ModelMap modelMap,
			ModelAndView modelAndView) {
		if (log.isDebugEnabled()) {
			log.debug("findCertificateList - 시작");
		}
		ArrayList<CertificateTO> certificateList = certificateServiceFacade.findCertificateList(empCode, startDate,
				endDate);
		modelMap.put("certificateList", certificateList);
		modelAndView = new ModelAndView("jsonView", modelMap);
		return modelAndView;
	}

	@DeleteMapping
	public void removeCertificateRequest(@RequestParam("sendData") String sendData) {
		if (log.isDebugEnabled()) {
			log.debug("removeCertificateRequest - 시작");
		}
		Gson gson = new Gson();
		ArrayList<CertificateTO> certificateList = gson.fromJson(sendData, new TypeToken<ArrayList<CertificateTO>>() {
		}.getType());
		certificateServiceFacade.removeCertificateRequest(certificateList);

	}

	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		log.error(e);
		log.error(e.getMessage());
		return "error:" + e;
	}

}