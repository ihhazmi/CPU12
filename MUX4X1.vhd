
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX4X1 is
	PORT(I0, I1, I2, I3: IN std_logic;
      S1, S0 : IN std_logic;
      O : OUT std_logic);
end MUX4X1;

architecture STRUCTURE of MUX4X1 is
   begin
      O <=  (NOT(S1) AND NOT(S0) AND I0) OR
      (NOT(S1) AND S0 AND I1) OR
      (S1 AND NOT(S0) AND I2) OR
      (S1 AND S0 AND I3);
end STRUCTURE;