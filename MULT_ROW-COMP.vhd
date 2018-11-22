---------- AND2.VDH ----------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------
ENTITY AND_2 IS
  PORT (A, B: IN STD_LOGIC;
      Y: OUT STD_LOGIC);
END AND_2;
-------------------------------
ARCHITECTURE AND_2 OF AND_2 IS
BEGIN
  Y <= A AND B;
END AND_2;
-------------------------------
------ fa.vhd (component): ----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
---------------------------------------
ENTITY fa IS
PORT ( a, b, cin: IN STD_LOGIC;
s, cout: OUT STD_LOGIC);
END fa;
---------------------------------------
ARCHITECTURE fa OF fa IS
BEGIN
s <= a XOR b XOR cin;
cout <= (a AND b) OR (a AND cin) OR (b AND cin);
END fa;
---------------------------------------
---- my_components.vhd (package): -----------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------
PACKAGE my_components IS
-----------------------
COMPONENT and_2 IS
PORT ( a, b: IN STD_LOGIC; y: OUT STD_LOGIC);
END COMPONENT;
-----------------------
COMPONENT fa IS -- full adder unit
PORT ( a, b, cin: IN STD_LOGIC; s, cout: OUT STD_LOGIC);
END COMPONENT;
-----------------------
-----------------------
END my_components;
