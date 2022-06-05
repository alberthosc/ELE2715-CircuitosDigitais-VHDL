--**************************************************************--
--**                SELETOR DO CANAL DO MUX                   **--
--** ***********************************************************--
------------------------------------------------------------------ 

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------

----------------------DECLARA��O DA ENTIDADE----------------------
ENTITY decod_seletor IS
  PORT ( OPCODE:  IN STD_LOGIC_VECTOR(3 DOWNTO 0);
         seletor: OUT STD_LOGIC);
         
END ENTITY decod_seletor;

-------INICIO DA CODIFICA��O DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF decod_seletor IS

--------DEFINI��O DOS SINAIS QUE SE�O USADOS INTERNAMENTE---------  

   
BEGIN
  
  seletor <= '0' WHEN OPCODE = "0001" ELSE
             '1';
                         
END ARCHITECTURE ckt;

