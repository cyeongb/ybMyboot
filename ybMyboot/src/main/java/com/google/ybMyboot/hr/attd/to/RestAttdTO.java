package com.google.ybMyboot.hr.attd.to;

import com.google.ybMyboot.base.to.BaseTO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class RestAttdTO extends BaseTO{
	private String empCode, empName, restAttdCode, restTypeCode
	,restTypeName, requestDate, startDate
	,endDate, numberOfDays, cost, cause
	,approvalStatus, rejectCause, startTime, endTime;

	

}

