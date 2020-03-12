package com.google.ybMyboot.hr.emp.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.google.ybMyboot.hr.emp.to.CareerInfoTO;

@Mapper
public interface CareerInfoDAO {
	public ArrayList<CareerInfoTO> selectCareerList(String code);

	public void insertCareerInfo(CareerInfoTO careerInfo);
	public void updateCareerInfo(CareerInfoTO careerInfo);
	public void deleteCareerInfo(CareerInfoTO careerInfo);
}

