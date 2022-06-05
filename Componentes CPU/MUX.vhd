--**************************************************************--
--** mux de dois canais de entrada de um bit cada e um canal  **--
--** de saida, composto apenas por duas portas AND, uma NOT e **--
--** uma OR.                                                  **--
------------------------------------------------------------------
--**    para CH = '0', a saida O receberá o sinal do CH_0     **--
--**    para CH = '1', a saida O receberá o sinal do CH_1     **--
------------------------------------------------------------------ 

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------

----------------------DECLARAÇÃO DA ENTIDADE----------------------
ENTITY mux IS
PORT (      CH : IN STD_LOGIC;
    CH_0, CH_1 : IN STD_LOGIC;
             O : OUT STD_LOGIC);
END ENTITY mux;

-------INICIO DA CODIFICAÇÃO DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF mux IS
BEGIN
	
	O <= ((CH_0 AND NOT(CH)) OR (CH_1 AND CH));
	 
END ARCHITECTURE ckt;