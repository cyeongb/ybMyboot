package com.google.ybMyboot.base.to;



import javax.persistence.Column;
import javax.persistence.Table;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Table(name="DEPT")
@EqualsAndHashCode(callSuper = false)
public class DeptTO extends BaseTO{
	@Column(name="DEPT_CODE")
	private String deptCode;
	@Column(name="DEPT_NAME")
	private String deptName;
	@Column(name="DEPT_TEL")
	private String deptTel;

	
}
