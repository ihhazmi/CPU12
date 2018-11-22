LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Reg8C IS   -- 8bit Register with clear input (for Accumulators)
	--GENERIC (Len: integer := 8);
	PORT (Clk, CLR, Ld	: IN STD_LOGIC;
		  D			: IN STD_LOGIC_VECTOR(7 downto 0);
		  Q			: OUT STD_LOGIC_VECTOR(7 downto 0));
END Reg8C;
ARCHITECTURE RTL OF Reg8C IS
BEGIN
  process(CLR, Ld, Clk) is
  begin
	IF (CLR = '1') THEN
	   Q <= (others => '0');
	ELSIF (Ld='1') and rising_edge(Clk) then
      Q <= D;
	END IF;
  end process;
END RTL;


