--**************************************************************--
--**             Bloco PC                                     **--
------------------------------------------------------------------
----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------

-------------------- DECLARAÇÃO DA ENTIDADE ----------------------  
ENTITY PC IS
PORT( PC_Clear,Load_PC,clk,En_PCIRROM: IN STD_LOGIC;
	salto_in: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	OUT_PC: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END PC;

-------INICIO DA CODIFICAÇÃO DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF PC IS

---Componente Somador---
COMPONENT op_add IS

GENERIC (DATA_BUS : INTEGER := 8); ----Largura do barramento de dados (8 bits)
  
PORT (DATA_IN_0, DATA_IN_1: IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	               DATA_OUT : OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	              CARRY_OUT : OUT STD_LOGIC);
END COMPONENT op_add;

---Componente Registrador_PC---
COMPONENT REG_PC IS

  port( clk,en,clr: in std_logic;
        D: in std_logic_vector (7 downto 0);
        S: out std_logic_vector (7 downto 0));

END COMPONENT REG_PC;

signal Carry_Contador,S_LOAD: std_logic;
signal Sig_Out_Salto,Sig_Out_PC,Contador_PC,Out_Contador_PC,Sig_Contador_PC: std_logic_vector (7 downto 0);

BEGIN

-- Out_Contador_PC eh a saida de um mux:
-- Esse mux tem como entrada, a saida do registrador
-- Tambem tem como entrada, a saida do contador
-- alem de a saida do salto
-----------------------------------------------------
-- No contador vai entrar a saida do registrador
-- E a saida vai para o mux, como dito anteriormente
--------------------------------------------------
-- A saida do mux vai depender das chaves seletoras:
-- En_PCIRROM e Load_PC;
-- Se En_PCIRROM for 0, entao a saida do mux vai ser o valor do registrador
-- se En_PCIRROM for 1, entao a saida vai ser o valor do contador
-- se Load_PC for 1, entao a saida vai ser o salto
-- essa saida do mux vai para o registrador.

RegistradorContador: REG_PC port map (clk,En_PCIRROM,PC_Clear,Out_Contador_PC,Sig_Out_PC);

contador:op_add port map(Sig_Out_PC,"00000001",Contador_PC,Carry_Contador);


Out_Contador_PC <= Sig_Out_PC when Load_PC = '0' and En_PCIRROM = '0' else
	  	Contador_PC when Load_PC = '0' and En_PCIRROM = '1' else
		salto_in when Load_PC = '1';

OUT_PC <= Sig_Out_PC;
	
END ckt;
