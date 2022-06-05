--**************************************************************--
--**  DECODIFICADOR DA OPERAÇÃO DA ULA, BASEADO NO OPCODE     **--
--** ***********************************************************--
------------------------------------------------------------------ 

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------

----------------------DECLARAÇÃO DA ENTIDADE----------------------
ENTITY decod_ula IS
  PORT ( OPCODE:  IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          opULA: OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
END ENTITY decod_ula;

-------INICIO DA CODIFICAÇÃO DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF decod_ula IS
  
   
BEGIN
  
  opULA <= "001" WHEN OPCODE = "0100" ELSE
           "010" WHEN OPCODE = "0101" ELSE
           "011" WHEN OPCODE = "0110" ELSE
           "100" WHEN OPCODE = "0111" ELSE
           "101" WHEN OPCODE = "1000" ELSE
           "110" WHEN OPCODE = "1001" ELSE
           "111" WHEN OPCODE = "1010" ELSE
           "000";
                         
END ARCHITECTURE ckt;
