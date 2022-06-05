--**************************************************************--
--**             Registrador de 8 bits                        **--
------------------------------------------------------------------
--**    para CH = '0', a saida O receberá o sinal do CH_0     **--
--**    para CH = '1', a saida O receberá o sinal do CH_1     **--
------------------------------------------------------------------ 

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------

-------------------- DECLARAÇÃO DA ENTIDADE ----------------------
ENTITY reg_1_bit IS
  
PORT ( clk, CLEAR, EN, DATA_IN: IN STD_LOGIC;
	                    DATA_OUT: OUT STD_LOGIC);
END reg_1_bit;

-------INICIO DA CODIFICAÇÃO DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF reg_1_bit IS

-------------USANDO UM FFD COMO ELEMENTO DE REGISTRO--------------
COMPONENT ffd IS
  PORT (clk,D,P,C: IN STD_LOGIC; 
	              q: OUT STD_LOGIC); 
END COMPONENT ffd;

--------DEFINIÇÃO DOS SINAIS QUE SEÃO USADOS INTERNAMENTE---------
SIGNAL S_IN, S_OUT, NC : STD_LOGIC;

BEGIN
  		 
  		 NC <= NOT CLEAR;
  		 
  		 S_IN <= (EN AND DATA_IN) OR ((NOT EN) AND S_OUT);
  		 
  		 A : ffd PORT MAP( clk, S_IN, '1', NC, S_OUT);
		
	DATA_OUT <= S_OUT; 
	
END ckt;