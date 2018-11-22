library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX8X4X1 is
   port (M1, M0 : IN std_logic; -- SELECT SIGNALS
         X0 : IN std_logic_vector(7 downto 0); -- MUX8X4 input1
         X1 : IN std_logic_vector(7 downto 0); -- MUX8X4 input2
         X2 : IN std_logic_vector(7 downto 0); -- MUX8X4 input1
         X3 : IN std_logic_vector(7 downto 0); -- MUX8X4 input2
         Y : OUT std_logic_vector(7 downto 0)); -- MUX8X4 output
end MUX8X4X1;

architecture STRUCTURE of MUX8X4X1 is
   begin 
      Y(0)<=(NOT(M1) AND NOT(M0) AND X0(0)) OR (NOT(M1) AND M0 AND X1(0)) OR 
            (M1 AND NOT(M0) AND X2(0)) OR (M1 AND M0 AND X3(0));
      Y(1)<=(NOT(M1) AND NOT(M0) AND X0(1)) OR (NOT(M1) AND M0 AND X1(1)) OR 
            (M1 AND NOT(M0) AND X2(1)) OR (M1 AND M0 AND X3(1));
      Y(2)<=(NOT(M1) AND NOT(M0) AND X0(2)) OR (NOT(M1) AND M0 AND X1(2)) OR 
            (M1 AND NOT(M0) AND X2(2)) OR (M1 AND M0 AND X3(2));
      Y(3)<=(NOT(M1) AND NOT(M0) AND X0(3)) OR (NOT(M1) AND M0 AND X1(3)) OR 
            (M1 AND NOT(M0) AND X2(3)) OR (M1 AND M0 AND X3(3));
      Y(4)<=(NOT(M1) AND NOT(M0) AND X0(4)) OR (NOT(M1) AND M0 AND X1(4)) OR 
            (M1 AND NOT(M0) AND X2(4)) OR (M1 AND M0 AND X3(4));
      Y(5)<=(NOT(M1) AND NOT(M0) AND X0(5)) OR (NOT(M1) AND M0 AND X1(5)) OR 
            (M1 AND NOT(M0) AND X2(5)) OR (M1 AND M0 AND X3(5));
      Y(6)<=(NOT(M1) AND NOT(M0) AND X0(6)) OR (NOT(M1) AND M0 AND X1(6)) OR 
            (M1 AND NOT(M0) AND X2(6)) OR (M1 AND M0 AND X3(6));
      Y(7)<=(NOT(M1) AND NOT(M0) AND X0(7)) OR (NOT(M1) AND M0 AND X1(7)) OR 
            (M1 AND NOT(M0) AND X2(7)) OR (M1 AND M0 AND X3(7));
End STRUCTURE;