LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY INCR IS
--	GENERIC (Len: integer := 16);
	PORT (Plus2		: IN STD_LOGIC; --if 1 then increment by 2
		  Inp		: IN STD_LOGIC_VECTOR(15 downto 0);
		  Op		: OUT STD_LOGIC_VECTOR(15 downto 0));
END INCR;

ARCHITECTURE RTL OF Incr IS

BEGIN
	process (Inp, Plus2) is
	variable T: STD_LOGIC_VECTOR(15 downto 0);
	variable i,j: integer; --bit indexes
	variable Ta: Std_logic; --temporary AND term
	begin
		T(15 downto 1) := Inp(15 downto 1); 
		T(0) := Inp(0) OR Plus2; 
	  	Op(0) <= Inp(0) xor not(Plus2);--toggle if +1, pass if +2
		Op(1) <= Inp(1) xor T(0);--toggle if +2; if +1, toggle if T(0)='1'
	  	for i IN 2 to 15 loop
		  Ta := '1';
		  for j IN (i-1) downto 0 loop
		  	Ta := Ta AND T(j);
		  end loop;
		  Op(i) <= T(i) xor Ta;
		end loop;
	end process;
END RTL;

