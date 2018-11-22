library IEEE;
use ieee.std_logic_1164.all;

entity DataPath is
   port (IM, DI, EX, O95, O16, RL, PRE_POST : IN std_logic_vector(15 DOWNTO 0); 
   -- IM=Immidiate, DIEX=00:DI/EX, O95=SIGN EXTENDED 5/9BIT OFFSET, O16=16BIT OFFSET, mm=MASK
         CU_CCR : IN std_logic_vector(7 DOWNTO 0); -- CCR EX INPUTS
         CLK, CLRA, CLRB  : IN std_logic; 
         LdA, LdB, LdX, LdY, LdSP, LdCC, LdPC, Plus2 : IN std_logic; -- REG LOAD AND INCREMET SELECT (1 OR 2)
         MDH1, MDL1, MDH2, MDL2, MAA, MAD2 : IN std_logic; -- MUXs SIGNALs 1BIT | MI=SWAP
         MR1, MR2, MACC, MX, MY, MSP, MCC, MPC, MAB, MBUS, MAD1, MAD, DWB, En : IN std_logic_vector(1 DOWNTO 0); -- MUXs SIGNALs 2BITs|DOUBLE/WORD/BYTE
         S_U, S3, S2, S1, S0: IN std_logic; -- SIGED/UNSIGNED & ALU OPERATION SELECT 
         SWAP, MI, ALSH : IN std_logic; -- ARITHMETIC/LOGIC SHIFT AND SWAP | (MI) FOR ACCLOW->A = SWAP WHEN EXG A,B
         CCOUT : INOUT std_logic_vector(7 DOWNTO 0);
         BUSMUXO, MEMDATA, ADDRESSO : INOUT std_logic_vector(15 DOWNTO 0); -- OPERATION RESULT -> DATA BUS
         GE, LE, LT, GT: OUT std_logic); -- COMP_OUT
END DataPath;

architecture STRUCTURE of DataPath is
-- SIGNAL DECLARATION  
   SIGNAL BUSDATA : std_logic_vector (15 DownTo 0);
   SIGNAL mm : std_logic_vector (15 DownTo 0) := "0000000000001111";
   SIGNAL REG1, REG2, ALUA, ALUB, ACCOUT2, YOUT, PCOUT, ALUO1, ALUO2, MADDR1, MADDR2, MUXADD, CCR16 : std_logic_vector(15 downto 0);
   SIGNAL CCR_NXT : std_logic_vector(7 downto 0);                   --^ ADDMUXOUT
   SIGNAL En0, En1, En2, En3 : std_logic;                   --^ ADDMUXOUT
-- COMPONENT DECLARATION  
	COMPONENT ALU16
   port (A, B, Y: IN std_logic_vector(15 downto 0); -- ALU INPUT1&2
         CCR_OLD: IN std_logic_vector(7 downto 0);
         DWB: IN std_logic_vector(1 DOWNTO 0); -- DOUBLE/WORD/BYTE 
         S_U: IN std_logic; -- Sign / UnSigned
         S3, S2, S1, S0: IN std_logic; -- ALU Operation Select 
         SWAP, ALSH : IN std_logic; -- ARITHMETIC/LOGIC SHIFT AND SWAP
         CCR_NEW: INOUT std_logic_vector(7 downto 0); -- NEW CCR VALUES
         ALUO1, ALUO2 : OUT std_logic_vector(15 downto 0); -- ALU output
         GE, LE, LT, GT: OUT std_logic); -- COMP_OUT
   END COMPONENT;
------------------------
	COMPONENT REG_BLOCK
	 PORT(BUSDATA, ALUO1, ALUO2, ADDRESSO, REL : IN std_logic_vector(15 DOWNTO 0); -- REG_BLOCK GENERAL INPUTS
	      CU_CCR, CAL_CCR : IN std_logic_vector(7 DOWNTO 0); -- CCR EX INPUTS
        CLK, CLRA, CLRB : IN std_logic;
        LdA, LdB, LdX, LdY, LdSP, LdCC, LdPC, Plus2, S_U : IN std_logic; -- REG ENABLE AND INCREMET SELECT (1 OR 2)
        MI, MDH1, MDL1, MDH2, MDL2: IN std_logic; -- Accumulators MUXs Signals
	      MR1, MR2, MACC, MX, MY, MSP, MCC, MPC : IN std_logic_vector(1 DOWNTO 0); -- REGs MUX SIGNALs 2BITs
	      ACCOUT2, YOUT, PCOUT : INOUT std_logic_vector(15 DOWNTO 0);
	      CCOUT : INOUT std_logic_vector(7 DOWNTO 0);
	      REG1, REG2 : OUT std_logic_vector(15 DOWNTO 0));
   END COMPONENT;
