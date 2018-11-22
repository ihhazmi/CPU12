library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX16X2X1 is
   port (M : IN std_logic; -- SELECT SIGNAL
         X0 : IN std_logic_vector(15 downto 0); -- MUX16X2 input1
         X1 : IN std_logic_vector(15 downto 0); -- MUX16X2 input2
         Y : OUT std_logic_vector(15 downto 0)); -- MUX16X2 output
end MUX16X2X1;

architecture STRUCTURE of MUX16X2X1 is
   begin 
      Y(0) <= (NOT(M) AND X0(0)) OR (M AND X1(0));
      Y(1) <= (NOT(M) AND X0(1)) OR (M AND X1(1));
      Y(2) <= (NOT(M) AND X0(2)) OR (M AND X1(2));
      Y(3) <= (NOT(M) AND X0(3)) OR (M AND X1(3));
      Y(4) <= (NOT(M) AND X0(4)) OR (M AND X1(4));
      Y(5) <= (NOT(M) AND X0(5)) OR (M AND X1(5));
      Y(6) <= (NOT(M) AND X0(6)) OR (M AND X1(6));
      Y(7) <= (NOT(M) AND X0(7)) OR (M AND X1(7));
      Y(8) <= (NOT(M) AND X0(8)) OR (M AND X1(8));
      Y(9) <= (NOT(M) AND X0(9)) OR (M AND X1(9));
      Y(10) <= (NOT(M) AND X0(10)) OR (M AND X1(10));
      Y(11) <= (NOT(M) AND X0(11)) OR (M AND X1(11));
      Y(12) <= (NOT(M) AND X0(12)) OR (M AND X1(12));
      Y(13) <= (NOT(M) AND X0(13)) OR (M AND X1(13));
      Y(14) <= (NOT(M) AND X0(14)) OR (M AND X1(14));
      Y(15) <= (NOT(M) AND X0(15)) OR (M AND X1(15));
end STRUCTURE;