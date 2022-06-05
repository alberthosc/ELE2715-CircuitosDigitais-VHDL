----------------------BIBLIOTECAS------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;
---------------------------------------------------------------------------


-------------------DECLARAÇÃO DA ENTIDADE----------------------------------
ENTITY m_ram IS
  PORT (clk, en, RW: IN STD_LOGIC;
           ADDR: IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- endereco que se deseja ler ou escrever
        dado_in: IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- Contem o dado de entrada
       dado_out: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); --Contém o dado de saida
END ENTITY m_ram;


------------------DEFININDO A ARQUITETURA DO CIRCUITO----------------------
ARCHITECTURE ckt OF m_ram IS
  TYPE mem IS ARRAY (0 TO 2**8) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    
  SIGNAL ADDRi: INTEGER RANGE 0 TO 2**8;
  
  SIGNAL ram: mem := (0 => "00000000",  --valor 0
                      1 => "00000001",  --valor 1
                      2 => "10000000",  --Valor 128
                      3 => "00000101",  --valor 5
                 others => "00000000");
  
BEGIN
  
  ADDRi <= conv_integer(ADDR);
  
  PROCESS (clk)
  BEGIN
    IF ((clk'EVENT AND clk = '1') AND (RW = '1') AND (en = '1')) THEN
      ram(ADDRi) <= dado_in;
    END IF;
  END PROCESS;
    
  dado_out <= ram(ADDRi);
        
END ARCHITECTURE ckt;