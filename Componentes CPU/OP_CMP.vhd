--**************************************************************--
--**             Operador da fun��o CMP                       **--
------------------------------------------------------------------
--**    DATA_OUT recebe o resulltado de uma compara��o de     **--
--**    igualdade entre DATA_IN_0 e DATA_IN_1                 **--
------------------------------------------------------------------ 

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------

-------------------- DECLARA��O DA ENTIDADE ----------------------
ENTITY op_cmp IS
GENERIC (DATA_BUS : INTEGER := 8); ----Largura do barramento de dados (8 bits)
  
PORT (DATA_IN_0, DATA_IN_1: IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	                DATA_OUT: OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0));
END op_cmp;

-------INICIO DA CODIFICA��O DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF op_cmp IS

--------DEFINI��O DOS SINAIS QUE SE�O USADOS INTERNAMENTE---------
SIGNAL S_OUT : STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);

BEGIN
  inst:
  FOR i IN (DATA_BUS-1) DOWNTO 0 GENERATE
		 A : S_OUT(i) <= (DATA_IN_0(i) XOR DATA_IN_1(i));
	END GENERATE
	inst;
	
	DATA_OUT <= S_OUT; 
	
END ckt;