-- Autor: Albertho Síziney Costa
-- 07/02/2021
-- Exibição de um valor BCD de um número binário de 8 bits em 3 displays de 7 segmentos.

--Lógica do Display (Para ser chamado como componente)
entity Display7 is
port (
	signal INBIT: in bit_vector (3 downto 0);
	signal HEX: out bit_vector (6 downto 0));
end Display7 ;
architecture LOGICA of Display7 is
signal A,B,C,D : bit;
begin
	D <= INBIT(0);
	C <= INBIT(1);
	B <= INBIT(2);
	A <= INBIT(3);
	HEX(0) <= A OR (NOT(B) AND NOT(D)) OR (NOT(B) AND C) OR (B AND D); ---A + B'D' + B'C + BD
	HEX(1) <= NOT(B) OR (NOT(C) AND NOT(D)) OR (C AND D); --- B' + C'D' + CD
	HEX(2) <= NOT(C) OR D OR B; ---C' + D + B
	HEX(3) <= (NOT(B) AND NOT(D)) OR (NOT(B) AND C) OR (C AND NOT(D)) OR (B AND NOT(C) AND D); ---B'D' + B'C + CD' + BC'D
	HEX(4) <= (NOT (B) AND NOT(D)) OR (C AND NOT(D)); ---B'D' + CD'
	HEX(5) <= A OR (NOT(C) AND NOT(D)) OR (B AND NOT(C)) OR (B AND NOT(D)); ---A + C'D' + BC' + BD'
	HEX(6) <= A OR (NOT(B) AND C) OR (C AND NOT(D)) OR (B AND NOT(C)); ---A + B'C + CD' + BC'

end LOGICA ;

--Lógica do CI (Para ser chamado como componente)
entity CI is
port (
	signal A : in bit_vector (3 downto 0);
	signal S : out bit_vector (3 downto 0));

end CI;

architecture LOGICA of CI is
 	signal X,Y,Z,W : bit;
begin
	Z <= A(0);
	Y <= A(1);
	W <= A(2);
	X <= A(3);

	S(0) <= (X AND NOT(Z)) OR (NOT(X) AND NOT(W) AND Z) OR (W AND Y AND NOT(Z));
	S(1) <= (NOT(W) AND Y) OR (Y AND Z) OR (X AND NOT(Z));
	S(2) <= (X AND Z) OR (W AND NOT(Y) AND NOT(Z));
	S(3) <= X OR (W AND Z) OR (W AND Y);

end LOGICA;
---
---
---
---
--- Bloco BIN-BCD
entity BINBCD is
port (
	signal SW: in bit_vector (7 downto 0));
end BINBCD;

architecture LOGICA of BINBCD is

--- componente CI

component CI is
port (
	signal A : in bit_vector (3 downto 0);
	signal S : out bit_vector (3 downto 0));

end component;

--- componente Display7

component Display7 is
port (
	INBIT: in bit_vector (3 downto 0);
	HEX: out bit_vector (6 downto 0));
end component ; 

	signal CI1A,CI2A,CI3A,CI4A,CI5A,CI6A,CI7A: bit_vector (3 downto 0);
	signal CI1S,CI2S,CI3S,CI4S,CI5S,CI6S,CI7S: bit_vector (3 downto 0);
	signal bcd: bit_vector (11 downto 0);
	signal HEX0,HEX1,HEX2 : bit_vector (6 downto 0);
begin

-- Circuito integrado 1

	CI1A(3) <= '0';
	CI1A(2) <= SW(7);
	CI1A(1) <= SW(6);
	CI1A(0) <= SW(5);
	
chamada1: CI port map(CI1A,CI1S);

-- Circuito integrado 2

	CI2A(3) <= CI1S(2);
	CI2A(2) <= CI1S(1);
	CI2A(1) <= CI1S(0);
	CI2A(0) <= SW(4);
	
chamada2: CI port map(CI2A,CI2S);

-- Circuito integrado 3

	CI3A(3) <= CI2S(2);
	CI3A(2) <= CI2S(1);
	CI3A(1) <= CI2S(0);
	CI3A(0) <= SW(3);
	
chamada3: CI port map(CI3A,CI3S);

-- Circuito integrado 4

	CI4A(3) <= '0';
	CI4A(2) <= CI1S(3);
	CI4A(1) <= CI2S(3);
	CI4A(0) <= CI3S(3);
	
chamada4: CI port map(CI4A,CI4S);

-- Circuito integrado 5

	CI5A(3) <= CI3S(2);
	CI5A(2) <= CI3S(1);
	CI5A(1) <= CI3S(0);
	CI5A(0) <= SW(2);
	
chamada5: CI port map(CI5A,CI5S);

-- Circuito integrado 6

	CI6A(3) <= CI4S(2);
	CI6A(2) <= CI4S(1);
	CI6A(1) <= CI4S(0);
	CI6A(0) <= CI5S(3);
	
chamada6: CI port map(CI6A,CI6S);

-- Circuito integrado 7

	CI7A(3) <= CI5S(2);
	CI7A(2) <= CI5S(1);
	CI7A(1) <= CI5S(0);
	CI7A(0) <= SW(1);
	
chamada7: CI port map(CI7A,CI7S);

-- Declaração do bcd

	bcd(11) <= '0';
	bcd(10) <= '0';
	bcd(9) <= CI4S(3);
	bcd(8) <= CI6S(3);
	bcd(7) <= CI6S(2);
	bcd(6) <= CI6S(1);
	bcd(5) <= CI6S(0);
	bcd(4) <= CI7S(3);
	bcd(3) <= CI7S(2);
	bcd(2) <= CI7S(1);
	bcd(1) <= CI7S(0);
	bcd(0) <= SW(0);

-- Direcionando aos Displays

direcionamento1 : Display7 port map (bcd(3 downto 0), HEX0(6 downto 0));
direcionamento2 : Display7 port map (bcd(7 downto 4), HEX1(6 downto 0));
direcionamento3 : Display7 port map (bcd(11 downto 8), HEX2(6 downto 0));

end LOGICA ;
