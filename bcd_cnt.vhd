-----------------------------------------------------------------------
-- Brno University of Technology, Department of Radio Electronics
-- Authors: Vladimir Lahoda & Hana Stolarova
-----------------------------------------------------------------------
--- BCD counter 0-9
-----------------------------------------------------------------------
-- Smaller part of a big project TIMER
-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 

--------------------------------------------------------------------------------
-- Entity declaration for BCD counter
--------------------------------------------------------------------------------
entity bcd_cnt_jed is
    port (
    -- Entity input signals
        clk1_i   : in std_logic;
        rst_n_i : in std_logic;     
                                   
    -- Entity output signals
        carry_n_o : out std_logic;  
        bcd_cnt_jed_o : out std_logic_vector(4-1 downto 0)
        );
end bcd_cnt_jed;

--------------------------------------------------------------------------------
-- Architecture declaration for BCD counter
--------------------------------------------------------------------------------
architecture Behavioral of bcd_cnt_jed is
    signal s_reg  : std_logic_vector(4-1 downto 0);
    signal s_next : std_logic_vector(4-1 downto 0);
    
begin
    --------------------------------------------------------------------------------
    -- Register
    --------------------------------------------------------------------------------
    p_bcd_cnt_jed: process(rst_n_i, clk1_i)
    begin
            if rst_n_i = '0' then           -- asynchronous reset
                s_reg <= (others => '0');   -- clear all bits in register
            elsif falling_edge(clk1_i) then
                s_reg <= s_next;            -- update register value
            end if;
    end process p_bcd_cnt_jed;

    --------------------------------------------------------------------------------
    -- Regulation of the counting process
    --------------------------------------------------------------------------------

     s_next <= "0000" when (s_reg = "1001")
                else s_reg + 1;
  
    --------------------------------------------------------------------------------
    -- Output signals of BCD counter
    --------------------------------------------------------------------------------
    bcd_cnt_jed_o <= s_reg;
    carry_n_o <= '0' when s_reg = "1001" else   
                 '1';
                
end Behavioral;
