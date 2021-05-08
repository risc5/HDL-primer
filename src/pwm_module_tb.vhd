library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use ieee.std_logic_unsigned.all;

entity pwm_tb is
end pwm_tb;

architecture arch_pwm_tb of pwm_tb is
    constant T_xmc4800 : time := 7 ns;
    constant bits_resolution : integer := 10;

    signal clk_sys   : std_logic;
    signal duty_value : std_logic_vector(bits_resolution - 1 downto 0);
    signal pwm_plus  : std_logic;
    signal pwm_minus : std_logic;

    component pwm_module port (
        clk   : in  std_logic;
        duty  : in  std_logic_vector(bits_resolution - 1 downto 0);
        pwm   : out std_logic;
        pwm_i : out std_logic
    );
    end component;

begin
    pwm_module_inst : pwm_module port map (
        clk => clk_sys,
        duty => duty_value,
        pwm => pwm_plus,
        pwm_i => pwm_minus
    );

    clock_generator: process
    begin
        clk_sys <= '0';
        wait for T_xmc4800 / 2;
        clk_sys <= '1';
        wait for T_xmc4800 / 2;
    end process clock_generator;

    basic_test: process
    variable duty_cycle : integer := 0;
    begin
        -- duty_value <= std_logic_vector(to_unsigned(512, duty_value'length));
        duty_value <= "1000000000";
        wait for 50 us;

        duty_cycle := 768;
        duty_value <= std_logic_vector(to_unsigned(duty_cycle, duty_value'length));
        wait for 75 us;
    end process basic_test;
end arch_pwm_tb;