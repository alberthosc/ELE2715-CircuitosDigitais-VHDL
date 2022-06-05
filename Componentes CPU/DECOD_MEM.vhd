--**************************************************************--
--**  DECODIFICADOR DAS OPERA합ES DO BANCO DE REGISTRADORES   **--
--** ***********************************************************--
------------------------------------------------------------------ 

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------

----------------------DECLARA플O DA ENTIDADE----------------------
ENTITY decod_mem IS
  PORT ( IR_DATA_IN:  IN STD_LOGIC_VECTOR(15 DOWNTO 0);
         Ram_en, rw: OUT STD_LOGIC;
           Ram_addr: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END ENTITY decod_mem;

-------INICIO DA CODIFICA플O DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF decod_mem IS

--------DEFINI플O DOS SINAIS QUE SE홒 USADOS INTERNAMENTE---------  
  SIGNAL OPCODE : STD_LOGIC_VECTOR(3 DOWNTO 0);

   
BEGIN
  
  OPCODE <= IR_DATA_IN(15 DOWNTO 12);
 
 --**   HABILITA플O DOS REGISTRADORES  **--
  
  Ram_en <= '1' WHEN OPCODE = "0001" ELSE
            '1' WHEN OPCODE = "0010" ELSE
            '0';
           
           
           
  rw <= '1' WHEN OPCODE = "0010" ELSE
        '0';
       
       
           
  Ram_addr <= IR_DATA_IN(7 DOWNTO 0) WHEN OPCODE = "0001" ELSE
              IR_DATA_IN(7 DOWNTO 0) WHEN OPCODE = "0010" ELSE
              "00000000";
 
 
                         
END ARCHITECTURE ckt;
