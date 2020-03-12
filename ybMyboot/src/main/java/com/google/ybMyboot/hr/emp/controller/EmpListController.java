package com.google.ybMyboot.hr.emp.controller;

import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.google.ybMyboot.hr.emp.sf.EmpServiceFacade;
import com.google.ybMyboot.hr.emp.to.EmpTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@RequestMapping("/emp/list")
@RestController
public class EmpListController  {
	@Autowired
	private EmpServiceFacade empServiceFacade;

	@GetMapping
	public Model emplist(@RequestParam("value")String value,ModelMap modelMap) {

	
			ArrayList<EmpTO> list = (ArrayList<EmpTO>) empServiceFacade.findEmpList(value);			
			
			modelMap.put("list", list);
			return (Model) modelMap;
	}
	
	/*public ModelAndView workInfoList(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<String, Object>();
		String viewName = null;
		try {
			String code = request.getParameter("code");

			EmpServiceFacadeImpl sf = EmpServiceFacadeImpl.getInstance();

			ListForm listForm = new ListForm();

			
			ArrayList<EmpTO> list = sf.workInfoList(code);
			map.put("list", list);

			JSONObject jsonobject = JSONObject.fromObject(map);
			PrintWriter out = response.getWriter();
			out.println(jsonobject);
			System.out.println(jsonobject);
		} catch (Exception e) {
			viewName = "error";
			map.put("errorCode", -1);
			map.put("errorMsg", e.getMessage());
			JSONObject jsonobject = JSONObject.fromObject(map);
			try {
				PrintWriter out = response.getWriter();
				out.println(jsonobject);
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		ModelAndView modelAndView = null;
		return null;
	} */
	
}