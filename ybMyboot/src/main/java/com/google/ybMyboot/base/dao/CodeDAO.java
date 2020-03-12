package com.google.ybMyboot.base.dao;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;
import com.google.ybMyboot.base.to.CodeTO;
@Mapper
public interface CodeDAO {
	   public ArrayList<CodeTO> selectCode();
}
