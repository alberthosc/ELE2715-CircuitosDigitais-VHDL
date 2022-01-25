-- Autor: Albertho Síziney Costa
-- 28/02/2021
-- Circuito somador de dois valores BCD 4 bits e um carry, formado por 4 somadores completos.

---Somador Completo---
entity SC is
port (
	signal A: in bit;
	signal B: in bit;
	signal CI: in bit;
	signal  CO: out bit;
	signal  S: out bit);
end SC ;

architecture LOGICA of SC is

begin
	CO <= (A AND B) OR (A AND CI) OR (B AND CI);
	S  <= (A XOR B XOR CI);
end LOGICA ;
---Somador Completo---


---Somador Completo 4 bits---
entity SC4BITS is
port (
	signal A: in bit_vector ( 3 downto 0);
	signal B: in bit_vector ( 3 downto 0);
	signal CI: in bit;
	signal CO: out bit;
	signal S: out bit_vector ( 3 downto 0));
end SC4BITS ;

architecture LOGICA of SC4BITS is
	signal CO0,CO1,CO2,CO3: bit;
component SC is
port (
	signal A: in bit;
	signal B: in bit;
	signal CI: in bit;
	signal  CO: out bit;
	signal  S: out bit);
end component;

begin
	chamadasoma1: SC port map(A(0),B(0),'0',CO0,S(0));
	chamadasoma2: SC port map(A(1),B(1),CO0,CO1,S(1));
	chamadasoma3: SC port map(A(2),B(2),CO1,CO2,S(2));
	chamadasoma4: SC port map(A(3),B(3),CO2,CO3,S(3));

	CO <= CO3;

end LOGICA ;
---Somador Completo 4 bits---

---Somador BCD---
entity SBCD is
port (
	signal X: in bit_vector ( 3 downto 0);
	signal Y: in bit_vector ( 3 downto 0);
	signal CI: in bit;
	signal CO: out bit;
	signal Z: out bit_vector ( 7 downto 0));
end SBCD ;

architecture LOGICA of SBCD is

	signal Cout1,Cout2,soma6: bit;
	signal S1,S2,numero6,s6ou0: bit_vector (3 downto 0);

component SC4BITS is
port (
	signal A: in bit_vector ( 3 downto 0);
	signal B: in bit_vector ( 3 downto 0);
	signal CI: in bit;
	signal CO: out bit;
	signal S: out bit_vector ( 3 downto 0));
end component;

begin
	numero6 <= ('0','1','1','0');
	chamadasoma1: SC4BITS port map(X,Y,'0',Cout1,S1);
	soma6 <= ((S1(3) OR (S1(2) AND S1(0)) OR (S1(2) AND S1(1))) );
	s6ou0 <= (numero6(3) AND soma6, numero6(2) AND soma6, numero6(1) AND soma6, numero6(0) AND soma6);
	chamadasoma2: SC4BITS port map(S1,s6ou0,'0',Cout2,S2);
	
	Z <= ('0','0','0',soma6,S2(3),S2(2),S2(1),S2(0));
	CO <= '0';

end LOGICA ;
---Somador BCD---
