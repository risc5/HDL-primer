library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity pwm_module is
    generic (
        duty_cycle : integer := 512;
        sys_clk         : INTEGER := 144_000_000; --system clock frequency in Hz
        pwm_freq        : INTEGER := 40_000;    --PWM switching frequency in Hz
        bits_resolution : INTEGER := 10          --bits of resolution setting the duty cycle
    );

    Port (
        clk   : in STD_LOGIC;
        duty  : in  std_logic_vector(bits_resolution - 1 downto 0); 
        pwm   : out STD_LOGIC;
        pwm_i : out STD_LOGIC
    );
end pwm_module;

architecture behavioral_pwm_module of pwm_module is
    constant period : integer := sys_clk / pwm_freq;

    signal counter : integer range 0 to period - 1 :=  0;
    signal duty_cycle_internal : integer := 0;
    -- signal counter : unsigned(9 downto 0) := (others => '0');
    -- signal pwm_signal : std_logic;
begin
    process(clk)
    begin
        if clk'event and clk = '1' then
            if counter = (period - 1) then
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;

        if counter = 0 then
            duty_cycle_internal <= (period * to_integer(unsigned(duty))) / (2**bits_resolution);
        end if;
    end process;

pwm <= '1' when counter < duty_cycle_internal else '0';
pwm_i <= '0' when counter < duty_cycle_internal else '1';

end behavioral_pwm_module;