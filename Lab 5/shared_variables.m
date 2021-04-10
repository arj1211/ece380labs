%% Helpful to ensure you don't have any variables sitting around corrupting your sims.
clear all;

%% DO NOT CHANGE THESE SHARED VARIABLES (BETWEEN SIMULINK AND MATLAB)
frequency = 100;
delay = 6;

Kp = 1;
Kd = 2;

desired_offset = -5;

s = tf('s');
sModel_UAVPlant = Kp/(s^2 + Kd*s + Kp);