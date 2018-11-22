library IEEE;
use ieee.std_logic_1164.all;

entity CELL_A is
   port (A, B : IN std_logic; -- CELL INPUT1&2
      S1, S0, C_in: IN std_logic; -- SELECT SIGNALS & INPUT CARRY
      O: INOUT std_logic;
      D: OUT std_logic); -- CELL output
END CELL_A;

architecture STRUCTURE of CELL_A is
-- SIGNAL DECLARATION
   SIGNAL X1: std_logic;
-- COMPONENT DECLARATION
	COMPONENT MUX4X1
	PORT(I0, I1, I2, I3: IN std_logic;
      S1, S0 : IN std_logic;
      O : OUT std_logic);
	END COMPONENT;
	COMPONENT FA_NCO 
	port(X, Y: in std_logic;
      C_in: in std_logic;
      S: out std_logic);
	END COMPONENT;
	BEGIN
	   X1 <= NOT(B);
	   MUX_A: MUX4X1 PORT MAP(B, X1, '0', '1', S1, S0, O);
     FA_NCA: FA_NCO PORT MAP(A, O, C_in, D);
end STRUCTURE;