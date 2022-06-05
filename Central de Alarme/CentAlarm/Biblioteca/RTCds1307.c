/*
 * RTCds1307.c
 *
 * Created: 27/08/2021 19:52:03
 *  Author: albertho
 *
 */
#include "RTCds1307.h"


unsigned char BCD_To_Decimal(unsigned char d)
{
	return ((d & 0x0F) + (((d & 0xF0) >> 4) * 10));
}

unsigned char Decimal_To_BCD(unsigned char d)
{
	return (((d / 10) << 4) & 0xF0) | ((d % 10) & 0x0F);
}

unsigned char RTC_Read(unsigned char Address)
{
	unsigned char data = 0;
	i2c_start();
	i2c_write(DS1307_Write_addr);
	i2c_write(Address);
	i2c_start();
	i2c_write(DS1307_Read_addr);
	i2c_read(&data);
	i2c_stop();
	return data;
}

void RTC_Write(unsigned char Address, unsigned char _value)
{
	i2c_start();
	i2c_write(DS1307_Write_addr);
	i2c_write(Address);
	i2c_write(_value);
	i2c_stop();
}

void RTC_Init(void)
{
	
	i2c_init();
	delay_ms(10);
	RTC_Write(CONTROLREG, 0x05);
	RTC_Write(STATUSREG, 0x00);
}

void RTC_GetTime(unsigned char* hourP, unsigned char* minutP, unsigned char* secP, unsigned char* ampmP, unsigned char hour_format)
{
	unsigned char tmp = 0;
	*secP = RTC_Read(SECONDREG);
	*secP = BCD_To_Decimal(*secP);
	*minutP = RTC_Read(MINUTEREG);
	*minutP = BCD_To_Decimal(*minutP);
	switch(hour_format)
	{
		case _12_hour_format:
		{
			tmp = RTC_Read(HOURREG);
			tmp &= 0x20;
			*ampmP = (short)(tmp >> 5);
			*hourP = (0x1F & RTC_Read(HOURREG));
			*hourP = BCD_To_Decimal(*hourP);
			break;
		}
		default:
		{
			*hourP = (0x3F & RTC_Read(HOURREG));
			*hourP = BCD_To_Decimal(*hourP);
			break;
		}
	}
}

void RTC_GetDate(unsigned char* dayP, unsigned char* dateP, unsigned char* montP, unsigned int* yearP)
{
	*yearP = RTC_Read(YEARREG);
	*yearP = BCD_To_Decimal(*yearP);
	*montP = RTC_Read(MONTHREG);
	*yearP += ((*montP >> 7) * 100) + 2000;
	*montP = (0x1F & *montP);
	*montP = BCD_To_Decimal(*montP);
	*dateP = (0x3F & RTC_Read(DATEREG));
	*dateP = BCD_To_Decimal(*dateP);
	*dayP = (0x07 & RTC_Read(DAYREG));
	*dayP = BCD_To_Decimal(*dayP);
}

void RTC_SetTime(unsigned char hSet, unsigned char mSet, unsigned char sSet, unsigned char am_pm_state, unsigned char hour_format)
{
	unsigned char tmp = 0;
	RTC_Write(SECONDREG, (Decimal_To_BCD(sSet)));
	RTC_Write(MINUTEREG, (Decimal_To_BCD(mSet)));
	switch(hour_format)
	{
		case _12_hour_format:
		{
			switch(am_pm_state)
			{
				case 1:
				{
					tmp = 0x60;
					break;
				}
				default:
				{
					tmp = 0x40;
					break;
				}
			}
			RTC_Write(HOURREG, ((tmp | (0x1F & (Decimal_To_BCD(hSet))))));
			break;
		}
		
		default:
		{
			RTC_Write(HOURREG, (0x3F & (Decimal_To_BCD(hSet))));
			break;
		}
	}
	
}

void RTC_SetDate(unsigned char daySet, unsigned char dateSet, unsigned char monthSet, unsigned int yearSet)
{
	RTC_Write(DAYREG, (Decimal_To_BCD(daySet)));
	RTC_Write(DATEREG, (Decimal_To_BCD(dateSet)));
	RTC_Write(MONTHREG, (Decimal_To_BCD(monthSet)));
	RTC_Write(YEARREG, (Decimal_To_BCD(yearSet % 100)));
}

