package com.google.ybMyboot.base.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
@RequestMapping("/logout")  //.do?
public class EmpLogoutController {

	public ModelAndView empLogout(HttpServletRequest request,HttpSession session,ModelMap modelMap) {
		String viewName="redirect:main.html";
        request.getSession().invalidate();
		ModelAndView modelAndView=new ModelAndView(viewName,modelMap);
		return modelAndView;
	}
	
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		log.debug(e);
		return "error:" + e;
	}
	
	
}
