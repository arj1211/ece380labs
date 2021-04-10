%% Configuration Flags
procedure_5_1;

%% Simulate the System
sim('Lab_5_Model_System');

%% Show Plots
datadict = Simulink.data.dictionary.open('Lab_5_Model_System_Data.sldd');
show_uav_plots(511, 512, datadict, logsout);