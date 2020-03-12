package com.google.ybMyboot.common.aop;


import org.springframework.aop.ThrowsAdvice;
import org.springframework.dao.DataAccessException;

public class DataAccessExceptionAdvice implements ThrowsAdvice {


    public void afterThrowing(DataAccessException ex) throws Throwable {
  
        throw ex;
    }

    public void afterThrowing(Exception ex) throws Throwable {
     
        throw ex;
    }
}
