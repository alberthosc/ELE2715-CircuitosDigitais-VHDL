--**************************************************************--
--**             Somador de 1 bit com carry                   **--
------------------------------------------------------------------
--**                   SALTO a+b-1                    		      **--
--**	           AUTOR: Lucas Batista da Fonseca			            **--
------------------------------------------------------------------ 

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------
entity Salto is
	port (IR_OUT,PC_OUT: in STD_LOGIC_VECTOR (7 downto 0);
		SALTO_OUT: out STD_LOGIC_VECTOR (7 downto 0));
end Salto;

architecture ckt of Salto is

COMPONENT op_sub IS
GENERIC (DATA_BUS : INTEGER := 8); ----Largura do barramento de dados (8 bits)
  
PORT (DATA_IN_0, DATA_IN_1: IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	                DATA_OUT: OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	               CARRY_OUT: OUT STD_LOGIC);
END COMPONENT;

COMPONENT op_add IS
GENERIC (DATA_BUS : INTEGER := 8); ----Largura do barramento de dados (8 bits)
  
PORT (DATA_IN_0, DATA_IN_1: IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	               DATA_OUT : OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	              CARRY_OUT : OUT STD_LOGIC);
END COMPONENT;


signal S_SOMA, S_SUB, S_PCOUTm1, S_SALTO, ssub, ssom: STD_LOGIC_VECTOR (7 downto 0);

signal C_sub0, C_sub, C_soma: STD_LOGIC;


begin
ssom(7) <= '0';
ssom(6 DOWNTO 0) <= IR_OUT(6 DOWNTO 0);
ssub(7) <= '0';
ssub(6 DOWNTO 0) <= IR_OUT(6 DOWNTO 0);


-- Subtraindo 0000 0001 do PC que realiza o conta a mais
Sub0: op_sub port map(PC_OUT, "00000001", S_PCOUTm1, C_sub0);


sub: op_sub port map(S_PCOUTm1, ssom , S_SUB, C_sub);


soma: op_add port map(S_PCOUTm1, ssub, S_SOMA, C_soma);


-- Se o Bit de sinal for 1 a saida eh uma subtracao, se não, uma soma
S_SALTO <= S_SUB when IR_OUT(7) = '1' else
	         S_SOMA;


SALTO_OUT <= S_SALTO;


end ckt;


