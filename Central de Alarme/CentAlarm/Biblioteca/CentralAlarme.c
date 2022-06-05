/*
 * CentralAlarme.c
 *
 * Created: 30/08/2021 11:47:19
 *  Author: Lucas
 */ 
#include "CentralAlarme.h"

int counter, t_teclado;
int senham = 1234, senha1, senha2, senha3;
int timeout = 99, temp_ativ = 0, temp_sirene = 0;
int T_down = 0;
int Modo = 0;
int zona [3] = {1,0,0};

int teclado()
{
	//int x = 20;
	
	//PORTC &= 0xF0;
	PORTB = 0x01;
	delay_ms(500);
	// 	PORTC |= 0x01;
	// 	PORTC |= 0x01;
	// 	PORTC |= 0x01;
	if(PINB & 0x10){return 1;}
	else if(PINB & 0x20){return 2;}
	else if(PINB & 0x40){return 3;}
	else if(PINB & 0x80){return P;}	
	
	//PORTC &= 0xF0;
	PORTB = 0x02;
	delay_ms(500);

	if(PINB & 0x10){return 4;}
	else if(PINB & 0x20){return 5;}
	else if(PINB & 0x40){return 6;}
	else if(PINB & 0x80){return A;}	
	
	//PORTC &= 0xF0;
	PORTB = 0x04;
	delay_ms(500);
	// 	PORTC |= 0x04;
	// 	PORTC |= 0x04;
	// 	PORTC |= 0x04;
	if(PINB & 0x10){return 7;}
	else if(PINB & 0x20){return 8;}
	else if(PINB & 0x40){return 9;}
	else if(PINB & 0x80){return D;}	
	
	//PORTC &= 0xF0;
	PORTB = 0x08;
	delay_ms(500);
	// 	PORTC |= 0x08;
	// 	PORTC |= 0x08;
	// 	PORTC |= 0x08;
	if(PINB & 0x10){return R;}			
	else if(PINB & 0x20){return 0;}
	else if(PINB & 0x40){return S;}	
	else if(PINB & 0x80){return E;}	
	
	return 20;
}

//*********************************************************************************
// ********************** Fun��es que implementa os estados ***********************
//*********************************************************************************

void E_desativado()
{
	i2c_start();
	i2c_write(0x70);
	limpa_lcd();
	delay_ms(1000);
	//Tela do modo desativado
	set_cell(5);
	set_str("ALARME");
	set_cell(19);
	set_str("DESATIVADO");
	i2c_stop();
	
// 	delay_ms(5000);
// 	limpa_lcd();
// 	delay_ms(2000)
	
}

int E_inserir_senha()
{
	int senha[4]; 
	Modo = Inserir_Senha;
	
	i2c_start();
	i2c_write(0x70);
	limpa_lcd();
	delay_ms(500);
	//Tela para a senha
	set_cell(1);
	set_str("INSIRA A SENHA:");
	set_cell(22);
	set_str("----");
	//Inseriu o primeiro valor
	set_cell(22);
	pisca_cell();
	
	int counter = 0 , aux = 0;
	while(counter != 4)
	{
		do{
		senha [counter] = teclado();
			while((PINB >> 4 != 0));
		}while(senha [counter] == 20 || senha [counter] == P || senha [counter] == A || senha [counter] == S || senha [counter] == E );
	aux = (aux * 10) + senha [counter];	
	if (senha[counter] == R)
	return -1;
	
	counter++; 
	lcd_escreve('*');
	}
	para_pisca();
	delay_ms(500);
	
	while(1)
	{
		if (teclado() == R)
		{
			limpa_lcd();
			delay_ms(500);
			i2c_stop();
			return -1;
		}else if (teclado() == E)
		{
			limpa_lcd();
			delay_ms(500);
			i2c_stop();
			return aux;
		}
	}
}

int E_verificar_senha(int senha)
{
	if (Modo == Inserir_Senha)
	{
		if(senha == senha1 || senha == senha2 || senha == senha3 || senha == senham)
			return (1);
		else if (senha == -1)
			return (-1);
		else return 0;
		
	}else if (Modo == Inserir_Senha_M){
		if(senha == senham)
			return (1);
		else if (senha == -1)
			return (-1);
		else
			return (0);
	}else
		return (0);
}	

void E_tempo(unsigned t)
{
	
}

void E_ativo()
{
	i2c_start();
	i2c_write(0x70);
	limpa_lcd();
	delay_ms(1000);
	set_cell(2);
	set_str("CENTRAL ATIVA");
	set_cell(17);
	set_str("Z1:- Z2:- Z3:-");
	i2c_stop();
}

void E_programacao()
{
	i2c_start();
	i2c_write(0x70);
	limpa_lcd();
	delay_ms(1000);	
	set_cell(1);
	set_str("INSIRA SENHA M:");
	set_cell(22);
	set_str("----");
	set_cell(22);
	pisca_cell();
	delay_ms(5000);
	i2c_stop();
}

void E_panico()
{

}

void E_recuperacao()
{
 senham = "1234";
 senha1 = "****";
 senha2 = "****";
 senha3 = "****";
 timeout = 99;
 temp_ativ = 0;
 temp_sirene = 0;
 T_down;
 
 
}

char Valor_teclado_LCD(int x)
{
	char y;
	switch (x)
	{
		case 1:
		y = '1';
		break;
		
		case 2:
		y = '2';
		break;
		
		case 3:
		y = '3';
		break;
		
		case 4:
		y = '4';
		break;
		
		case 5:
		y = '5';
		break;
		
		case 6:
		y = '6';
		break;
		
		case 7:
		y = '7';
		break;
		
		case 8:
		y = '8';
		break;
		
		case 9:
		y = '9';
		break;
		
		case 10:
		y = 'P';
		break;
		
		case 11:
		y = 'A';
		break;
		
		case 12:
		y = 'D';
		break;
		
		case 13:
		y = 'E';
		break;
		
		case 14:
		y = 'S';
		break;
		
		case 15:
		y = 'R';
		break;
		
		case 0:
		y = '0';
		break;
		
		case 20:
		x = 20;
		break;
	}
	return y;
}