LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;

ENTITY REG_BLOCK IS
	PORT (BUSDATA, ALUO1, ALUO2, ADDRESSO, REL  : IN std_logic_vector(15 DOWNTO 0); -- REG_BLOCK GENERAL INPUTS
	      CU_CCR, CAL_CCR : IN std_logic_vector(7 DOWNTO 0); -- CCR EX INPUTS
        CLK, CLRA, CLRB : IN std_logic;
        LdA, LdB, LdX, LdY, LdSP, LdCC, LdPC, Plus2, S_U : IN std_logic; -- REG ENABLE AND INCREMET SELECT (1 OR 2)
        MI, MDH1, MDL1, MDH2, MDL2: IN std_logic; -- Accumulators MUXs Signals
	      MR1, MR2, MACC, MX, MY, MSP, MCC, MPC: IN std_logic_vector(1 DOWNTO 0); -- REGs MUX SIGNALs 2BITs
	      ACCOUT2, YOUT, PCOUT : INOUT std_logic_vector(15 DOWNTO 0);
	      CCOUT : INOUT std_logic_vector(7 DOWNTO 0);
	      REG1, REG2 : OUT std_logic_vector(15 DOWNTO 0));
END REG_BLOCK;

ARCHITECTURE STRUCTURE OF REG_BLOCK IS
-- SIGNALS DECLARATION
   SIGNAL ACCIN, ACCOUT1, XIN, YIN, SPIN, PCIN, PC_INC, CCOUT16, D :std_logic_vector(15 DOWNTO 0); --Y/PC/CCOUT INOUT
   SIGNAL XOUT, SPOUT :std_logic_vector(15 DOWNTO 0);
   SIGNAL CCIN : std_logic_vector(7 DOWNTO 0);
-- COMPONENT DECLARATION
	COMPONENT Acc_BLOCK
	PORT( CLK, CLRA, CLRB, LdA, LdB, S_U : IN std_logic;
		   AccIN : IN std_logic_vector(15 DOWNTO 0);
		   MI, MDH1, MDL1, MDH2, MDL2 :IN std_logic;
       D : INOUT std_logic_vector(15 DOWNTO 0);
		   ACCOUT1, ACCOUT2 : OUT std_logic_vector(15 DOWNTO 0));
	END COMPONENT;
	COMPONENT Reg8
	--GENERIC (Len: integer := 8);
	PORT (Clk, Ld	: IN STD_LOGIC;
		   D			: IN STD_LOGIC_VECTOR(7 downto 0);
		   Q			: OUT STD_LOGIC_VECTOR(7 downto 0));
   END COMPONENT;
	COMPONENT Reg16
	--GENERIC (Len: integer := 16);
	PORT (Clk, Ld	: IN STD_LOGIC;
		   D			: IN STD_LOGIC_VECTOR(15 downto 0);
		   Q			: OUT STD_LOGIC_VECTOR(15 downto 0));
	END COMPONENT;
	COMPONENT INCR
	--GENERIC (Len: integer := 16);
	PORT (Plus2		: IN STD_LOGIC;
		   Inp		: IN STD_LOGIC_VECTOR(15 downto 0);
		   Op		: OUT STD_LOGIC_VECTOR(15 downto 0));
	END COMPONENT;
	COMPONENT MUX8X4X1
   port (M1, M0 : IN std_logic;
         X0 : IN std_logic_vector(7 downto 0);
         X1 : IN std_logic_vector(7 downto 0);
         X2 : IN std_logic_vector(7 downto 0);
         X3 : IN std_logic_vector(7 downto 0);
         Y : OUT std_logic_vector(7 downto 0));
   END COMPONENT;
	COMPONENT MUX16X4X1
   port (M1, M0 : IN std_logic;
         X0 : IN std_logic_vector(15 downto 0);
         X1 : IN std_logic_vector(15 downto 0);
         X2 : IN std_logic_vector(15 downto 0);
         X3 : IN std_logic_vector(15 downto 0);
         Y : OUT std_logic_vector(15 downto 0));
   END COMPONENT;
	BEGIN
	CCOUT16 <= "00000000" & CCOUT;
	-- Registers
	ACCUMULATOR: Acc_BLOCK PORT MAP(CLK,CLRA,CLRB,LdA,LdB,S_U,ACCIN,MI,MDH1,MDL1,MDH2,MDL2,
	                                D,ACCOUT1,ACCOUT2);
	XI: Reg16 PORT MAP(CLK, LdX, XIN, XOUT);
	YI: Reg16 PORT MAP(CLK, LdY, YIN, YOUT);
	SP: Reg16 PORT MAP(CLK, LdSP, SPIN, SPOUT);
	CCR: Reg8 PORT MAP(CLK, LdCC, CCIN, CCOUT);
	PC: Reg16 PORT MAP(CLK, LdPC, PCIN, PCOUT);
  -- INC
	PCINC: INCR PORT MAP(Plus2, PCOUT, PC_INC);
  -- MUXs
  ACCMUX: MUX16X4X1 PORT MAP(MACC(1), MACC(0) ,BUSDATA, ALUO1, ALUO2, D, ACCIN);
	XIMUX: MUX16X4X1 PORT MAP(MX(1), MX(0) ,BUSDATA, ALUO1, ALUO2, ADDRESSO, XIN);
	YIMUX: MUX16X4X1 PORT MAP(MY(1), MY(0), BUSDATA, ALUO1, ALUO2, ADDRESSO, YIN);
	SPMUX: MUX16X4X1 PORT MAP(MSP(1), MSP(0), BUSDATA, ALUO1, ALUO2, ADDRESSO, SPIN);
	CCMUX: MUX8X4X1 PORT MAP(MCC(1), MCC(0), CAL_CCR, ALUO2(7 DOWNTO 0), CU_CCR, BUSDATA(7 DOWNTO 0), CCIN);
	PCMUX: MUX16X4X1 PORT MAP(MPC(1), MPC(0),BUSDATA, REL, ADDRESSO, PC_INC, PCIN);
	R1MUX: MUX16X4X1 PORT MAP(MR1(1), MR1(0),ACCOUT1, YOUT, XOUT, CCOUT16, REG1);
	R2MUX: MUX16X4X1 PORT MAP(MR2(1), MR2(0),ACCOUT2, SPOUT, YOUT, XOUT, REG2);
END STRUCTURE;
