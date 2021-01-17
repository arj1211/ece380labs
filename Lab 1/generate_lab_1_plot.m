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
%% Settling Time + Time Const. (Open-loop)
% point_63 = 0.63*0.9128;
% down2p = 0.9128/2*.98;
% up2p = 0.9128/2*1.02;
% settling_time = 0.02230355;
% y_val = point_63 - 0.9128/2;
% tau = 0.0048159299;
%% Settling Time + Time Const. (Closed-loop)
point_63 = 0.63*0.47719;
down2p = 0.47719/2*.98;
up2p = 0.47719/2*1.02;
settling_time = 0.0116563755;
y_val = point_63 - 0.47719/2;
tau = 0.00251805496;
%% Plot Input (u) and Output (y) Signals
figure(1);                                      % Create a figure indexed by (1)
plot([u_t(:), y_t(:)], [u_v(:), y_v(:)], '-');  % Plot input and output.

hold on
plot(px,py,'go');                               % Green circle markers

% hold on
% yline(y_val);
% plot(1+tau,y_val,'mx');                         % 63% point (tau point)

% hold on
% yline(down2p);                                  % 2% lower
% hold on
% yline(up2p);                                    % 2% higher

% hold on
% plot(1+settling_time, down2p, 'c+');            % settling point

legend('Input Signal', 'Output Signal', 'Peaks');% Legend, in order of signals above.
title('Put a good title here')                  % Title
xlabel('Time')                                  % XLable is 'Time'