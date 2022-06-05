--**************************************************************--
--**                         ULA                              **--
--**                                                          **--
------------------------------------------------------------------
--**    Opera dom os dados contidos em DATA_IN_0 E DATA_IN_1  **--
--** de acordo com o OPCode previamente definido.             **--
------------------------------------------------------------------ 

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------

----------------------DECLARAÇÃO DA ENTIDADE----------------------
ENTITY ula IS
  PORT (             OP: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
   DATA_IN_0, DATA_IN_1: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
               DATA_OUT: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
           CARRY, ULA_0: OUT STD_LOGIC);
END ENTITY ula;


-------INICIO DA CODIFICAÇÃO DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF ula IS
----***************************************************************************************************************************  
COMPONENT op_add IS
GENERIC (DATA_BUS : INTEGER := 8); ----Largura do barramento de dados (8 bits)
  
PORT (DATA_IN_0, DATA_IN_1: IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	               DATA_OUT : OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	              CARRY_OUT : OUT STD_LOGIC);
END COMPONENT op_add; 


COMPONENT op_sub IS
GENERIC (DATA_BUS : INTEGER := 8); ----Largura do barramento de dados (8 bits)
  
PORT (DATA_IN_1, DATA_IN_0: IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	                DATA_OUT: OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	               CARRY_OUT: OUT STD_LOGIC);
END COMPONENT op_sub;


COMPONENT op_and IS
GENERIC (DATA_BUS : INTEGER := 8); ----Largura do barramento de dados (8 bits)
  
PORT (DATA_IN_0, DATA_IN_1: IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	                DATA_OUT: OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0));
END COMPONENT op_and;

  
COMPONENT op_or IS
GENERIC (DATA_BUS : INTEGER := 8); ----Largura do barramento de dados (8 bits)
  
PORT (DATA_IN_0, DATA_IN_1: IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	                DATA_OUT: OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0));
END COMPONENT op_or;


COMPONENT op_not IS
GENERIC (DATA_BUS : INTEGER := 8); ----Largura do barramento de dados (8 bits)
  
PORT (DATA_IN_0: IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	     DATA_OUT: OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0));
END COMPONENT op_not;


COMPONENT op_xor IS
GENERIC (DATA_BUS : INTEGER := 8); ----Largura do barramento de dados (8 bits)
  
PORT (DATA_IN_0, DATA_IN_1: IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	                DATA_OUT: OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0));
END COMPONENT op_xor;


COMPONENT op_cmp IS
GENERIC (DATA_BUS : INTEGER := 8); ----Largura do barramento de dados (8 bits)
  
PORT (DATA_IN_0, DATA_IN_1: IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	                DATA_OUT: OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0));
END COMPONENT op_cmp;


--------DEFINIÇÃO DOS SINAIS QUE SEÃO USADOS INTERNAMENTE---------  
  SIGNAL S_ADD, S_SUB, S_AND, S_OR, S_NOT, S_XOR, S_CMP, D_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL CARRY_SUB, CARRY_ADD : STD_LOGIC;
    
BEGIN

  A: op_add PORT MAP(DATA_IN_0, DATA_IN_1, S_ADD, CARRY_ADD);
  B: op_sub PORT MAP(DATA_IN_1, DATA_IN_0, S_SUB, CARRY_SUB);
  C: op_and PORT MAP(DATA_IN_0, DATA_IN_1, S_AND);
  D: op_or  PORT MAP(DATA_IN_0, DATA_IN_1, S_OR );
  E: op_not PORT MAP(DATA_IN_1, S_NOT);
  F: op_xor PORT MAP(DATA_IN_0, DATA_IN_1, S_XOR);
  G: op_cmp PORT MAP(DATA_IN_0, DATA_IN_1, S_CMP); 
  
  D_OUT <= DATA_IN_1 WHEN OP = "000" ELSE
               S_ADD WHEN OP = "001" ELSE
               S_SUB WHEN OP = "010" ELSE
               S_AND WHEN OP = "011" ELSE
               S_OR  WHEN OP = "100" ELSE
               S_NOT WHEN OP = "101" ELSE
               S_XOR WHEN OP = "110" ELSE
               S_CMP;
   
  CARRY <=       '0' WHEN OP = "000" ELSE
           CARRY_ADD WHEN OP = "001" ELSE
           CARRY_SUB WHEN OP = "010" ELSE
                 '0' WHEN OP = "011" ELSE
                 '0' WHEN OP = "100" ELSE
                 '0' WHEN OP = "101" ELSE
                 '0' WHEN OP = "110" ELSE
                 '0';
  
  ULA_0 <= NOT(D_OUT(7) OR D_OUT(6) OR D_OUT(5) OR D_OUT(4) OR D_OUT(3) OR D_OUT(2) OR D_OUT(1) OR D_OUT(0));
  
  DATA_OUT <= D_OUT;
                         
END ARCHITECTURE ckt;