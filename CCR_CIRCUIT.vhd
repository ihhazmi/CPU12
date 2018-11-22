library IEEE;
use ieee.std_logic_1164.all;

entity CCR_CAL is
   port (F, MUL_PHI, B16_2_31 : IN std_logic_vector(15 downto 0); -- ALU RESULT BEFORE
      S3, S2, S1, S0: IN std_logic; -- SELECT SIGNALS 
      DWB : IN std_logic_vector(1 downto 0); -- DOUBLE/WORD/BYTE
      MUL_C8, MUL_C16, RR, RL: IN std_logic; -- MULCARRY B(7) & ROTATE
      C_16, C_15, C_8, C_7, C_4: IN std_logic;-- C_out(16,15,8,7,4)
      CCR_OLD: IN std_logic_vector(7 downto 0); -- MAY BE H, N, Z, V, C ONLY
      CCR_NEW: OUT std_logic_vector(7 downto 0)); -- output
END CCR_CAL;

-- NOT(DWB(1))AND NOT(DWB(0)), NOT(DWB(1))AND DWB(0), DWB(1)AND NOT(DWB(0))
architecture STRUCTURE of CCR_CAL is
-- SIGNAL DECLARATION
   SIGNAL M, L, K: std_logic_vector(15 downto 8);
   SIGNAL H, N, Z, V, C, NI1, ZI1, VI1, CI1, MUL_C : std_logic; -- M = EXCLUDE MUL
-- COMPONENT DECLARATION
	 COMPONENT MUX4X1
	 PORT(I0, I1, I2, I3: IN std_logic;
      S1, S0 : IN std_logic;
      O : OUT std_logic);
	 END COMPONENT;
	 BEGIN
   MUL_C <= (MUL_C16 AND NOT(DWB(1))AND DWB(0)) OR (MUL_C8 AND NOT(DWB(1))AND NOT(DWB(0)));
   CARRYGP:  FOR i IN 8 TO 15 GENERATE
    M(i) <= F(i) AND NOT(DWB(1))AND DWB(0);
    L(i) <= MUL_PHI(i) AND NOT(DWB(1))AND DWB(0);
    K(i) <= B16_2_31(i) AND (DWB(1) XOR DWB(0));
   END GENERATE;
   H <= C_4;
   N <= ((DWB(1)AND NOT(DWB(0)))AND MUL_PHI(15)) OR (F(15) AND NOT(DWB(1))AND DWB(0)) OR (F(7) AND NOT(DWB(1))AND NOT(DWB(0)));
   Z <= NOT (F(0)OR F(1) OR F(2)OR F(3) OR F(4)OR F(5) OR F(6) OR F(7) 
        OR M(8)OR M(9) OR M(10)OR M(11) OR M(12)OR M(13) OR M(14) OR M(15)
        OR L(8)OR L(9) OR L(10)OR L(11) OR L(12)OR L(13) OR L(14) OR L(15)
        OR K(8)OR K(9) OR K(10)OR K(11) OR K(12)OR K(13) OR K(14) OR K(15));
   V <= ((C_16 AND NOT(DWB(1))AND DWB(0)) OR (C_8 AND NOT(DWB(1))AND NOT(DWB(0)))) XOR
        ((C_15 AND NOT(DWB(1))AND DWB(0)) OR (C_7 AND NOT(DWB(1))AND NOT(DWB(0))));
   C <= (C_16 AND NOT(DWB(1))AND DWB(0)) OR (C_8 AND NOT(DWB(1))AND NOT(DWB(0)));
   
   NI1 <= (S1 AND S0 AND CCR_OLD(3)) OR (NOT(S1 AND S0) AND N);
   ZI1 <= (S1 AND S0 AND CCR_OLD(2)) OR (NOT(S1 AND S0) AND Z);
   VI1 <= (S1 AND S0 AND CCR_OLD(1)) OR (NOT(S1 AND S0) AND V);
   CI1 <= (S1 AND S0 AND MUL_C) OR (NOT(S1 AND S0) AND CCR_OLD(0));
   
	 MUX_H: MUX4X1 PORT MAP(H, CCR_OLD(5), CCR_OLD(5), H, S3, S2, CCR_NEW(5));
   MUX_N: MUX4X1 PORT MAP(N, NI1, '1', N, S3, S2, CCR_NEW(3));
	 MUX_Z: MUX4X1 PORT MAP(Z, ZI1, '1', Z, S3, S2, CCR_NEW(2));
   MUX_V: MUX4X1 PORT MAP(V, VI1, '0', V, S3, S2, CCR_NEW(1));
   MUX_C: MUX4X1 PORT MAP(C, CI1, CCR_OLD(0), C, S3, S2, CCR_NEW(0));
   
   CCR_NEW(7 DOWNTO 6) <= CCR_OLD(7 DOWNTO 6);
   CCR_NEW(4) <= CCR_OLD(4);
end STRUCTURE;
