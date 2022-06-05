----------------------BIBLIOTECAS------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;
---------------------------------------------------------------------------


-------------------DECLARAÇÃO DA ENTIDADE----------------------------------
ENTITY m_rom IS
  PORT (clk, en: IN STD_LOGIC;
           ADDR: IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- endereco que se deseja ler ou escrever
       dado_out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)); --Contém o dado de saida
END ENTITY m_rom;


------------------DEFININDO A ARQUITETURA DO CIRCUITO----------------------
ARCHITECTURE ckt OF m_rom IS
  TYPE mem IS ARRAY (0 TO 2**8) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
  
  SIGNAL ADDRi: INTEGER RANGE 0 TO 2**8;
  
  SIGNAL rom: mem := (0 => "0001000000000000",  --carrega - 0
                      1 => "0001000100000001",  --carrega  - 1
                      2 => "0001001000000010",  --carrega  - 128
                      3 => "0001001100000011", --carrega  - 5
                      4 => "0011000011110000", -- iniciando o cont.
                      5 => "0011000001110000", -- iniciando o cont.
                      6 => "0100111111110010", -- soma 128 ao R
                      7 => "1101000000000110", -- salta 6 linha para frente
                      8 => "0101001100110001", -- subtrai 1 do R 
                      9 => "1110000010000011", -- salta -3 linhas
                     10 => "0010011100000100", --MSB 16 bits
                     11 => "0010111100000101", --LSB 16 bits
                     12 => "0000000000000000", --Fim do programa     
                     13 => "0100011101110001", -- adiciona 1 ao R
                     14 => "1011000010000110", -- Salta -6 linhas
                 others => "0000000000000000");
  
BEGIN
  ADDRi <= conv_integer(ADDR);
  
  PROCESS (clk) BEGIN
    IF ((clk'EVENT AND clk = '1') AND (en = '1') ) THEN
      dado_out <= rom(ADDRi);
    END IF;
  END PROCESS;

 
END ARCHITECTURE ckt;


