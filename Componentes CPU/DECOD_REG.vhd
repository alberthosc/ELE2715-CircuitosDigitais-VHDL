--**************************************************************--
--**  DECODIFICADOR DAS OPERAÇÕES DO BANCO DE REGISTRADORES   **--
--** ***********************************************************--
------------------------------------------------------------------ 

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------

----------------------DECLARAÇÃO DA ENTIDADE----------------------
ENTITY decod_reg IS
  PORT ( IR_DATA_IN:  IN STD_LOGIC_VECTOR(15 DOWNTO 0);
                 Ra_en, Rb_en, Rc_en: OUT STD_LOGIC;
          Ra_addr, Rb_addr, Rc_addr : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END ENTITY decod_reg;

-------INICIO DA CODIFICAÇÃO DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF decod_reg IS

--------DEFINIÇÃO DOS SINAIS QUE SEÃO USADOS INTERNAMENTE---------  
  SIGNAL OPCODE : STD_LOGIC_VECTOR(3 DOWNTO 0);
  
    

   
BEGIN
  
  OPCODE <= IR_DATA_IN(15 DOWNTO 12);
 
 --**   HABILITAÇÃO DOS REGISTRADORES  **--
  
  Ra_en <= '1' WHEN OPCODE = "0001" ELSE
           '1' WHEN OPCODE = "0011" ELSE
           '1' WHEN OPCODE = "0100" ELSE
           '1' WHEN OPCODE = "0101" ELSE
           '1' WHEN OPCODE = "0110" ELSE
           '1' WHEN OPCODE = "0111" ELSE
           '1' WHEN OPCODE = "1000" ELSE
           '1' WHEN OPCODE = "1001" ELSE
           '1' WHEN OPCODE = "1010" ELSE
           '0';
           
  Rb_en <= '1' WHEN OPCODE = "0010" ELSE
           '1' WHEN OPCODE = "0100" ELSE
           '1' WHEN OPCODE = "0101" ELSE
           '1' WHEN OPCODE = "0110" ELSE
           '1' WHEN OPCODE = "0111" ELSE
           '1' WHEN OPCODE = "1001" ELSE
           '1' WHEN OPCODE = "1010" ELSE
           '0';
           
  Rc_en <= '1' WHEN OPCODE = "0011" ELSE
           '1' WHEN OPCODE = "0100" ELSE
           '1' WHEN OPCODE = "0101" ELSE
           '1' WHEN OPCODE = "0110" ELSE
           '1' WHEN OPCODE = "0111" ELSE
           '1' WHEN OPCODE = "1000" ELSE
           '1' WHEN OPCODE = "1001" ELSE
           '1' WHEN OPCODE = "1010" ELSE
           '0';
           
           
--**   ENDEREÇAMENTO DOS REGISTRADORES  **--           
           
           
  Ra_addr <= IR_DATA_IN(11 DOWNTO 8) WHEN OPCODE = "0001" ELSE
             IR_DATA_IN( 7 DOWNTO 4) WHEN OPCODE = "0011" ELSE
             IR_DATA_IN(11 DOWNTO 8) WHEN OPCODE = "0100" ELSE
             IR_DATA_IN(11 DOWNTO 8) WHEN OPCODE = "0101" ELSE
             IR_DATA_IN(11 DOWNTO 8) WHEN OPCODE = "0110" ELSE
             IR_DATA_IN(11 DOWNTO 8) WHEN OPCODE = "0111" ELSE
             IR_DATA_IN(11 DOWNTO 8) WHEN OPCODE = "1000" ELSE
             IR_DATA_IN(11 DOWNTO 8) WHEN OPCODE = "1001" ELSE
             IR_DATA_IN(11 DOWNTO 8) WHEN OPCODE = "1010" ELSE
             "0000";
           
  Rb_addr <= IR_DATA_IN(11 DOWNTO 8) WHEN OPCODE = "0010" ELSE
             IR_DATA_IN( 7 DOWNTO 4) WHEN OPCODE = "0100" ELSE
             IR_DATA_IN( 7 DOWNTO 4) WHEN OPCODE = "0101" ELSE
             IR_DATA_IN( 7 DOWNTO 4) WHEN OPCODE = "0110" ELSE
             IR_DATA_IN( 7 DOWNTO 4) WHEN OPCODE = "0111" ELSE
             IR_DATA_IN( 7 DOWNTO 4) WHEN OPCODE = "1001" ELSE
             IR_DATA_IN( 7 DOWNTO 4) WHEN OPCODE = "1010" ELSE
             "0000";
           
  Rc_addr <= IR_DATA_IN(3 DOWNTO 0) WHEN OPCODE = "0011" ELSE
             IR_DATA_IN(3 DOWNTO 0) WHEN OPCODE = "0100" ELSE
             IR_DATA_IN(3 DOWNTO 0) WHEN OPCODE = "0101" ELSE
             IR_DATA_IN(3 DOWNTO 0) WHEN OPCODE = "0110" ELSE
             IR_DATA_IN(3 DOWNTO 0) WHEN OPCODE = "0111" ELSE
             IR_DATA_IN(3 DOWNTO 0) WHEN OPCODE = "1000" ELSE
             IR_DATA_IN(3 DOWNTO 0) WHEN OPCODE = "1001" ELSE
             IR_DATA_IN(3 DOWNTO 0) WHEN OPCODE = "1010" ELSE
             "0000";  
                         
END ARCHITECTURE ckt;
