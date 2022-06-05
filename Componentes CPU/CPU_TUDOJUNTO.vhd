----------------------------------------------------
--												  --
--  SISTEMAS DIGITAIS - SEMANA 04 - IMPLEMENTAï¿½ï¿½O --
--	GRUPO 1: ELIAS, LUCAS, ALBERTHO E MARCELO      --
--												  --
----------------------------------------------------

-------------------------------------
library ieee;
use ieee.std_logic_1164.all;
-------------------------------------


entity CPU_GERAL is
	port( 
    
	
        rst,clk : in STD_LOGIC


    );

end CPU_GERAL;

-------------------------
architecture ckt of CPU_GERAL is

component b_dados IS
  
PORT (  
        Ra_addr, Rb_addr, Rc_addr: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	    clk, Ra_en, Rb_en, Rc_en, seletor: IN STD_LOGIC;
	    opula: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	    r_data: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    w_data: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	    carry, ula_z: OUT STD_LOGIC
    
    );
END component;
-----------
-- ROM ----
component m_rom IS

  PORT (clk, en: IN STD_LOGIC;
           ADDR: IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- endereco que se deseja ler ou escrever
       dado_out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)); --Contém o dado de saida
END component;

-------------------------
-- CHAMADO DO REG DE 1 BIT --

component reg_1_bit IS
  
PORT ( 
    
        clk, CLEAR, EN, DATA_IN: IN STD_LOGIC;
	    DATA_OUT: OUT STD_LOGIC
        
    );
END component;

-------------------------
------ RAM -----------
component m_ram IS
  PORT (clk, en, RW: IN STD_LOGIC;
           ADDR: IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- endereco que se deseja ler ou escrever
        dado_in: IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- Contem o dado de entrada
       dado_out: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); --Contém o dado de saida
END component;

-------------------------

component MDE is
    port(
			  
		Carry, Zero_ULA, clk, rst : in std_logic;				  
    En_Carry_ZeroULA : out std_logic;
		IR_in : in std_logic_vector(15 downto 0);
		Ra_addr, Rb_addr, Rc_addr : out std_logic_vector(3 downto 0);
		addr : out std_logic_vector(7 downto 0);
		seletor, Ra_en, Rb_en, Rc_en, En_RAM, rw, En_PCIRROM, Load_PC, PC_Clear : out std_logic;
		OpULA : out std_logic_vector(2 downto 0);   
		PC : out std_logic_vector (7 downto 0 )		
		
);
end component;

-------------------------

component Salto is
	port (
        
        IR_OUT,PC_OUT: in STD_LOGIC_VECTOR (7 downto 0);
		SALTO_OUT: out STD_LOGIC_VECTOR (7 downto 0)
    
    );
end component;

------------------------

component reg_ir IS

GENERIC (DATA_BUS : INTEGER := 16); ----Largura do barramento de dados (16 bits)
  
PORT ( 
    
        clk, en: IN STD_LOGIC;
	     DATA_IN: IN STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0);
	    DATA_OUT: OUT STD_LOGIC_VECTOR((DATA_BUS-1) DOWNTO 0)
        
    );
END component;

-------------------------

component PC IS
PORT( 
    
        PC_Clear,Load_PC,clk,En_PCIRROM: IN STD_LOGIC;
	    salto_in: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    OUT_PC: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        
    );
END component;


    
    
    -- PC_OUT sinal de 8 bits que sai do PC e vai para a ROM. --
    -- IR_OUT sinal que sai de IR e vai para o salto          --
     
    
    signal PC_OUT, Sig_Salto,PC_OUT_MDE, addr, W_data, R_data : std_logic_vector (7 downto 0);    
    signal IR_OUT,Data : std_logic_vector (15 downto 0);
    signal En_Ra, En_Rb, En_Rc, seletor, En_PCIRROM, Carry, Zero_ULA, Reg_Carry, 
    Reg_Zero_ULA, En_Carry_ZeroULA, PC_Clear, Load_PC, En_RAM,En_ROM,rw: std_logic;
    signal Ra_addr, Rb_addr, Rc_addr : std_logic_vector (3 downto 0);
    signal OpULA : std_logic_vector (2 downto 0);
    
    begin

    En_ROM <= En_PCIRROM;
    
--    ROM_Value <= PC_OUT;
 
                              
    Bloco_date : b_dados port map (Ra_addr, Rb_addr, Rc_addr, clk, En_Ra, En_Rb, En_Rc, seletor, OpULA, R_data, W_data, Carry, Zero_ULA);
    
    Register_Carry : reg_1_bit port map (clk, '0', En_Carry_ZeroULA, Carry, Reg_Carry);
    Register_Zero_ULA : reg_1_bit port map (clk, '0', En_Carry_ZeroULA, Zero_ULA, Reg_Zero_ULA);
    
    Register_IR : reg_ir port map (clk, En_PCIRROM, Data, IR_OUT);
    PC_VAI_ROM : PC port map (PC_Clear, Load_PC,clk, En_PCIRROM, Sig_Salto, PC_OUT);
    SALTA_PFV : Salto port map (IR_OUT (7 downto 0 ), PC_OUT, Sig_Salto);
    VAI_LA_MDE : MDE port map (Reg_Carry, Reg_Zero_ULA, clk, rst, En_Carry_ZeroULA, IR_OUT, Ra_addr, Rb_addr, Rc_addr, addr, seletor, 
    En_Ra, En_Rb, En_Rc, En_RAM,rw,En_PCIRROM, Load_PC, PC_Clear, OpULA, PC_OUT_MDE);

    Chamada_ROM : m_rom port map (clk, '1',PC_OUT,Data);
    Chamada_RAM : m_ram port map (clk, '1',rw,addr,W_data,R_data);


end ckt; 





