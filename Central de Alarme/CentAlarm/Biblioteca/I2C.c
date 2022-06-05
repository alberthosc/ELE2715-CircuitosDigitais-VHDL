/*
 * I2C.c
 *
 * Created: 27/08/2021 19:50:30
 *  Author: albertho
 */ 


#include "I2C.h"

//Conexão i2C//

void i2c_init(){
	TWBR = 0x20;		//TWBR = 32 - Para o cálculo do Baud rate 
	TWCR = (1<<TWEN);	//Enable I2C
	TWSR = 0x00;		//Prescaler configurado pra 1

}
//Start condition
void i2c_start(){
	TWCR = (1<<TWINT) | (1<<TWEN) | (1<<TWSTA);	//Start
	while (!(TWCR & (1<<TWINT)));				//Espera ACK

}
void i2c_write(char x){				
	TWDR = x;						//Envia o char x via i2c
	TWCR = (1<<TWINT) | (1<<TWEN);	
	while  (!(TWCR &(1<<TWINT)));
}

char i2c_read(){
	TWCR  = (1<<TWEN) | (1<<TWINT);	//Enable I2C e clear da interrupção
	while (!(TWCR & (1<<TWINT)));	
	return TWDR;
}

char i2c_stop(void)
{
	TWCR = (1<<TWINT)|(1<<TWSTO)|(1<<TWEN); //Stop
	return 1;
}