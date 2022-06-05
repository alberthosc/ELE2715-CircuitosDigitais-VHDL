--**************************************************************--
--**             Operador da função SOMA                      **--
------------------------------------------------------------------
--**    DATA_OUT recebe o resulltado de uma operação de soma  **--
--**    binaria entre DATA_IN_0 e DATA_IN_1                   **--
------------------------------------------------------------------ 

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------

-------------------- DECLARAÇÃO DA ENTIDADE ----------------------
ENTITY op_add IS
GENERIC (DATA_BUS : INTEGER := 8); ----Largura do barramento de dados (8 bits)
  
PORT (DATA_IN_0, DATA_IN_1: IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	               DATA_OUT : OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	              CARRY_OUT : OUT STD_LOGIC);
END op_add;

-------INICIO DA CODIFICAÇÃO DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF op_add IS

---------------USANDO UM SOMADOR COMPLETO DE 1 BIT----------------
COMPONENT som_comp IS
PORT( A, B, CARRY_IN: IN STD_LOGIC;
	ADD_OUT, CARRY_OUT: OUT STD_LOGIC);
END COMPONENT som_comp;

--------DEFINIÇÃO DOS SINAIS QUE SEÃO USADOS INTERNAMENTE---------
SIGNAL I_OUT : STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
SIGNAL CARRY : STD_LOGIC_VECTOR(DATA_BUS DOWNTO 0);


BEGIN
  
  CARRY(0) <= '0';
  
  inst:
  FOR i IN 0 TO (DATA_BUS-1) GENERATE
		 A : som_comp PORT MAP (DATA_IN_0(i), DATA_IN_1(i), CARRY(i), I_OUT(i), CARRY(i+1));
	END GENERATE
	inst;
	
	DATA_OUT  <= I_OUT;
	CARRY_OUT <= CARRY(DATA_BUS); 
	
END ckt;


