library ieee ;
use ieee.std_logic_1164.all;
--============--
-- FlipFlop D --
--============--
ENTITY ffd2 IS
	port ( clk ,D ,P , C: IN std_logic ;
		q: OUT std_logic );
END ffd2 ;

ARCHITECTURE ckt OF ffd2 IS
	SIGNAL qS : std_logic;
	BEGIN
PROCESS ( clk ,P ,C)
	BEGIN
	IF P = '1' THEN qS <= '1';
	ELSIF C = '1' THEN qS <= '0';
	ELSIF clk = '1' AND clk ' EVENT THEN
	qS <= D ;
	END IF;
END PROCESS ;
q <= qS ;
END ckt ;
