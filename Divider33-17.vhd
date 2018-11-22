-- divider.vhd  parallel division
-- based on non-restoring division, uncorrected remainder
-- Controlled add/subtract "cas" cell (NOT CSA)
-- "T" is sub_add signal in div_ser.vhdl
 
library IEEE;
use IEEE.std_logic_1164.all;
 
entity cas is  -- Controlled Add/Subtract cell
  port (
    divisor       : in  std_logic;
    T             : in  std_logic;
    remainder_in  : in  std_logic;
    cin           : in  std_logic;
    remainder_out : out std_logic;
    cout          : out std_logic);
end entity cas;
 
architecture behavior of cas is
  signal tt : std_logic;
begin
  tt            <= (T   xor divisor);
  remainder_out <= (tt  xor remainder_in xor cin);
  cout          <= ((tt and remainder_in) or (tt and cin) or (remainder_in and cin)) ;
end architecture behavior;  -- cas
 
-----------------------------------------------------------------------------------
 
library IEEE;
use IEEE.std_logic_1164.all;
 
entity divcas17 is   -- 32 bit dividend, 17 bit divisor
  port (
    S_U : in std_logic;
    DWB : IN std_logic_vector(1 DOWNTO 0); -- DOUBLE/WORD/BYTE 
    dividendUS  : in  std_logic_vector(32 downto 0);--UnSigned
    divisorUS   : in  std_logic_vector(16 downto 0);--UnSigned
    quotient  : out std_logic_vector(16 downto 0);
    remainder : out std_logic_vector(16 downto 0)
  );
end entity divcas17;
 
architecture behavior of divcas17 is
 
  component cas port(
    divisor       : in  std_logic;
    T             : in  std_logic;
    remainder_in  : in  std_logic;
    cin           : in  std_logic;
    remainder_out : out std_logic;
    cout          : out std_logic
  );
  end component;
 
  signal dividend  : std_logic_vector(32 downto 0);
  signal divisor   : std_logic_vector(16 downto 0);
  signal T : std_logic_vector(16 downto 0);
  signal cGW, cGV, cGU, cGT, cGS, cGR, cGQ, cGP, cGO, cGN, cGM, cGL, cGK, cGJ, cGI, cGH, cGG : std_logic;
  signal cFV, cFU, cFT, cFS, cFR, cFQ, cFP, cFO, cFN, cFM, cFL, cFK, cFJ, cFI, cFH, cFG, cFF : std_logic;
  signal cEU, cET, cES, cER, cEQ, cEP, cEO, cEN, cEM, cEL, cEK, cEJ, cEI, cEH, cEG, cEF, cEE : std_logic;
  signal cDT, cDS, cDR, cDQ, cDP, cDO, cDN, cDM, cDL, cDK, cDJ, cDI, cDH, cDG, cDF, cDE, cDD : std_logic;
  signal cCS, cCR, cCQ, cCP, cCO, cCN, cCM, cCL, cCK, cCJ, cCI, cCH, cCG, cCF, cCE, cCD, cCC : std_logic;
  signal cBR, cBQ, cBP, cBO, cBN, cBM, cBL, cBK, cBJ, cBI, cBH, cBG, cBF, cBE, cBD, cBC, cBB : std_logic;
  signal cAQ, cAP, cAO, cAN, cAM, cAL, cAK, cAJ, cAI, cAH, cAG, cAF, cAE, cAD, cAC, cAB, cAA : std_logic;
  signal c9P, c9O, c9N, c9M, c9L, c9K, c9J, c9I, c9H, c9G, c9F, c9E, c9D, c9C, c9B, c9A, c99 : std_logic;
  signal c8O, c8N, c8M, c8L, c8K, c8J, c8I, c8H, c8G, c8F, c8E, c8D, c8C, c8B, c8A, c89, c88 : std_logic;
  signal c7N, c7M, c7L, c7K, c7J, c7I, c7H, c7G, c7F, c7E, c7D, c7C, c7B, c7A, c79, c78, c77 : std_logic;
  signal c6M, c6L, c6K, c6J, c6I, c6H, c6G, c6F, c6E, c6D, c6C, c6B, c6A, c69, c68, c67, c66 : std_logic;
  signal c5L, c5K, c5J, c5I, c5H, c5G, c5F, c5E, c5D, c5C, c5B, c5A, c59, c58, c57, c56, c55 : std_logic;
  signal c4K, c4J, c4I, c4H, c4G, c4F, c4E, c4D, c4C, c4B, c4A, c49, c48, c47, c46, c45, c44 : std_logic;
  signal c3J, c3I, c3H, c3G, c3F, c3E, c3D, c3C, c3B, c3A, c39, c38, c37, c36, c35, c34, c33 : std_logic;
  signal c2I, c2H, c2G, c2F, c2E, c2D, c2C, c2B, c2A, c29, c28, c27, c26, c25, c24, c23, c22 : std_logic;
  signal c1H, c1G, c1F, c1E, c1D, c1C, c1B, c1A, c19, c18, c17, c16, c15, c14, c13, c12, c11 : std_logic;
  signal c0G, c0F, c0E, c0D, c0C, c0B, c0A, c09, c08, c07, c06, c05, c04, c03, c02, c01, c00 : std_logic;
  signal rGW, rGV, rGU, rGT, rGS, rGR, rGQ, rGP, rGO, rGN, rGM, rGL, rGK, rGJ, rGI, rGH, rGG : std_logic;
  signal rFV, rFU, rFT, rFS, rFR, rFQ, rFP, rFO, rFN, rFM, rFL, rFK, rFJ, rFI, rFH, rFG, rFF : std_logic;
  signal rEU, rET, rES, rER, rEQ, rEP, rEO, rEN, rEM0, rEL, rEK, rEJ, rEI, rEH, rEG, rEF, rEE : std_logic;
  signal rDT, rDS, rDR, rDQ, rDP, rDO, rDN, rDM, rDL, rDK, rDJ, rDI, rDH, rDG, rDF, rDE, rDD : std_logic;
  signal rCS, rCR, rCQ, rCP, rCO, rCN, rCM, rCL, rCK, rCJ, rCI, rCH, rCG, rCF, rCE, rCD, rCC : std_logic;
  signal rBR, rBQ, rBP, rBO, rBN, rBM, rBL, rBK, rBJ, rBI, rBH, rBG, rBF, rBE, rBD, rBC, rBB : std_logic;
  signal rAQ, rAP, rAO, rAN, rAM, rAL, rAK, rAJ, rAI, rAH, rAG, rAF, rAE, rAD, rAC, rAB, rAA : std_logic;
  signal r9P, r9O, r9N, r9M, r9L, r9K, r9J, r9I, r9H, r9G, r9F, r9E, r9D, r9C, r9B, r9A, r99 : std_logic;
  signal r8O, r8N, r8M, r8L, r8K, r8J, r8I, r8H, r8G, r8F, r8E, r8D, r8C, r8B, r8A, r89, r88 : std_logic;
  signal r7N, r7M, r7L, r7K, r7J, r7I, r7H, r7G, r7F, r7E, r7D, r7C, r7B, r7A, r79, r78, r77 : std_logic;
  signal r6M, r6L, r6K, r6J, r6I, r6H, r6G, r6F, r6E, r6D, r6C, r6B, r6A, r69, r68, r67, r66 : std_logic;
  signal r5L, r5K, r5J, r5I, r5H, r5G, r5F, r5E, r5D, r5C, r5B, r5A, r59, r58, r57, r56, r55 : std_logic;
  signal r4K, r4J, r4I, r4H, r4G, r4F, r4E, r4D, r4C, r4B, r4A, r49, r48, r47, r46, r45, r44 : std_logic;
  signal r3J, r3I, r3H, r3G, r3F, r3E, r3D, r3C, r3B, r3A, r39, r38, r37, r36, r35, r34, r33 : std_logic;
  signal r2I, r2H, r2G, r2F, r2E, r2D, r2C, r2B, r2A, r29, r28, r27, r26, r25, r24, r23, r22 : std_logic;
  signal r1H, r1G, r1F, r1E, r1D, r1C, r1B, r1A, r19, r18, r17, r16, r15, r14, r13, r12, r11 : std_logic;
  signal r0G, r0F, r0E, r0D, r0C, r0B, r0A, r09, r08, r07, r06, r05, r04, r03, r02, r01, r00 : std_logic;
