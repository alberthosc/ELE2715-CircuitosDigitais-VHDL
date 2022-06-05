/*
 * UART.h
 *
 * Created: 30/08/2021 18:03:43
 *  Author: alber
 */ 


#ifndef UART_H_
#define UART_H_
#define  F_CPU 8000000UL
#define BAUD 9600
#define UBRRy F_CPU/16/BAUD-1
#include <avr/io.h>
#include <avr/interrupt.h>

void envio_teste();
unsigned char receber(void);
void enviar(unsigned char data);
void config_UART(unsigned int UBRRx );


#endif /* UART_H_ */