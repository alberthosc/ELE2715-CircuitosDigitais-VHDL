/*
 * CentAlarm.c
 *
 * Created: 25/08/2021 20:13:12
 * Author : albertho
 */ 

#include <avr/io.h>
#include "Biblioteca/displayI2C.h"
#include "Biblioteca/I2C.h"
#include "Biblioteca/RTCds1307.h"
#include "Biblioteca/CentralAlarme.h"
#include "Biblioteca/UART.h"



ISR (USART_RX_vect)
{
	char dado_recebido;
	dado_recebido = UDR0;

	if(dado_recebido=='0')
	{
		enviar(' ');
		enviar('a');
		enviar('l');
		enviar('o');
		enviar(' ');
		enviar('m');
		enviar('e');
		enviar('u');
		enviar(' ');
		enviar('p');
		enviar('a');
		enviar('r');
		enviar('s');
		enviar('a');
		enviar(' ');
	}
}


//*********************************************************************************
// ********************************* Funcao principal *****************************
//*********************************************************************************


int main(void)
{
	int  x = 20;
	char y;
	DDRB = 0x0F;
	DDRD = 0x07;// para o teclado entrada das colunas PD4 a PD7
	DDRC = 0x30; // para o teclado Saida das linhas de PC0 a PC3
	i2c_init();
	i2c_start();
	i2c_write(0x72);
	i2c_write(0x00);
	i2c_start();
	i2c_write(0x70);
	inicia_display();
	lcd_cmd_8bits(0x0C); //Apaga o cursor;
	i2c_stop();
	//Replace with your application code
	while (1)
	{
		x = teclado();		//Lê teclado
		PORTB = 0x00;		//---

		int j=1;
		while(Modo == Desativado )
		{
			do{
				E_desativado();
			}while(j!=1);
			
			x = teclado();
			PORTB = 0x00;
			
			if(x == A)
			{
				Modo = Inserir_Senha;
				while(Modo = Inserir_Senha)
				{
					int aux = E_verificar_senha(E_inserir_senha());
					if (aux)
					{
						//Tela para temporizador de ativação
						i2c_start();
						i2c_write(0x70);
						set_cell(2);
						set_str("TEMPORIZADOR");
						set_cell(18);
						set_str("DE  ATIVACAO");
						delay_ms(5000);
						limpa_lcd();
						delay_ms(1000);
						i2c_stop();
						Modo = Ativado;
					}
					else if (aux == -1){Modo = Desativado;}
					else if (aux == 0){Modo = Desativado;}
				}
			}				
		}//while(Ativado)
		j=1;
		while(Modo == Ativado )
		{
			do{
				E_ativo();
			}while(j!=1);
			
			x = teclado();
			PORTB = 0x00;
			i2c_start();
			i2c_write(0x70);
			
			//Zona ativa piscando
			while(x != S && x != D )
			{
				x = teclado();
				PORTB = 0x00;
				
				if (zona[0])
				{
					set_cell(20);
					lcd_escreve('*');
				}
				if (zona[1])
				{
					set_cell(25);
					lcd_escreve('*');
				}
				if (zona[2])
				{
					set_cell(30);
					lcd_escreve('*');
				}
				delay_ms(1000);
				set_cell(20);
				lcd_escreve('-');
				set_cell(25);
				lcd_escreve('-');
				delay_ms(1000);
				set_cell(30);
				lcd_escreve('-');
				delay_ms(1000);
				
				if (x == D)
				{	
					if (E_verificar_senha(E_inserir_senha()))
					{
						Modo = Desativado;
					}
					else Modo = Ativado;
					
				}
				if (x == S)
				{
					Modo = Panico;
					while((PINB >> 4 != 0));
				}
			}
			limpa_lcd();
			delay_ms(2000);
			i2c_stop();
			
		} //while(Ativado)
	} //while(1)
} //Main

   
   /*RTC_Init();
   RTC_SetTime(4,10,0,AM,_24_hour_format);
   RTC_SetDate(2,8,3,19);*/

   /*
    while (1) 
    {
		
		
		
		
		
		//Teste dos leds com i2c
		i2c_start();
		i2c_write(0x72);
		i2c_write(0x01);
		delay_ms(2000);
		i2c_write(0x02);
		delay_ms(2000);
		i2c_write(0x04);
		delay_ms(2000);
		i2c_write(0x08);
		delay_ms(2000);
		i2c_write(0x10);
		delay_ms(2000);
		i2c_stop();
		
		//Tela do modo desativado
 		set_cell(5);
		set_str("ALARME");
		set_cell(19);
		set_str("DESATIVADO");
		delay_ms(5000);
		limpa_lcd();
		delay_ms(2000);
		
		//Tela de panico
		set_cell(5);
		set_str("PANICO");
		set_cell(17);
		set_str("---- ---- ----");
		for(int i=0; i<5; i++)
		{
			set_cell(17);
			set_str("              ");
			delay_ms(750);
			set_cell(17);
			set_str("---- ---- ----");
			delay_ms(1000);
		}
		limpa_lcd();
		delay_ms(2000);

		//Tela para a senha
		set_cell(1);
		set_str("INSIRA A SENHA:");
		set_cell(22);
		set_str("----");
		delay_ms(5000);
		//Inseriu o primeiro valor
		set_cell(22);
		pisca_cell();
		delay_ms(5000);
		lcd_escreve('*');
		delay_ms(5000);
		//Inseriu o segundo valor
		lcd_escreve('*');
		delay_ms(5000);
		//Inseriu o terceiro valor
		lcd_escreve('*');
		delay_ms(5000);
		para_pisca();
		//Inseriu o quarto valor
		lcd_escreve('*');
		delay_ms(5000);
		limpa_lcd();
		delay_ms(2000);
		
		//Tela para a senha mestre
		set_cell(1);
		set_str("INSIRA SENHA M:");
		set_cell(22);
		set_str("----");
		set_cell(22);
		pisca_cell();
		delay_ms(5000);
		//Inseriu o primeiro valor
		set_cell(22);
		lcd_escreve('*');
		delay_ms(5000);
		//Inseriu o segundo valor
		lcd_escreve('*');
		delay_ms(5000);
		//Inseriu o terceiro valor
		lcd_escreve('*');
		delay_ms(5000);
		para_pisca();
		//Inseriu o quarto valor
		lcd_escreve('*');
		delay_ms(2000);
		limpa_lcd();
		delay_ms(2000);
		
		
		//Tela para central ativa
		set_cell(2);
		set_str("CENTRAL ATIVA");
		set_cell(17);
		set_str("Z1:- Z2:- Z3:-");
		delay_ms(5000);
		set_cell(31);
		lcd_escreve(0xFC);
		delay_ms(5000);
		set_cell(31);
		lcd_escreve(' ');
		delay_ms(5000);
		//Zona ativa piscando
		for(int i=0; i<5; i++)
		{
			set_cell(25);
			lcd_escreve('*');
			set_cell(30);
			lcd_escreve('*');
			delay_ms(1000);
			set_cell(25);
			lcd_escreve('-');
			set_cell(30);
			lcd_escreve('-');
			delay_ms(1000);
		}
		limpa_lcd();
		delay_ms(2000);
		
		//Tela da escolha de opcao
		set_cell(5);
		set_str("OPCAO");
		set_cell(20);
		set_str("[2..8]:-");
		set_cell(27);
		pisca_cell();
		delay_ms(5000);
		para_pisca();
		limpa_lcd();
		delay_ms(2000);
		
		
		//Tela para alterar senha
		set_cell(2);
		set_str("ALTERAR SENHA");
		delay_ms(5000);
		limpa_lcd();
		delay_ms(2000);
		set_cell(3);
		set_str("QUAL SENHA?");
		set_cell(20);
		set_str("0 1 2 3");
		delay_ms(5000);
		limpa_lcd();
		delay_ms(2000);
		set_cell(3);
		set_str("NOVA SENHA:");
		set_cell(22);
		set_str("----");
		set_cell(22);
		pisca_cell();
		delay_ms(5000);
		//Inseriu o primeiro valor
		lcd_escreve('*');
		delay_ms(5000);
		//Inseriu o segundo valor
		lcd_escreve('*');
		delay_ms(5000);
		//Inseriu o terceiro valor
		lcd_escreve('*');
		delay_ms(5000);
		para_pisca();
		//Inseriu o quarto valor
		lcd_escreve('*');
		delay_ms(5000);
		limpa_lcd();
		delay_ms(2000);
		
		//Tela para ativar/desativar sensores
		set_cell(0);
		set_str("ATIVAR/DESATIVAR");
		set_cell(20);
		set_str("SENSORES");
		delay_ms(5000);
		limpa_lcd();
		set_cell(0);
		set_str("1 2 3 4 5 6 7 8");
		pula_linha();
		set_str("SENSOR:-");
		set_cell(23);
		pisca_cell();
		delay_ms(5000);
		para_pisca();
		set_cell(2);
		lcd_escreve('*');
		set_cell(12);
		lcd_escreve('*');
		delay_ms(5000);
		para_pisca();
		limpa_lcd();
		
		//Tela para ativar/desativar zonas
		set_cell(0);
		set_str("ATIVAR/DESATIVAR");
		set_cell(22);
		set_str("ZONAS");
		delay_ms(5000);
		limpa_lcd();
		delay_ms(2000);
		set_cell(6);
		set_str("ZONAS:");
		set_cell(22);
		set_str("1 2 3");
 		delay_ms(5000);
 		set_cell(24);
 		lcd_escreve('*');
		delay_ms(5000);
		limpa_lcd();
		delay_ms(2000);
		
		//Tela para temporizador de ativação
		set_cell(2);
		set_str("TEMPORIZADOR");
		set_cell(18);
		set_str("DE  ATIVACAO");
		delay_ms(5000);
		limpa_lcd();
		delay_ms(2000);
		set_cell(3);
		set_str("TEMPO (s):");
		set_cell(22);
		set_str("000");
		delay_ms(5000);
		set_cell(24);
		lcd_escreve('9');
		delay_ms(5000);
		set_cell(23);
		set_str("95");
		delay_ms(5000);
		set_cell(22);
		set_str("957");
		delay_ms(5000);
		limpa_lcd();
		delay_ms(2000);
		
		//Tela para temporizador de sirene
		set_cell(2);
		set_str("TEMPORIZADOR");
		set_cell(19);
		set_str("DA  SIRENE");
		delay_ms(5000);
		limpa_lcd();
		delay_ms(2000);
		set_cell(3);
		set_str("TEMPO (s):");
		set_cell(22);
		set_str("000");
		delay_ms(5000);
		set_cell(24);
		lcd_escreve('9');
		delay_ms(5000);
		set_cell(23);
		set_str("95");
		delay_ms(5000);
		set_cell(22);
		set_str("957");
		delay_ms(5000);
		limpa_lcd();
		delay_ms(2000);
		
		//Tela para temporizador do timeout
		set_cell(2);
		set_str("TEMPORIZADOR");
		set_cell(19);
		set_str("DE TIMEOUT");
		delay_ms(5000);
		limpa_lcd();
		delay_ms(2000);
		set_cell(3);
		set_str("TEMPO (s):");
		set_cell(23);
		set_str("00");
		delay_ms(5000);
		set_cell(24);
		lcd_escreve('9');
		delay_ms(5000);
		set_cell(23);
		set_str("95");
		delay_ms(5000);
		limpa_lcd();
		delay_ms(2000);
		*/
		/*
		RTC_GetTime(&Hour, &Minute, &Second, &am_pm, hr_format);
		RTC_GetDate(&DayOfWeek, &Day, &Mount, &Year);
		
    }
	*/
//}
