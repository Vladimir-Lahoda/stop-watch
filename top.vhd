library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-----------------------------------------------------------------------
-- Entity declaration for top level
-----------------------------------------------------------------------
entity top is
port(
    -- Global input signals at CPLD expansion board
    btn_i : in std_logic_vector(2-1 downto 0);
   

    -- Global input signals at Coolrunner-II board
    clk_i : in std_logic;   -- on-board jumper JP1 select 10 kHz clock

    -- Global output signals at Coolrunner-II board
    disp_sseg_o : out std_logic_vector(7-1 downto 0);
    led : out std_logic;
    disp_digit_o : out std_logic_vector(4-1 downto 0));
    
end top;

-----------------------------------------------------------------------
-- Architecture declaration for top level
-----------------------------------------------------------------------
architecture Behavioral of top is
    signal sec_1 : std_logic;
    signal sec_2 : std_logic;
    signal carry_klop : std_logic;
    signal data_0 : std_logic_vector(4-1 downto 0);
    signal data_1 : std_logic_vector(4-1 downto 0);
    signal data_2 : std_logic_vector(4-1 downto 0);
    signal data_3 : std_logic_vector(4-1 downto 0);
    signal carry_1 : std_logic;
    signal carry_2 : std_logic;
    signal carry_3 : std_logic;


   
begin
    PREVODNIK_S : entity work.prevodnik_s
        port map (
        clk_i => clk_i,
        sec_o => sec_1
        );
        

    SEKUNDY_jed : entity work.bcd_cnt_jed
        port map (                     
            clk1_i => sec_2,
            carry_n_o => carry_1,
            bcd_cnt_jed_o => data_0,
            rst_n_i => btn_i(0)
        );
      
    SEKUNDY_des : entity work.bcd_cnt_des
        port map (
            clk2_i => carry_1,
            carry_n_o => carry_2,
            bcd_cnt_des_o => data_1,  
            rst_n_i => btn_i(0)
        );

    MINUTY_jed : entity work.bcd_cnt_jed
        port map(                    
            clk1_i => carry_klop,
            carry_n_o => carry_3,
            bcd_cnt_jed_o => data_2,
            rst_n_i => btn_i(0)
        ); 
      
    MINUTY_des : entity work.bcd_cnt_des
        port map(                    
            clk2_i => carry_3,
            bcd_cnt_des_o => data_3,
            rst_n_i => btn_i(0),
            carry_n_o => led 
        );
       
    DISP_MUX : entity work.disp_mux
        port map(
            data3_i => data_3,
            data2_i => data_2,
            data1_i => data_1,
            data0_i => data_0,
            clk_i => clk_i,  
            sseg_o => disp_sseg_o,
            an_o => disp_digit_o
            );
            
    START_STOP : entity work.start_stop
        port map (
        sec_i => sec_1,
        sec_o => sec_2,
        povel  => btn_i(1)
        );
   
    carry_klop <= '1' when(carry_1 = '0' and carry_2 = '0') else           
                  '0'; 

end Behavioral;