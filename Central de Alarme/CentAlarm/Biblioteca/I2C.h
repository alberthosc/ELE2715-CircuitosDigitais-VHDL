/*
 * I2C.h
 *
 * Created: 27/08/2021 19:50:45
 *  Author: albertho
 */ 


#ifndef I2C_H_
#define I2C_H_
#include <avr/io.h>
#include "displayI2C.h"
#include "RTCds1307.h"
//#include <util/delay.h>

#define START       0x08
#define START_REP   0x10
#define MT_SLA_ACK  0x18
#define MT_DATA_ACK     0x28
#define MR_SLA_ACK      0x40
#define MR_DATA_NACK    0x58

//Conexão i2C//
void i2c_init();
void i2c_start();
void i2c_write(char x);
char i2c_read();
char i2c_stop(void);


#endif /* I2C_H_ */