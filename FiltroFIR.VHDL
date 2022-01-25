-- Autor: Albertho Síziney Costa
-- 18/04/2021
-- Filtro FIR com 3 taps. F = y(k).c0 + y(k-1).c1 + y(k-2).c2

---------- Flip-Flop D -------------
entity FFD is
  port (
        clk, D, P, C,LOAD : IN BIT ;
        Q, QL : OUT BIT 
       );
  
  end FFD ;
  
  architecture LOGICA of FFD is
    SIGNAL QS : BIT;
  
  begin
    PROCESS ( clk ,P ,C )
    BEGIN
    IF P = '1' THEN QS <= '1';
    ELSIF C = '1' THEN QS <= '0';
    ELSIF clk = '1' AND LOAD = '1' AND clk' EVENT THEN
    QS <= D ;
    END IF;
  
  END PROCESS ;
    Q <= QS ;
    QL <= NOT(QS);
  
  end LOGICA ;

------------------------------------------------------------------------------------------

---------- Registrador 4 bits -------------
entity REG4BITS is
  port (
        clk,C,LOAD: IN BIT ;
	D,P: IN BIT_VECTOR (3 DOWNTO 0);
        Q, QL : OUT BIT_VECTOR (3 DOWNTO 0)
       );
  
  end REG4BITS ;
  
  architecture LOGICA of REG4BITS is
    
component FFD is
	port (
        clk, D, P, C,LOAD : IN BIT ;
        Q, QL : OUT BIT 
       );
  
end component ;
  
  begin
    
	chamadaFFD0: FFD port map(clk,D(0),P(0),C,LOAD,Q(0),QL(0)); 
	chamadaFFD1: FFD port map(clk,D(1),P(1),C,LOAD,Q(1),QL(1)); 
	chamadaFFD2: FFD port map(clk,D(2),P(2),C,LOAD,Q(2),QL(2)); 
	chamadaFFD3: FFD port map(clk,D(3),P(3),C,LOAD,Q(3),QL(3)); 

  end LOGICA ;


------------------------------------------------------------------------------------------
---------- Registrador 10 bits -------------
entity REG10BITS is
  port (
        clk,C,LOAD: IN BIT ;
	D,P: IN BIT_VECTOR (9 DOWNTO 0);
        Q, QL : OUT BIT_VECTOR (9 DOWNTO 0)
       );
  
  end REG10BITS ;
  
  architecture LOGICA of REG10BITS is
    
component FFD is
	port (
        clk, D, P, C,LOAD : IN BIT ;
        Q, QL : OUT BIT 
       );
  
end component ;
  
  begin
    
	chamadaFFD0: FFD port map(clk,D(0),P(0),C,LOAD,Q(0),QL(0)); 
	chamadaFFD1: FFD port map(clk,D(1),P(1),C,LOAD,Q(1),QL(1)); 
	chamadaFFD2: FFD port map(clk,D(2),P(2),C,LOAD,Q(2),QL(2)); 
	chamadaFFD3: FFD port map(clk,D(3),P(3),C,LOAD,Q(3),QL(3)); 
	chamadaFFD4: FFD port map(clk,D(4),P(4),C,LOAD,Q(4),QL(4)); 
	chamadaFFD5: FFD port map(clk,D(5),P(5),C,LOAD,Q(5),QL(5)); 
	chamadaFFD6: FFD port map(clk,D(6),P(6),C,LOAD,Q(6),QL(6)); 
	chamadaFFD7: FFD port map(clk,D(7),P(7),C,LOAD,Q(7),QL(7)); 
	chamadaFFD8: FFD port map(clk,D(8),P(8),C,LOAD,Q(8),QL(8)); 
	chamadaFFD9: FFD port map(clk,D(9),P(9),C,LOAD,Q(9),QL(9)); 

  end LOGICA ;


------------------------------------------------------------------------------------------
---Lógica do Somador 8 bits (Para ser chamado como componente)
entity Somador8bits is
port (
	signal A: in bit_vector (7 downto 0);
	signal B: in bit_vector (7 downto 0);
	signal SAIDA: out bit_vector (7 downto 0));
end Somador8bits;

architecture LOGICA of Somador8bits is
	signal soma: bit_vector (7 downto 0);
	signal carrySoma: bit_vector (7 downto 0);
