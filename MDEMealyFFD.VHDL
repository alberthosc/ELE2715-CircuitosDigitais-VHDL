-- Autor: Albertho Síziney Costa
-- 22/03/2021
-- Projeto de uma Máquina de Estados tipo Mealy com FlipFlop D.

---------- Flip-Flop D -------------
entity FFD is
  port (
        clk, D, P, C : IN BIT ;
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
    ELSIF clk = '1' AND clk' EVENT THEN
    QS <= D ;
    END IF;
  
  END PROCESS ;
    Q <= QS ;
    QL <= NOT(QS);
  
  end LOGICA ;
 ----------Flip Flop tipo D-------------

---------- Registrador de Estados 2 bits -------------
entity REG is
	port (
        CLK, Q1, Q0, CLR: IN BIT ;
        Q_1, Q_0 : OUT BIT 
       );
 
end REG ;
  
architecture LOGICA of REG is

	signal ql1,ql2 : bit;

component FFD is
port (
        clk, D, P, C : IN BIT ;
        Q, QL : OUT BIT 
       );
  
  end component ;
  
  begin
  	
	--- Registradores FFD---
	chamadaFFD1: FFD port map(CLK,Q1,'0',CLR,Q_1,ql1);
	chamadaFFD0: FFD port map(CLK,Q0,'0',CLR,Q_0,ql2);

  
  end LOGICA ;
---------- Registrador de Estados 2 bits -------------

---MDE MEALY---
entity MEALY is
port (
	signal CLK: in bit;
	signal CLR: in bit;
	signal u:   in bit;
	signal y:   in bit;
	signal z:   out bit;
	signal E:   out bit_vector ( 1 downto 0));
end MEALY ;

architecture LOGICA of MEALY is
	
	signal Q1,Q0, Q_1,Q_0 : bit;
component REG is
port (
        CLK, Q1, Q0, CLR: IN BIT ;
        Q_1, Q_0 : OUT BIT 
       );
  end component ;

begin

	--- Equações do bloco de controle ---
	Q_1 <= (not Q1 and not Q0 and not u and not y) or 
	(not Q1 and Q0 and not u and y) or 
	(Q1 and not Q0 and y) or (Q1 and u) or 
	(Q1 and Q0 and not y);
	
	Q_0 <= (not Q0 and not u) or (Q0 and u);
	
	z <= (u) or (Q1 and Q0 and y);

	---Chamada Registrador de Estados---
	chamadaFFD: FFD port map(CLK,Q_1,Q_0,CLR,Q1,Q0);

	E(1) <= Q1;
	E(0) <= Q0;




end LOGICA ;
---MDE MEALY---
