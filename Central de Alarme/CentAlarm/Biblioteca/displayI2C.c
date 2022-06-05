/*
 * displayi2c.c
 *
 * Created: 25/08/2021 20:16:06
 *  Author: albertho
 */ 

#include "displayI2C.h"



//Comandos Display//
void lcd_cmd_8bits(char value)
{
	TWDR&=~0x01;					//rs = 0; 
	TWCR = (1<<TWINT) | (1<<TWEN);	//Enable I2C e clear da interrupção
	while  (!(TWCR &(1<<TWINT)));
	TWDR &= 0x0F;                   //limpando os 4 msb
	TWCR = (1<<TWINT) | (1<<TWEN);	
	while  (!(TWCR &(1<<TWINT)));
	TWDR |= (value & 0xF0);			//Enviando os 4 msb do value
	TWCR = (1<<TWINT) | (1<<TWEN);	
	while  (!(TWCR &(1<<TWINT)));
	en_up_down();
	
	TWDR &= 0x0F;                    //limpando os 4 msb
	TWCR = (1<<TWINT) | (1<<TWEN);	
	while  (!(TWCR &(1<<TWINT)));
	TWDR |= ((value & 0x0F)<<4);	//Enviando os 4 lsb do value
	TWCR = (1<<TWINT) | (1<<TWEN);	
	while  (!(TWCR &(1<<TWINT)));
	en_up_down();
}

void lcd_cmd_4bits(char value)
{
	TWDR&=~0x01;					//rs = 0; 
	TWCR = (1<<TWINT) | (1<<TWEN);	//Enable I2C e clear da interrupção
	while  (!(TWCR &(1<<TWINT)));
	TWDR &= 0x0F;                   ///limpando os 4 msb
	TWCR = (1<<TWINT) | (1<<TWEN);	
	while  (!(TWCR &(1<<TWINT)));
	TWDR |= (value & 0xF0);			//Enviando os 4 msb do value
	TWCR = (1<<TWINT) | (1<<TWEN);	
	while  (!(TWCR &(1<<TWINT)));
	en_up_down();
}

void lcd_escreve(char value)
{
	TWDR|=0x01;						//rs = 1;
	TWCR = (1<<TWINT) | (1<<TWEN);	//Enable I2C e clear da interrupção
	while  (!(TWCR &(1<<TWINT)));
	TWDR &= 0x0F;				    //limpando os 4 msb
	TWCR = (1<<TWINT) | (1<<TWEN);	
	while  (!(TWCR &(1<<TWINT)));
	TWDR |= (value & 0xF0);			//Enviando os 4 msb do value
	TWCR = (1<<TWINT) | (1<<TWEN);	
	while  (!(TWCR &(1<<TWINT)));
	en_up_down();
	
	TWDR &= 0x0F;					//limpando os 4 msb
	TWCR = (1<<TWINT) | (1<<TWEN);	
	while  (!(TWCR &(1<<TWINT)));
	TWDR |= ((value & 0x0F)<<4);	//Enviando os 4 lsb do value
	TWCR = (1<<TWINT) | (1<<TWEN);	
	while  (!(TWCR &(1<<TWINT)));
	en_up_down();
}

void pula_linha()
{
	 lcd_cmd_8bits(0xC0); // (1100 0000)
}

void limpa_lcd()
{
	lcd_cmd_8bits(0x01); // (0000 0001)
}

void en_up_down(){
	TWDR |= 0x02;					//EN = 1;  
	TWCR = (1<<TWINT) | (1<<TWEN);	//Enable I2C e clear da interrupção
	while  (!(TWCR &(1<<TWINT)));	
	//delay_ms(10);
	TWDR &= ~0x02;					//EN = 0;
	TWCR = (1<<TWINT) | (1<<TWEN);	
	while  (!(TWCR &(1<<TWINT)));
}

void inicia_display(uint8_t *Port)
{
	
	lcd_cmd_4bits(0x20);			//Envia (0010 0000). Essa fun??o s? trata os 4 msb.
	lcd_cmd_4bits(0x20);			//Envia (0010 0000) pela segunda vez, pois ele inicializa no modo 8 bits. Essa fun??o s? trata os 4 msb.
	lcd_cmd_4bits(0x80);			//Envia (1000 0000). 
	
	//Liga LCD e cursor
	lcd_cmd_8bits(0x0E);
	
	//Habilita incremento
	lcd_cmd_8bits(0x06);
}

void set_str(unsigned char *str)
{
	while(*str)      
	lcd_escreve(*str++);		
}

void set_cell(unsigned int val){
	//DEFINE A C?LULA DO DISPLAY A SER ESCRITA
		uint8_t simbol;
		switch(val)
		{
			case 0:
			simbol = 0x80;
			break;
			case 1:
			simbol = 0x81;
			break;
			case 2:
			simbol = 0x82;
			break;
			case 3:
			simbol = 0x83;
			break;
			case 4:
			simbol = 0x84;
			break;
			case 5:
			simbol = 0x85;
			break;
			case 6:
			simbol = 0x86;
			break;
			case 7:
			simbol = 0x87;
			break;
			case 8:
			simbol = 0x88;
			break;
			case 9:
			simbol = 0x89;
			break;
			case 10:
			simbol = 0x8A;
			break;
			case 11:
			simbol = 0x8B;
			break;
			case 12:
			simbol = 0x8C;
			break;
			case 13:
			simbol = 0x8D;
			break;
			case 14:
			simbol = 0x8E;
			break;
			case 15:
			simbol = 0x8F;
			break;
			case 16:
			simbol = 0xC0;
			break;
			case 17:
			simbol = 0xC1;
			break;
			case 18:
			simbol = 0xC2;
			break;
			case 19:
			simbol = 0xC3;
			break;
			case 20:
			simbol = 0xC4;
			break;
			case 21:
			simbol = 0xC5;
			break;
			case 22:
			simbol = 0xC6;
			break;
			case 23:
			simbol = 0xC7;
			break;
			case 24:
			simbol = 0xC8;
			break;
			case 25:
			simbol = 0xC9;
			break;
			case 26:
			simbol = 0xCA;
			break;
			case 27:
			simbol = 0xCB;
			break;
			case 28:
			simbol = 0xCC;
			break;
			case 29:
			simbol = 0xCD;
			break;
			case 30:
			simbol = 0xCE;
			break;
			default:
			simbol = 0xCF;
			break;
		}
		lcd_cmd_8bits(simbol);
}

void limpa_cursor (){
	
		lcd_cmd_8bits(0x0C);
}

void pisca_cell (){
	lcd_cmd_8bits(0x0D);
}

void para_pisca()
{
	lcd_cmd_8bits(0x0C);
}

void delay_ms(int ms)
{
	for(int i = 0; i <= ms; i++)
		for(int j=0; j <= 255; j++);
}