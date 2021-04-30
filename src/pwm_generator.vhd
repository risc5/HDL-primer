-- ************************************************************
-- Copyright (C), 2015-2021, Surgnova HealthTech. Co., Ltd.
-- FileName: pwm_generator.vhd
-- Author: Alexander Hsu
-- Version : 1.0
-- Date: 2021.04.29

-- Description: the module which can generate the pwm output 
--              with any duty cycle.
-- ************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity pwm_generator is
    GENERIC(
        sys_clk         : INTEGER := 144_000_000; --system clock frequency in Hz
        pwm_freq        : INTEGER := 40_000;    --PWM switching frequency in Hz
        bits_resolution : INTEGER := 10          --bits of resolution setting the duty cycle
    );

    port (
        clk:      in  std_logic;
        reset_n : in  std_logic;
        duty    : in  std_logic_vector(bits_resolution - 1 downto 0); --duty cycle
        pwm_out   : out std_logic;
        pwm_n_out : out std_logic
    );
end pwm_generator;

architecture arch of pwm_generator is
    constant period : integer := sys_clk / pwm_freq;
    constant duty_max_count : integer := 2**bits_resolution;

    signal duty_cycle_threhold : integer := conv_integer(duty) * period / duty_max_count;
    signal pwm_count : unsigned(bits_resolution - 1 downto 0) := (others => '0');
begin
    pwm_proc: process(clk, reset_n)
    begin
        report "pwm_proc, pwm_count=" & integer'image(to_integer(pwm_count));
        report "duty_cycle_threhold=" & integer'image(duty_cycle_threhold);
        report "period=" & integer'image(period);
        report "duty_max_count=" & integer'image(duty_max_count);
        report "duty=" & integer'image(conv_integer(duty));
        if clk'event and clk = '1' then
            pwm_count <= pwm_count + 1;
        elsif reset_n = '0' then
            pwm_count <= (others => '0');
            pwm_out <= '0';
            pwm_n_out <= '0';
        end if;
    end process pwm_proc;

pwm_out <= '1' when pwm_count <= duty_cycle_threhold else '0';
pwm_n_out <= '1' when pwm_count > duty_cycle_threhold else '0';

end arch;