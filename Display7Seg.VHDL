-- Autor: Albertho Síziney Costa
-- 07/03/2020
-- Exibição de um valor hexadecimal de 4 bits em um display de 7 segmentos 

entity Atividade01 is
port (SW: in bit_vector (3 downto 0);
HEX: out bit_vector (6 downto 0));
end Atividade01 ;
architecture LOGICA of Atividade01 is
signal A,B,C,D : bit;
begin
D <= SW(0);
C <= SW(1);
B <= SW(2);
A <= SW(3);
HEX(0) <= (not(C)) or (B and D) or (A and D) or (A and B);
HEX(1) <= (not(A) and not(B) and not(C)) or (not(A) and D) or (B and C) or (B and D) or (not(D) and C and A);
HEX(2) <= (not(D) and A) or (A and B) or (not(A) and C) or (not(A) and not(B));
HEX(3) <= (not(A) and not(D) and C) or (not(A) and B) or (not(C) and not(B) and D) or (not(D) and not(C) and A) or (not(D) and B);
HEX(4) <= (not(A) and not(C)) or (not(A) and not(D)) or (not(B) and not(C)) or (not(B) and A and D) or (not(D) and B and C);
HEX(5) <= (not(C) and not(D)) or (A and C) or (not(B) and not(C)) or (not(B) and not(D));
HEX(6) <= (not(B) and A) or (B and C) or (not(D) and A) or (not(B) and not(D)) or (not(A) and B and D);
end LOGICA ;
