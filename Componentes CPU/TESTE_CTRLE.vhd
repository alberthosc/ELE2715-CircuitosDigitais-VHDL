--**************************************************************--
--**                      Bloco de dados                      **--
------------------------------------------------------------------
------------------------------------------------------------------ 

----------------------BIBLIOTECAS---------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------------

-------------------- DECLARAÇÃO DA ENTIDADE ----------------------
ENTITY teste_ctrle IS
  
PORT (   data_in: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	    clk, en_ir: IN STD_LOGIC);
	    
END teste_ctrle;

-------INICIO DA CODIFICAÇÃO DA ARQUITETURA DO CIRCUITO-----------
ARCHITECTURE ckt OF teste_ctrle IS

---------------USANDO O IR----------------
COMPONENT reg_ir IS
GENERIC (DATA_BUS : INTEGER := 16); ----Largura do barramento de dados (16 bits)
  
PORT ( clk, en: IN STD_LOGIC;
	     DATA_IN: IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	    DATA_OUT: OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0));
END COMPONENT reg_ir;


COMPONENT decod_ula IS
  PORT ( OPCODE:  IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          opULA: OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
END COMPONENT decod_ula;


COMPONENT decod_reg IS
  PORT ( IR_DATA_IN:  IN STD_LOGIC_VECTOR(15 DOWNTO 0);
                 Ra_en, Rb_en, Rc_en: OUT STD_LOGIC;
          Ra_addr, Rb_addr, Rc_addr : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END COMPONENT decod_reg;


COMPONENT decod_mem IS
  PORT ( IR_DATA_IN:  IN STD_LOGIC_VECTOR(15 DOWNTO 0);
         Ram_en, rw: OUT STD_LOGIC;
           Ram_addr: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END COMPONENT decod_mem;


COMPONENT decod_seletor IS
  PORT ( OPCODE:  IN STD_LOGIC_VECTOR(3 DOWNTO 0);
         seletor: OUT STD_LOGIC);
         
END COMPONENT decod_seletor;


--------DEFINIÇÃO DOS SINAIS QUE SEÃO USADOS INTERNAMENTE---------
SIGNAL S_OUT_IR : STD_LOGIC_VECTOR(15 DOWNTO 0);

SIGNAL OUT_OP_ULA: STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL Ra, Rb, Rc, en_RAM, rw_RAM: STD_LOGIC;
SIGNAL RAAddr, RBAddr, RCAddr: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL addr_RAM: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL seletor: STD_LOGIC;



BEGIN
  
       IRt: reg_ir PORT MAP (clk, en_ir, data_in, S_OUT_IR);
     D_ula: decod_ula PORT MAP (S_OUT_IR(15 DOWNTO 12), OUT_OP_ULA);
    decodr: decod_reg PORT MAP (S_OUT_IR, Ra, Rb, Rc, RAAddr, RBAddr, RCAddr);
  decodmem: decod_mem PORT MAP (S_OUT_IR, en_RAM, rw_RAM, addr_RAM);
  seletort: decod_seletor PORT MAP (S_OUT_IR(15 DOWNTO 12),seletor); 
  
	
END ckt;


