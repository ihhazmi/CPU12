LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Reg8 IS
--	GENERIC (Len: integer := 8);
	PORT (Clk, Ld	: IN STD_LOGIC;
		  D			: IN STD_LOGIC_VECTOR(7 downto 0);
		  Q			: OUT STD_LOGIC_VECTOR(7 downto 0));
END Reg8;
ARCHITECTURE RTL OF Reg8 IS
BEGIN
  process(Ld, Clk) is
  begin
  	if (Ld='1') and rising_edge(Clk) then
      Q <= D;
	end if;
  end process;
END RTL;
