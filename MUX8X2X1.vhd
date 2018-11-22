library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX8X2X1 is
   port (M : IN std_logic; -- SELECT SIGNAL
         X0 : IN std_logic_vector(7 downto 0); -- MUX82 input1
         X1 : IN std_logic_vector(7 downto 0); -- MUX82 input2
         Y : OUT std_logic_vector(7 downto 0)); -- MUX82 output
end MUX8X2X1;

architecture STRUCTURE of MUX8X2X1 is
   begin 
      Y(0) <= (NOT(M) AND X0(0)) OR (M AND X1(0));
      Y(1) <= (NOT(M) AND X0(1)) OR (M AND X1(1));
      Y(2) <= (NOT(M) AND X0(2)) OR (M AND X1(2));
      Y(3) <= (NOT(M) AND X0(3)) OR (M AND X1(3));
      Y(4) <= (NOT(M) AND X0(4)) OR (M AND X1(4));
      Y(5) <= (NOT(M) AND X0(5)) OR (M AND X1(5));
      Y(6) <= (NOT(M) AND X0(6)) OR (M AND X1(6));
      Y(7) <= (NOT(M) AND X0(7)) OR (M AND X1(7));
end STRUCTURE;