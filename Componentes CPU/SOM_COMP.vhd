--**************************************************************--
--**             Somador de 1 bit com carry                   **--
------------------------------------------------------------------
--**    ADD_OUT recebe o resulltado de uma operação de soma  **--
--**    binaria entre A e B                   **--
------------------------------------------------------------------ 

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------

-------------------- DECLARAÇÃO DA ENTIDADE ----------------------  
ENTITY som_comp IS
PORT( A, B, CARRY_IN: IN STD_LOGIC;
	ADD_OUT, CARRY_OUT: OUT STD_LOGIC);
END som_comp;

-------INICIO DA CODIFICAÇÃO DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF som_comp IS

BEGIN
	ADD_OUT <=((A XOR B) XOR CARRY_IN);
	CARRY_OUT<=(A AND (B OR CARRY_IN)) OR (B AND CARRY_IN);
END ckt;
