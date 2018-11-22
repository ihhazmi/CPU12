library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY REG16_FLTR IS
	PORT( I : IN std_logic_vector(15 DOWNTO 0);
	      O : OUT std_logic_vector(15 DOWNTO 0);
		   En : IN std_logic);
END REG16_FLTR;

ARCHITECTURE structural OF REG16_FLTR IS
-- COMPONENT DECLARATION
	COMPONENT three_state
     port (a, En : in std_logic;
           z : out std_logic);
	END COMPONENT;
	BEGIN
	    B_0: three_state PORT MAP(I(0), En, O(0));
	    B_1: three_state PORT MAP(I(1), En, O(1));
	    B_2: three_state PORT MAP(I(2), En, O(2));
	    B_3: three_state PORT MAP(I(3), En, O(3));
	    B_4: three_state PORT MAP(I(4), En, O(4));
	    B_5: three_state PORT MAP(I(5), En, O(5));
	    B_6: three_state PORT MAP(I(6), En, O(6));
	    B_7: three_state PORT MAP(I(7), En, O(7));
	    B_8: three_state PORT MAP(I(8), En, O(8));
	    B_9: three_state PORT MAP(I(9), En, O(9));
	    B_10: three_state PORT MAP(I(10), En, O(10));
	    B_11: three_state PORT MAP(I(11), En, O(11));
	    B_12: three_state PORT MAP(I(12), En, O(12));
	    B_13: three_state PORT MAP(I(13), En, O(13));
	    B_14: three_state PORT MAP(I(14), En, O(14));
	    B_15: three_state PORT MAP(I(15), En, O(15));
END structural;