begin
  -- dividend(32) assumed zero and unused
  T(16) <= '1'; 
  casGW: cas port map(divisor(16), T(16), dividend(32), cGV,  rGW, cGW); 
  casGV: cas port map(divisor(15), T(16), dividend(31), cGU,  rGV, cGV); 
  casGU: cas port map(divisor(14), T(16), dividend(30), cGT,  rGU, cGU); 
  casGT: cas port map(divisor(13), T(16), dividend(29), cGS,  rGT, cGT); 
  casGS: cas port map(divisor(12), T(16), dividend(28), cGR,  rGS, cGS); 
  casGR: cas port map(divisor(11), T(16), dividend(27), cGQ,  rGR, cGR); 
  casGQ: cas port map(divisor(10), T(16), dividend(26), cGP,  rGQ, cGQ);
  casGP: cas port map(divisor(9), T(16), dividend(25), cGO,  rGP, cGP); 
  casGO: cas port map(divisor(8), T(16), dividend(24), cGN,  rGO, cGO); 
  casGN: cas port map(divisor(7), T(16), dividend(23), cGM,  rGN, cGN); 
  casGM: cas port map(divisor(6), T(16), dividend(22), cGL,  rGM, cGM); 
  casGL: cas port map(divisor(5), T(16), dividend(21), cGK,  rGL, cGL); 
  casGK: cas port map(divisor(4), T(16), dividend(20), cGJ,  rGK, cGK); 
  casGJ: cas port map(divisor(3), T(16), dividend(19), cGI,  rGJ, cGJ);
  casGI: cas port map(divisor(2), T(16), dividend(18), cGH,  rGI, cGI); 
  casGH: cas port map(divisor(1), T(16), dividend(17), cGG,  rGH, cGH); 
  casGG: cas port map(divisor(0), T(16), dividend(16) , T(16),  rGG, cGG); 
  T(15) <= not rGW;
 
  casFV: cas port map(divisor(16), T(15), rGV         , cFU,  rFV, cFV); 
  casFU: cas port map(divisor(15), T(15), rGU         , cFT,  rFU, cFU); 
  casFT: cas port map(divisor(14), T(15), rGT         , cFS,  rFT, cFT); 
  casFS: cas port map(divisor(13), T(15), rGS         , cFR,  rFS, cFS); 
  casFR: cas port map(divisor(12), T(15), rGR         , cFQ,  rFR, cFR); 
  casFQ: cas port map(divisor(11), T(15), rGQ         , cFP,  rFQ, cFQ);
  casFP: cas port map(divisor(10), T(15), rGP         , cFO,  rFP, cFP); 
  casFO: cas port map(divisor(9), T(15), rGO         , cFN,  rFO, cFO); 
  casFN: cas port map(divisor(8), T(15), rGN         , cFM,  rFN, cFN); 
  casFM: cas port map(divisor(7), T(15), rGM         , cFL,  rFM, cFM); 
  casFL: cas port map(divisor(6), T(15), rGL         , cFK,  rFL, cFL); 
  casFK: cas port map(divisor(5), T(15), rGK         , cFJ,  rFK, cFK); 
  casFJ: cas port map(divisor(4), T(15), rGJ         , cFI,  rFJ, cFJ);
  casFI: cas port map(divisor(3), T(15), rGI         , cFH,  rFI, cFI); 
  casFH: cas port map(divisor(2), T(15), rGH         , cFG,  rFH, cFH); 
  casFG: cas port map(divisor(1), T(15), rGG         , cFF,  rFG, cFG); 
  casFF: cas port map(divisor(0), T(15), dividend(15) , T(15), rFF, cFF);
  T(14) <= not rFV;
 
  casEU: cas port map(divisor(16), T(14), rFU        , cET,  rEU, cEU); 
  casET: cas port map(divisor(15), T(14), rFT        , cES,  rET, cET); 
  casES: cas port map(divisor(14), T(14), rFS        , cER,  rES, cES); 
  casER: cas port map(divisor(13), T(14), rFR        , cEQ,  rER, cER); 
  casEQ: cas port map(divisor(12), T(14), rFQ        , cEP,  rEQ, cEQ); 
  casEP: cas port map(divisor(11), T(14), rFP        , cEO,  rEP, cEP); 
  casEO: cas port map(divisor(10), T(14), rFO        , cEN,  rEO, cEO); 
  casEN: cas port map(divisor(9), T(14), rFN        , cEM,  rEN, cEN); 
  casEM: cas port map(divisor(8), T(14), rFM        , cEL,  rEM0, cEM); 
  casEL: cas port map(divisor(7), T(14), rFL        , cEK,  rEL, cEL); 
  casEK: cas port map(divisor(6), T(14), rFK        , cEJ,  rEK, cEK); 
  casEJ: cas port map(divisor(5), T(14), rFJ        , cEI,  rEJ, cEJ); 
  casEI: cas port map(divisor(4), T(14), rFI        , cEH,  rEI, cEI); 
  casEH: cas port map(divisor(3), T(14), rFH        , cEG,  rEH, cEH); 
  casEG: cas port map(divisor(2), T(14), rFG        , cEF,  rEG, cEG); 
  casEF: cas port map(divisor(1), T(14), rFF        , cEE,  rEF, cEF); 
  casEE: cas port map(divisor(0), T(14), dividend(14), T(14),  rEE, cEE); 
  T(13) <= not rEU;

  casDT: cas port map(divisor(16), T(13), rET        , cDS,  rDT, cDT); 
  casDS: cas port map(divisor(15), T(13), rES        , cDR,  rDS, cDS); 
  casDR: cas port map(divisor(14), T(13), rER        , cDQ,  rDR, cDR); 
  casDQ: cas port map(divisor(13), T(13), rEQ        , cDP,  rDQ, cDQ); 
  casDP: cas port map(divisor(12), T(13), rEP        , cDO,  rDP, cDP); 
  casDO: cas port map(divisor(11), T(13), rEO        , cDN,  rDO, cDO); 
  casDN: cas port map(divisor(10), T(13), rEN        , cDM,  rDN, cDN); 
  casDM: cas port map(divisor(9), T(13), rEM0        , cDL,  rDM, cDM); 
  casDL: cas port map(divisor(8), T(13), rEL        , cDK,  rDL, cDL); 
  casDK: cas port map(divisor(7), T(13), rEK        , cDJ,  rDK, cDK); 
  casDJ: cas port map(divisor(6), T(13), rEJ        , cDI,  rDJ, cDJ); 
  casDI: cas port map(divisor(5), T(13), rEI        , cDH,  rDI, cDI); 
  casDH: cas port map(divisor(4), T(13), rEH        , cDG,  rDH, cDH); 
  casDG: cas port map(divisor(3), T(13), rEG        , cDF,  rDG, cDG); 
  casDF: cas port map(divisor(2), T(13), rEF        , cDE,  rDF, cDF); 
  casDE: cas port map(divisor(1), T(13), rEE        , cDD,  rDE, cDE); 
  casDD: cas port map(divisor(0), T(13), dividend(13), T(13),  rDD, cDD); 
  T(12) <= not rDT;

  casCS: cas port map(divisor(16), T(12), rDS        , cCR,  rCS, cCS); 
  casCR: cas port map(divisor(15), T(12), rDR        , cCQ,  rCR, cCR); 
  casCQ: cas port map(divisor(14), T(12), rDQ        , cCP,  rCQ, cCQ); 
  casCP: cas port map(divisor(13), T(12), rDP        , cCO,  rCP, cCP); 
  casCO: cas port map(divisor(12), T(12), rDO        , cCN,  rCO, cCO); 
  casCN: cas port map(divisor(11), T(12), rDN        , cCM,  rCN, cCN); 
  casCM: cas port map(divisor(10), T(12), rDM        , cCL,  rCM, cCM); 
  casCL: cas port map(divisor(9), T(12), rDL        , cCK,  rCL, cCL); 
  casCK: cas port map(divisor(8), T(12), rDK        , cCJ,  rCK, cCK); 
  casCJ: cas port map(divisor(7), T(12), rDJ        , cCI,  rCJ, cCJ); 
  casCI: cas port map(divisor(6), T(12), rDI        , cCH,  rCI, cCI); 
  casCH: cas port map(divisor(5), T(12), rDH        , cCG,  rCH, cCH); 
  casCG: cas port map(divisor(4), T(12), rDG        , cCF,  rCG, cCG); 
  casCF: cas port map(divisor(3), T(12), rDF        , cCE,  rCF, cCF); 
  casCE: cas port map(divisor(2), T(12), rDE        , cCD,  rCE, cCE); 
  casCD: cas port map(divisor(1), T(12), rDD        , cCC,  rCD, cCD); 
  casCC: cas port map(divisor(0), T(12), dividend(12), T(12),  rCC, cCC); 
  T(11) <= not rCS;

  casBR: cas port map(divisor(16), T(11), rCR        , cBQ,  rBR, cBR); 
  casBQ: cas port map(divisor(15), T(11), rCQ        , cBP,  rBQ, cBQ); 
  casBP: cas port map(divisor(14), T(11), rCP        , cBO,  rBP, cBP); 
  casBO: cas port map(divisor(13), T(11), rCO        , cBN,  rBO, cBO); 
  casBN: cas port map(divisor(12), T(11), rCN        , cBM,  rBN, cBN); 
  casBM: cas port map(divisor(11), T(11), rCM        , cBL,  rBM, cBM); 
  casBL: cas port map(divisor(10), T(11), rCL        , cBK,  rBL, cBL); 
  casBK: cas port map(divisor(9), T(11), rCK        , cBJ,  rBK, cBK); 
  casBJ: cas port map(divisor(8), T(11), rCJ        , cBI,  rBJ, cBJ); 
  casBI: cas port map(divisor(7), T(11), rCI        , cBH,  rBI, cBI); 
  casBH: cas port map(divisor(6), T(11), rCH        , cBG,  rBH, cBH); 
  casBG: cas port map(divisor(5), T(11), rCG        , cBF,  rBG, cBG); 
  casBF: cas port map(divisor(4), T(11), rCF        , cBE,  rBF, cBF); 
  casBE: cas port map(divisor(3), T(11), rCE        , cBD,  rBE, cBE); 
  casBD: cas port map(divisor(2), T(11), rCD        , cBC,  rBD, cBD); 
  casBC: cas port map(divisor(1), T(11), rCC        , cBB,  rBC, cBC); 
  casBB: cas port map(divisor(0), T(11), dividend(11), T(11),  rBB, cBB); 
  T(10) <= not rBR;

  casAQ: cas port map(divisor(16), T(10), rBQ        , cAP,  rAQ, cAQ); 
  casAP: cas port map(divisor(15), T(10), rBP        , cAO,  rAP, cAP); 
  casAO: cas port map(divisor(14), T(10), rBO        , cAN,  rAO, cAO); 
  casAN: cas port map(divisor(13), T(10), rBN        , cAM,  rAN, cAN); 
  casAM: cas port map(divisor(12), T(10), rBM        , cAL,  rAM, cAM); 
  casAL: cas port map(divisor(11), T(10), rBL        , cAK,  rAL, cAL); 
  casAK: cas port map(divisor(10), T(10), rBK        , cAJ,  rAK, cAK); 
  casAJ: cas port map(divisor(9), T(10), rBJ        , cAI,  rAJ, cAJ); 
  casAI: cas port map(divisor(8), T(10), rBI        , cAH,  rAI, cAI); 
  casAH: cas port map(divisor(7), T(10), rBH        , cAG,  rAH, cAH); 
  casAG: cas port map(divisor(6), T(10), rBG        , cAF,  rAG, cAG); 
  casAF: cas port map(divisor(5), T(10), rBF        , cAE,  rAF, cAF); 
  casAE: cas port map(divisor(4), T(10), rBE        , cAD,  rAE, cAE); 
  casAD: cas port map(divisor(3), T(10), rBD        , cAC,  rAD, cAD); 
  casAC: cas port map(divisor(2), T(10), rBC        , cAB,  rAC, cAC); 
  casAB: cas port map(divisor(1), T(10), rBB        , cAA,  rAB, cAB); 
  casAA: cas port map(divisor(0), T(10), dividend(10), T(10),  rAA, cAA); 
  T(9) <= not rAQ;

  cas9P: cas port map(divisor(16), T(9), rAP        , c9O,  r9P, c9P); 
  cas9O: cas port map(divisor(15), T(9), rAO        , c9N,  r9O, c9O); 
  cas9N: cas port map(divisor(14), T(9), rAN        , c9M,  r9N, c9N); 
  cas9M: cas port map(divisor(13), T(9), rAM        , c9L,  r9M, c9M); 
  cas9L: cas port map(divisor(12), T(9), rAL        , c9K,  r9L, c9L); 
  cas9K: cas port map(divisor(11), T(9), rAK        , c9J,  r9K, c9K); 
  cas9J: cas port map(divisor(10), T(9), rAJ        , c9I,  r9J, c9J); 
  cas9I: cas port map(divisor(9), T(9), rAI        , c9H,  r9I, c9I); 
  cas9H: cas port map(divisor(8), T(9), rAH        , c9G,  r9H, c9H); 
  cas9G: cas port map(divisor(7), T(9), rAG        , c9F,  r9G, c9G); 
  cas9F: cas port map(divisor(6), T(9), rAF        , c9E,  r9F, c9F); 
  cas9E: cas port map(divisor(5), T(9), rAE        , c9D,  r9E, c9E); 
  cas9D: cas port map(divisor(4), T(9), rAD        , c9C,  r9D, c9D); 
  cas9C: cas port map(divisor(3), T(9), rAC        , c9B,  r9C, c9C); 
  cas9B: cas port map(divisor(2), T(9), rAB        , c9A,  r9B, c9B); 
  cas9A: cas port map(divisor(1), T(9), rAA        , c99,  r9A, c9A); 
  cas99: cas port map(divisor(0), T(9), dividend(9), T(9),  r99, c99); 
  T(8) <= not r9P;


  cas8O: cas port map(divisor(16), T(8), r9O        , c8N,  r8O, c8O); 
  cas8N: cas port map(divisor(15), T(8), r9N        , c8M,  r8N, c8N); 
  cas8M: cas port map(divisor(14), T(8), r9M        , c8L,  r8M, c8M); 
  cas8L: cas port map(divisor(13), T(8), r9L        , c8K,  r8L, c8L); 
  cas8K: cas port map(divisor(12), T(8), r9K        , c8J,  r8K, c8K); 
  cas8J: cas port map(divisor(11), T(8), r9J        , c8I,  r8J, c8J); 
  cas8I: cas port map(divisor(10), T(8), r9I        , c8H,  r8I, c8I); 
  cas8H: cas port map(divisor(9), T(8), r9H        , c8G,  r8H, c8H); 
  cas8G: cas port map(divisor(8), T(8), r9G        , c8F,  r8G, c8G); 
  cas8F: cas port map(divisor(7), T(8), r9F        , c8E,  r8F, c8F); 
  cas8E: cas port map(divisor(6), T(8), r9E        , c8D,  r8E, c8E); 
  cas8D: cas port map(divisor(5), T(8), r9D        , c8C,  r8D, c8D); 
  cas8C: cas port map(divisor(4), T(8), r9C        , c8B,  r8C, c8C); 
  cas8B: cas port map(divisor(3), T(8), r9B        , c8A,  r8B, c8B); 
  cas8A: cas port map(divisor(2), T(8), r9A        , c89,  r8A, c8A); 
  cas89: cas port map(divisor(1), T(8), r99        , c88,  r89, c89); 
  cas88: cas port map(divisor(0), T(8), dividend(8), T(8), r88, c88);
  T(7) <= not r8O;

  cas7N: cas port map(divisor(16), T(7), r8N        , c7M,  r7N, c7N); 
  cas7M: cas port map(divisor(15), T(7), r8M        , c7L,  r7M, c7M); 
  cas7L: cas port map(divisor(14), T(7), r8L        , c7K,  r7L, c7L); 
  cas7K: cas port map(divisor(13), T(7), r8K        , c7J,  r7K, c7K); 
  cas7J: cas port map(divisor(12), T(7), r8J        , c7I,  r7J, c7J); 
  cas7I: cas port map(divisor(11), T(7), r8I        , c7H,  r7I, c7I); 
  cas7H: cas port map(divisor(10), T(7), r8H        , c7G,  r7H, c7H); 
  cas7G: cas port map(divisor(9), T(7), r8G        , c7F,  r7G, c7G); 
  cas7F: cas port map(divisor(8), T(7), r8F        , c7E,  r7F, c7F); 
  cas7E: cas port map(divisor(7), T(7), r8E        , c7D,  r7E, c7E); 
  cas7D: cas port map(divisor(6), T(7), r8D        , c7C,  r7D, c7D); 
  cas7C: cas port map(divisor(5), T(7), r8C        , c7B,  r7C, c7C); 
  cas7B: cas port map(divisor(4), T(7), r8B        , c7A,  r7B, c7B); 
  cas7A: cas port map(divisor(3), T(7), r8A        , c79,  r7A, c7A); 
  cas79: cas port map(divisor(2), T(7), r89        , c78,  r79, c79); 
  cas78: cas port map(divisor(1), T(7), r88        , c77,  r78, c78); 
  cas77: cas port map(divisor(0), T(7), dividend(7), T(7), r77, c77);
  T(6) <= not r7N;
 
  cas6M: cas port map(divisor(16), T(6), r7M        , c6L,  r6M, c6M); 
  cas6L: cas port map(divisor(15), T(6), r7L        , c6K,  r6L, c6L); 
  cas6K: cas port map(divisor(14), T(6), r7K        , c6J,  r6K, c6K); 
  cas6J: cas port map(divisor(13), T(6), r7J        , c6I,  r6J, c6J); 
  cas6I: cas port map(divisor(12), T(6), r7I        , c6H,  r6I, c6I); 
  cas6H: cas port map(divisor(11), T(6), r7H        , c6G,  r6H, c6H); 
  cas6G: cas port map(divisor(10), T(6), r7G        , c6F,  r6G, c6G); 
  cas6F: cas port map(divisor(9), T(6), r7F        , c6E,  r6F, c6F); 
  cas6E: cas port map(divisor(8), T(6), r7E        , c6D,  r6E, c6E); 
  cas6D: cas port map(divisor(7), T(6), r7D        , c6C,  r6D, c6D); 
  cas6C: cas port map(divisor(6), T(6), r7C        , c6B,  r6C, c6C); 
  cas6B: cas port map(divisor(5), T(6), r7B        , c6A,  r6B, c6B); 
  cas6A: cas port map(divisor(4), T(6), r7A        , c69,  r6A, c6A); 
  cas69: cas port map(divisor(3), T(6), r79        , c68,  r69, c69); 
  cas68: cas port map(divisor(2), T(6), r78        , c67,  r68, c68); 
  cas67: cas port map(divisor(1), T(6), r77        , c66,  r67, c67); 
  cas66: cas port map(divisor(0), T(6), dividend(6), T(6), r66, c66);
  T(5) <= not r6M;
 
  cas5L: cas port map(divisor(16), T(5), r6L        , c5K,  r5L, c5L); 
  cas5K: cas port map(divisor(15), T(5), r6K        , c5J,  r5K, c5K); 
  cas5J: cas port map(divisor(14), T(5), r6J        , c5I,  r5J, c5J); 
  cas5I: cas port map(divisor(13), T(5), r6I        , c5H,  r5I, c5I); 
  cas5H: cas port map(divisor(12), T(5), r6H        , c5G,  r5H, c5H); 
  cas5G: cas port map(divisor(11), T(5), r6G        , c5F,  r5G, c5G); 
  cas5F: cas port map(divisor(10), T(5), r6F        , c5E,  r5F, c5F); 
  cas5E: cas port map(divisor(9), T(5), r6E        , c5D,  r5E, c5E); 
  cas5D: cas port map(divisor(8), T(5), r6D        , c5C,  r5D, c5D); 
  cas5C: cas port map(divisor(7), T(5), r6C        , c5B,  r5C, c5C); 
  cas5B: cas port map(divisor(6), T(5), r6B        , c5A,  r5B, c5B); 
  cas5A: cas port map(divisor(5), T(5), r6A        , c59,  r5A, c5A); 
  cas59: cas port map(divisor(4), T(5), r69        , c58,  r59, c59); 
  cas58: cas port map(divisor(3), T(5), r68        , c57,  r58, c58); 
  cas57: cas port map(divisor(2), T(5), r67        , c56,  r57, c57); 
  cas56: cas port map(divisor(1), T(5), r66        , c55,  r56, c56); 
  cas55: cas port map(divisor(0), T(5), dividend(5), T(5), r55, c55);
  T(4) <= not r5L;
 
  cas4K: cas port map(divisor(16), T(4), r5K        , c4J,  r4K, c4K); 
  cas4J: cas port map(divisor(15), T(4), r5J        , c4I,  r4J, c4J); 
  cas4I: cas port map(divisor(14), T(4), r5I        , c4H,  r4I, c4I); 
  cas4H: cas port map(divisor(13), T(4), r5H        , c4G,  r4H, c4H); 
  cas4G: cas port map(divisor(12), T(4), r5G        , c4F,  r4G, c4G); 
  cas4F: cas port map(divisor(11), T(4), r5F        , c4E,  r4F, c4F); 
  cas4E: cas port map(divisor(10), T(4), r5E        , c4D,  r4E, c4E); 
  cas4D: cas port map(divisor(9), T(4), r5D        , c4C,  r4D, c4D); 
  cas4C: cas port map(divisor(8), T(4), r5C        , c4B,  r4C, c4C); 
  cas4B: cas port map(divisor(7), T(4), r5B        , c4A,  r4B, c4B); 
  cas4A: cas port map(divisor(6), T(4), r5A        , c49,  r4A, c4A); 
  cas49: cas port map(divisor(5), T(4), r59        , c48,  r49, c49); 
  cas48: cas port map(divisor(4), T(4), r58        , c47,  r48, c48); 
  cas47: cas port map(divisor(3), T(4), r57        , c46,  r47, c47); 
  cas46: cas port map(divisor(2), T(4), r56        , c45,  r46, c46); 
  cas45: cas port map(divisor(1), T(4), r55        , c44,  r45, c45); 
  cas44: cas port map(divisor(0), T(4), dividend(4), T(4), r44, c44);
  T(3) <= not r4K;
 
  cas3J: cas port map(divisor(16), T(3), r4J        , c3I,  r3J, c3J); 
  cas3I: cas port map(divisor(15), T(3), r4I        , c3H,  r3I, c3I); 
  cas3H: cas port map(divisor(14), T(3), r4H        , c3G,  r3H, c3H); 
  cas3G: cas port map(divisor(13), T(3), r4G        , c3F,  r3G, c3G); 
  cas3F: cas port map(divisor(12), T(3), r4F        , c3E,  r3F, c3F); 
  cas3E: cas port map(divisor(11), T(3), r4E        , c3D,  r3E, c3E); 
  cas3D: cas port map(divisor(10), T(3), r4D        , c3C,  r3D, c3D); 
  cas3C: cas port map(divisor(9), T(3), r4C        , c3B,  r3C, c3C); 
  cas3B: cas port map(divisor(8), T(3), r4B        , c3A,  r3B, c3B); 
  cas3A: cas port map(divisor(7), T(3), r4A        , c39,  r3A, c3A); 
  cas39: cas port map(divisor(6), T(3), r49        , c38,  r39, c39); 
  cas38: cas port map(divisor(5), T(3), r48        , c37,  r38, c38); 
  cas37: cas port map(divisor(4), T(3), r47        , c36,  r37, c37); 
  cas36: cas port map(divisor(3), T(3), r46        , c35,  r36, c36); 
  cas35: cas port map(divisor(2), T(3), r45        , c34,  r35, c35); 
  cas34: cas port map(divisor(1), T(3), r44        , c33,  r34, c34); 
  cas33: cas port map(divisor(0), T(3), dividend(3), T(3), r33, c33);
  T(2) <= not r3J;
 
  cas2I: cas port map(divisor(16), T(2), r3I        , c2H,  r2I, c2I); 
  cas2H: cas port map(divisor(15), T(2), r3H        , c2G,  r2H, c2H); 
  cas2G: cas port map(divisor(14), T(2), r3G        , c2F,  r2G, c2G); 
  cas2F: cas port map(divisor(13), T(2), r3F        , c2E,  r2F, c2F); 
  cas2E: cas port map(divisor(12), T(2), r3E        , c2D,  r2E, c2E); 
  cas2D: cas port map(divisor(11), T(2), r3D        , c2C,  r2D, c2D); 
  cas2C: cas port map(divisor(10), T(2), r3C        , c2B,  r2C, c2C); 
  cas2B: cas port map(divisor(9), T(2), r3B        , c2A,  r2B, c2B); 
  cas2A: cas port map(divisor(8), T(2), r3A        , c29,  r2A, c2A); 
  cas29: cas port map(divisor(7), T(2), r39        , c28,  r29, c29); 
  cas28: cas port map(divisor(6), T(2), r38        , c27,  r28, c28); 
  cas27: cas port map(divisor(5), T(2), r37        , c26,  r27, c27); 
  cas26: cas port map(divisor(4), T(2), r36        , c25,  r26, c26); 
  cas25: cas port map(divisor(3), T(2), r35        , c24,  r25, c25); 
  cas24: cas port map(divisor(2), T(2), r34        , c23,  r24, c24); 
  cas23: cas port map(divisor(1), T(2), r33         , c22,  r23, c23); 
  cas22: cas port map(divisor(0), T(2), dividend(2), T(2), r22, c22);
  T(1) <= not r2I;
 
  cas1H: cas port map(divisor(16), T(1), r2H        , c1G,  r1H, c1H); 
  cas1G: cas port map(divisor(15), T(1), r2G        , c1F,  r1G, c1G); 
  cas1F: cas port map(divisor(14), T(1), r2F        , c1E,  r1F, c1F); 
  cas1E: cas port map(divisor(13), T(1), r2E        , c1D,  r1E, c1E); 
  cas1D: cas port map(divisor(12), T(1), r2D        , c1C,  r1D, c1D); 
  cas1C: cas port map(divisor(11), T(1), r2C        , c1B,  r1C, c1C); 
  cas1B: cas port map(divisor(10), T(1), r2B        , c1A,  r1B, c1B); 
  cas1A: cas port map(divisor(9), T(1), r2A        , c19,  r1A, c1A); 
  cas19: cas port map(divisor(8), T(1), r29        , c18,  r19, c19); 
  cas18: cas port map(divisor(7), T(1), r28        , c17,  r18, c18); 
  cas17: cas port map(divisor(6), T(1), r27        , c16,  r17, c17); 
  cas16: cas port map(divisor(5), T(1), r26        , c15,  r16, c16); 
  cas15: cas port map(divisor(4), T(1), r25        , c14,  r15, c15); 
  cas14: cas port map(divisor(3), T(1), r24        , c13,  r14, c14); 
  cas13: cas port map(divisor(2), T(1), r23        , c12,  r13, c13); 
  cas12: cas port map(divisor(1), T(1), r22        , c11,  r12, c12); 
  cas11: cas port map(divisor(0), T(1), dividend(1), T(1), r11, c11);
  T(0) <= not r1H;
 
  cas0G: cas port map(divisor(16), T(0), r1G        , c0F,  r0G, c0G); 
  cas0F: cas port map(divisor(15), T(0), r1F        , c0E,  r0F, c0F); 
  cas0E: cas port map(divisor(14), T(0), r1E        , c0D,  r0E, c0E); 
  cas0D: cas port map(divisor(13), T(0), r1D        , c0C,  r0D, c0D); 
  cas0C: cas port map(divisor(12), T(0), r1C        , c0B,  r0C, c0C); 
  cas0B: cas port map(divisor(11), T(0), r1B        , c0A,  r0B, c0B);
  cas0A: cas port map(divisor(10), T(0), r1A        , c09,  r0A, c0A); 
  cas09: cas port map(divisor(9), T(0), r19        , c08,  r09, c09); 
  cas08: cas port map(divisor(8), T(0), r18        , c07,  r08, c08); 
  cas07: cas port map(divisor(7), T(0), r17        , c06,  r07, c07); 
  cas06: cas port map(divisor(6), T(0), r16        , c05,  r06, c06); 
  cas05: cas port map(divisor(5), T(0), r15        , c04,  r05, c05); 
  cas04: cas port map(divisor(4), T(0), r14        , c03,  r04, c04);
  cas03: cas port map(divisor(3), T(0), r13        , c02,  r03, c03); 
  cas02: cas port map(divisor(2), T(0), r12        , c01,  r02, c02); 
  cas01: cas port map(divisor(1), T(0), r11        , c00,  r01, c01); 
  cas00: cas port map(divisor(0), T(0), dividend(0), T(0), r00, c00);

 -- SIGNED/UNSIGNED CALCULATIONS
  dividend(32) <= dividendUS(32);
  dividend(30 downto 16) <= dividendUS(30 downto 16);
  dividend(14 downto 0) <= dividendUS(14 downto 0);
  dividend(31) <= dividendUS(31)AND(NOT(S_U)OR NOT(DWB(1))OR DWB(0));
  dividend(15) <= dividendUS(15)AND(NOT(S_U)OR DWB(1)OR NOT(DWB(0)));
  divisor(16) <= divisorUS(16);
  divisor(14 downto 0) <= divisorUS(14 downto 0);
  divisor(15) <= divisorUS(15)AND(NOT(S_U)OR (NOT(DWB(1))AND NOT(DWB(0)))OR (DWB(1)AND DWB(0)));
 
  quotient(16)  <= T(15);
  quotient(15)  <= (T(14) AND NOT(S_U)) OR (NOT (DWB(1))AND DWB(0) AND(dividendUS(15) XOR divisorUS(15)))
                    OR(DWB(1)AND NOT(DWB(0)) AND(dividendUS(15) XOR divisorUS(15))); --Signed
  quotient(14)  <= T(13);
  quotient(13)  <= T(12);
  quotient(12)  <= T(11);
  quotient(11)  <= T(10);
  quotient(10)  <= T(9);
  quotient(9)  <= T(8);
  quotient(8)  <= T(7);
  quotient(7)  <= T(6);
  quotient(6)  <= T(5);
  quotient(5)  <= T(4);
  quotient(4)  <= T(3);
  quotient(3)  <= T(2);
  quotient(2)  <= T(1);
  quotient(1)  <= T(0);
  quotient(0)  <= not r0F;
  remainder(16) <= r0G;
  remainder(15) <= r0F;
  remainder(14) <= r0E;
  remainder(13) <= r0D;
  remainder(12) <= r0C;
  remainder(11) <= r0B;
  remainder(10) <= r0A;
  remainder(9) <= r09;
  remainder(8) <= r08;
  remainder(7) <= r07;
  remainder(6) <= r06;
  remainder(5) <= r05;
  remainder(4) <= r04;
  remainder(3) <= r03;
  remainder(2) <= r02;
  remainder(1) <= r01;
  remainder(0) <= r00;
 
end architecture behavior; -- divcas9
