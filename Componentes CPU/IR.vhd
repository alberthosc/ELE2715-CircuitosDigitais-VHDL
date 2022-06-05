--**************************************************************--
--**             Registrador de 16 bits                        **--
------------------------------------------------------------------
------------------------------------------------------------------ 

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------

-------------------- DECLARAÇÃO DA ENTIDADE ----------------------
ENTITY reg_ir IS
GENERIC (DATA_BUS : INTEGER := 16); ----Largura do barramento de dados (16 bits)
  
PORT ( clk, en: IN STD_LOGIC;
	     DATA_IN: IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	    DATA_OUT: OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0));
END reg_ir;

-------INICIO DA CODIFICAÇÃO DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF reg_ir IS

-------------USANDO UM FFD COMO ELEMENTO DE REGISTRO--------------
COMPONENT ffd IS
  PORT (clk,D,P,C: IN STD_LOGIC; 
	              q: OUT STD_LOGIC); 
END COMPONENT ffd;

--------DEFINIÇÃO DOS SINAIS QUE SEÃO USADOS INTERNAMENTE---------
SIGNAL S_OUT, S_IN : STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);

BEGIN
  
  S_IN <= DATA_IN WHEN en = '1' ELSE
          S_OUT;  --** Interligando saida na entrada quando desabilitado
  
  
  inst:
  FOR i IN (DATA_BUS-1) DOWNTO 0 GENERATE
		 A : ffd PORT MAP( clk, S_IN(i), '1', '1', S_OUT(i));
	END GENERATE
	inst;
	
	
	DATA_OUT <= S_OUT;
	  
	
END ckt;