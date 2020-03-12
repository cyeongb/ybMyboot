package com.google.ybMyboot.base.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.google.ybMyboot.base.sf.BaseServiceFacade;
import com.google.ybMyboot.hr.emp.sf.EmpServiceFacade;
import com.google.ybMyboot.hr.emp.to.EmpTO;

import lombok.extern.log4j.Log4j2;


@Log4j2
@RestController
@RequestMapping("/login")
public class EmpLoginController {
	@Autowired
	private BaseServiceFacade baseServiceFacade;
	@Autowired
	private EmpServiceFacade empServiceFacade;


	public ModelMap empLogin(@RequestParam("name") String name, @RequestParam("empCode") String empCode,
			@SessionAttribute("dept")String dept,@SessionAttribute("position")String position,
			@SessionAttribute("code")String code,ModelMap modelMap) throws Exception{
		if(log.isDebugEnabled()) {
			log.debug("empLogin - 시작");
		}
		EmpTO empto=new EmpTO();
		empto = (EmpTO) empServiceFacade.getEmp(name);
		modelMap.put("me", "enter");   //이게뭘까?????????
		return modelMap;
		

	}
}
