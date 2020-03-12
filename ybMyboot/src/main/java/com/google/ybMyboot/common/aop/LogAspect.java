package com.google.ybMyboot.common.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import com.google.ybMyboot.common.aop.LogAspect;

import lombok.extern.log4j.Log4j2;


@Component
@Aspect
@Log4j2
public class LogAspect {
    // Logger logger =  LoggerFactory.getLogger(LogAspect.class);
    
    //Service의 모든 메서드
	@Around("execution(* com.google.ybMyboot..controller.*Controller.*(..)) "
			+ "or execution(* com.google.ybMyboot..*Service.*Impl.*(..)) "
			+ "or execution(* com.google.ybMyboot..dao.*DAO.*(..))")  
	public Object logPrint(ProceedingJoinPoint joinPoint) throws Throwable {
		String type = "";
		String name = joinPoint.getSignature().getDeclaringTypeName();
		if (name.indexOf("Controller") > -1) {
			type = "Controller  \t:  ";
		}
		else if (name.indexOf("Service") > -1) {
			type = "ServiceImpl  \t:  ";
		}
		else if (name.indexOf("Mapper") > -1) {
			type = "Mapper  \t\t:  ";
		}
		log.debug(type + name + "." + joinPoint.getSignature().getName() + "()");
		return joinPoint.proceed();
	
	}
 
}
