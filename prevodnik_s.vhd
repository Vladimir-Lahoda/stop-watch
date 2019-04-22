-----------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
-- Authors: Vladimir Lahoda & Hana Stolarova
-----------------------------------------------------------------------
--- Convertor of clock signal (10kHz) to wanted signal (1Hz) 
-----------------------------------------------------------------------
-- Smaller part of a big project TIMER
-----------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

-----------------------------------------------------------------------
-- Entity declaration for 
-----------------------------------------------------------------------

entity prevodnik_s is
port(
        clk_i : in std_logic;
        sec_o : out std_logic
     );
end prevodnik_s;
----------------------------------------------------------------
----------------------------------------------------------------
architecture Behavioral of prevodnik_s is
    signal poc_10k : std_logic_vector(16-1 downto 0);
    signal poc_10k_next : std_logic_vector(16-1 downto 0);
    
begin

    p_prevodnik_s: process(clk_i)
    begin
        if rising_edge(clk_i) then
            poc_10k <= poc_10k_next ;           
        end if;
           
    end process p_prevodnik_s;
    
    poc_10k_next <= "0000000000000000" when (poc_10k = "0010100000011000") else
                    poc_10k + 1;
    
     sec_o <= '1' when (poc_10k = "0010100000011000") else 
              '0' ; 
    
end Behavioral;

