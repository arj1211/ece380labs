%% This Script Generates the Root Locus you need to Analyze to Find K_i

%% Symbolic Variables
s = tf('s');

%% Load Variables
datadict = Simulink.data.dictionary.open('Lab_4_Data.sldd');
section = datadict.getSection('Design Data');
N = section.getEntry('filterCoeff').getValue();
datadict.close();

%% Your Choice of Kp and Kd. (MAKE YOUR EDITS IN THIS SECTION)

Kp = 1; % Your Kp
Kd = 0; % Your Kd

%% Root Locus
figure(3);
rlocus((s+N)/(s^4 + N*s^3 + (N*Kd+Kp)*s^2 + N*Kp*s));
title('Root Locus of PID System with Variable K_i');
