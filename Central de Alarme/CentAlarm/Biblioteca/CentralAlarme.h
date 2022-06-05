/*
 * CentralAlarme.h
 *
 * Created: 30/08/2021 11:47:34
 *  Author: Lucas
 */ 


#ifndef CENTRALALARME_H_
#define CENTRALALARME_H_
#include <avr/io.h>
#include "displayI2C.h"
#include "I2C.h"
#include "RTCds1307.h"

#define P 10
#define A 11
#define D 12
#define E 13
#define S 14
#define R 15
#define Desativado 0
#define Ativado 1
#define Inserir_Senha 2
#define Inserir_Senha_M 3
#define Verificar_Senha 4
#define Panico 5
#define Recuperacao 6

int teclado();
void E_desativado();
int E_inserir_senha();
int E_verificar_senha();
void E_tempo(unsigned t);
void E_ativo();
void E_programacao();
void E_panico();
void E_recuperacao();
char Valor_teclado_LCD(int x);

//*********************************************************************************
// ********************** Declara??o das vari?veis globais ************************
//*********************************************************************************


extern int counter, t_teclado;
extern int senham, senha1, senha2, senha3;
extern int timeout, temp_ativ, temp_sirene;
extern int zona [3];
extern int T_down;
extern int Modo;



#endif /* CENTRALALARME_H_ */