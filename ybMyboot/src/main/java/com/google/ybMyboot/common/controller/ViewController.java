package com.google.ybMyboot.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ViewController {
   
   @RequestMapping("/{viewName}.html")
   public String view(@PathVariable String viewName) {
   
      return "/" + viewName;
   }
   
   @RequestMapping("/{pack}/{viewName}.html")
   public String packView(@PathVariable String pack, @PathVariable String viewName) {
      
      return "/" + pack + "/" + viewName;
      
   }

}
