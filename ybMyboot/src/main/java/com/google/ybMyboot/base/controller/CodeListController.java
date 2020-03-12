package com.google.ybMyboot.base.controller;

import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.google.ybMyboot.base.sf.BaseServiceFacade;
import com.google.ybMyboot.base.to.CodeTO;
import com.google.ybMyboot.base.to.DetailCodeTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@RestController
@RequestMapping("/base")
public class CodeListController {

	@Autowired // 스프링 4.3 이상부터는 이 어노테이션을 생략할 수 있다.
	private BaseServiceFacade baseServiceFacade;

	@GetMapping("/detailCodeList")
	public ArrayList<DetailCodeTO> detailCodelist(@RequestParam("code") String code, Model model) {
		if(log.isDebugEnabled()) {
			log.debug("detailCodelist - 시작");
			
		}
		return baseServiceFacade.findDetailCodeList(code);

	}

	@GetMapping("/detailCodeListRest")  //--> codeWindow.jsp 에 type 선언 없음
	public ArrayList<DetailCodeTO> detailCodelistRest(@RequestParam("code1") String code1,
			@RequestParam("code2") String code2, @RequestParam("code3") String code3, Model model) {
		if(log.isDebugEnabled()) {
			log.debug("detailCodelistRest - 시작");
		}
		return baseServiceFacade.findDetailCodeListRest(code1, code2, code3);
	}
	
	@GetMapping("/codeList")
	public ArrayList<CodeTO> codelist(Model model) {
		if(log.isDebugEnabled()) {
			log.debug("codelist - 시작");
		}
		return baseServiceFacade.findCodeList();
	}
	

	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		System.out.println(e);
		return "error:" + e;
	}

}
