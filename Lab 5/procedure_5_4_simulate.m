%% Configuration Flags
procedure_5_2;

%% Simulate the System
sim('Lab_5_Real_System');

%% Show Plots
datadict = Simulink.data.dictionary.open('Lab_5_Real_System_Data.sldd');
show_uav_plots(541, 542, datadict, logsout);