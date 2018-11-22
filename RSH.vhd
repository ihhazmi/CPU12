library IEEE;
use ieee.std_logic_1164.all;

entity CELL_RSH is
   port (SHR, SHL, RR, RL: IN std_logic; -- CELL INPUT1&2
      S1, S0 : IN std_logic; -- SELECT SIGNALS & INPUT CARRY
      RSH : OUT std_logic); -- CELL output
END CELL_RSH;

architecture STRUCTURE of CELL_RSH is
-- SIGNAL DECLARATION
-- COMPONENT DECLARATION
	COMPONENT MUX4X1
	PORT(I0, I1, I2, I3: IN std_logic;
      S1, S0 : IN std_logic;
      O : OUT std_logic);
	END COMPONENT;
	BEGIN
	    MUX_L: MUX4X1 PORT MAP(SHR, SHL, RR, RL, S1, S0, RSH);
end STRUCTURE;

