library ieee;                -- Load the ieee 1164 library
use ieee.std_logic_1164.all; -- Make the ieee package 'visible'

entity FA_NCO is port(
	X, Y: in std_logic;
	C_in: in std_logic;
	S: out std_logic);
--C_out: out std_logic);
	end entity FA_NCO;
	
architecture STRUCTURAL of FA_NCO is
	begin
	S <= X xor Y xor C_in;
--c_out <= (X and Y) or (X and C_in) or (Y and C_in);
end architecture STRUCTURAL;
