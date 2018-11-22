library IEEE;
use ieee.std_logic_1164.all;

entity ALU16 is
   port (A, B, Y: IN std_logic_vector(15 downto 0); -- ALU INPUT1&2
      CCR_OLD: IN std_logic_vector(7 downto 0);
      DWB: IN std_logic_vector(1 DOWNTO 0); -- DOUBLE/WORD/BYTE 
      S_U: IN std_logic; -- Sign / UnSigned
      S3, S2, S1, S0: IN std_logic; -- ALU Operation Select 
      SWAP, ALSH : IN std_logic; -- ARITHMETIC/LOGIC SHIFT AND SWAP
      CCR_NEW: INOUT std_logic_vector(7 downto 0); -- NEW CCR VALUES
      ALUO1, ALUO2 : OUT std_logic_vector(15 downto 0); -- ALU output
      GE, LE, LT, GT: OUT std_logic); -- COMP_OUT
END ALU16;

architecture STRUCTURE of ALU16 is
-- SIGNAL DECLARATION
   SIGNAL C_out : std_logic_vector(16 downto 1);
   SIGNAL Dividend : std_logic_vector(32 downto 0);
   SIGNAL MUL_P : std_logic_vector(31 downto 0);
   SIGNAL Divisor, DIV_Q, DIV_R : std_logic_vector(16 downto 0);
   SIGNAL ALU_OUT, O, MUXMDO, M0YO : std_logic_vector(15 downto 0);
   SIGNAL COMP, SHR, SH7, YSEL : std_logic;
-- COMPONENT DECLARATION
	COMPONENT CELL_ALU
   port (A, B, SHR, SHL, RR, RL, MUL_P, DIV_Q: IN std_logic;
         S3, S2, S1, S0, C_in: IN std_logic;
         O: INOUT std_logic;
         F: OUT std_logic);
	END COMPONENT;
------------------------
	COMPONENT C_LA 
   port (A, B: in std_logic_vector(15 downto 0);
         C_in: in std_logic;
         C_OUT: out std_logic_vector(16 downto 1));
   end COMPONENT;
