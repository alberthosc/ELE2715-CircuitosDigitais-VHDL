/*
 * GccApplication6.cpp
 *
 * Created: 25/08/2021 20:04:35
 * Author : Alysson
 */ 

#include "UART.h"


void config_UART(unsigned int UBRRx )
{
	UCSR0A = 0x00;
	UCSR0B = 0x98;
	UCSR0C = 0x2F;
	UBRR0H = (unsigned char)(UBRRx>>8);
	UBRR0L = (unsigned char)UBRRx;
	
	return;
}

void enviar(unsigned char data)
{
	while(!( UCSR0A & (1<<UDRE0)));
	UDR0 = data;
}

unsigned char receber(void)
{
	while(!(UCSR0A & (1<<RXC0)));
	return UDR0;
}


void envio_teste()
{
	
	enviar('0');
	
}

