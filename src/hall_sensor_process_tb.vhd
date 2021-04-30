-- ************************************************************
-- Copyright (C), 2015-2021, Surgnova HealthTech. Co., Ltd.
-- FileName: hall_sensor_process_tb.vhd
-- Author: Alexander Hsu
-- Version : 1.0
-- Date: 2021.04.27

-- Description: th tb of the module that processes three hall sensors'
--              signals.
-- ************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

entity hall_sensor_preprocess_tb is
end hall_sensor_preprocess_tb;

architecture arch_hall_sensor_preprocess_tb of hall_sensor_preprocess_tb is
    signal hall_sensor_input_1 : std_logic;
    signal hall_sensor_input_2 : std_logic;
    signal hall_sensor_input_3 : std_logic;

    signal pwm_output_a_plus  : std_logic;
    signal pwm_output_a_minus : std_logic;
    signal pwm_output_b_plus  : std_logic;
    signal pwm_output_b_minus : std_logic;
    signal pwm_output_c_plus  : std_logic;
    signal pwm_output_c_minus : std_logic;

    constant T : time := 100 ms;

    component hall_sensor_preprocess port (
        hall_h1 IN std_logic;
        hall_h2 IN std_logic;
        hall_h3 IN std_logic;
        driving_pwm_A_plus  out std_logic;
        driving_pwm_A_minus out std_logic;
        driving_pwm_B_plus  out std_logic;
        driving_pwm_B_minus out std_logic;
        driving_pwm_C_plus  out std_logic;
        driving_pwm_C_minus out std_logic
    );
    end component;

begin
    hall_sensor_preprocess_inst : hall_sensor_preprocess port map (
        hall_h1 => hall_sensor_input_1,
        hall_h2 => hall_sensor_input_2,
        hall_h3 => hall_sensor_input_3,
        driving_pwm_A_plus  => pwm_output_a_plus,
        driving_pwm_A_minus => pwm_output_a_minus,
        driving_pwm_B_plus  => pwm_output_b_plus,
        driving_pwm_B_minus => pwm_output_b_minus,
        driving_pwm_C_plus  => pwm_output_b_plus,
        driving_pwm_C_minus => pwm_output_b_minus

    );

    sensors_generation: process
    begin
        hall_sensor_input_1 := '1';
        hall_sensor_input_2 := '0';
        hall_sensor_input_3 := '1';
        wait for T/2;

        hall_sensor_input_1 := '1';
        hall_sensor_input_2 := '0';
        hall_sensor_input_3 := '0';
        wait for T/2;

        hall_sensor_input_1 := '1';
        hall_sensor_input_2 := '1';
        hall_sensor_input_3 := '0';
        wait for T/2;

        hall_sensor_input_1 := '0';
        hall_sensor_input_2 := '1';
        hall_sensor_input_3 := '0';
        wait for T/2;

        hall_sensor_input_1 := '0';
        hall_sensor_input_2 := '1';
        hall_sensor_input_3 := '1';
        wait for T/2;

        hall_sensor_input_1 := '0';
        hall_sensor_input_2 := '0';
        hall_sensor_input_3 := '1';
        wait for T/2;
    end process sensors_generation;

end arch_hall_sensor_preprocess_tb;