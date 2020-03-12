package com.google.ybMyboot.base.dao;
import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;
import com.google.ybMyboot.base.to.DetailCodeTO;

@Mapper
public interface DetailCodeDAO {
	public ArrayList<DetailCodeTO> selectDetailCodeList(String codetype);
	public ArrayList<DetailCodeTO> selectDetailCodeListRest(String code1,String code2, String code3);
	public void updateDetailCode(DetailCodeTO detailCodeto);
	public void registDetailCode(DetailCodeTO detailCodeto);
	public void deleteDetailCode(DetailCodeTO detailCodeto);
	
}