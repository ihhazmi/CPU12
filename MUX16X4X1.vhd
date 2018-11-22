library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX16X4X1 is
   port (M1, M0 : IN std_logic; -- SELECT SIGNALS
         X0 : IN std_logic_vector(15 downto 0); -- MUX16X4 input1
         X1 : IN std_logic_vector(15 downto 0); -- MUX16X4 input2
         X2 : IN std_logic_vector(15 downto 0); -- MUX16X4 input1
         X3 : IN std_logic_vector(15 downto 0); -- MUX16X4 input2
         Y : OUT std_logic_vector(15 downto 0)); -- MUX16X4 output
end MUX16X4X1;

architecture STRUCTURE of MUX16X4X1 is
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
      Y(8)<=(NOT(M1) AND NOT(M0) AND X0(8)) OR (NOT(M1) AND M0 AND X1(8)) OR 
            (M1 AND NOT(M0) AND X2(8)) OR (M1 AND M0 AND X3(8));
      Y(9)<=(NOT(M1) AND NOT(M0) AND X0(9)) OR (NOT(M1) AND M0 AND X1(9)) OR 
            (M1 AND NOT(M0) AND X2(9)) OR (M1 AND M0 AND X3(9));
      Y(10)<=(NOT(M1) AND NOT(M0) AND X0(10)) OR (NOT(M1) AND M0 AND X1(10)) OR 
            (M1 AND NOT(M0) AND X2(10)) OR (M1 AND M0 AND X3(10));
      Y(11)<=(NOT(M1) AND NOT(M0) AND X0(11)) OR (NOT(M1) AND M0 AND X1(11)) OR 
            (M1 AND NOT(M0) AND X2(11)) OR (M1 AND M0 AND X3(11));
      Y(12)<=(NOT(M1) AND NOT(M0) AND X0(12)) OR (NOT(M1) AND M0 AND X1(12)) OR 
            (M1 AND NOT(M0) AND X2(12)) OR (M1 AND M0 AND X3(12));
      Y(13)<=(NOT(M1) AND NOT(M0) AND X0(13)) OR (NOT(M1) AND M0 AND X1(13)) OR 
            (M1 AND NOT(M0) AND X2(13)) OR (M1 AND M0 AND X3(13));
      Y(14)<=(NOT(M1) AND NOT(M0) AND X0(14)) OR (NOT(M1) AND M0 AND X1(14)) OR 
            (M1 AND NOT(M0) AND X2(14)) OR (M1 AND M0 AND X3(14));
      Y(15)<=(NOT(M1) AND NOT(M0) AND X0(15)) OR (NOT(M1) AND M0 AND X1(15)) OR 
            (M1 AND NOT(M0) AND X2(15)) OR (M1 AND M0 AND X3(15));
End STRUCTURE;