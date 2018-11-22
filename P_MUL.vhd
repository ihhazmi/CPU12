------- top_row.vhd (component): -------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components.all;
---------------------------------------
ENTITY top_row IS
PORT ( a: IN STD_LOGIC;
b: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
sout, cout: OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
p: OUT STD_LOGIC);
END top_row;
---------------------------------------
ARCHITECTURE structural OF top_row IS
BEGIN
U1: COMPONENT and_2 PORT MAP (a, b(15), sout(14));
U2: COMPONENT and_2 PORT MAP (a, b(14), sout(13));
U3: COMPONENT and_2 PORT MAP (a, b(13), sout(12));
U4: COMPONENT and_2 PORT MAP (a, b(12), sout(11));
U5: COMPONENT and_2 PORT MAP (a, b(11), sout(10));
U6: COMPONENT and_2 PORT MAP (a, b(10), sout(9));
U7: COMPONENT and_2 PORT MAP (a, b(9), sout(8));
U8: COMPONENT and_2 PORT MAP (a, b(8), sout(7));
U9: COMPONENT and_2 PORT MAP (a, b(7), sout(6));
U10: COMPONENT and_2 PORT MAP (a, b(6), sout(5));
U11: COMPONENT and_2 PORT MAP (a, b(5), sout(4));
U12: COMPONENT and_2 PORT MAP (a, b(4), sout(3));
U13: COMPONENT and_2 PORT MAP (a, b(3), sout(2));
U14: COMPONENT and_2 PORT MAP (a, b(2), sout(1));
U15: COMPONENT and_2 PORT MAP (a, b(1), sout(0));
U16: COMPONENT and_2 PORT MAP (a, b(0), p);
cout<="000000000000000";
END structural;
----------------------------------------------
------- mid_row.vhd (component): -------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components.all;
---------------------------------------
ENTITY mid_row IS
PORT ( a: IN STD_LOGIC;
b: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
sin, cin: IN STD_LOGIC_VECTOR (14 DOWNTO 0);
sout, cout: OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
p: OUT STD_LOGIC);
END mid_row;
---------------------------------------
ARCHITECTURE structural OF mid_row IS
SIGNAL and_out: STD_LOGIC_VECTOR (14 DOWNTO 0);
BEGIN
U1: COMPONENT and_2 PORT MAP (a, b(15), sout(14));
U2: COMPONENT and_2 PORT MAP (a, b(14), and_out(14));
U3: COMPONENT and_2 PORT MAP (a, b(13), and_out(13));
U4: COMPONENT and_2 PORT MAP (a, b(12), and_out(12));
U5: COMPONENT and_2 PORT MAP (a, b(11), and_out(11));
U6: COMPONENT and_2 PORT MAP (a, b(10), and_out(10));
U7: COMPONENT and_2 PORT MAP (a, b(9), and_out(9));
U8: COMPONENT and_2 PORT MAP (a, b(8), and_out(8));
U9: COMPONENT and_2 PORT MAP (a, b(7), and_out(7));
U10: COMPONENT and_2 PORT MAP (a, b(6), and_out(6));
U11: COMPONENT and_2 PORT MAP (a, b(5), and_out(5));
U12: COMPONENT and_2 PORT MAP (a, b(4), and_out(4));
U13: COMPONENT and_2 PORT MAP (a, b(3), and_out(3));
U14: COMPONENT and_2 PORT MAP (a, b(2), and_out(2));
U15: COMPONENT and_2 PORT MAP (a, b(1), and_out(1));
U16: COMPONENT and_2 PORT MAP (a, b(0), and_out(0));
----------------
U20: COMPONENT fa PORT MAP (sin(14), cin(14), and_out(14),sout(13), cout(14));
U30: COMPONENT fa PORT MAP (sin(13), cin(13), and_out(13),sout(12), cout(13));
U40: COMPONENT fa PORT MAP (sin(12), cin(12), and_out(12),sout(11), cout(12));
U50: COMPONENT fa PORT MAP (sin(11), cin(11), and_out(11),sout(10), cout(11));
U60: COMPONENT fa PORT MAP (sin(10), cin(10), and_out(10),sout(9), cout(10));
U70: COMPONENT fa PORT MAP (sin(9), cin(9), and_out(9),sout(8), cout(9));
U80: COMPONENT fa PORT MAP (sin(8), cin(8), and_out(8),sout(7), cout(8));
U90: COMPONENT fa PORT MAP (sin(7), cin(7), and_out(7),sout(6), cout(7));
U100: COMPONENT fa PORT MAP (sin(6), cin(6), and_out(6),sout(5), cout(6));
U110: COMPONENT fa PORT MAP (sin(5), cin(5), and_out(5),sout(4), cout(5));
U120: COMPONENT fa PORT MAP (sin(4), cin(4), and_out(4),sout(3), cout(4));
U130: COMPONENT fa PORT MAP (sin(3), cin(3), and_out(3),sout(2), cout(3));
U140: COMPONENT fa PORT MAP (sin(2), cin(2), and_out(2),sout(1), cout(2));
U150: COMPONENT fa PORT MAP (sin(1), cin(1), and_out(1),sout(0), cout(1));
U160: COMPONENT fa PORT MAP (sin(0), cin(0), and_out(0),p, cout(0));
END structural;
----------------------------------------------
------ lower_row.vhd (component): -----------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components.all;
---------------------------------------
ENTITY lower_row IS
PORT ( sin, cin: IN STD_LOGIC_VECTOR (14 DOWNTO 0);
p: OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END lower_row;
---------------------------------------
ARCHITECTURE structural OF lower_row IS
SIGNAL local: STD_LOGIC_VECTOR (14 DOWNTO 0);
BEGIN
local(0)<='0';
U1: COMPONENT fa PORT MAP (sin(0), cin(0), local(0),p(0), local(1));
U2: COMPONENT fa PORT MAP (sin(1), cin(1), local(1),p(1), local(2));
U3: COMPONENT fa PORT MAP (sin(2), cin(2), local(2),p(2), local(3));
U4: COMPONENT fa PORT MAP (sin(3), cin(3), local(3),p(3), local(4));
U5: COMPONENT fa PORT MAP (sin(4), cin(4), local(4),p(4), local(5));
U6: COMPONENT fa PORT MAP (sin(5), cin(5), local(5),p(5), local(6));
U7: COMPONENT fa PORT MAP (sin(6), cin(6), local(6),p(6), local(7));
U8: COMPONENT fa PORT MAP (sin(7), cin(7), local(7),p(7), local(8));
U9: COMPONENT fa PORT MAP (sin(8), cin(8), local(8),p(8), local(9));
U10: COMPONENT fa PORT MAP (sin(9), cin(9), local(9),p(9), local(10));
U11: COMPONENT fa PORT MAP (sin(10), cin(10), local(10),p(10), local(11));
U12: COMPONENT fa PORT MAP (sin(11), cin(11), local(11),p(11), local(12));
U13: COMPONENT fa PORT MAP (sin(12), cin(12), local(12),p(12), local(13));
U14: COMPONENT fa PORT MAP (sin(13), cin(13), local(13),p(13), local(14));
U15: COMPONENT fa PORT MAP (sin(14), cin(14), local(14),p(14), p(15));
END structural;
----------------------------------------------
----------------------------------------------
------ multiplier.vhd (project): ------------
LIBRARY    ieee;
USE ieee.std_logic_1164.all;
--USE work.my_components.all;
---------------------------------------
ENTITY multiplier IS
PORT (S_U : in std_logic;
DWB: IN std_logic_vector(1 DOWNTO 0); -- DOUBLE/WORD/BYTE 
A_US, B_US: IN STD_LOGIC_VECTOR (15 DOWNTO 0);--UnSigned
SProd: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
END multiplier;
---------------------------------------
ARCHITECTURE structural OF multiplier IS
TYPE matrix IS ARRAY (0 TO 15) OF STD_LOGIC_VECTOR (14 DOWNTO 0);
SIGNAL s, c: matrix;
SIGNAL A, B: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL Prod: STD_LOGIC_VECTOR (31 DOWNTO 0);
COMPONENT top_row
PORT ( a: IN STD_LOGIC;
b: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
sout, cout: OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
p: OUT STD_LOGIC);
END COMPONENT;
-----------------------
COMPONENT mid_row IS
PORT ( a: IN STD_LOGIC;
b: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
sin, cin: IN STD_LOGIC_VECTOR (14 DOWNTO 0);
sout, cout: OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
p: OUT STD_LOGIC);
END COMPONENT;
-----------------------
COMPONENT lower_row IS
PORT ( sin, cin: IN STD_LOGIC_VECTOR (14 DOWNTO 0);
p: OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END COMPONENT;
BEGIN
-- SIGNED/UNSIGNED CALCULATIONS
A(15) <= A_US(15)AND(NOT(S_U)OR DWB(1)OR NOT(DWB(0)));
A(7) <= A_US(7)AND(NOT(S_U)OR DWB(1)OR DWB(0));
A(14 DOWNTO 8) <= A_US(14 DOWNTO 8);
A(6 DOWNTO 0) <= A_US(6 DOWNTO 0);
B(15) <= B_US(15)AND(NOT(S_U)OR (NOT(DWB(1))AND NOT(DWB(0)))OR (DWB(1)AND DWB(0)));
B(7) <= B_US(7)AND(NOT(S_U)OR DWB(1)OR DWB(0));
B(14 DOWNTO 8) <= B_US(14 DOWNTO 8);
B(6 DOWNTO 0) <= B_US(6 DOWNTO 0);
SProd(31) <= (Prod(31) AND NOT(S_U)) OR (S_U AND (A_US(15) XOR B_US(15)));
SProd(15) <= (Prod(15) AND NOT(S_U)) OR (S_U AND (A_US(7) XOR B_US(7)));
SProd(30 DOWNTO 16) <= Prod(30 DOWNTO 16);
SProd(14 DOWNTO 0) <= Prod(14 DOWNTO 0);
-- PORT MAPPING
U1: top_row PORT MAP (A(0), B, s(0), c(0), Prod(0));
U2: mid_row PORT MAP (A(1), B, s(0), c(0), s(1),c(1), Prod(1));
U3: mid_row PORT MAP (A(2), B, s(1), c(1), s(2),c(2), Prod(2));
U4: mid_row PORT MAP (A(3), B, s(2), c(2), s(3),c(3), Prod(3));
U5: mid_row PORT MAP (A(4), B, s(3), c(3), s(4),c(4), Prod(4));
U6: mid_row PORT MAP (A(5), B, s(4), c(4), s(5),c(5), Prod(5));
U7: mid_row PORT MAP (A(6), B, s(5), c(5), s(6),c(6), Prod(6));
U8: mid_row PORT MAP (A(7), B, s(6), c(6), s(7),c(7), Prod(7));
U9: mid_row PORT MAP (A(8), B, s(7), c(7), s(8),c(8), Prod(8));
U10: mid_row PORT MAP (A(9), B, s(8), c(8), s(9),c(9), Prod(9));
U11: mid_row PORT MAP (A(10), B, s(9), c(9), s(10),c(10), Prod(10));
U12: mid_row PORT MAP (A(11), B, s(10), c(10), s(11),c(11), Prod(11));
U13: mid_row PORT MAP (A(12), B, s(11), c(11), s(12),c(12), Prod(12));
U14: mid_row PORT MAP (A(13), B, s(12), c(12), s(13),c(13), Prod(13));
U15: mid_row PORT MAP (A(14), B, s(13), c(13), s(14),c(14), Prod(14));
U16: mid_row PORT MAP (A(15), B, s(14), c(14), s(15),c(15), Prod(15));
U17: lower_row PORT MAP (s(15), c(15), Prod(31 DOWNTO 16));
END structural;
---------------------------------------------