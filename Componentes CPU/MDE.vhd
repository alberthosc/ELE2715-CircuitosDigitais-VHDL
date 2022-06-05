----------------------------------------------------
--												  --
--  SISTEMAS DIGITAIS - SEMANA 04 - IMPLEMENTAÇÃO --
--	GRUPO 1: ELIAS, LUCAS, ALBERTO E MARCELO      --
--												  --
----------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity MDE is
    port(
			  
		Carry, Zero_ULA, clk, rst: in std_logic;						  
     En_Carry_ZeroULA: out std_logic;
		IR_in : in std_logic_vector(15 downto 0);
		Ra_addr, Rb_addr, Rc_addr : out std_logic_vector(3 downto 0);
		addr : out std_logic_vector(7 downto 0);
		seletor, Ra_en, Rb_en, Rc_en, En_RAM, rw, En_PCIRROM, Load_PC, PC_Clear : out std_logic;
		OpULA : out std_logic_vector(2 downto 0);   
		PC : out std_logic_vector (7 downto 0 )		
		
);
end MDE;

architecture LOGICA of MDE is

   
	type st is (SET_PC, INICIAR, BUSCAR, DEC, HLT, LDR, STR, MOV, ADD, SUB, E_AND, E_OR, 
	E_NOT, E_XOR, CMP, JMP, JNC, JC, JNZ, JZ, SALTAR);

    signal estado : st;

	signal sig_PC_Clear : std_logic;
	signal OpCode :  std_logic_vector(3 downto 0);
	signal IR : std_logic_vector(11 downto 0);

   begin
	process (clk)
	begin	

		

		Opcode <= IR_in (15 downto 12);

		IR <= IR_in (11 downto 0);

	    if rst = '1' then estado <= SET_PC;	    
	    elsif (clk'event and clk = '1') then
		case estado is

		----------------------					
		-- 	  SET_PC_CLEAR-- 
		----------------------
		when SET_PC =>
		
		PC_clear <= '1';

		estado <= INICIAR;
		
		----------------------					
		-- 	  INICIO MDE	-- 
		----------------------

		when INICIAR =>

		OpULA <= "000"; Load_PC <= '0'; PC_clear <= '0'; En_PCIRROM <= '1'; 
		Ra_en <= '0'; Rb_en <= '0'; Rc_en <= '0'; seletor <= '0'; rw <= '0'; En_RAM <='0'; sig_PC_Clear <= '1'; 

			
		--    if (sig_PC_clear = '1') 		then 
		
		estado <= BUSCAR;

			
			
	--	   end if;

		----------------------					
		-- ESTADO BUSCAR -- 
		----------------------

		when BUSCAR =>

		OpULA <= "000"; Load_PC <= '0'; PC_clear <= '0'; En_PCIRROM <= '0'; 
		Ra_en <= '0'; Rb_en <= '0'; Rc_en <= '0'; seletor <= '0'; rw <= '0'; En_RAM <='0'; sig_PC_Clear <= '0';  
		
				En_Carry_ZeroULA <='0';
		     estado <= DEC;    		    
			
		--------------------------
		-- ESTADO DECODIFICAÇÃO -- 
		--------------------------
		
		when DEC =>

		OpULA <= "000"; Load_PC <= '0'; En_PCIRROM <= '1'; PC_clear <= '0';
		Ra_en <= '0'; Rb_en <= '0'; Rc_en <= '0'; seletor <= '0'; rw <= '0'; En_RAM <='0'; 

		-- TODAS AS CONDIÇÕES POSSÍVEIS PARA ESTE ESTADO --
			
			if    (OpCode="0000") then estado <= HLT;
			elsif (OpCode="0001") then estado <= LDR;
			elsif (OpCode="0010") then estado <= STR;
			elsif (OpCode="0011") then estado <= MOV;
			elsif (OpCode="0100") then estado <= ADD;
			elsif (OpCode="0101") then estado <= SUB;
			elsif (OpCode="0110") then estado <= E_AND;
			elsif (OpCode="0111") then estado <= E_OR;
			elsif (OpCode="1000") then estado <= E_NOT;
			elsif (OpCode="1001") then estado <= E_XOR;
			elsif (OpCode="1010") then estado <= CMP;
			elsif (OpCode="1011") then estado <= JMP;
			elsif (OpCode="1100") then estado <= JNC;
			elsif (OpCode="1101") then estado <= JC;
			elsif (OpCode="1110") then estado <= JNZ;
			elsif (OpCode="1111") then estado <= JZ;

					
		    end if;
		
		
		  En_Carry_ZeroULA <='0';
		----------------------					
		-- ESTADO HLT -- 
		----------------------	
				
		when HLT =>

		OpULA <= "000"; Load_PC <= '0'; En_PCIRROM <= '0'; PC_clear <= '0';
		Ra_en <= '0'; Rb_en <= '0'; Rc_en <= '0'; seletor <= '0'; rw <= '0'; En_RAM <='0';		
		En_Carry_ZeroULA <='0';	

			estado <= HLT;

		----------------------					
		-- ESTADO LDR -- 
		----------------------

		when LDR =>

		OpULA <= "000"; Load_PC <= '0'; En_PCIRROM <= '0'; PC_clear <= '0';
		Ra_en <= '1'; Rb_en <= '0'; Rc_en <= '0'; seletor <= '0'; rw <= '0'; En_RAM <='1'; 
		
		addr (7 downto 0) <= IR (7 downto 0); 
		Ra_addr (3 downto 0) <= IR (11 downto 8);		
		En_Carry_ZeroULA <='0';	
					
			estado <= BUSCAR;			
		
		----------------------					
		-- ESTADO STR -- 
		----------------------

		when STR => 
		
		OpULA <= "000"; Load_PC <= '0'; En_PCIRROM <= '0'; PC_clear <= '0';
		Ra_en <= '0'; Rb_en <= '1'; Rc_en <= '0'; seletor <= '0'; rw <= '1'; En_RAM <='1'; 
		
		addr (7 downto 0) <= IR (7 downto 0); 
		Rb_addr (3 downto 0) <= IR (11 downto 8);	
    En_Carry_ZeroULA <='0';
		
			estado <= BUSCAR;
			
		----------------------					
		--  ESTADO MOV -- 
		----------------------
		when MOV =>

		OpULA <= "000"; Load_PC <= '0'; En_PCIRROM <= '0'; PC_clear <= '0';
		Ra_en <= '1'; Rb_en <= '0'; Rc_en <= '1'; seletor <= '1'; rw <= '0'; En_RAM <='0'; 
		
		
		Ra_addr (3 downto 0) <= IR (7 downto 4);	
		Rc_addr (3 downto 0) <= IR (3 downto 0);
		En_Carry_ZeroULA <='1';	
			
			estado <= BUSCAR;
		
		----------------------					
		-- ESTADO ADD -- 
		----------------------
		when ADD =>

		OpULA <= "001"; Load_PC <= '0'; En_PCIRROM <= '0'; PC_clear <= '0';
		Ra_en <= '1'; Rb_en <= '1'; Rc_en <= '1'; seletor <= '1'; rw <= '0'; En_RAM <='0'; 		
		
		
		Ra_addr (3 downto 0) <= IR (11 downto 8);	
		Rb_addr (3 downto 0) <= IR (7 downto 4);	
		Rc_addr (3 downto 0) <= IR (3 downto 0);		
    En_Carry_ZeroULA <='1';
						
			estado <= BUSCAR;
		
		----------------------					
		-- ESTADO SUB -- 
		----------------------

		when SUB =>

		OpULA <= "010"; Load_PC <= '0'; En_PCIRROM <= '0'; PC_clear <= '0';
		Ra_en <= '1'; Rb_en <= '1'; Rc_en <= '1'; seletor <= '1'; rw <= '0'; En_RAM <='0'; 
		
		
		Ra_addr (3 downto 0) <= IR (11 downto 8);	
		Rb_addr (3 downto 0) <= IR (7 downto 4);	
		Rc_addr (3 downto 0) <= IR (3 downto 0);	
    En_Carry_ZeroULA <='1';
    
			estado <= BUSCAR;				
			
		
		----------------------					
		-- ESTADO  AND -- 
		----------------------

		when E_AND => 
			
		OpULA <= "011"; Load_PC <= '0'; En_PCIRROM <= '0'; PC_clear <= '0';
		Ra_en <= '1'; Rb_en <= '1'; Rc_en <= '1'; seletor <= '1'; rw <= '0'; En_RAM <='0'; 		
		
		Ra_addr (3 downto 0) <= IR (11 downto 8);	
		Rb_addr (3 downto 0) <= IR (7 downto 4);	
		Rc_addr (3 downto 0) <= IR (3 downto 0);	
		En_Carry_ZeroULA <='1';
				
			estado <= BUSCAR;

		----------------------					
		-- ESTADO OR -- 
		----------------------

		when E_OR =>

		OpULA <= "100"; Load_PC <= '0'; En_PCIRROM <= '0'; PC_clear <= '0';
		Ra_en <= '1'; Rb_en <= '1'; Rc_en <= '1'; seletor <= '1'; rw <= '0'; En_RAM <='0'; 
		
		
		Ra_addr (3 downto 0) <= IR (11 downto 8);	
		Rb_addr (3 downto 0) <= IR (7 downto 4);	
		Rc_addr (3 downto 0) <= IR (3 downto 0);
		En_Carry_ZeroULA <='1';
			
			estado <= BUSCAR;
			
		----------------------					
		-- ESTADO NOT -- 
		----------------------

		when E_NOT =>

		OpULA <= "101"; Load_PC <= '0'; En_PCIRROM <= '0'; PC_clear <= '0';
		Ra_en <= '1'; Rb_en <= '0'; Rc_en <= '1'; seletor <= '1'; rw <= '0'; En_RAM <='0'; 
		
		
		Ra_addr (3 downto 0) <= IR (11 downto 8);			
		Rc_addr (3 downto 0) <= IR (3 downto 0);
		En_Carry_ZeroULA <='1';
			
			estado <= BUSCAR;
		
		----------------------					
		-- ESTADO XOR -- 
		----------------------

		when E_XOR =>

		OpULA <= "110"; Load_PC <= '0'; En_PCIRROM <= '0'; PC_clear <= '0';
		Ra_en <= '1'; Rb_en <= '1'; Rc_en <= '1'; seletor <= '1'; rw <= '0'; En_RAM <='0'; 
		
		
		Ra_addr (3 downto 0) <= IR (11 downto 8);	
		Rb_addr (3 downto 0) <= IR (7 downto 4);	
		Rc_addr (3 downto 0) <= IR (3 downto 0);
		En_Carry_ZeroULA <='1';
			
			estado <= BUSCAR;	

		----------------------					
		-- ESTADO CMP -- 
		----------------------

		when CMP =>

		OpULA <= "111"; Load_PC <= '0'; En_PCIRROM <= '0'; PC_clear <= '0';
		Ra_en <= '1'; Rb_en <= '1'; Rc_en <= '1'; seletor <= '1'; rw <= '0'; En_RAM <='0'; 

		
		Ra_addr (3 downto 0) <= IR (11 downto 8);	
		Rb_addr (3 downto 0) <= IR (7 downto 4);	
		Rc_addr (3 downto 0) <= IR (3 downto 0);
		En_Carry_ZeroULA <='1';
			
			estado <= BUSCAR;

		----------------------					
		-- ESTADO JMP -- 
		----------------------

		when JMP =>

		OpULA <= "000"; Load_PC <= '1'; En_PCIRROM <= '1'; PC_clear <= '0';
		Ra_en <= '0'; Rb_en <= '0'; Rc_en <= '0'; seletor <= '0'; rw <= '0'; En_RAM <='0'; 
		
		PC (7 downto 0) <= IR (7 downto 0);
		En_Carry_ZeroULA <='0';
		
			estado <= BUSCAR;

	
		----------------------					
		-- ESTADO JNC -- 
		----------------------

		when JNC =>

		OpULA <= "000"; Load_PC <= '0'; En_PCIRROM <= '0'; PC_clear <= '0';
		Ra_en <= '0'; Rb_en <= '0'; Rc_en <= '0'; seletor <= '0'; rw <= '0'; En_RAM <='0'; 
		
		
			if (Carry = '0') then estado <= SALTAR;
			elsif (Carry = '1') then estado <= BUSCAR;				
			end if;
      
      En_Carry_ZeroULA <='0';
		----------------------					
		-- ESTADO JC -- 
		----------------------

		when JC =>

		OpULA <= "000"; Load_PC <= '0'; En_PCIRROM <= '0'; PC_clear <= '0';
		Ra_en <= '0'; Rb_en <= '0'; Rc_en <= '0'; seletor <= '0'; rw <= '0'; En_RAM <='0'; 
		
					
			if (Carry = '1') then estado <= SALTAR;
			elsif (Carry = '0') then estado <= BUSCAR;			
			end if;

      En_Carry_ZeroULA <='0';
		----------------------					
		-- ESTADO JNZ -- 
		----------------------

		when JNZ =>

		OpULA <= "000"; Load_PC <= '0'; En_PCIRROM <= '0'; PC_clear <= '0';
		Ra_en <= '0'; Rb_en <= '0'; Rc_en <= '0'; seletor <= '0'; rw <= '0'; En_RAM <='0'; 
		
					
			if (Zero_ULA = '0') then estado <= SALTAR;
			elsif (Zero_ULA= '1') then estado <= BUSCAR;			
			end if;

      En_Carry_ZeroULA <='0';
		----------------------					
		-- ESTADO JZ -- 
		----------------------

		when JZ =>

		OpULA <= "000"; Load_PC <= '0'; En_PCIRROM <= '0'; PC_clear <= '0';
		Ra_en <= '0'; Rb_en <= '0'; Rc_en <= '0'; seletor <= '0'; rw <= '0'; En_RAM <='0'; 
					
			if (Zero_ULA = '1') then estado <= SALTAR;
			elsif (Zero_ULA = '0') then estado <= BUSCAR;			
			end if;
			
			En_Carry_ZeroULA <='0';

		----------------------					
		-- ESTADO SALTAR -- 
		----------------------

		when SALTAR =>
					
		estado <= BUSCAR;

		
		end case;
	    end if;
	end process;
	
			
end LOGICA;

