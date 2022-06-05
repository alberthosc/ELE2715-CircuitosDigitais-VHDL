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
ENTITY reg_8_bits IS
GENERIC (DATA_BUS : INTEGER := 8); ----Largura do barramento de dados (8 bits)
  
PORT ( clk, CLEAR: IN STD_LOGIC;
	        DATA_IN: IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	       DATA_OUT: OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0));
END reg_8_bits;

-------INICIO DA CODIFICAÇÃO DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF reg_8_bits IS

-------------USANDO UM FFD COMO ELEMENTO DE REGISTRO--------------
COMPONENT ffd IS
  PORT (clk,D,P,C: IN STD_LOGIC; 
	              q: OUT STD_LOGIC); 
END COMPONENT ffd;

--------DEFINIÇÃO DOS SINAIS QUE SEÃO USADOS INTERNAMENTE---------
SIGNAL I_OUT : STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);

BEGIN
  inst:
  FOR i IN (DATA_BUS-1) DOWNTO 0 GENERATE
		 A : ffd PORT MAP( clk, DATA_IN(i), '1', CLEAR, I_OUT(i));
	END GENERATE
	inst;
	
	DATA_OUT <= I_OUT; 
	
END ckt;