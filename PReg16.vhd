LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Reg16 IS
--	GENERIC (Len: integer := 16);
	PORT (Clk, Ld	: IN STD_LOGIC;
		  D			: IN STD_LOGIC_VECTOR(15 downto 0);
		  Q			: OUT STD_LOGIC_VECTOR(15 downto 0));
END Reg16;
ARCHITECTURE RTL OF Reg16 IS
BEGIN
  process(Ld, Clk) is
  begin
  	if (Ld='1') and rising_edge(Clk) then
      Q <= D;
	end if;
  end process;
END RTL;
