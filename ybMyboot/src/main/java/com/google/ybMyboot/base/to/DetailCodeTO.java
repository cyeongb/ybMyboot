package com.google.ybMyboot.base.to;

import javax.persistence.Column;
import javax.persistence.Table;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Table(name="DETAIL_CODE")
@EqualsAndHashCode(callSuper = false)
public class DetailCodeTO {
	@Column(name="DETAIL_CODE_NUMBER")
	private String detailCodeNumber;
	@Column(name="CODE_NUMBER")
	private String codeNumber;
	@Column(name="DETAIL_CODE_NAME")
	private String detailCodeName;
	@Column(name="DETAIL_CODE_NAMEUSING")
	private String detailCodeNameusing;

	
}
