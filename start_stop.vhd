-----------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
-- Authors: Vladimir Lahoda & Hana Stolarova
-----------------------------------------------------------------------
--- A special type of black box with switching function, 
--- ensuring STOP or START of the TIMER after pushing the button
-----------------------------------------------------------------------
-- Smaller part of a big project TIMER
-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;    

--------------------------------------------------------------------------------
-- Entity declaration for the block
--------------------------------------------------------------------------------
entity start_stop is
    port (   
    -- entity input signals
        sec_i : in std_logic;   -- input clock signal
        povel : in std_logic ;   -- command input signal from the button
    
    -- entity output signals
        sec_o   : out std_logic -- output clock signal     
    );
end start_stop;

--------------------------------------------------------------------------------
-- Architecture declaration for BCD counter
--------------------------------------------------------------------------------
architecture Behavioral of start_stop is
    signal s_comb  : std_logic;
    signal s_next : std_logic;   
    
begin
process (povel)
begin
        if falling_edge(povel) then
             s_comb <= s_next;            -- update register value
        end if;
end process;
    --------------------------------------------------------------------------------
    sec_o <= sec_i when(s_comb = '0') else -- switch of clock signal          
             '0'; 
    
    s_next <= '0' when (s_comb = '1') else -- next register value
              '1';
end Behavioral;

