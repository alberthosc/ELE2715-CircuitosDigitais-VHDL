library ieee ;
use ieee.std_logic_1164.all;
--==================--
-- Registrador PC   --
--==================--
entity REG_PC is
  port( clk,en,clr: in std_logic;
        D: in std_logic_vector (7 downto 0);
        S: out std_logic_vector (7 downto 0));
end REG_PC;

architecture logic of REG_PC is
  component reg1 IS
	port( clk, D,C,en: in std_logic;
        S: out std_logic);
end component;

signal S_S:std_logic_vector (7 downto 0);
  begin
    
  reg01: reg1 port map(clk,D(0),clr,en,S_S(0));
  reg02: reg1 port map(clk,D(1),clr,en,S_S(1));
  reg03: reg1 port map(clk,D(2),clr,en,S_S(2));
  reg04: reg1 port map(clk,D(3),clr,en,S_S(3));
  reg05: reg1 port map(clk,D(4),clr,en,S_S(4));
  reg06: reg1 port map(clk,D(5),clr,en,S_S(5));
  reg07: reg1 port map(clk,D(6),clr,en,S_S(6));
  reg08: reg1 port map(clk,D(7),clr,en,S_S(7));

S <= S_S;
  
end logic;