begin
	soma(0) <= A(0) XOR B(0);
	carrySoma(0)<= (A(0) AND B(0));
	soma(1) <= (A(1) XOR B(1)) XOR carrySoma(0);
	carrySoma(1) <= (A(1) AND B(1)) OR (A(1) AND carrySoma(0)) OR (B(1) AND carrySoma(0));
	soma(2) <= (A(2) XOR B(2)) XOR carrySoma(1);
	carrySoma(2) <= (A(2) AND B(2)) OR (A(2) AND carrySoma(1)) OR (B(2) AND carrySoma(1));
	soma(3) <= (A(3) XOR B(3)) XOR carrySoma(2);
	carrySoma(3) <= (A(3) AND B(3)) OR (A(3) AND carrySoma(2)) OR (B(3) AND carrySoma(2));
	soma(4) <= (A(4) XOR B(4)) XOR carrySoma(3);
	carrySoma(4) <= (A(4) AND B(4)) OR (A(4) AND carrySoma(3)) OR (B(4) AND carrySoma(3));
	soma(5) <= (A(5) XOR B(5)) XOR carrySoma(4);
	carrySoma(5) <= (A(5) AND B(5)) OR (A(5) AND carrySoma(4)) OR (B(5) AND carrySoma(4));
	soma(6) <= (A(6) XOR B(6)) XOR carrySoma(5);
	carrySoma(6) <= (A(6) AND B(6)) OR (A(6) AND carrySoma(5)) OR (B(6) AND carrySoma(5));
	soma(7) <= (A(7) XOR B(7)) XOR carrySoma(6);
	carrySoma(7) <= (A(7) AND B(7)) OR (A(7) AND carrySoma(6)) OR (B(7) AND carrySoma(6));
	
	SAIDA <= soma;
end LOGICA ;


------------------------------------------------------------------------------------------
---Lógica do Somador 10 bits (Para ser chamado como componente)
entity Somador10bits is
port (
	signal A: in bit_vector (9 downto 0);
	signal B: in bit_vector (9 downto 0);
	signal SAIDA: out bit_vector (9 downto 0));
end Somador10bits;

architecture LOGICA of Somador10bits is
	signal soma: bit_vector (9 downto 0);
	signal carrySoma: bit_vector (9 downto 0);
begin
	soma(0) <= A(0) XOR B(0);
	carrySoma(0)<= (A(0) AND B(0));
	soma(1) <= (A(1) XOR B(1)) XOR carrySoma(0);
	carrySoma(1) <= (A(1) AND B(1)) OR (A(1) AND carrySoma(0)) OR (B(1) AND carrySoma(0));
	soma(2) <= (A(2) XOR B(2)) XOR carrySoma(1);
	carrySoma(2) <= (A(2) AND B(2)) OR (A(2) AND carrySoma(1)) OR (B(2) AND carrySoma(1));
	soma(3) <= (A(3) XOR B(3)) XOR carrySoma(2);
	carrySoma(3) <= (A(3) AND B(3)) OR (A(3) AND carrySoma(2)) OR (B(3) AND carrySoma(2));
	soma(4) <= (A(4) XOR B(4)) XOR carrySoma(3);
	carrySoma(4) <= (A(4) AND B(4)) OR (A(4) AND carrySoma(3)) OR (B(4) AND carrySoma(3));
	soma(5) <= (A(5) XOR B(5)) XOR carrySoma(4);
	carrySoma(5) <= (A(5) AND B(5)) OR (A(5) AND carrySoma(4)) OR (B(5) AND carrySoma(4));
	soma(6) <= (A(6) XOR B(6)) XOR carrySoma(5);
	carrySoma(6) <= (A(6) AND B(6)) OR (A(6) AND carrySoma(5)) OR (B(6) AND carrySoma(5));
	soma(7) <= (A(7) XOR B(7)) XOR carrySoma(6);
	carrySoma(7) <= (A(7) AND B(7)) OR (A(7) AND carrySoma(6)) OR (B(7) AND carrySoma(6));
	soma(8) <= (A(8) XOR B(8)) XOR carrySoma(7);
	carrySoma(8) <= (A(8) AND B(8)) OR (A(8) AND carrySoma(7)) OR (B(8) AND carrySoma(7));
	soma(9) <= (A(9) XOR B(9)) XOR carrySoma(8);
	carrySoma(9) <= (A(9) AND B(9)) OR (A(9) AND carrySoma(8)) OR (B(9) AND carrySoma(8));
	

	SAIDA <= soma;
