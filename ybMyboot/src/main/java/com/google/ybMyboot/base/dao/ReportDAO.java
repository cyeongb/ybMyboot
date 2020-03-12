package com.google.ybMyboot.base.dao;

import org.apache.ibatis.annotations.Mapper;
import com.google.ybMyboot.base.to.ReportTO;
@Mapper
public interface ReportDAO {
	public ReportTO selectReport(String empCode);
	}