package com.google.ybMyboot.hr.emp.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.google.ybMyboot.hr.emp.to.FamilyInfoTO;
@Mapper
public interface FamilyInfoDAO {
	public ArrayList<FamilyInfoTO> selectFamilyList(String empCode);
	public void insertFamilyInfo(FamilyInfoTO familyInfo);
	public void updateFamilyInfo(FamilyInfoTO familyInfo);
	public void deleteFamilyInfo(FamilyInfoTO familyInfo);
}
