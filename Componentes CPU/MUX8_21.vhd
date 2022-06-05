--**************************************************************--
--** mux de dois canais de entrada de 8 bits cada, e um canal **--
--** de saida, tamb�m de 8 bits.                              **--
------------------------------------------------------------------
--**    para CH = '0', a saida O receber� o sinal do CH_0     **--
--**    para CH = '1', a saida O receber� o sinal do CH_1     **--
------------------------------------------------------------------ 

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------

-------------------- DECLARA��O DA ENTIDADE ----------------------
ENTITY mux8_21 IS
GENERIC (DATA_BUS : INTEGER := 8); ----Largura do barramento de dados (8 bits)

PORT (      CH : IN STD_LOGIC;
    CH_0, CH_1 : IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
            O : OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0));
END ENTITY mux8_21;


-------INICIO DA CODIFICA��O DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF mux8_21 IS

-------------USANDO UM MUX DE DOIS CANAIS DE UM BIT --------------
COMPONENT mux IS
PORT (      CH : IN STD_LOGIC;
    CH_0, CH_1 : IN STD_LOGIC;
             O : OUT STD_LOGIC);
END COMPONENT mux;

--------DEFINI��O DOS SINAIS QUE SE�O USADOS INTERNAMENTE---------
SIGNAL S_OUT : STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);

BEGIN
  
  inst:
  FOR i IN (DATA_BUS-1) DOWNTO 0 GENERATE
		 A : mux PORT MAP( CH, CH_0(i), CH_1(i), S_OUT(i));
	END GENERATE
	inst;

  O <= S_OUT;
	 
END ARCHITECTURE ckt;