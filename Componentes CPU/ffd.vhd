--**************************************************************--
--** C�digo que implemnta um flip flop tipo D                 **--
------------------------------------------------------------------

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------

-------------------- DECLARA��O DA ENTIDADE ----------------------
ENTITY ffd IS 
	PORT (clk,D,P,C: IN STD_LOGIC; 
	              q: OUT STD_LOGIC); 
END ffd;

-------INICIO DA CODIFICA��O DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF ffd IS
  
--------DEFINI��O DOS SINAIS QUE SE�O USADOS INTERNAMENTE---------
   SIGNAL qS: STD_LOGIC;

BEGIN 

PROCESS(clk,P,C) 

BEGIN 

	IF P = '0' THEN qS <= '1';
        ELSIF C = '0' THEN qS <= '0';
        ELSIF clk'EVENT AND clk = '1' THEN qS <= D; 
        END IF;
 END PROCESS;
 q <= qS; 
END ckt; 