-----------------------
	COMPONENT multiplier
   PORT (S_U : in std_logic;
         DWB: IN std_logic_vector(1 DOWNTO 0); -- DOUBLE/WORD/BYTE
         A_US, B_US: IN STD_LOGIC_VECTOR (15 DOWNTO 0); --UnSigned
         SProd: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
   END COMPONENT;
-----------------------
	COMPONENT divcas17
   port (
         S_U : in std_logic;
         DWB: IN std_logic_vector(1 DOWNTO 0); -- DOUBLE/WORD/BYTE
         dividendUS  : in  std_logic_vector(32 downto 0);--UnSigned
         divisorUS   : in  std_logic_vector(16 downto 0);--UnSigned
         quotient  : out std_logic_vector(16 downto 0);
         remainder : out std_logic_vector(16 downto 0));
   END COMPONENT;
----------------------
	COMPONENT CCR_CAL
   port (F, MUL_PHI, B16_2_31 : IN std_logic_vector(15 downto 0);
         S3, S2, S1, S0: IN std_logic; 
         DWB : IN std_logic_vector(1 downto 0);
         MUL_C8, MUL_C16, RR, RL: IN std_logic; 
         C_16, C_15, C_8, C_7, C_4: IN std_logic;
         CCR_OLD: IN std_logic_vector(7 downto 0);
         CCR_NEW: OUT std_logic_vector(7 downto 0));
   END COMPONENT;
   COMPONENT MUX16X2X1
   port (M : IN std_logic; -- SELECT SIGNAL
         X0 : IN std_logic_vector(15 downto 0);
         X1 : IN std_logic_vector(15 downto 0);
         Y : OUT std_logic_vector(15 downto 0));
  END COMPONENT;
----------------------
	BEGIN

	   -- DIVISION PARAMETERS
	   Dividend <= '0' & M0YO(15 downto 0) & A(15 downto 0);
	   Divisor <= '0' & B;

	   -- SHIFT BITS
	   SHR <= ALSH AND ((A(15) AND NOT(DWB(1))AND DWB(0)) OR (A(7) AND NOT(DWB(1))AND NOT(DWB(0))));
      SH7 <= (A(8) AND NOT(DWB(1))AND DWB(0)) OR (SHR AND NOT(DWB(1))AND NOT(DWB(0)));

	   -- DOUBLE WORD SELCTION
	   YSEL <= DWB(1)AND NOT(DWB(0));

	   -- COMPONENTS PORT MAPING
	   MUL16: multiplier PORT MAP(S_U, DWB, A, B, MUL_P);
	   DIV16: divcas17 PORT MAP(S_U, DWB, Dividend, Divisor, DIV_Q, DIV_R);
	   C_LA0: C_LA PORT MAP(A, O, S0, C_out);
	   CCR_CAL0: CCR_CAL PORT MAP(ALU_OUT,MUL_P(31 DOWNTO 16),MUXMDO,S3,S2,S1,S0,DWB,B(7),B(15),A(0),A(15),C_out(16),C_out(15),C_out(8),C_out(7),C_out(4),CCR_OLD,CCR_NEW);
	   CELL_ALU0: CELL_ALU PORT MAP(A(0), B(0), A(1), '0', A(1), CCR_OLD(0), MUL_P(0), DIV_Q(0), S3, S2, S1, S0, S0, O(0), ALU_OUT(0));
     CELL_ALU1: CELL_ALU PORT MAP(A(1), B(1), A(2), A(0), A(2), A(0), MUL_P(1), DIV_Q(1), S3, S2, S1, S0, C_out(1), O(1), ALU_OUT(1));
     CELL_ALU2: CELL_ALU PORT MAP(A(2), B(2), A(3), A(1), A(3), A(1), MUL_P(2), DIV_Q(2), S3, S2, S1, S0, C_out(2), O(2), ALU_OUT(2));
     CELL_ALU3: CELL_ALU PORT MAP(A(3), B(3), A(4), A(2), A(4), A(2), MUL_P(3), DIV_Q(3), S3, S2, S1, S0, C_out(3), O(3), ALU_OUT(3));
     CELL_ALU4: CELL_ALU PORT MAP(A(4), B(4), A(5), A(3), A(5), A(3), MUL_P(4), DIV_Q(4), S3, S2, S1, S0, C_out(4), O(4), ALU_OUT(4));
     CELL_ALU5: CELL_ALU PORT MAP(A(5), B(5), A(6), A(4), A(6), A(4), MUL_P(5), DIV_Q(5), S3, S2, S1, S0, C_out(5), O(5), ALU_OUT(5));
     CELL_ALU6: CELL_ALU PORT MAP(A(6), B(6), A(7), A(5), A(7), A(5), MUL_P(6), DIV_Q(6), S3, S2, S1, S0, C_out(6), O(6), ALU_OUT(6));
     CELL_ALU7: CELL_ALU PORT MAP(A(7), B(7), SH7, A(6), A(8), A(6), MUL_P(7), DIV_Q(7), S3, S2, S1, S0, C_out(7), O(7), ALU_OUT(7));
     CELL_ALU8: CELL_ALU PORT MAP(A(8), B(8), A(9), A(7), A(9), A(7), MUL_P(8), DIV_Q(8), S3, S2, S1, S0, C_out(8), O(8), ALU_OUT(8));
     CELL_ALU9: CELL_ALU PORT MAP(A(9), B(9), A(10), A(8), A(10), A(8), MUL_P(9), DIV_Q(9), S3, S2, S1, S0, C_out(9), O(9), ALU_OUT(9));
     CELL_ALU10: CELL_ALU PORT MAP(A(10), B(10), A(11), A(9), A(11), A(9), MUL_P(10), DIV_Q(10), S3, S2, S1, S0, C_out(10), O(10), ALU_OUT(10));
     CELL_ALU11: CELL_ALU PORT MAP(A(11), B(11), A(12), A(10), A(12), A(10), MUL_P(11), DIV_Q(11), S3, S2, S1, S0, C_out(11), O(11), ALU_OUT(11));
     CELL_ALU12: CELL_ALU PORT MAP(A(12), B(12), A(13), A(11), A(13), A(11), MUL_P(12), DIV_Q(12), S3, S2, S1, S0, C_out(12), O(12), ALU_OUT(12));
     CELL_ALU13: CELL_ALU PORT MAP(A(13), B(13), A(14), A(12), A(14), A(12), MUL_P(13), DIV_Q(13), S3, S2, S1, S0, C_out(13), O(13), ALU_OUT(13));
     CELL_ALU14: CELL_ALU PORT MAP(A(14), B(14), A(15), A(13), A(15), A(13), MUL_P(14), DIV_Q(14), S3, S2, S1, S0, C_out(14), O(14), ALU_OUT(14));
     CELL_ALU15: CELL_ALU PORT MAP(A(15), B(15), SHR, A(14), CCR_OLD(0), A(14), MUL_P(15), DIV_Q(15), S3, S2, S1, S0, C_out(15), O(15), ALU_OUT(15));
  	  MUX0Y: MUX16X2X1 PORT MAP(YSEL ,"0000000000000000", Y, M0YO);
	   MUVMD: MUX16X2X1 PORT MAP(S0 ,DIV_R(15 DOWNTO 0), MUL_P(31 DOWNTO 16), MUXMDO);
	   MUXO1: MUX16X2X1 PORT MAP(SWAP, ALU_OUT, B, ALUO1);
	   MUXO2: MUX16X2X1 PORT MAP(SWAP, MUXMDO, A, ALUO2);

	   -- COMPARE FUNCTION AND SIGNALS
      COMP <= NOT(S3) AND NOT(S2) AND S1 AND S0;
      LT <= CCR_NEW(0) AND COMP;
      LE <= (CCR_NEW(1) OR CCR_NEW(0)) AND COMP;
      GT <= NOT((CCR_NEW(1) OR CCR_NEW(0))) AND COMP;
      GE <= NOT(CCR_NEW(0)) AND COMP;	

END STRUCTURE;
