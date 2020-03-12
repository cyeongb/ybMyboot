package com.google.ybMyboot;

import javax.servlet.Filter;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import com.google.ybMyboot.common.filter.MySiteMeshFilter;

import lombok.extern.log4j.Log4j2;

@Log4j2
//@Configuration
//@ComponentScan
//@EnableAutoConfiguration
@SpringBootApplication
public class ybMybootApplication {

	public static void main(String[] args) {
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		log.info(">>>>>>>>>>>> ybMyboot start >>>>>>>>>>>>>>>>>>>");
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		  if(log.isDebugEnabled()) {
			  log.debug("main  run ~~~~");
			  }
		SpringApplication.run(ybMybootApplication.class, args);
	}
	
	@Bean
	public FilterRegistrationBean<Filter> siteMeshFilter() {
	    FilterRegistrationBean<Filter> filter = new FilterRegistrationBean<>();
	      filter.setFilter(new MySiteMeshFilter());
	      return filter;
	}

}
