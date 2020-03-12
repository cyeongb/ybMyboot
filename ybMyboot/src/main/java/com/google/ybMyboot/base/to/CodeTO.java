package com.google.ybMyboot.base.to;

import javax.persistence.Column;
import javax.persistence.Table;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Table(name="DIVISION_CODE")
@EqualsAndHashCode(callSuper = false)
public class CodeTO extends BaseTO{
	@Column(name="CODE_NUMBER")
	private String codeNumber;
	@Column(name="CODE_NAME")
	private String codeName;
	@Column(name="MODIFIABLE")
	private String modifiable;

	
}
