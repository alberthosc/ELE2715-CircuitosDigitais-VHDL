/*
 * RTC.h
 *
 * Created: 27/08/2021 19:51:13
 *  Author: albertho
 */ 


#ifndef RTCds1307_H_
#define RTCds1307_H_
#include <avr/io.h>
//#include <util/delay.h>
#include "displayI2C.h"
#include "I2C.h"

// DS1307 Endere�os de registradores 
#define DS1307_Address		0x68
#define DS1307_Read_addr		((DS1307_Address << 1) | 0x01)	//0xD1
#define DS1307_Write_addr		((DS1307_Address << 1) & 0xFE)	//0xD0
#define SECONDREG			0x00
#define MINUTEREG			0x01
#define HOURREG				0x02
#define DAYREG				0x03
#define DATEREG				0x04
#define MONTHREG			0x05
#define YEARREG				0x06
#define CONTROLREG			0x0E
#define STATUSREG			0x0F
#define _24_hour_format		0
#define _12_hour_format		1
#define AM					0
#define PM					1

// Vari�veis 
unsigned int Year ;
unsigned char Mount ;
unsigned char Day ;
unsigned char DayOfWeek ;
unsigned char Hour ;
unsigned char Minute ;
unsigned char Second ;
unsigned char am_pm ;
unsigned char hr_format;

unsigned char BCD_To_Decimal(unsigned char d);
unsigned char Decimal_To_BCD(unsigned char d);
unsigned char RTC_Read(unsigned char Address);
void RTC_Write(unsigned char Address, unsigned char _value);
void RTC_Init(void);
void RTC_GetTime(unsigned char* hourP, unsigned char* minutP, unsigned char* secP, unsigned char* ampmP, unsigned char hour_format);
void RTC_GetDate(unsigned char* dayP, unsigned char* dateP, unsigned char* montP, unsigned int* yearP);
void RTC_SetTime(unsigned char hSet, unsigned char mSet, unsigned char sSet, unsigned char am_pm_state, unsigned char hour_format);
void RTC_SetDate(unsigned char daySet, unsigned char dateSet, unsigned char monthSet, unsigned int yearSet);



#endif /* RTC_H_ */