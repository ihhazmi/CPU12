library IEEE;
use ieee.std_logic_1164.all;

entity CELL_L is
   port (A, B : IN std_logic; -- CELL INPUT1&2
      S1, S0 : IN std_logic; -- SELECT SIGNALS & INPUT CARRY
      E : OUT std_logic); -- CELL output
END CELL_L;

architecture STRUCTURE of CELL_L is
-- SIGNAL DECLARATION
   SIGNAL X0, X1, X2, X3: std_logic;
-- COMPONENT DECLARATION
	COMPONENT MUX4X1
	PORT(I0, I1, I2, I3: IN std_logic;
      S1, S0 : IN std_logic;
      O : OUT std_logic);
	END COMPONENT;
	BEGIN
	    X0 <= A AND B;
	    X1 <= A OR B;
	    X2 <= NOT(A);
	    X3 <= A XOR B;
	    MUX_L: MUX4X1 PORT MAP(X0, X1, X2, X3, S1, S0, E);
end STRUCTURE;
