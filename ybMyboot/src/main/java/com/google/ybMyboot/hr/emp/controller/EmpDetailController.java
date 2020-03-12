package com.google.ybMyboot.hr.emp.controller;

import java.util.ArrayList;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.google.ybMyboot.hr.emp.sf.EmpServiceFacade;
import com.google.ybMyboot.hr.emp.to.CareerInfoTO;
import com.google.ybMyboot.hr.emp.to.EducationInfoTO;
import com.google.ybMyboot.hr.emp.to.EmpTO;
import com.google.ybMyboot.hr.emp.to.FamilyInfoTO;
import com.google.ybMyboot.hr.emp.to.LicenseInfoTO;
import com.google.ybMyboot.hr.emp.to.WorkInfoTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@RequestMapping("/emp/empDetail")
@RestController
public class EmpDetailController  {	
	
	@Autowired
	private EmpServiceFacade empServiceFacade;
	
	@GetMapping
	public ModelAndView findAllEmployeeInfo(@RequestParam("empCode")String empCode,ModelMap modelMap,ModelAndView modelAndView){
		if(log.isDebugEnabled()) {
			log.debug("findAllEmployeeInfo - 시작");
			}
			EmpTO empTO=empServiceFacade.findAllEmpInfo(empCode);
			modelMap.put("empBean", empTO); 
			WorkInfoTO workInfoTO = new WorkInfoTO();
			CareerInfoTO careerInfoTO = new CareerInfoTO();
			EducationInfoTO educationInfoTO = new EducationInfoTO();
			LicenseInfoTO licenseInfoTO = new LicenseInfoTO();			
			FamilyInfoTO familyInfoTO = new FamilyInfoTO();
			
			modelMap.put("emptyFamilyInfoBean",familyInfoTO );
			modelMap.put("emptyCareerInfoBean", careerInfoTO);
			modelMap.put("emptyEducationInfoBean", educationInfoTO);
			modelMap.put("emptyLicenseInfoBean", licenseInfoTO);
			modelMap.put("emptyWorkInfoBean", workInfoTO);
			modelMap.put("errorMsg","success");
			modelMap.put("errorCode", 0);
		
		modelAndView = new ModelAndView("jsonView", modelMap);
		return modelAndView;
	}
	
	@PutMapping
	public void modifyEmployee(@RequestParam("sendData")String sendData){
		if(log.isDebugEnabled()) {
			log.debug("modifyEmployee - 시작");
			}
			Gson gson = new Gson();
			EmpTO emp = gson.fromJson(sendData, EmpTO.class);			
			empServiceFacade.modifyEmployee(emp);

	}
	
	@DeleteMapping
	public void removeEmployeeList(@RequestParam("sendData")String sendData){
		if(log.isDebugEnabled()) {
			log.debug("removeEmployeeList - 시작");
			}
			
			Gson gson = new Gson();
			ArrayList<EmpTO> empList = gson.fromJson(sendData, new TypeToken<ArrayList<EmpTO>>(){}.getType());
			empServiceFacade.deleteEmpList(empList);
			
	}
	
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		log.error(e);
		log.error(e.getMessage());
		return "error:" + e;
	}
}
