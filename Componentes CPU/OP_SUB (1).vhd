--**************************************************************--
--**             Operador da função subtraçao                 **--
------------------------------------------------------------------
--**    DATA_OUT recebe o resulltado de uma operação de       **--
--** subtração binaria entre DATA_IN_0 e DATA_IN_1, ou seja,  **--
--** DATA_OUT = DATA_IN_0 - DATA_IN_1.                        **--
------------------------------------------------------------------ 

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------

-------------------- DECLARAÇÃO DA ENTIDADE ----------------------
ENTITY op_sub IS
GENERIC (DATA_BUS : INTEGER := 8); ----Largura do barramento de dados (8 bits)
  
PORT (DATA_IN_0, DATA_IN_1: IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	                DATA_OUT: OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	               CARRY_OUT: OUT STD_LOGIC);
END ENTITY op_sub;

-------INICIO DA CODIFICAÇÃO DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF op_sub IS

--------------USANDO UM SOMADOR DE 8 BITS COM CARRY---------------
COMPONENT op_add IS
GENERIC (DATA_BUS : INTEGER := 8); ----Largura do barramento de dados (8 bits)
  
PORT (DATA_IN_0, DATA_IN_1: IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	               DATA_OUT : OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	              CARRY_OUT : OUT STD_LOGIC);
END COMPONENT op_add;



--------DEFINIÇÃO DOS SINAIS QUE SEÃO USADOS INTERNAMENTE---------
SIGNAL ADD_1, ADD_2 : STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
SIGNAL NOT_DIN_1, ONE :STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
SIGNAL CARRY_1, CARRY_2 : STD_LOGIC;

BEGIN
----a OPERAÇÃO DE SUBTRAÇÃO É REALIZADA ATRVÉS DO COMPLEMENTO DE 2  
    ONE(0)<='1';
		ONE(1)<='0';
		ONE(2)<='0';
		ONE(3)<='0';
		ONE(4)<='0';
    ONE(5)<='0';
		ONE(6)<='0';
		ONE(7)<='0';
  
  inst:
  FOR i IN (DATA_BUS-1) DOWNTO 0 GENERATE
		 A : NOT_DIN_1(i) <= NOT(DATA_IN_1(i));
	END GENERATE
	inst;
	
	
	soma1: op_add PORT MAP (NOT_DIN_1, ONE, ADD_1, CARRY_1);
	soma2: op_add PORT MAP (ADD_1, DATA_IN_0, ADD_2, CARRY_2);
	
	DATA_OUT <= ADD_2;
	CARRY_OUT <= CARRY_2; 	
	
END ckt;