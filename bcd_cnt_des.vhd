-----------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
-- Authors: Vladimir Lahoda & Hana Stolarova
-----------------------------------------------------------------------
--- BCD counter 0-5
-----------------------------------------------------------------------
-- Smaller part of a big project TIMER
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;   

--------------------------------------------------------------------------------
-- Entity declaration for BCD counter
--------------------------------------------------------------------------------
entity bcd_cnt_des is
    port (
     --Entity input signals
        clk2_i   : in std_logic;    -- input clock signal 
        rst_n_i : in std_logic;     -- input reset signal
                                   
     --Entity output signals
        carry_n_o : out std_logic;   -- output carry_up signal    
        bcd_cnt_des_o : out std_logic_vector(4-1 downto 0)  -- output BCD signal
    );
end bcd_cnt_des;

--------------------------------------------------------------------------------
-- Architecture declaration for BCD counter
--------------------------------------------------------------------------------
architecture Behavioral of bcd_cnt_des is
    signal s_reg  : std_logic_vector(4-1 downto 0);
    signal s_next : std_logic_vector(4-1 downto 0);
    
begin
    --------------------------------------------------------------------------------
    -- Register
    --------------------------------------------------------------------------------
    p_bcd_cnt_des: process(rst_n_i, clk2_i)
    begin
            if rst_n_i = '0' then           -- asynchronous reset
                s_reg <= (others => '0');   -- clear all bits in register
            elsif rising_edge(clk2_i) then
                s_reg <= s_next;            -- update register value
            end if;
    end process p_bcd_cnt_des;

    --------------------------------------------------------------------------------
    -- Regulation of the counting process
    --------------------------------------------------------------------------------
    s_next <= "0000" when (s_reg = "0101")
              else s_reg + 1;
    --------------------------------------------------------------------------------
    -- Output signals of BCD counter
    --------------------------------------------------------------------------------
    bcd_cnt_des_o <= s_reg;
    carry_n_o <= '0' when s_reg = "0101" else  
                 '1';
end Behavioral;
