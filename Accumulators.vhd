LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;

ENTITY Acc_BLOCK IS
	PORT( CLK, CLRA, CLRB, LdA, LdB, S_U : IN std_logic;
		   AccIN : IN std_logic_vector(15 DOWNTO 0);
		   MI, MDH1, MDL1, MDH2, MDL2  :IN std_logic;  --SWAP A,B THROUGH THE OUT MUX IN DATAPATH CIRCUIT
       D : INOUT std_logic_vector(15 DOWNTO 0);
		   ACCOUT1, ACCOUT2 : OUT std_logic_vector(15 DOWNTO 0));
END Acc_BLOCK;

ARCHITECTURE STRUCTURE OF Acc_BLOCK IS
-- SIGNALS DECLARATION
   SIGNAL MUXAO, MUXBO, RA, RB, MUX0FO:std_logic_vector(7 DOWNTO 0); 
   SIGNAL M0F, MHL1,MHL2 :std_logic; 
-- COMPONENT DECLARATION
	COMPONENT Reg8C
--	GENERIC (Len: integer := 8);
	PORT (Clk, CLR, Ld	: IN STD_LOGIC;
		   D			: IN STD_LOGIC_VECTOR(7 downto 0);
		   Q			: OUT STD_LOGIC_VECTOR(7 downto 0));
	END COMPONENT;
	COMPONENT MUX8X2X1
   PORT(	M : IN std_logic; -- SELECT SIGNAL
         X0 : IN std_logic_vector(7 downto 0); -- MUX82 input1
         X1 : IN std_logic_vector(7 downto 0); -- MUX82 input2
         Y : OUT std_logic_vector(7 downto 0)); -- MUX82 output	
	END COMPONENT;
	COMPONENT MUX16X2X1
   port (M : IN std_logic; -- SELECT SIGNAL
         X0 : IN std_logic_vector(15 downto 0);
         X1 : IN std_logic_vector(15 downto 0);
         Y : OUT std_logic_vector(15 downto 0));
  END COMPONENT;
	BEGIN
	    MHL1 <= MDH1 AND MDL1; -- TO AVOID MDH:MDL = 1:0 (A:A)
	    MHL2 <= MDH2 AND MDL2; -- TO AVOID MDH:MDL = 1:0 (A:A)
	    D <= RA & RB;
	    M0F <= S_U AND ((RA(7) AND NOT(MDL2)) OR (RB(7) AND MDL2));
	    MUXA: MUX8X2X1 PORT MAP(MI, AccIN(15 DOWNTO 8), AccIN(7 DOWNTO 0), MUXAO);
	    MUXB: MUX8X2X1 PORT MAP(MI, AccIN(7 DOWNTO 0), AccIN(15 DOWNTO 8), MUXBO);
	    A: Reg8C PORT MAP(CLK, CLRA, LdA, MUXAO, RA);
	    B: Reg8C PORT MAP(CLK, CLRB, LdB, MUXBO, RB);
	    MUX0F:MUX8X2X1 PORT MAP(M0F, "00000000", "11111111", MUX0FO);
	    MUXDH1:MUX8X2X1 PORT MAP(MHL1, MUX0FO, RA, ACCOUT1(15 DOWNTO 8));
	    MUXDL1:MUX8X2X1 PORT MAP(MDL1, RA, RB, ACCOUT1(7 DOWNTO 0));
	    MUXDH2:MUX8X2X1 PORT MAP(MHL2, MUX0FO, RA, ACCOUT2(15 DOWNTO 8));
	    MUXDL2:MUX8X2X1 PORT MAP(MDL2, RA, RB, ACCOUT2(7 DOWNTO 0));
END STRUCTURE;