end LOGICA ;

------------------------------------------------------------------------------------------
---Lógica do MULTIAND (Para ser chamado como componente)
entity multiAND is
port (
	signal A: in bit_vector (7 downto 0);
	signal B: in bit_vector (7 downto 0);
	signal SAIDA: out bit_vector (7 downto 0));
end multiAND;

architecture LOGICA of multiAND is
begin
 SAIDA <= A AND B;
end LOGICA;

------------------------------------------------------------------------------------------

---Lógica do Multiplicador (Para ser chamado como componente)
entity Multiplicador is
port (
	signal A: in bit_vector (3 downto 0);
	signal B: in bit_vector (3 downto 0);
	signal SAIDA: out bit_vector (7 downto 0));
end Multiplicador;

architecture LOGICA of Multiplicador is
	signal vetorAND0: bit_vector (7 downto 0);
	signal vetorAND1: bit_vector (7 downto 0);
	signal vetorAND2: bit_vector (7 downto 0);
	signal vetorAND3: bit_vector (7 downto 0);
	signal A0,A1,A2,A3,B0,B1,B2,B3: bit_vector (7 downto 0);
	signal soma0,soma1,soma2: bit_vector (7 downto 0);

---Declarando Componente multiAND
component multiAND is
port (
	signal A: in bit_vector (7 downto 0);
	signal B: in bit_vector (7 downto 0);
	signal SAIDA: out bit_vector (7 downto 0));
end component;
---Fim de declaração


---Declarando Componente Somador
component Somador8bits is
port (
	signal A: in bit_vector (7 downto 0);
	signal B: in bit_vector (7 downto 0);
	signal SAIDA: out bit_vector (7 downto 0));
end component;
---Fim de declaração

begin
--- Declaração das linhas da multiplicação:
	A0 <= ('0','0','0','0',A(3),A(2),A(1),A(0));
	A1 <= ('0','0','0',A(3),A(2),A(1),A(0),'0');
	A2 <= ('0','0',A(3),A(2),A(1),A(0),'0','0');
	A3 <= ('0',A(3),A(2),A(1),A(0),'0','0','0');

	B0 <= ('0','0','0','0',B(0),B(0),B(0),B(0));
	B1 <= ('0','0','0',B(1),B(1),B(1),B(1),'0');
	B2 <= ('0','0',B(2),B(2),B(2),B(2),'0','0');
	B3 <= ('0',B(3),B(3),B(3),B(3),'0','0','0');

	chamada1and1: multiAND port map(A0,B0,vetorAND0);
	chamada1and2: multiAND port map(A1,B1,vetorAND1);
	chamada1and3: multiAND port map(A2,B2,vetorAND2);
	chamada1and4: multiAND port map(A3,B3,vetorAND3);
--- Somatório das linhas:
	chamada1soma: Somador8bits port map(vetorAND0,vetorAND1,soma0);
	chamada2soma: Somador8bits port map(soma0,vetorAND2,soma1);
	chamada3soma: Somador8bits port map(soma1,vetorAND3,soma2);
--- Resultado final da multiplicação:
	SAIDA <= soma2;
	
end LOGICA;

------------------------------------------------------------------------------------------
---------- BLOCO COD (2X4) -------------
entity COD is
  port (
        s_cod: in bit_vector (1 downto 0);
	en_cod: in bit;
	COD: out bit_vector(2 downto 0)
       );
  
  end COD ;
  
  architecture LOGICA of COD is
  
  begin
    
	COD(0) <= not(s_cod(0)) and not(s_cod(1)) and en_cod;
	COD(1) <= s_cod(0) and not(s_cod(1)) and en_cod;
	COD(2) <= not(s_cod(0)) and s_cod(1) and en_cod;

  end LOGICA ;

------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------
---------- BLOCO R X C  -------------
entity RXC is
  port (
        Y,C: in bit_vector (3 downto 0);
	clk, ld_r, clr_r, ld_c: in bit;
	outMulti: out bit_vector(7 downto 0);
	outRegY: out bit_vector(3 downto 0)
       );
  
  end RXC ;
  
  architecture LOGICA of RXC is
  
component Multiplicador is
port (
	signal A: in bit_vector (3 downto 0);
	signal B: in bit_vector (3 downto 0);
	signal SAIDA: out bit_vector (7 downto 0));
end component;

