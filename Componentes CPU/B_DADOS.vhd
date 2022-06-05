--**************************************************************--
--**                      Bloco de dados                      **--
------------------------------------------------------------------
------------------------------------------------------------------ 

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------

-------------------- DECLARAÇÃO DA ENTIDADE ----------------------
ENTITY b_dados IS
  
PORT (        Ra_addr, Rb_addr, Rc_addr: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	    clk, Ra_en, Rb_en, Rc_en, seletor: IN STD_LOGIC;
	                                opula: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	                               r_data: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	                               w_data: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	                        carry, ula_z: OUT STD_LOGIC);
END b_dados;

-------INICIO DA CODIFICAÇÃO DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF b_dados IS

---------------USANDO UM MUX----------------
COMPONENT mux8_21 IS
GENERIC (DATA_BUS : INTEGER := 8); ----Largura do barramento de dados (8 bits)

PORT (      CH : IN STD_LOGIC;
    CH_0, CH_1 : IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
            O : OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0));
END COMPONENT mux8_21;

---------------USANDO UM BANCO DE REGISTRADORES----------------
COMPONENT reg16_8 IS
GENERIC (DATA_BUS : INTEGER := 8; ----Largura do barramento de dados (8 bits)
         ADDRES_BUS : INTEGER :=  4); --Largura do barramento de dendereço (4 bits)
         
PORT (clk, RA_EN, RB_EN, RC_EN : IN STD_LOGIC;
     RA_ADDR, RB_ADDR, RC_ADDR : IN STD_LOGIC_VECTOR((ADDRES_BUS-1) DOWNTO 0);
                       RA_DATA : IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
              RB_DATA, RC_DATA : OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0));
END COMPONENT reg16_8;

---------------USANDO A ULA----------------
COMPONENT ula IS
  PORT (             OP: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
   DATA_IN_0, DATA_IN_1: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
               DATA_OUT: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
           CARRY, ULA_0: OUT STD_LOGIC);
END COMPONENT ula;


--------DEFINIÇÃO DOS SINAIS QUE SERÃO USADOS INTERNAMENTE---------
SIGNAL MUX_TO_REG, ULA_TO_MUX : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL   Rb_TO_ULA, Rc_TO_ULA : STD_LOGIC_VECTOR(7 DOWNTO 0);


BEGIN
  
   mux: mux8_21 PORT MAP (seletor, r_data, ULA_TO_MUX, MUX_TO_REG);
   reg: reg16_8 PORT MAP (clk, Ra_en, Rb_en, Rc_en, Ra_addr, Rb_addr, Rc_addr, MUX_TO_REG, Rb_TO_ULA, Rc_TO_ULA);
  uula: ula     PORT MAP (opula, Rc_TO_ULA, Rb_TO_ULA, ULA_TO_MUX, carry, ula_z);
    
	w_data <= Rb_TO_ULA;
	
END ckt;


