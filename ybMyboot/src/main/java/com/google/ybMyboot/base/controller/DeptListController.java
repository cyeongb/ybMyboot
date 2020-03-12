package com.google.ybMyboot.base.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.google.ybMyboot.base.sf.BaseServiceFacade;
import com.google.ybMyboot.base.to.DeptTO;
import com.google.ybMyboot.hr.emp.sf.EmpServiceFacade;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/base/deptList")   // +.do??
@RestController
public class DeptListController {
	@Autowired
	private BaseServiceFacade baseServiceFacade;

	@Autowired
	private EmpServiceFacade empServiceFacade;

	// 프로시저 ~~~~~~~~~~~~~~~~~~~~~~~~~
	//
	@PutMapping
	public void batchDeptProcess(@RequestParam("sendData") String sendData)
			throws JsonParseException, JsonMappingException, IOException {
		ObjectMapper mapper = new ObjectMapper();
		ArrayList<DeptTO> deptto = null;
		deptto = mapper.readValue(sendData, new TypeReference<ArrayList<DeptTO>>() {
		});
		baseServiceFacade.batchDeptProcess(deptto);

//		Gson gson = new Gson();
//		ArrayList<DeptTO> deptto = gson.fromJson(sendData, new TypeToken<ArrayList<DeptTO>>() {
//		}.getType());
//		log.info("sendData",sendData);
//	 baseServiceFacade.batchDeptProcess(deptto);

	}

	@GetMapping
	public ModelMap findDeptList(ModelMap modelMap) {
		DeptTO emptyBean = new DeptTO();
		List<DeptTO> list=empServiceFacade.findDeptList();
		 modelMap.put("emptyBean", emptyBean);
		 modelMap.put("list", list);
		 return modelMap;
	}

	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		System.out.println(e);
		return "error:" + e;
	}

}
