library IEEE;
use ieee.std_logic_1164.all;

entity CELL_ALU is
   port (A, B, SHR, SHL, RR, RL, MUL_P, DIV_Q: IN std_logic; --CELL INPUTS
      S3, S2, S1, S0, C_in: IN std_logic; --SELECT SIGNALS &INPUT CARRY
      O: INOUT std_logic;
      F: OUT std_logic); -- CELL output, C_out:OUT std_logic
END CELL_ALU;

architecture STRUCTURE of CELL_ALU is
-- SIGNAL DECLARATION
   SIGNAL D, P, E, RSH : std_logic;
-- COMPONENT DECLARATION
	COMPONENT CELL_A
   port (A, B : IN std_logic;
      S1, S0 , C_in: IN std_logic;
      O: INOUT std_logic;
      D : OUT std_logic);
	END COMPONENT;
	COMPONENT CELL_L is
   port (A, B : IN std_logic;
      S1, S0 : IN std_logic;
      E : OUT std_logic);
	END COMPONENT;
	COMPONENT CELL_RSH
   port (SHR, SHL, RR, RL: IN std_logic;
      S1, S0 : IN std_logic;
      RSH : OUT std_logic);
	END COMPONENT;
	COMPONENT MUX4X1
	PORT(I0, I1, I2, I3: IN std_logic;
      S1, S0 : IN std_logic;
      O : OUT std_logic);
	END COMPONENT;
	BEGIN
	   CELL_CA0: CELL_A PORT MAP(A, B, S2, S1, C_in, O, D);
      CELL_CL0: CELL_L PORT MAP(A, B, S1, S0, E);
      CELL_RS0: CELL_RSH PORT MAP(SHR, SHL, RR, RL, S1, S0, RSH);
	   MUX_AL0: MUX4X1 PORT MAP(DIV_Q, D, D, MUL_P, S1, S0, P);
	   MUX_AL1: MUX4X1 PORT MAP(D, P, E, RSH, S3, S2, F);
end STRUCTURE;