component REG4BITS is
  port (
        clk,C,LOAD: IN BIT ;
	D,P: IN BIT_VECTOR (3 DOWNTO 0);
        Q, QL : OUT BIT_VECTOR (3 DOWNTO 0)
       );
  
end component ;

	signal RegY,RegC,QL0,QL1: bit_vector(3 downto 0);
	
begin
	chamadaRegisterY: REG4BITS port map (clk,clr_r,ld_r,Y,('0','0','0','0'),RegY,QL0);
	chamadaRegisterC: REG4BITS port map (clk,'0',ld_c,C,('0','0','0','0'),RegC,QL1);

	chamadaMultiplicador: Multiplicador port map (RegY,RegC,outMulti);

	outRegY <= RegY;

end LOGICA ;


------------------------------------------------------------------------------------------
---------- FILTRO FIR  -------------
entity FIR is
  port (
        Y,C: in bit_vector (3 downto 0);
	clk,ld_r,clr_r,ld_out: in bit;
	s_cod: in bit_vector (1 downto 0);
	en_cod: in bit;
	F: out bit_vector(9 downto 0)
       );
  
  end FIR ;
  
  architecture LOGICA of FIR is
  

component COD is
 	port (
        s_cod: in bit_vector (1 downto 0);
	en_cod: in bit;
	COD: out bit_vector(2 downto 0)
       );
  
	end component ;

component RXC is
 	port (
        Y,C: in bit_vector (3 downto 0);
	clk, ld_r, clr_r, ld_c: in bit;
	outMulti: out bit_vector(7 downto 0);
	outRegY: out bit_vector(3 downto 0)
	);
	end component ;

component REG10BITS is
 	port (
         clk,C,LOAD: IN BIT ;
	D,P: IN BIT_VECTOR (9 DOWNTO 0);
        Q, QL : OUT BIT_VECTOR (9 DOWNTO 0)
       );
	end component ;

component Somador10bits is
 	port (
	signal A: in bit_vector (9 downto 0);
	signal B: in bit_vector (9 downto 0);
	signal SAIDA: out bit_vector (9 downto 0));
	end component;

	---Variáveis---
	signal ci: bit_vector (2 downto 0);
	signal auxci1,auxci2,auxci3: bit;
	signal outRegY1,outRegY2,outRegY3: bit_vector(3 downto 0);
	signal outMulti1,outMulti2,outMulti3: bit_vector(7 downto 0);
	signal outSoma1,outSoma2,nF,auxOutMulti1,auxOutMulti2,auxOutMulti3: bit_vector(9 downto 0);

begin
	---Chamada do bloco COD---
	chamadaCOD: COD port map (s_cod,en_cod,ci);
	auxci1 <= ci(0);
	auxci2 <= ci(1);
	auxci3 <= ci(2);
    	---Chamada dos blocos RXC---
	chamadaBlocoRXC1: RXC port map (Y,C,clk,ld_r,clr_r,auxci1,outMulti1,outRegY1);
	chamadaBlocoRXC2: RXC port map (outRegY1,C,clk,ld_r,clr_r,auxci2,outMulti2,outRegY2);
	chamadaBlocoRXC3: RXC port map (outRegY2,C,clk,ld_r,clr_r,auxci3,outMulti3,outRegY3);
	---Chamada Somadores---
	auxOutMulti1 <= ('0','0',outMulti1(7),outMulti1(6),outMulti1(5),outMulti1(4),outMulti1(3),outMulti1(2),outMulti1(1),outMulti1(0));
	auxOutMulti2 <= ('0','0',outMulti2(7),outMulti2(6),outMulti2(5),outMulti2(4),outMulti2(3),outMulti2(2),outMulti2(1),outMulti2(0));
	auxOutMulti3 <= ('0','0',outMulti3(7),outMulti3(6),outMulti3(5),outMulti3(4),outMulti3(3),outMulti3(2),outMulti3(1),outMulti3(0));	
	
	chamadaSomador1: Somador10bits port map (auxOutMulti1,auxOutMulti2,outSoma1);
	chamadaSomador2: Somador10bits port map (outSoma1,auxOutMulti3,outSoma2);
	---Chamada Reg---
	chamadaRegister: REG10BITS port map (clk,'0',ld_out,outSoma2,('0','0','0','0','0','0','0','0','0','0'),F,nF);

end LOGICA ;

------------------------------------------------------------------------------------------
