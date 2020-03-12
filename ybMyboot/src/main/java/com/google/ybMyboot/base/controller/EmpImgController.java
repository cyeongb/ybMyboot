package com.google.ybMyboot.base.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.google.ybMyboot.base.sf.BaseServiceFacade;
import com.google.ybMyboot.common.util.FileUploadUtil;

import lombok.extern.log4j.Log4j2;
import lombok.extern.slf4j.Slf4j;

@Log4j2
@RestController
@RequestMapping("base/empImg")   //.do?
public class EmpImgController  {
	@Autowired
	private BaseServiceFacade baseServiceFacade;



	public ModelAndView handleRequestInternal(@SessionAttribute("newcheck")String check ,ModelMap modelMap,HttpServletRequest request,ModelAndView modelAndView) throws FileNotFoundException, IOException, FileUploadException {
		
		//org.apache.tomcat.util.http.fileupload package : 인코딩타입 - 'multipart/form-data'
		  DiskFileItemFactory factory = new DiskFileItemFactory(); //디스크에 있는 파일 읽어오는 class
	        ServletFileUpload upload = new ServletFileUpload(factory); //읽어온파일 서버에 올리는 애
	        RequestContext rc = new ServletRequestContext(request);
        String empCode = null;
        String empImgUrl = null;
        int newCheck = 0;

   
        List<FileItem> items = upload.parseRequest(rc);
	        for (FileItem fileItem : items){
	        	if(fileItem.isFormField()){
	        		if("empCode".equals(fileItem.getFieldName())){
	        			empCode = fileItem.getString();
	        			log.info("empcode:"+empCode);
	    
	        		}
	        		if("newcheck".equals(fileItem.getFieldName())){
	        			check = fileItem.getString();
	        			log.info("check:"+check);

	        		}
	        	} else {
	        		if((fileItem.getName() != null) && (fileItem.getSize() > 0)){
	        			empImgUrl = FileUploadUtil.doFileUpload(request, fileItem, empCode);
	        			log.info("empImgUrl:"+empImgUrl);
	      
	        		}
	        	}
	        }
	        
	        if("1".equals(check)) {
	        	newCheck = 1;
	        }

	        if(newCheck == 0) {
	        	modelMap.put("empImgUrl", empImgUrl);
	            baseServiceFacade.registEmpImg(empCode, empImgUrl.substring(empImgUrl.lastIndexOf(".")+1));
	        }       
	        modelAndView = new ModelAndView("jsonView", modelMap);
			return modelAndView;
	        
	}
	
	@ExceptionHandler(Exception.class)
	public Object exeption(Exception e) {
		System.out.println(e);
		return "error:" + e;
	}
}