-- ************************************************************
-- Copyright (C), 2015-2021, Surgnova HealthTech. Co., Ltd.
-- FileName: pwm_generator_tb.vhd
-- Author: Alexander Hsu
-- Version : 1.0
-- Date: 2021.04.30

-- Description: the test bench of the module which can generate
--              the pwm output with any duty cycle.
-- ************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

entity pwm_generator_tb is
end pwm_generator_tb;

architecture arch_pwm_generator_tb of pwm_generator_tb is
    constant T_xmc4800 : time := 7 ns;
    constant bits_resolution : integer := 10;

    signal clk_sys : std_logic := '0';
    signal reset : std_logic := '1';
    signal duty_cycle : std_logic_vector(bits_resolution - 1 downto 0) := (others => '0');
    signal pwm_plus  : std_logic := '0';
    signal pwm_minus : std_logic := '0';


    component pwm_generator port (
        clk :     in  std_logic;
        reset_n : in  std_logic;
        duty    : in  std_logic_vector(bits_resolution - 1 downto 0);
        pwm_out   : out std_logic;
        pwm_n_out : out std_logic
    );
    end component;

begin
    pwm_generator_inst : pwm_generator port map (
        clk => clk_sys,
        reset_n => reset,
        duty => duty_cycle,
        pwm_out => pwm_plus,
        pwm_n_out => pwm_minus
    );

    clock_generator: process
    begin
        clk_sys <= '0';
        wait for T_xmc4800 / 2;
        clk_sys <= '1';
        wait for T_xmc4800 / 2;
    end process clock_generator;

    basic_test: process
    begin
        reset <= '1';
        duty_cycle <= "1000000000";
        wait for 300 ns;
    end process basic_test;

end arch_pwm_generator_tb;