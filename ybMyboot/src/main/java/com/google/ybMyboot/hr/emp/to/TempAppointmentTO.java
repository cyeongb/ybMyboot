package com.google.ybMyboot.hr.emp.to;

import com.google.ybMyboot.base.to.BaseTO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class TempAppointmentTO extends BaseTO{

	private String appointmentNo; 
	private String empCode;
	private String appointmentHistory;
	private String currentInformation;
	private String preAppointmentInformation;

}

