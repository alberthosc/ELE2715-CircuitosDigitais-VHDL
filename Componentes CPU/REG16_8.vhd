
--**************************************************************--
--**       Banco com 16 registradores de 8 bits cada          **--
------------------------------------------------------------------
--**    Para RA_EN = '1', o dado RA_DATA será gravado no      **--
--**  registrador de endereço RA_ADDR.                        **--
--**    Para RB/RC_EN = '1', o dado contido nos registradores **--
--**  de endereços RB/RC_ADDR serão disponibilizados nas      **--
--**  saidas RB/RC_DATA.                                      **--
------------------------------------------------------------------ 

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;
------------------------------------------------------------------


----------------------DECLARAÇÃO DA ENTIDADE----------------------
ENTITY reg16_8 IS
GENERIC (DATA_BUS : INTEGER := 8; ----Largura do barramento de dados (8 bits)
         ADDRES_BUS : INTEGER :=  4); --Largura do barramento de dendereço (4 bits)
         
PORT (clk, RA_EN, RB_EN, RC_EN : IN STD_LOGIC;
     RA_ADDR, RB_ADDR, RC_ADDR : IN STD_LOGIC_VECTOR((ADDRES_BUS-1) DOWNTO 0);
                       RA_DATA : IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
              RB_DATA, RC_DATA : OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0));
END ENTITY reg16_8;


-------INICIO DA CODIFICAÇÃO DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF reg16_8 IS
TYPE bank IS ARRAY (0 TO 2**ADDRES_BUS) OF STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);

--------DEFINIÇÃO DOS SINAIS QUE SEÃO USADOS INTERNAMENTE---------  
SIGNAL  reg : bank; -- essa variável (bank) consiste no banco de registradores (baseada no tipo acima)
SIGNAL S_RA_ADDR, S_RB_ADDR, S_RC_ADDR : INTEGER RANGE 0 TO 2**ADDRES_BUS;

  
BEGIN
-------CONVERTENDO OS ENDEREÇOS PARA UM INTEIRO SEM SINAL---------
  S_RA_ADDR <= conv_integer(RA_ADDR);
  S_RB_ADDR <= conv_integer(RB_ADDR);
  S_RC_ADDR <= conv_integer(RC_ADDR);

--********* Gravação do dado contido no barramento de entrada, endereçado por RA_ADDR
PROCESS (clk)
  BEGIN
    IF ((clk'EVENT AND clk = '1') AND (RA_EN = '1')) THEN
      reg(S_RA_ADDR) <= RA_DATA;
    END IF;
  END PROCESS;
  

--********* Disponibilização do dado contido no registrador endereçado por RB_ADDR no barramento de saída "B"
  RB_DATA <= reg(S_RB_ADDR) WHEN RB_EN = '1' ELSE
             "00000000";
  
--********* Disponibilização do dado contido no registrador endereçado por RC_ADDR no barramento de saída "C"    
  RC_DATA <= reg(S_RC_ADDR) WHEN RC_EN = '1' ELSE
             "00000000"; 
   
	 
END ARCHITECTURE ckt;