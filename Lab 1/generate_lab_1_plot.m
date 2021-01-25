%% 1.1
[y_t,y_v,u_t,u_v] = run_sim('Lab_1_1.slx');
% Estimate DC Gain
dc_gain_open = (max(y_v)-min(y_v)) / (max(u_v)-min(u_v));
% Markers at Peaks
[maxy,maxind]=max(y_v);
[miny,minind]=min(y_v);
minx = y_t(minind);
maxx = y_t(maxind);
px = [minx, maxx];
py = [miny, maxy];

figure(1);
plot([u_t(:), y_t(:)], [u_v(:), y_v(:)], '-');
hold on
plot(px,py,'go');
legend('Input Signal', 'Output Signal', 'Peaks');
xlabel('Time')

title('Response to Low-Frequency Input')
annotation('textbox',[0.2,0.15,0.1,0.1],'String',strcat("DC Gain Estimate: ",num2str(dc_gain_open)));
%% 1.2
[y_t,y_v,u_t,u_v] = run_sim('Lab_1_2.slx');
bwf_open = 32.5; % Hz
% Markers at Peaks
[maxy,maxind]=max(y_v);
[miny,minind]=min(y_v);
minx = y_t(minind);
maxx = y_t(maxind);
px = [minx, maxx];
py = [miny, maxy];

figure(2);
plot([u_t(:), y_t(:)], [u_v(:), y_v(:)], '-');
hold on
plot(px,py,'go');
legend('Input Signal', 'Output Signal', 'Peaks');
xlabel('Time')

title('Time-Domain Response of Plant at Bandwidth Frequency')
annotation('textbox',[0.2,0.15,0.1,0.1],'String',strcat("B.W. Freq.: ",num2str(bwf_open)));
%% 1.3.1
[y_t,y_v,u_t,u_v] = run_sim('Lab_1_3_1.slx');
% Estimate DC Gain
dc_gain_closed = (max(y_v)-min(y_v)) / (max(u_v)-min(u_v));
% Markers at Peaks
[maxy,maxind]=max(y_v);
[miny,minind]=min(y_v);
minx = y_t(minind);
maxx = y_t(maxind);
px = [minx, maxx];
py = [miny, maxy];

figure(3);
plot([u_t(:), y_t(:)], [u_v(:), y_v(:)], '-');
hold on
plot(px,py,'go');
legend('Input Signal', 'Output Signal', 'Peaks');
xlabel('Time')

title('Closed-loop Response to Low-Frequency Input')
annotation('textbox',[0.2,0.15,0.1,0.1],'String',strcat("DC Gain Estimate: ",num2str(dc_gain_closed)));
%% 1.3.2
[y_t,y_v,u_t,u_v] = run_sim('Lab_1_3_2.slx');
% Markers at Peaks
[maxy,maxind]=max(y_v);
[miny,minind]=min(y_v);
minx = y_t(minind);
maxx = y_t(maxind);
px = [minx, maxx];
py = [miny, maxy];
figure(4);
plot([u_t(:), y_t(:)], [u_v(:), y_v(:)], '-');
hold on
plot(px,py,'go');
legend('Input Signal', 'Output Signal', 'Peaks');
xlabel('Time')

title('Closed-loop Time-Domain Response of Plant at Bandwidth Frequency')
bwf_closed = 32.5; % Hz
annotation('textbox',[0.2,0.15,0.1,0.1],'String',strcat("B.W. Freq.: ",num2str(bwf_closed)));
%% 1.4
[y_t,y_v,u_t,u_v] = run_sim('Lab_1_4.slx');
tau_y_open = dc_gain_open*0.63 - dc_gain_open/2;
set_time_low_open = dc_gain_open/2 * 0.98;
set_time_high_open = dc_gain_open/2 * 1.02;

% From graph
tau_open = 0.0048157462;
settling_time_open = 0.0222780065037;

figure(5);
plot([u_t(:), y_t(:)], [u_v(:), y_v(:)], '-');
hold on
yline(tau_y_open,'c-');
hold on
yline(set_time_low_open,'g-');
hold on
yline(set_time_high_open,'g-');
hold on
plot(1+tau_open,tau_y_open,'ro');
hold on
plot(1+settling_time_open, set_time_low_open,'bo');

legend('Input Signal', 'Output Signal');
xlabel('Time')

title('Settling Time and Time Constant for Open-loop Step-Response')
annotation('textbox',[0.2,0.15,0.1,0.1],'String',strcat("Time Constant: ",num2str(tau_open)));
annotation('textbox',[0.2,0.22,0.1,0.1],'String',strcat("Settling Time: ",num2str(settling_time_open)));
%% 1.5
[y_t,y_v,u_t,u_v] = run_sim('Lab_1_5.slx');
tau_y_closed = dc_gain_closed*0.63 - dc_gain_closed/2;
set_time_low_closed = dc_gain_closed/2 * 0.98;
set_time_high_closed = dc_gain_closed/2 * 1.02;

% From graph
tau_closed = 0.00251806053;
settling_time_closed = 0.01165713981;

figure(6);
plot([u_t(:), y_t(:)], [u_v(:), y_v(:)], '-');
hold on
yline(tau_y_closed,'c-');
hold on
yline(set_time_low_closed,'g-');
hold on
yline(set_time_high_closed,'g-');
hold on
plot(1+tau_closed,tau_y_closed,'ro');
hold on
plot(1+settling_time_closed, set_time_low_closed,'bo');

legend('Input Signal', 'Output Signal');
xlabel('Time')

title('Settling Time and Time Constant for Closed-loop Step-Response')
annotation('textbox',[0.2,0.15,0.1,0.1],'String',strcat("Time Constant: ",num2str(tau_closed)));
annotation('textbox',[0.2,0.22,0.1,0.1],'String',strcat("Settling Time: ",num2str(settling_time_closed)));
%% 1.6
[y_t,y_v,u_t,u_v] = run_sim('Lab_1_6.slx');

% Markers at Peaks
[maxy,maxind]=max(y_v);
[miny,minind]=min(y_v);
minx = y_t(minind);
maxx = y_t(maxind);
px = [minx, maxx];
py = [miny, maxy];

figure(7);
plot([u_t(:), y_t(:)], [u_v(:), y_v(:)], '-');
hold on
plot(px,py,'go');
legend('Input Signal', 'Output Signal', 'Peaks');
xlabel('Time')

title('Gain for Saturation/Clipping')
annotation('textbox',[0.2,0.15,0.1,0.1],'String',strcat("Kp: ",num2str(20.5)));
%%
function [y_t, y_v, u_t, u_v] = run_sim(slx_name)
    % Run the simulink diagram!
    sim(slx_name);
    % Once the simulink diagram executes, it generates a variable "logsout". We
    % can inspect this variable to pull out the signals we have recorded!
    % Pull out the Output (y) and Input (u) signals.
    y_t = logsout.getElement('y').Values.Time;      % Get the Time Points for the output signal 'y'
    y_v = logsout.getElement('y').Values.Data;      % Get the values for the output signal 'y'
    u_t = logsout.getElement('u').Values.Time;      % Get the time points for the input signal 'u'
    u_v = logsout.getElement('u').Values.Data;      % Get the values for the input signal 'u'
end