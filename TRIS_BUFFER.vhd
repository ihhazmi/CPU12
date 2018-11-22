
library ieee;
use ieee.std_logic_1164.all;
entity three_state is
  port (a : in std_logic_vector(15 DOWNTO 0);
        En : in std_logic;
        z : out std_logic_vector(15 DOWNTO 0));
end entity three_state;

architecture behavior of three_state is
begin
  z <= a when En = '1' else "ZZZZZZZZZZZZZZZZ";
end architecture behavior;

