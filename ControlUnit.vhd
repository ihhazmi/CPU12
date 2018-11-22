--  INSTRUCTIONSTATES.vhd
--  VHDL code created by Xilinx's StateCAD 9.1i
--  Tue Jun 30 17:49:22 2009

--  This VHDL code (for use with IEEE compliant tools) was generated using: 
--  enumerated state assignment with structured code format.
--  Minimization is enabled,  implied else is enabled, 
--  and outputs are speed optimized.


-- EXG, SEX AND TFR FUNCTIONS NEED TO IMPLEMENT THEIR TABLE HERE!


LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY INSTRUCTIONSTATES IS
	PORT (CLK,RESET: IN std_logic;
		  -- OPCODE, OPCODEP2, POSTCODE, OFFSETH, OFFSETL, REL8: IN std_logic_vector(7 downto 0); -- FROM IR 
			DATAMEM : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			INSTSEL: IN std_logic_vector(3 downto 0);
			IM, DI, EX, O95, O16, RL, PRE_POST : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      CU_CCR : OUT std_logic_vector (7 DownTo 0);
			MR1,MR2,MACC,MSP,MX,MY,MCC,MPC,MAB,MAD1,MAD,MBUS,DWB,En : OUT std_logic_VECTOR(1 DOWNTO 0);
		  CLRA,CLRB,LdA,LdB,LdCC,LdPC,LdSP,LdX,LdY,MAA,MDH1,MDH2,MDL1,MDL2,MAD2,
			Plus2,S0,S1,S2,S3,S_U,SWAP,MI,ALSH,DONE : OUT std_logic);
END;

ARCHITECTURE BEHAVIOR OF INSTRUCTIONSTATES IS
	TYPE type_sreg IS (BRANCH,DCALADD,DECODE,EXECUTE,FETCH,GETADD,GETDATA,
		ICALADD,P2DECODE,POSTBYTE,RWRITE,START);
	SIGNAL sreg, next_sreg : type_sreg;
  SIGNAL OPCODE, OPCODEP2, POSTCODE, OFFSETH, OFFSETL, REL8: std_logic_vector(7 downto 0);
BEGIN