-----------------------
	COMPONENT MUX16X4X1
   port (M1, M0 : IN std_logic;
         X0 : IN std_logic_vector(15 downto 0);
         X1 : IN std_logic_vector(15 downto 0);
         X2 : IN std_logic_vector(15 downto 0);
         X3 : IN std_logic_vector(15 downto 0);
         Y : OUT std_logic_vector(15 downto 0));
   END COMPONENT;
-----------------------
	COMPONENT MUX16X2X1
   port (M : IN std_logic; -- SELECT SIGNAL
         X0 : IN std_logic_vector(15 downto 0);
         X1 : IN std_logic_vector(15 downto 0);
         Y : OUT std_logic_vector(15 downto 0));
   END COMPONENT;
----------------------
	COMPONENT ADD16 -- ADDRESS ADDER
   port (A, B : IN std_logic_vector(15 downto 0); -- ADDER INPUT1&2
         ADDOUT : OUT std_logic_vector(15 downto 0)); -- ADDER_OUT
   END COMPONENT;
----------------------
	COMPONENT MEMSAMPLE
	PORT (CLK : IN std_logic;
			ADDRESSO : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			DATAMEM : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
   END COMPONENT;
-----------------------
	COMPONENT three_state
  port (a : in std_logic_vector(15 DOWNTO 0);
        En : in std_logic;
        z : out std_logic_vector(15 DOWNTO 0));
   END COMPONENT;
-----------------------
	BEGIN

    En0 <= NOT(En(1)) AND NOT(En(0));
    En1 <= NOT(En(1)) AND En(0);
    En2 <= En(1) AND NOT(En(0));
    En3 <= En(1) AND En(0);

	   CCR16(15 DOWNTO 8) <= (OTHERS => CCOUT(7));
	   CCR16(7 DOWNTO 0)  <= CCOUT;

	   REG: REG_BLOCK PORT MAP(BUSDATA,ALUO1,ALUO2,ADDRESSO,RL,CU_CCR,CCR_NXT,CLK,CLRA,CLRB,
	                           LdA,LdB,LdX,LdY,LdSP,LdCC,LdPC,Plus2,S_U,MI,MDH1,MDL1,MDH2,MDL2, 
	                           MR1,MR2,MACC,MX,MY,MSP,MCC,MPC,ACCOUT2,YOUT,PCOUT,CCOUT,REG1,REG2);
	   ALU: ALU16 PORT MAP(ALUA,ALUB,YOUT,CCOUT,DWB,S_U,S3,S2,S1,S0,SWAP,ALSH,CCR_NXT,ALUO1,ALUO2,GE,LE,LT,GT);
	   AMUX: MUX16X2X1 PORT MAP(MAA, BUSDATA, REG1, ALUA);
	   BMUX: MUX16X4X1 PORT MAP(MAB(1), MAB(0), BUSDATA, REG2, "0000000000000000", mm, ALUB);
	   BUS_MUX: MUX16X4X1 PORT MAP(MBUS(1), MBUS(0), REG2, ALUO1, CCR16, PCOUT, BUSMUXO);
	   ADDR1MUX: MUX16X4X1 PORT MAP(MAD1(1), MAD1(0), ACCOUT2, PRE_POST, O95, O16, MADDR1);
	   ADDR2MUX: MUX16X2X1 PORT MAP(MAD2 ,PCOUT, REG2, MADDR2);
	   ADD16A: ADD16 PORT MAP(MADDR1, MADDR2, MUXADD);
	   ADDMUX: MUX16X4X1 PORT MAP(MAD(1), MAD(0), REG2, MUXADD, EX, DI, ADDRESSO);
	   MEMS: MEMSAMPLE PORT MAP(CLK, ADDRESSO, MEMDATA);
	   NUMBUF: three_state PORT MAP("1000000000001111", En0, BUSDATA); -- CONSTANT AT THE BEGINNING
	   MEMBUF: three_state PORT MAP(MEMDATA, En1, BUSDATA); -- MEMORY DATA TO DATA BUS 
	   CTRBUF: three_state PORT MAP(IM, En2, BUSDATA); -- CONTROL UNIT TO DATA BUS
	   BMXBUF: three_state PORT MAP(BUSMUXO, En3, BUSDATA); -- BUS MUX OUTPUT TO DTAT BUS
	   
END STRUCTURE;
