
--------------------------------------------------------------------------------
-- Copyright (c) 1995-2007 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.2i
--  \   \         Application : ISE
--  /   /         Filename : TCPU12.vhw
-- /___/   /\     Timestamp : Sun Jul 12 01:02:55 2009
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: TCPU12
--Device: Xilinx
--

library ieee;
use ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE STD.TEXTIO.ALL;

ENTITY TCPU12 IS
END TCPU12;

ARCHITECTURE testbench_arch OF TCPU12 IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT SCPU12
        PORT (
            CLK : In std_logic;
            RESET : In std_logic;
            INSTSEL : In std_logic_vector (3 DownTo 0);
            DONE : Out std_logic
        );
    END COMPONENT;

    SIGNAL CLK : std_logic := '0';
    SIGNAL RESET : std_logic := '0';
    SIGNAL INSTSEL : std_logic_vector (3 DownTo 0) := "0000";
    SIGNAL DONE : std_logic := '0';

    constant PERIOD : time := 100 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 50 ns;

    BEGIN
        UUT : SCPU12
        PORT MAP (
            CLK => CLK,
            RESET => RESET,
            INSTSEL => INSTSEL,
            DONE => DONE
        );

        PROCESS    -- clock process for CLK
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                CLK <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                CLK <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;
        PROCESS
            BEGIN
                -- -------------  Current Time:  100ns
                WAIT FOR 100 ns;
                RESET <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  300ns
                WAIT FOR 100 ns;
                RESET <= '0';
                -- -------------------------------------
                -- IM-------------  Current Time:  800ns
                WAIT FOR 500 ns;
                INSTSEL <= "0001";
                -- -------------------------------------5
                -- DI-------------  Current Time:  1300ns
                WAIT FOR 500 ns;
                INSTSEL <= "0010";
                -- -------------------------------------5
                -- EX-------------  Current Time:  2000ns
                WAIT FOR 500 ns;
                INSTSEL <= "0011";
                -- -------------------------------------5
                -- O5-------------  Current Time:  2700ns
                WAIT FOR 700 ns;
                INSTSEL <= "0100";
                -- -------------------------------------7
                -- O9-------------  Current Time:  3400ns
                WAIT FOR 700 ns;
                INSTSEL <= "0101";
                -- -------------------------------------7
                -- O16-------------  Current Time:  4100ns
                WAIT FOR 700 ns;
                INSTSEL <= "0110";
                -- -------------------------------------7
                -- PP-------------  Current Time:  4800ns
                WAIT FOR 700 ns;
                INSTSEL <= "0111";
                -- -------------------------------------7
                -- AO-------------  Current Time:  5500ns
                WAIT FOR 700 ns;
                INSTSEL <= "1000";
                -- -------------------------------------7
                -- BO-------------  Current Time:  6200ns
                WAIT FOR 700 ns;
                INSTSEL <= "1001";
                -- -------------------------------------7
                -- DO-------------  Current Time:  6900ns
                WAIT FOR 700 ns;
                INSTSEL <= "1010";
                -- -------------------------------------7
                -- 16I-------------  Current Time:  7700ns
                WAIT FOR 800 ns;
                INSTSEL <= "1011";
                -- -------------------------------------8
                -- DI-------------  Current Time:  8500ns
                WAIT FOR 800 ns;
                INSTSEL <= "1100";
                WAIT FOR 800 ns;
                -- IH-----------------------------------8

            END PROCESS;

    END testbench_arch;


