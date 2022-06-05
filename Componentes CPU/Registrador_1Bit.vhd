library ieee ;
use ieee.std_logic_1164.all;
--=======================--
-- Registrador 1 bit --
--===================--
entity reg1 is
  port( clk, D,C,en: in std_logic;
        S: out std_logic);
end reg1;

architecture logic of reg1 is
  component ffd2 IS
	port ( clk ,D ,P , C: IN std_logic ;
		q : OUT std_logic );
end component;

  signal a,s_d: std_logic;  

  begin
    
  ffd1: ffd2 port map(clk,s_d,'0',C,a);

s_d <= (a and (not en)) or (D and en);

S <= a;

end logic;
