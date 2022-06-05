/*
 * displayi2c.h
 *
 * Created: 25/08/2021 20:16:26
 *  Author: albertho
 */ 


#ifndef DISPLAYI2C_H_
#define DISPLAYI2C_H_
#define F_CPU 8000000UL
#define tam 3
#include <avr/io.h>
#include "RTCds1307.h"
#include "I2C.h"
//#include <util/delay.h>

//---Comandos do Display---//
void lcd_cmd_8bits(char value);
void lcd_cmd_4bits(char value);
void lcd_escreve(char value);
void pula_linha();
void limpa_lcd();
void en_up_down();
void inicia_display();
void set_freq(unsigned char *str);
void set_str(unsigned char *str);
void set_cell(unsigned int val);
void limpa_cursor ();
void pisca_cell ();
void para_pisca();
void delay_ms(int ms);


#endif /* DISPLAYI2C_H_ */