-- ************************************************************
-- Copyright (C), 2015-2021, Surgnova HealthTech. Co., Ltd.
-- FileName: hall_sensor_process.vhd
-- Author: Alexander Hsu
-- Version : 1.0
-- Date: 2021.04.27

-- Description: the module that processes three hall sensors'
--              signals.
-- ************************************************************


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hall_sensor_preprocess is

    port (
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

end hall_sensor_preprocess; 

architecture arch_hall_sensor_preprocess of hall_sensor_preprocess is

end arch_hall_sensor_preprocess; 