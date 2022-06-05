--**************************************************************--
--**             Operador da função NOT                       **--
------------------------------------------------------------------
--**    DATA_OUT recebe o resulltado de uma operação NOT bit  **--
--**    a bit sobre DATA_IN_0                                 **--
------------------------------------------------------------------ 

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------

-------------------- DECLARAÇÃO DA ENTIDADE ----------------------
ENTITY op_not IS
GENERIC (DATA_BUS : INTEGER := 8); ----Largura do barramento de dados (8 bits)
  
PORT (DATA_IN_0: IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	     DATA_OUT: OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0));
END op_not;

-------INICIO DA CODIFICAÇÃO DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF op_not IS

--------DEFINIÇÃO DOS SINAIS QUE SEÃO USADOS INTERNAMENTE---------
SIGNAL I_OUT : STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);

BEGIN
  inst:
  FOR i IN (DATA_BUS-1) DOWNTO 0 GENERATE
		 A : I_OUT(i) <= NOT(DATA_IN_0(i));
	END GENERATE
	inst;
	
	DATA_OUT <= I_OUT; 
	
END ckt;