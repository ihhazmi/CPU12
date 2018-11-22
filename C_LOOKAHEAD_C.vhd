library ieee;                -- Load the ieee 1164 library
use ieee.std_logic_1164.all; -- Make the ieee package 'visible'

entity C_LA is port(
	A, B: in std_logic_vector(15 downto 0);
	C_in: in std_logic;
  C_OUT: out std_logic_vector(16 downto 1));
end entity C_LA;
	
architecture STRUCTURAL of C_LA is

-- SIGNAL DECLARATION
  SIGNAL G, P: STD_LOGIC_VECTOR(15 DOWNTO 0);  
	begin
  CARRYGP:  FOR i IN 0 TO 15 GENERATE
    G(i) <= A(i) AND B(i);
    P(i) <= A(i) XOR B(i);
  END GENERATE;
  
  C_OUT(1) <= G(0) OR (P(0) AND C_IN);

  C_OUT(2) <= G(1) OR (G(0) AND P(1)) OR (P(1) AND P(0) AND C_IN);

  C_OUT(3) <= G(2) OR (G(1) AND P(2)) OR (G(0) AND P(2) AND P(1))
  OR (P(2) AND P(1) AND P(0) AND C_IN);

  C_OUT(4) <= G(3) OR (G(2) AND P(3)) OR (G(1) AND P(3) AND P(2)) 
  OR (G(0) AND P(3) AND P(2) AND P(1))
  OR (P(3) AND P(2) AND P(1) AND P(0) AND C_IN);

  C_OUT(5) <= G(4) OR (G(3) AND P(4)) OR (G(2) AND P(4) AND P(3)) 
  OR (G(1) AND P(4) AND P(3) AND P(2)) 
  OR (G(0) AND P(4) AND P(3) AND P(2) AND P(1))
  OR (P(4) AND P(3) AND P(2) AND P(1) AND P(0) AND C_IN);
  
  C_OUT(6) <= G(5) OR (G(4) AND P(5)) OR (G(3) AND P(5) AND P(4))
  OR (G(2) AND P(5) AND P(4) AND P(3)) 
  OR (G(1) AND P(5) AND P(4) AND P(3) AND P(2)) 
  OR (G(0) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1))
  OR (P(5) AND P(4) AND P(3) AND P(2) AND P(1) AND P(0) AND C_IN);
  
  C_OUT(7) <= G(6) OR (G(5) AND P(6)) OR (G(4) AND P(6) AND P(5))
  OR (G(3) AND P(6) AND P(5) AND P(4))
  OR (G(2) AND P(6) AND P(5) AND P(4) AND P(3)) 
  OR (G(1) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2)) 
  OR (G(0) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1))
  OR (P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1) AND P(0) AND C_IN);
  
  C_OUT(8) <= G(7) OR (G(6) AND P(7)) OR (G(5) AND P(7) AND P(6))
  OR (G(4) AND P(7) AND P(6) AND P(5))
  OR (G(3) AND P(7) AND P(6) AND P(5) AND P(4))
  OR (G(2) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3))
  OR (G(1) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2))
  OR (G(0) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1))
  OR (P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1) AND P(0) AND C_IN);
  
  C_OUT(9) <= G(8) OR (G(7) AND P(8)) OR (G(6) AND P(8) AND P(7))
  OR (G(5) AND P(8) AND P(7) AND P(6))
  OR (G(4) AND P(8) AND P(7) AND P(6) AND P(5))
  OR (G(3) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4))
  OR (G(2) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3)) 
  OR (G(1) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2)) 
  OR (G(0) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1))
  OR (P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1) AND P(0) AND C_IN);

  C_OUT(10) <= G(9) OR (G(8) AND P(9)) OR (G(7) AND P(9) AND P(8))
  OR (G(6) AND P(9) AND P(8) AND P(7))
  OR (G(5) AND P(9) AND P(8) AND P(7) AND P(6))
  OR (G(4) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5))
  OR (G(3) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4))
  OR (G(2) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3)) 
  OR (G(1) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2)) 
  OR (G(0) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1))
  OR (P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1) AND P(0) AND C_IN);

  C_OUT(11) <= G(10) OR (G(9) AND P(10)) OR (G(8) AND P(10) AND P(9))
  OR (G(7) AND P(10) AND P(9) AND P(8))
  OR (G(6) AND P(10) AND P(9) AND P(8) AND P(7))
  OR (G(5) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6))
  OR (G(4) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5))
  OR (G(3) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4))
  OR (G(2) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3)) 
  OR (G(1) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2)) 
  OR (G(0) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1))
  OR (P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1) AND P(0) AND C_IN);

  C_OUT(12) <= G(11) OR (G(10) AND P(11)) OR (G(9) AND P(11) AND P(10))
  OR (G(8) AND P(11) AND P(10) AND P(9))
  OR (G(7) AND P(11) AND P(10) AND P(9) AND P(8))
  OR (G(6) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7))
  OR (G(5) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6))
  OR (G(4) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5))
  OR (G(3) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4))
  OR (G(2) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3)) 
  OR (G(1) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2)) 
  OR (G(0) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1))
  OR (P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1) AND P(0) AND C_IN);

  C_OUT(13) <= G(12) OR (G(11) AND P(12)) OR (G(10) AND P(12) AND P(11))
  OR (G(9) AND P(12) AND P(11) AND P(10))
  OR (G(8) AND P(12) AND P(11) AND P(10) AND P(9))
  OR (G(7) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8))
  OR (G(6) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7))
  OR (G(5) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6))
  OR (G(4) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5))
  OR (G(3) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4))
  OR (G(2) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3)) 
  OR (G(1) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2)) 
  OR (G(0) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1))
  OR (P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1) AND P(0) AND C_IN);

  C_OUT(14) <= G(13) OR (G(12) AND P(13)) OR (G(11) AND P(13) AND P(12))
  OR (G(10) AND P(13) AND P(12) AND P(11))
  OR (G(9) AND P(13) AND P(12) AND P(11) AND P(10))
  OR (G(8) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9))
  OR (G(7) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8))
  OR (G(6) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7))
  OR (G(5) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6))
  OR (G(4) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5))
  OR (G(3) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4))
  OR (G(2) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3)) 
  OR (G(1) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2)) 
  OR (G(0) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1))
  OR (P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1) AND P(0) AND C_IN);

  C_OUT(15) <= G(14) OR (G(13) AND P(14)) OR (G(12) AND P(14) AND P(13))
  OR (G(11) AND P(14) AND P(13) AND P(12))
  OR (G(10) AND P(14) AND P(13) AND P(12) AND P(11))
  OR (G(9) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10))
  OR (G(8) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9))
  OR (G(7) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8))
  OR (G(6) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7))
  OR (G(5) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6))
  OR (G(4) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5))
  OR (G(3) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4))
  OR (G(2) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3)) 
  OR (G(1) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2)) 
  OR (G(0) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1))
  OR (P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1) AND P(0) AND C_IN);

  C_OUT(16) <= G(15) OR (G(14) AND P(15)) OR (G(13) AND P(15) AND P(14))
  OR (G(12) AND P(15) AND P(14) AND P(13))
  OR (G(11) AND P(15) AND P(14) AND P(13) AND P(12))
  OR (G(10) AND P(15) AND P(14) AND P(13) AND P(12) AND P(11))
  OR (G(9) AND P(15) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10))
  OR (G(8) AND P(15) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9))
  OR (G(7) AND P(15) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8))
  OR (G(6) AND P(15) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7))
  OR (G(5) AND P(15) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6))
  OR (G(4) AND P(15) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5))
  OR (G(3) AND P(15) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4))
  OR (G(2) AND P(15) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3)) 
  OR (G(1) AND P(15) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2)) 
  OR (G(0) AND P(15) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1))
  OR (P(15) AND P(14) AND P(13) AND P(12) AND P(11) AND P(10) AND P(9) AND P(8) AND P(7) AND P(6) AND P(5) AND P(4) AND P(3) AND P(2) AND P(1) AND P(0) AND C_IN);

end architecture STRUCTURAL;