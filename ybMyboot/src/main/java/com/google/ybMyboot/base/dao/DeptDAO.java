package com.google.ybMyboot.base.dao;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;
import com.google.ybMyboot.base.to.DeptTO;
@Mapper
public interface DeptDAO {
	public ArrayList<DeptTO> selectDeptList();
	public void updateDept(DeptTO dept);
	public void registDept(DeptTO dept);
	public void deleteDept(DeptTO dept);
}
