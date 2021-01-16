%% Run the simulink diagram!
sim('Lab_1.slx');
% Once the simulink diagram executes, it generates a variable "logsout". We
% can inspect this variable to pull out the signals we have recorded!
%% Pull out the Output (y) and Input (u) signals.
y_t = logsout.getElement('y').Values.Time;      % Get the Time Points for the output signal 'y'
y_v = logsout.getElement('y').Values.Data;      % Get the values for the output signal 'y'
u_t = logsout.getElement('u').Values.Time;      % Get the time points for the input signal 'u'
u_v = logsout.getElement('u').Values.Data;      % Get the values for the input signal 'u'
%% Markers at Peaks
[maxy,maxind]=max(y_v);
[miny,minind]=min(y_v);
minx = y_t(minind);
maxx = y_t(maxind);
px = [minx, maxx];
py = [miny, maxy];
%% Estimate DC Gain
gain = (max(y_v)-min(y_v)) / (max(u_v)-min(u_v));
% annotation('textbox',[0.2,0.15,0.1,0.1],'String',strcat("DC Gain Estimate:",num2str(gain)));
disp(['DC Gain Estimate: ',num2str(gain)])
%% Predict Amplitude of Steady-State output at Bandwidth Frequency
% Open loop B.freq = 35.6 Hz
% Closed loop B.freq = 68 Hz
amp_open = 0.9127/sqrt(2); % Open-loop
amp_closed = 0.47719/sqrt(2); % Closed-loop
disp(['Open-loop Amplitude of Steady-State output at Bandwidth Frequency: ',num2str(amp_open)])
disp(['Closed-loop Amplitude of Steady-State output at Bandwidth Frequency: ',num2str(amp_closed)])
%% Settling Time + Time Const.
y_val = 0.63*0.9128;
%% Plot Input (u) and Output (y) Signals
figure(1);                                      % Create a figure indexed by (1)
plot([u_t(:), y_t(:)], [u_v(:), y_v(:)], '-');  % Plot input and output.

hold on
plot(px,py,'go');                               % Green circle markers

hold on
plot(y_t,y_val);

legend('Input Signal', 'Output Signal', 'Peaks');% Legend, in order of signals above.
title('Put a good title here')                  % Title
xlabel('Time')                                  % XLable is 'Time'