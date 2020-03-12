package com.google.ybMyboot.hr.emp.controller;


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
import com.google.ybMyboot.hr.emp.sf.EmpServiceFacade;
import com.google.ybMyboot.hr.emp.to.EmpTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@RestController
@RequestMapping("/emp/empRegist")
public class EmpRegistController {
	@Autowired
	private EmpServiceFacade empServiceFacade;	

	@PutMapping
	public ModelAndView registEmployee(@RequestParam("sendData")String sendData,ModelMap modelMap,ModelAndView modelAndView) {
		if(log.isDebugEnabled()) {
			log.debug("registEmployee - 시작");
			}
			Gson gson = new Gson();
			EmpTO emp = gson.fromJson(sendData, new TypeToken<EmpTO>(){}.getType());		
			empServiceFacade.registEmployee(emp);		

			modelMap.put("errorMsg","request.getParameter(\"emp_name\")+\" 사원이 등록되었습니다.\"");
			modelMap.put("errorCode", 0);

		modelAndView = new ModelAndView("jsonView", modelMap);
		return modelAndView;
	}
	
	@GetMapping
	public ModelAndView findLastEmpCode(ModelMap modelMap,ModelAndView modelAndView){
		if(log.isDebugEnabled()) {
			log.debug("findLastEmpCode - 시작");
			}
	
			String empCode = empServiceFacade.findLastEmpCode();
			modelMap.put("lastEmpCode", empCode);
			modelMap.put("errorMsg","success");
			modelMap.put("errorCode", 0);

		modelAndView = new ModelAndView("jsonView", modelMap);
		return modelAndView;
	}
	
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		log.error(e);
		log.error(e.getMessage());
		return "error:" + e;
	}
	
}
