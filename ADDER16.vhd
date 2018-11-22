library IEEE;
use ieee.std_logic_1164.all;

entity ADD16 is
   port (A, B : IN std_logic_vector(15 downto 0); -- ADDER INPUT1&2
         ADDOUT : OUT std_logic_vector(15 downto 0)); -- ADDER_OUT
END ADD16;

architecture STRUCTURE of ADD16 is
----------------------
-- SIGNAL DECLARATION
   SIGNAL C_out : std_logic_vector(16 downto 1);
------------------------
-- COMPONENT DECLARATION
	COMPONENT FA_NCO 
	port(X, Y: in std_logic;
      C_in: in std_logic;
      S: out std_logic);
	END COMPONENT;
----------------------
	COMPONENT C_LA 
   port (A, B: in std_logic_vector(15 downto 0);
         C_in: in std_logic;
         C_OUT: out std_logic_vector(16 downto 1));
   end COMPONENT;
----------------------
	BEGIN
	  C_LA0: C_LA PORT MAP(A, B, '0', C_out);
     FA_NC0: FA_NCO PORT MAP(A(0), B(0), '0', ADDOUT(0));	
     FA_NC1: FA_NCO PORT MAP(A(1), B(1), C_out(1), ADDOUT(1));	
     FA_NC2: FA_NCO PORT MAP(A(2), B(2), C_out(2), ADDOUT(2));	
     FA_NC3: FA_NCO PORT MAP(A(3), B(3), C_out(3), ADDOUT(3));	
     FA_NC4: FA_NCO PORT MAP(A(4), B(4), C_out(4), ADDOUT(4));	
     FA_NC5: FA_NCO PORT MAP(A(5), B(5), C_out(5), ADDOUT(5));	
     FA_NC6: FA_NCO PORT MAP(A(6), B(6), C_out(6), ADDOUT(6));	
     FA_NC7: FA_NCO PORT MAP(A(7), B(7), C_out(7), ADDOUT(7));	
     FA_NC8: FA_NCO PORT MAP(A(8), B(8), C_out(8), ADDOUT(8));	
     FA_NC9: FA_NCO PORT MAP(A(9), B(9), C_out(9), ADDOUT(9));	
     FA_NCA: FA_NCO PORT MAP(A(10), B(10), C_out(10), ADDOUT(10));	
     FA_NCB: FA_NCO PORT MAP(A(11), B(11), C_out(11), ADDOUT(11));	
     FA_NCC: FA_NCO PORT MAP(A(12), B(12), C_out(12), ADDOUT(12));	
     FA_NCD: FA_NCO PORT MAP(A(13), B(13), C_out(13), ADDOUT(13));	
     FA_NCE: FA_NCO PORT MAP(A(14), B(14), C_out(14), ADDOUT(14));	
     FA_NCF: FA_NCO PORT MAP(A(15), B(15), C_out(15), ADDOUT(15));	
END STRUCTURE;