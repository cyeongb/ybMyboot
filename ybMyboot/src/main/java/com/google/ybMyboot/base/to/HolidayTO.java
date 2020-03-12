package com.google.ybMyboot.base.to;

import javax.persistence.Column;
import javax.persistence.Table;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Table(name="HOLIDAY")
@EqualsAndHashCode(callSuper = false)
public class HolidayTO extends BaseTO{
	@Column(name="APPLY_DAY")
	private String applyDay;
	@Column(name="HOLIDAY_NAME")
	private String holidayName;
	@Column(name="NOTE")
	private String note;

}
