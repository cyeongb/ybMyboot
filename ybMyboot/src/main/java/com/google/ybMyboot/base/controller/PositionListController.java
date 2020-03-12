package com.google.ybMyboot.base.controller;

import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.google.ybMyboot.base.sf.BaseServiceFacade;
import com.google.ybMyboot.hr.salary.to.BaseSalaryTO;

@RequestMapping("/base/positionList")
@RestController
public class PositionListController {
	@Autowired
	BaseServiceFacade baseServiceFacade;


	public ModelMap findPositionList(ModelMap modelMap,ModelAndView modelAndView) {

	
			ArrayList<BaseSalaryTO> positionList = baseServiceFacade.findPositionList();
			BaseSalaryTO positionTO = new BaseSalaryTO();

			modelMap.put("positionList", positionList);
			modelMap.put("emptyPositionBean", positionTO);

		    return modelMap;
	}

	public ModelAndView modifyPosition(@RequestParam("sendData")String sendData,ModelAndView modelAndView,ModelMap modelMap) {
	
			Gson gson = new Gson();
			ArrayList<BaseSalaryTO> positionList = gson.fromJson(sendData, new TypeToken<ArrayList<BaseSalaryTO>>() {
			}.getType());

			baseServiceFacade.modifyPosition(positionList);
		

		modelAndView = new ModelAndView("jsonView", modelMap);
		return modelAndView;
	}

}
