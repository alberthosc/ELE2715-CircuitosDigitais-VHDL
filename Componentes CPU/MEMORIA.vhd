--**************************************************************--
--** Memória de 256 endereços, com 8 bits de informação por   **--
--** endereço.                                                **--
--**                                                          **--
------------------------------------------------------------------
--**    Se RW = '0', R_DATA receberá a informação contida     **--
--** no endereço informado em ADDR.                           **--
--**    Se RW = '1', em um pulso de clock, será gravado no    **--
--** endereço informado em ADDR a informação contida em       **--
--** W_DATA.                                                  **--
--**    Para que aconteça o que está descrito acima, EN deve  **--
--** ser '1'. Se EN = 0, nenhuma das operações acima seão     **--
--** executadas e, nesse caso, R_DATA será 00000000.          **--
------------------------------------------------------------------ 

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;
------------------------------------------------------------------


----------------------DECLARAÇÃO DA ENTIDADE----------------------
ENTITY memoria IS
  GENERIC (DATA_BUS : INTEGER := 8; ----Largura do barramento de dados (8 bits)
         ADDRES_BUS : INTEGER :=  8); --Largura do barramento de dendereço (8 bits)
         
  PORT (  clk, RW, EN: IN STD_LOGIC;
                 ADDR: IN STD_LOGIC_VECTOR(ADDRES_BUS-1 DOWNTO 0);-- endereco que se deseja ler ou escrever
               W_DATA: IN STD_LOGIC_VECTOR(DATA_BUS-1 DOWNTO 0); -- Contem o dado de entrada
               R_DATA: OUT STD_LOGIC_VECTOR(DATA_BUS-1 DOWNTO 0)); --Contém o dado de saida
END ENTITY memoria;


-------INICIO DA CODIFICAÇÃO DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF memoria IS
  TYPE mem IS ARRAY (0 TO 2**ADDRES_BUS) OF STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
  
  
--------DEFINIÇÃO DOS SINAIS QUE SEÃO USADOS INTERNAMENTE---------  
  SIGNAL ram: mem; -- essa variável (ram) consiste na memoria (baseada no tipo acima)
  SIGNAL S_ADDR: INTEGER RANGE 0 TO 2**ADDRES_BUS; -- endereco que se deseja ler ou escrever
  
  
BEGIN
  S_ADDR <= conv_integer(ADDR);-- convertendo ADDRES para um inteiro sem sinal
  
  PROCESS (clk)
  BEGIN
    IF ((clk'EVENT AND clk = '1') AND (RW = '1') AND (EN = '1')) THEN
      ram(S_ADDR) <= W_DATA;
    END IF;
  END PROCESS;
    
  R_DATA <= ram(S_ADDR) WHEN EN = '1' ELSE
              "00000000";
        
END ARCHITECTURE ckt;