CU_CCR <= "10001111"; -- DUMMY VALUE (CHANGES AT CONDITIONAL BTRANCHES)
OFFSETH <= "00001000"; -- $8
OFFSETL <= "00001000"; -- $8
REL8 <= "00001001"; --WHEN BRANCH ONLY

	PROCESS (CLK, next_sreg) -- SAMPLE CODING (ADDA
	BEGIN
		IF CLK='1' AND CLK'event THEN
			sreg <= next_sreg;
      CASE INSTSEL IS
				WHEN "0000" =>					OPCODE <= "10001011"; IM <= "0000000010001000";-- IMM
				WHEN "0001" =>					OPCODE <= "10011011"; -- DIR
				WHEN "0010" =>					OPCODE <= "10111011"; -- EXT
				WHEN "0011" =>					OPCODE <= "10101011"; POSTCODE <= "11010100";--OFFSET5 D4
				WHEN "0100" =>					OPCODE <= "10101011"; POSTCODE <= "11110000";--OFFSET9 F0
				WHEN "0101" =>					OPCODE <= "10101011"; POSTCODE <= "11110010";--OFFSET16 F2
				WHEN "0110" =>					OPCODE <= "10101011"; POSTCODE <= "00100010";--PRE-POST 22
				WHEN "0111" =>					OPCODE <= "10101011"; POSTCODE <= "11101100";--AOFFSET EC
				WHEN "1000" =>					OPCODE <= "10101011"; POSTCODE <= "11101101";--BOFFSET ED
				WHEN "1001" =>					OPCODE <= "10101011"; POSTCODE <= "11100110";--DOFFSET E6
				WHEN "1010" =>					OPCODE <= "10101011"; POSTCODE <= "11110011";--16 F3
				WHEN "1011" =>					OPCODE <= "10101011"; POSTCODE <= "11101111";--DI EF
				WHEN "1100" =>					OPCODE <= "00011000"; OPCODEP2 <= "00000110";-- ABA
--				WHEN "1101" =>					OPCODE <= "00010010"; -- DUMMY
				WHEN OTHERS =>     OPCODE <= "00000000";
			END CASE;
		END IF;
	END PROCESS;

	PROCESS (sreg,OPCODE,OPCODEP2,POSTCODE,RESET, INSTSEL)

    VARIABLE REL,BP_CLRA,BP_CLRB,BP_LdA,BP_LdB,BP_LdCC,BP_LdPC,BP_LdSP,BP_LdX,
             BP_LdY,BP_MAA,BP_MDH1,BP_MDH2,BP_MDL1,BP_MDL2,BP_MAD2,
             BP_Plus2,BP_S0,BP_S1,BP_S2,BP_S3,BP_S_U,BP_SWAP,BP_MI,BP_ALSH,BP_DONE: std_logic;

    VARIABLE BP_MR1,BP_MR2,BP_MACC,BP_MSP,BP_MX,BP_MY,BP_MCC,BP_MPC,BP_MAB,BP_MAD1,BP_MAD,
             BP_MBUS,BP_DWB,BP_En: std_logic_VECTOR(1 DOWNTO 0);

	BEGIN

		IF ( RESET='1' ) THEN
			next_sreg<=START;
			BP_CLRA:='0';
			BP_CLRB:='0';
			BP_LdA:='1';
			BP_LdB:='1';
			BP_LdCC:='0';
			BP_LdPC:='1';
			BP_LdSP:='1';
			BP_LdX:='1';
			BP_LdY:='1';
			BP_MAA:='0';
			BP_MDH1:='0';
			BP_MDL1:='0';
			BP_MDH2:='0';
			BP_MDL2:='0';
			BP_MAD:="00";
			BP_MAD2:='0';
			BP_Plus2:='0';
			BP_S3:='0';
			BP_S2:='0';
			BP_S1:='0';
			BP_S0:='0';
			BP_S_U:='0';
			BP_SWAP:='0';
         BP_MI:='0';
			BP_ALSH:='0';
         BP_MR1:="00";
         BP_MR2:="00";
         BP_MACC:="00";
         BP_MSP:="00";
         BP_MX:="00";
         BP_MY:="00";
         BP_MCC:="00";
         BP_MPC:="00";
         BP_MAB:="00";
         BP_MAD1:="00";
         BP_MBUS:="01";
         BP_DWB:="00";
         BP_En:="00";

			BP_DONE:='0';

		ELSE

			CASE sreg IS

				WHEN START =>					
			next_sreg<=FETCH;

			  WHEN FETCH =>					
			next_sreg<=DECODE;
			BP_CLRA:='0';
			BP_CLRB:='0';
			BP_LdA:='0';
			BP_LdB:='0';
			BP_LdCC:='0';
			BP_LdSP:='0';
			BP_LdX:='0';
			BP_LdY:='0';
			BP_DONE:='0'; -- IN THE NEW BEGINNING

				WHEN DECODE =>

			BP_CLRA:='0';
			BP_CLRB:='0';
			BP_LdA:='0';
			BP_LdB:='0';
			BP_LdCC:='0';
			BP_LdSP:='0';
			BP_LdX:='0';
			BP_LdY:='0';
			BP_LdPC:='1';
			BP_MPC:="11";
			BP_Plus2:='0';

					
					IF (OPCODE = "00011000") THEN --$18 
						next_sreg<=P2DECODE; -- PAGE 2

					ELSIF (OPCODE = "00000000" OR OPCODE = "10100111") THEN
						next_sreg<=FETCH; -- NOP, BGND

				  ELSIF (OPCODE="00000101" OR OPCODE="00010101" OR OPCODE(7 downto 2)="000011" OR
					     OPCODE = "00011001" OR OPCODE(7 downto 1)="0001101" OR
					     OPCODE = "01001011" OR OPCODE(7 downto 4)="0110" OR
					     OPCODE(7 downto 4)="1010" OR OPCODE(7 downto 4)="1110" -- INEDXED ADDRESSING MODE
					     OR OPCODE = "10110111" ) THEN -- $B7 EXCHANGE AND TRANSFER POSTBYTE
						next_sreg<=POSTBYTE;  -- EXG/TFR ARE INCLUDED BUT WITH DIFFERENT CODING

					ELSIF (OPCODE(7 downto 4)="0011" OR OPCODE(7 downto 2)="000000" OR
					     OPCODE(7 downto 2)="000010" OR OPCODE = "00010001" OR 
					     OPCODE(7 downto 1)="0001001" OR OPCODE(7 downto 3)="01000" OR
					     OPCODE(7 downto 1)="0100100" OR OPCODE(7 downto 3)="01010" OR
					     OPCODE(7 downto 1)="0101100" OR OPCODE = "00010000" OR OPCODE = "00010100" OR
					     OPCODE(7 downto 4)= "1000" OR OPCODE(7 downto 4)="1100") THEN
						next_sreg<=EXECUTE; -- INH & IMM (EXCLUDE (IMM) OPCODE=10XX0111+110X0111)

					ELSIF (OPCODE = "00010111" OR OPCODE(7 downto 2)="010011" OR
					     OPCODE(7 downto 2)="010111" OR OPCODE(7 downto 1)="0101101" OR
					     OPCODE(7 downto 4)="1001" OR OPCODE(7 downto 4)="1101" OR
					     OPCODE = "00000110" OR OPCODE = "00010110" OR OPCODE(7 downto 2)="000111" OR
					     OPCODE = "01001010" OR OPCODE(7 downto 4)="0111" OR OPCODE(7 downto 4)="1011") THEN
						next_sreg<=GETDATA; -- DI OR EX
					
					ELSIF ( OPCODE = "00000100" OR OPCODE = "00000111" OR OPCODE(7 downto 4)="0010") THEN
						next_sreg<=BRANCH; -- REL
					END IF;

				WHEN P2DECODE =>
  			   BP_CLRA:='0';
			   BP_CLRB:='0';
			   BP_LdA:='0';
			   BP_LdB:='0';
			   BP_LdCC:='0';
			   BP_LdSP:='0';
			   BP_LdX:='0';
			   BP_LdY:='0';
			   BP_LdPC:='1';
			   BP_MPC:="11";
			   BP_Plus2:='0';
					IF (OPCODEP2(7 downto 3)="00011" OR OPCODEP2 = "00111101" OR OPCODEP2 = "00111111") THEN
						next_sreg<=POSTBYTE; -- INDEXED

					ELSIF (OPCODEP2(7 downto 3)="00010" OR OPCODEP2(7 downto 1)="0000011" 
					   OR OPCODEP2(7 downto 1)="0000111" OR OPCODEP2 = "00111110") THEN
						next_sreg<=EXECUTE; -- INH

					ELSIF ( OPCODEP2(7 downto 2)="000000" OR OPCODE(7 downto 1)="0000010" 
					  OR OPCODEP2(7 downto 2)="000010" OR OPCODE(7 downto 1)="0000110") THEN
						next_sreg<=GETDATA; -- DI OR EX

					ELSIF (OPCODEP2(7 downto 4)="0010") THEN
						next_sreg<=BRANCH; -- REL
					END IF;

				WHEN BRANCH =>
					next_sreg<=FETCH;
          RL <= "00000000" & REL8;
			    BP_CLRA:='0';
			    BP_CLRB:='0';
			    BP_LdA:='0';
			    BP_LdB:='0';
			    BP_LdCC:='0';
			    BP_LdPC:='0';
			    BP_LdSP:='0';
			    BP_LdX:='0';
			    BP_LdY:='0';
          BP_LdPC:='1';
					BP_MPC:="10";
					BP_DONE:='1'; -- IN THE TRANSACTION TO NEW FETCH

				WHEN EXECUTE => -- PC (IH(?)
-- SAMPLE EXECUTION OF ADDA + FETCH AFTER EXECUTE WHEN CCR TEST
 						IF(OPCODE = "00010000" OR OPCODE = "00010100" OR 
 						   OPCODE(7 downto 4)="1000" OR OPCODE(7 downto 4)="1100") THEN 
			        BP_LdPC:='1';  -- IMM
			        BP_MPC:="11";
			        BP_Plus2:='0';
						  BP_En:="10";
						ELSE
						  BP_En:="01";
						END IF;
						
					   IF (OPCODE(7 downto 4)="0011" OR OPCODE(7 downto 2)="000000" OR OPCODE(7 downto 2)="000010"
					       OR OPCODE = "00010001" OR OPCODE(7 downto 1)= "0001001" OR OPCODE(7 downto 3)="01000"
					       OR OPCODE(7 downto 1)="0100100" OR OPCODE(7 downto 3)="01010" OR OPCODE(7 downto 1)="0101100"
					       OR OPCODEP2(7 downto 3)="00010" OR OPCODEP2(7 downto 1)="0000011" 
					       OR OPCODEP2(7 downto 1)="0000111" OR OPCODEP2 = "00111110")THEN
						  BP_MAB:="01";--INH
						  IF (OPCODE = "10100111" OR OPCODE = "11000111" OR OPCODE(7 DOWNTO 2)="000000"
						  OR OPCODE(7 DOWNTO 2)="000010" OR OPCODE = "00010001" OR OPCODE(7 DOWNTO 1)="0000001"
						  OR OPCODE(7 DOWNTO 4)="0011" OR OPCODE(7 DOWNTO 3)="01000" OR OPCODE(7 DOWNTO 1)="0100100"
						  OR OPCODE(7 DOWNTO 3)="01010" OR OPCODE(7 DOWNTO 1)="0101100" OR OPCODE = "10000111")THEN -- NOT SINGLE YTE INSTRUCTION
			           BP_LdPC:='0';
						  ELSE
			           BP_LdPC:='1';
			           BP_MPC:="11";
			           BP_Plus2:='0';
						  END IF;
                  ELSIF (OPCODE(7 DOWNTO 2)="000011" OR OPCODE(7 DOWNTO 2)="000111"
                      OR OPCODE(7 DOWNTO 2)="010011")THEN -- mm=11(BCLR,BRCLR,BSET,BRSET),
						  BP_MAB:="11"; 
                  ELSIF ((OPCODE(7 DOWNTO 6)="01" AND OPCODE(3 DOWNTO 0)="0000")OR
                    OPCODE = "10010111" OR OPCODE = "11010111" OR OPCODE = "11100111" OR
                    OPCODE = "11110111" OR OPCODE = "01101001" OR OPCODE = "01111001")THEN
						  BP_MAB:="10"; -- 00=10(NEG,TST: A, B AND MEM + CLR MEM IF NO MEM CLR SIGNAL:01101001,01101001)
                  ELSE
						  BP_MAB:="00"; -- THE REST OF (DI, EX, AND ID)
                  END IF;

            IF ( OPCODE = "00000100" OR OPCODE = "00000111" OR OPCODE(7 downto 4)="0010"
              OR OPCODEP2(7 downto 4)="0010") THEN
              REL := '1';
            ELSE REL := '0';
            END IF;
            -- HERE WILL BE ONLY FOR ADD EXAMPLE
						BP_CLRA:='0';
						BP_MDH1:='0'; 
						BP_MDL1:='0';
						BP_MDH2:='0';
						BP_MDL2:='1';
--						BP_MACC:="00";
						BP_MAA:='1';
						BP_MR1:="00";
--						BP_MBUS:="01";
						BP_DWB:="00";
						BP_S_U:='0';
						BP_S3:='0';
						BP_S2:='0';
						BP_S1:='0';
						BP_S0:='0';
						BP_SWAP:='0';
--						BP_ALSH:='1';
					    
					IF ( REL='1' ) THEN
						next_sreg<=BRANCH;
          ELSIF (OPCODE="00000000" OR (OPCODE(7)='1' AND OPCODE(3 downto 0)="0001")
              OR OPCODE="10000111" OR OPCODE="10010111" OR OPCODE="10100111"
              OR( OPCODE(7 DOWNTO 6)="11" AND OPCODE(3 downto 0)="0111")
              OR(OPCODE(7 downto 6)="10" AND OPCODE(3 DOWNTO 2)="11"))THEN
						next_sreg<=FETCH;
						BP_DONE:='1'; -- IN THE TRANSACTION TO NEW FETCH
				  ELSE
						next_sreg<=RWRITE;
					END IF;

				WHEN GETDATA => 
					next_sreg<=EXECUTE;
        -- SAMPLE EXECUTION OF ADDA
						BP_LdX:='0';
						BP_LdY:='0';
						BP_LdSP:='0';

 						IF(OPCODE = "00000110" OR OPCODE = "00010110" OR OPCODE(7 downto 2)="000111" 
					  OR OPCODE = "01001010" OR OPCODE(7 downto 4)="0111" OR OPCODE(7 downto 4)="1011" 
            OR OPCODEP2(7 downto 2)="000000" OR OPCODE(7 downto 1)="0000010" 
					  OR OPCODEP2(7 downto 2)="000010" OR OPCODE(7 downto 1)="0000110") THEN 
 						  EX<= OFFSETH & OFFSETL; -- Extend
     						  BP_MAD:="10";
			        BP_LdPC:='1';
			        BP_MPC:="11";
			        BP_Plus2:='1';
						ELSIF (OPCODE = "00010111" OR OPCODE(7 downto 2)="010011"
					      OR OPCODE(7 downto 2)="010111" OR OPCODE(7 downto 1)="0101101"
					      OR OPCODE(7 downto 4)="1001" OR OPCODE(7 downto 4)="1101")THEN
						  DI<= "00000000" & OFFSETL; -- Direct
	     						BP_MAD:="11";
			        BP_LdPC:='1';
			        BP_MPC:="11";
			        BP_Plus2:='0';
--					  ELSIF ((OPCODE="00000101" OR OPCODE="00010101" OR OPCODE(7 downto 2)="000011" OR
--					     OPCODE = "00011001" OR OPCODE(7 downto 1)="0001101" OR OPCODE = "01001011" 
--					     OR OPCODE(7 downto 4)="0110" OR OPCODE(7 downto 4)="1010"  
--					     OR OPCODE(7 downto 4)="1110" OR OPCODE = "10110111")
--					     AND(POSTCODE(7 downto 5)="111" AND POSTCODE(1 downto 0)="11")) THEN  -- INDIRECT INDEX
					  ELSIF (POSTCODE(7 downto 5)="111" AND POSTCODE(1 downto 0)="11") THEN  -- INDIRECT INDEX
						  EX <= DATAMEM; -- InDirect IndxED
	     						BP_MAD:="10";
            ELSE
	     						BP_MAD:="01";
			        BP_LdPC:='0';
					  END IF;

				WHEN RWRITE =>        -- SAMPLE EXECUTION OF ADDA
					next_sreg<=FETCH;
					IF (NOT(OPCODE(7 downto 4)="0011" OR OPCODE(7 downto 2)="000000" OR OPCODE(7 downto 2)="000010"
					   OR OPCODE = "00010001" OR OPCODE(7 downto 1)= "0001001" OR OPCODE(7 downto 3)="01000"
					   OR OPCODE(7 downto 1)="0100100" OR OPCODE(7 downto 3)="01010" OR OPCODE(7 downto 1)="0101100"
					   OR OPCODEP2(7 downto 3)="00010" OR OPCODEP2(7 downto 1)="0000011" 
					   OR OPCODEP2(7 downto 1)="0000111" OR OPCODEP2 = "00111110" OR
					   OPCODE = "00010000" OR OPCODE = "00010100" OR 
 						OPCODE(7 downto 4)="1000" OR OPCODE(7 downto 4)="1100"))THEN -- DI, EX OR ID
			            BP_LdPC:='0'; 
					      IF (POSTCODE(5) = '1') THEN -- PRE-POST
                        IF (POSTCODE(7 DOWNTO 6) = "00") THEN --X
						         BP_MR2:="11";
						         BP_MAD2:='1';
						         BP_LdX:='1';
			                  BP_MX:="11";
						      ELSIF (POSTCODE(7 DOWNTO 6) = "01") THEN --Y
						         BP_MR2:="10";
					            BP_MAD2:='1';
						         BP_LdY:='1';
			                  BP_MY:="11";
					         ELSIF (POSTCODE(7 DOWNTO 6) = "10") THEN --SP
						         BP_MR2:="01";
						         BP_MAD2:='1';
						         BP_LdSP:='1';
			                  BP_MSP:="11";
						      END IF;
                     ELSE
						      BP_LdX:='0';
						      BP_LdY:='0';
						      BP_LdSP:='0';
					      END IF;
					   END IF;
                  BP_CLRA:='0';
      				      BP_CLRB:='0';
                  BP_MI:='1';
					   BP_LdA:='1';
					   BP_LdB:='0';
					   BP_LdCC:='0';
					   BP_LdPC:='0';
					   BP_MACC:="01";
					   BP_DONE:='1'; -- IN THE TRANSACTION TO NEW FETCH

				WHEN POSTBYTE =>
					IF (OPCODE = "10110111")THEN
					  next_sreg<=EXECUTE;
					  -- CASE STATEMENT FOR THE EXG AND TFR CODING TO PUT HERE (WHEN EXG A,B SWAP=MI=1) SEX S_U ='1'
					ELSIF (POSTCODE(7 downto 5)="111" AND POSTCODE(1 downto 0)="11") THEN  -- INDIRECT INDEX
						next_sreg<=ICALADD;
				  ELSE-- DIRECT INDEX
						next_sreg<=DCALADD;
          END IF;               

				WHEN DCALADD =>
					next_sreg<=GETDATA;
					BP_En:="01";
						IF (POSTCODE(7 downto 5)="111" AND POSTCODE(2)='1') THEN -- ACC OFFSET
                  BP_MAD:="01";
						      BP_MAD1:="00";
						   IF (POSTCODE(7 downto 5)="111" AND POSTCODE(2 downto 0)="100") THEN  --A
						      BP_MDH1:='0';
						      BP_MDL1:='0';
                     ELSIF (POSTCODE(7 downto 5)="111" AND POSTCODE(2 downto 0)="101") THEN --B
						      BP_MDH1:='0';
						      BP_MDL1:='1';
                     ELSIF (POSTCODE(7 downto 5)="111" AND POSTCODE(2 downto 0)="110") THEN --D
						      BP_MDH1:='1';
						      BP_MDL1:='1';
  						   END IF;
						   IF (POSTCODE(4 DOWNTO 3) = "00") THEN --X
						      BP_MR2:="11";
						      BP_MAD2:='1';
						   ELSIF (POSTCODE(4 DOWNTO 3) = "01") THEN --Y
						      BP_MR2:="10";
						      BP_MAD2:='1';
					     ELSIF (POSTCODE(4 DOWNTO 3) = "10") THEN --SP
						      BP_MR2:="01";
						      BP_MAD2:='1';
						   ELSIF (POSTCODE(4 DOWNTO 3) = "11") THEN -- PC
						      BP_MAD2:='0';
						   END IF;
  
  						ELSIF (POSTCODE(7 downto 5)="111" AND POSTCODE(2 downto 0)="010") THEN -- 16 
               BP_MAD:="01";
						   BP_MAD1:="11";
   			         BP_LdPC:='1';
			         BP_MPC:="11";
		     	     BP_Plus2:='1';    
              O16 <= OFFSETH & OFFSETL;
               IF (POSTCODE(4 DOWNTO 3) = "00") THEN --X
						      BP_MR2:="11";
						      BP_MAD2:='1';
						   ELSIF (POSTCODE(4 DOWNTO 3) = "01") THEN --Y
						      BP_MR2:="10";
						      BP_MAD2:='1';
					      ELSIF (POSTCODE(4 DOWNTO 3) = "10") THEN --SP
						      BP_MR2:="01";
						      BP_MAD2:='1';
						   ELSIF (POSTCODE(4 DOWNTO 3) = "11") THEN -- PC
						      BP_MAD2:='0';
						   END IF;

						ELSIF (POSTCODE(7 downto 5)="111" AND POSTCODE(2 downto 1)="00") THEN -- OFFSET9
               BP_MAD:="01";
						   BP_MAD1:="10";
  			         BP_LdPC:='1';
			         BP_MPC:="11";
		     	     BP_Plus2:='0';    
             O95(7 DOWNTO 0) <= OFFSETH;
               O95(15 DOWNTO 8) <= (OTHERS => POSTCODE(0));
               IF (POSTCODE(4 DOWNTO 3) = "00") THEN --X
						      BP_MR2:="11";
						      BP_MAD2:='1';
						   ELSIF (POSTCODE(4 DOWNTO 3) = "01") THEN --Y
						      BP_MR2:="10";
						      BP_MAD2:='1';
					      ELSIF (POSTCODE(4 DOWNTO 3) = "10") THEN --SP
						      BP_MR2:="01";
						      BP_MAD2:='1';
						   ELSIF (POSTCODE(4 DOWNTO 3) = "11") THEN -- PC
						      BP_MAD2:='0';
						   END IF;

						ELSIF (POSTCODE(5) = '0') THEN -- OFFSET5
               BP_MAD:="01";
						   BP_MAD1:="10";
               O95(4 DOWNTO 0) <= POSTCODE(4 DOWNTO 0);
               O95(15 DOWNTO 5) <= (OTHERS => POSTCODE(4));
               IF (POSTCODE(7 DOWNTO 6) = "00") THEN --X
						      BP_MR2:="11";
						      BP_MAD2:='1';
						   ELSIF (POSTCODE(7 DOWNTO 6) = "01") THEN --Y
						      BP_MR2:="10";
						      BP_MAD2:='1';
					      ELSIF (POSTCODE(7 DOWNTO 6) = "10") THEN --SP
						      BP_MR2:="01";
						      BP_MAD2:='1';
						   ELSIF (POSTCODE(7 DOWNTO 6) = "11") THEN -- PC
						      BP_MAD2:='0';
						   END IF;

						ELSIF (POSTCODE(5) = '1') THEN -- PRE
						  BP_MAD1:="01";
			           BP_MPC:="11";
		     	        BP_Plus2:='0';    
                    PRE_POST(3 DOWNTO 0) <= POSTCODE(3 DOWNTO 0);
                    PRE_POST(15 DOWNTO 4) <= (OTHERS => POSTCODE(4));
                    IF (POSTCODE(4) = '0') THEN
 						    BP_MAD:="01";
                      IF (POSTCODE(7 DOWNTO 6) = "00") THEN --X
						      BP_MR2:="11";
						    ELSIF (POSTCODE(7 DOWNTO 6) = "01") THEN --Y
						      BP_MR2:="10";
					       ELSIF (POSTCODE(7 DOWNTO 6) = "10") THEN --SP
						      BP_MR2:="01";
						    END IF;
                    ELSIF (POSTCODE(4) = '1') THEN
 						    BP_MAD:="00";
                      IF (POSTCODE(7 DOWNTO 6) = "00") THEN --X
						      BP_MR2:="11";
						    ELSIF (POSTCODE(7 DOWNTO 6) = "01") THEN --Y
						      BP_MR2:="10";
					       ELSIF (POSTCODE(7 DOWNTO 6) = "10") THEN --SP
						      BP_MR2:="01";
						    END IF;
                    END IF;
                  END IF;


				WHEN ICALADD => 
					next_sreg<=GETADD;
 			    BP_MAD:="01";
					BP_En:="01";

						IF (POSTCODE(4 DOWNTO 3) = "00") THEN --X
						      BP_MR2:="11";
						      BP_MAD2:='1';
						ELSIF (POSTCODE(4 DOWNTO 3) = "01") THEN --Y
						      BP_MR2:="10";
						      BP_MAD2:='1';
					   ELSIF (POSTCODE(4 DOWNTO 3) = "10") THEN --SP
						      BP_MR2:="01";
						      BP_MAD2:='1';
						ELSIF (POSTCODE(4 DOWNTO 3) = "11") THEN -- PC
						      BP_MAD2:='0';
						END IF;

						IF (POSTCODE(7 downto 5)="111" AND POSTCODE(2 downto 0)="111") THEN -- D
						   BP_MAD1:="00";
						   BP_MDH1:='1';
						   BP_MDL1:='1';

            ELSIF (POSTCODE(7 downto 5)="111" AND POSTCODE(2 downto 0)="011") THEN --16
						   BP_MAD1:="11";
   			         BP_LdPC:='1';
			         BP_MPC:="11";
		     	     BP_Plus2:='1';    
						   O16<= OFFSETH & OFFSETL;
 						END IF;

				WHEN GETADD =>
					next_sreg<=GETDATA;

				WHEN OTHERS =>
			END CASE;
		END IF;


      CLRA <= BP_CLRA;
      CLRB <= BP_CLRB;
      LdA <= BP_LdA;
      LdB <= BP_LdB;
      LdCC <= BP_LdCC;
      LdPC <= BP_LdPC;
      LdSP <= BP_LdSP;
      LdX <= BP_LdX;
      LdY <= BP_LdY;
      MAA <= BP_MAA;
      MDH1 <= BP_MDH1;
      MDH2 <= BP_MDH2;
      MDL1 <= BP_MDL1;
      MDL2 <= BP_MDL2;
      MAD <= BP_MAD;
      MAD2 <= BP_MAD2;
      Plus2 <= BP_Plus2;
      S0 <= BP_S0;
      S1 <= BP_S1;
      S2 <= BP_S2;
      S3 <= BP_S3;
      S_U <= BP_S_U;
      SWAP <= BP_SWAP;
      MI <= BP_MI;
      MR1 <= BP_MR1;
      MR2 <= BP_MR2;
      MACC <= BP_MACC;
      MSP <= BP_MSP;
      MX <= BP_MX;
      MY <= BP_MY;
      MCC <= BP_MCC;
      MPC <= BP_MPC;
      MAB <= BP_MAB;
      MAD1 <= BP_MAD1;
      MBUS <= BP_MBUS;
      DWB <= BP_DWB;
      En <= BP_En;
      ALSH <= BP_ALSH;
      DONE <= BP_DONE;

	END PROCESS;

END BEHAVIOR;

--OpCS	Start	Fetch	Dec	DP2	PostB	DCAL	IDCAL	GetA	GstD	Ex(ADDA)	W(ADDA)	BRA
--CLRA	0	     0	    0	  0	  0	    0	    0	    0	    0	    0	    0	      0
--CLRB	0	     0	    0	  0	  0	    0	    0	    0	    0	    0	    0	      0
--LdA	 1      0	    0	  0	  0	    0	    0	    0	    0	    0	    1	      0
--LdB	 1      0	    0	  0	  0	    0	    0	    0	    0	    0	    0	      0
--LdCC	0	     0	    0	  0	  0	    0	    0	    0	    0	    0	    0	      0
--LdPC	1	     0	    0	  0	  0	    0	    0	    0	    0	    0	    0	      1
--LdSP	1	     0	    0	  0	  0	  43|76	  43?	  0	    0	    0	    0	      0
--LdX	 1      0	    0	  0	  0	  43|76	  43?	  0	    0	    0	    0	      0
--LdY	 1      0	    0	  0	  0	  43|76	  43?	  0	    0	    0	    0	      0
--DWB	 00     XX	   XX	 XX	 XX	   XX	   XX	   XX	   XX	   00	   XX	     XX
--S_U	 0	     X	    X 	 X	  X	    X	    X	    X	    X	    0	    X	      X
--S3	  0	     X	    X	  X	  X	    X	    X	    X	    X	    0	    X	      X
--S2	  0	     X  	  X	  X	  X	    X	    X	    X	    X	    0	    X	      X
--S1	  0	     X	    X	  X	  X	    X	    X	    X	    X	    0	    X	      X
--S0	  0	     X	    X	  X	  X	    X 	   X	    X	    X	    0	    X	      X
--SWAP	0	     X	    X	  X 	 X	    X	    X	    X	    X	    0	    X	      X
--ALSH	0	     X	    X	  X	  X	    X	    X	    X	    X	    0	    X	      X
--Plus20	     ?	    0	  0	  0	    0	    0	    0	    0	    0	    X	      0
--MACC	0	     X	    X	  X	  X	    X	    X	    X	    X	    X	    1	      X
--MAD	 0	     X	    X	  X 	 X   43|76	  43?	  X	    X 	   X	    X   	   X
--MAD2	0	     X	    X	  X	  X	  43|76	  43?	  X	    X	    X	    X	      X
--MDH1	0	     X	    X	  X	  X	  43|76	  43?	  X	    X	  0(ABA)	 X	      X
--MDH2	0	     X	    X	  X	  X	    X	    X	    X	    X	    0	    X	      X
--MDL1	0	     X	    X	  X	  X	  43|76	  43?	  X	    X	  1(ABA)	 X	      X
--MDL2	0	     X	    X	  X	  X	    X	    X	    X	    X	    0	    X	      X
--MSP	 0	     X	    X	  X	  X	    1	    1	    X	    X	    X	    X 	     X
--MX	  0	     X	    X	  X	  X	    1	    1	    X	    X	    X	    X	      X
--MY	  0	     X	    X	  X 	 X	    1	    1	    X	    X	    X	    X	      X
--MAA	 00	    XX	   XX	 XX	 XX	   01	   43?	  XX	   XX	 10(IM)	 XX	     XX
--										                                    01(IH)		
--										                                    00(Add)		
--MAB	 00	    XX	   XX	 XX	 XX	   01	   XX	   XX	   XX	   01	   XX	     XX
--MR1	 00	    XX	   XX	 XX	 XX	   00	   XX	   XX	   XX	   00	   XX	     XX
--MR2	 00	    XX	   XX	 XX	 XX	   76?	  XX	   XX	   XX	   00	   XX	     XX
--MBUS	00	    XX  	 XX	 XX	 XX	   01	   XX	   XX	   XX	   XX	   XX	     XX
--MCC	 00	    XX	   XX	 XX	 XX	   XX	   XX	   XX	   XX	   XX	   XX	     XX
--MPC	 00	    11	   XX	 XX	 XX	   XX	   XX	   XX	   XX	   XX	   XX	     10
--MAD1	00	    XX	   XX	 XX	 XX	 43|76	  43?	  XX	   XX	   ?(ID) XX	     XX
--										                                      10(NID)		
