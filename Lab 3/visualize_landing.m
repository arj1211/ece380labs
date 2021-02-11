%% Configuration Flags
% Record Animation Flag. Set this to true only if your computer is good enough!
% This _DOES_ work on the Remote Desktops if you like.
shouldSaveAnimation = false;
animationFileName = 'Landing_Animation';

%% Simulate the System
sim('Lab_3_Position_Controlled_Landing_Module');

%% Acquire Position Data
position = logsout.getElement('position');
velocity = logsout.getElement('velocity');
acceleration = logsout.getElement('accel');

%% Resample Signal at 0.5 Hz (A Very Low Frame Rate, to save space)
TimeStart = 0;
TimeEnd = 100;
FrameRate = 0.5;
TimePoints = linspace(TimeStart, TimeEnd, (TimeEnd - TimeStart)*FrameRate);

position_timeseries = position.Values.resample(TimePoints);

% I've got the data now. So let us save some memory
clear('position', 'velocity', 'logsout');

%% Setup the Figure
figure(1);
fig = gcf();
fig.Color = '#2f3640';
clf;
axis([-125, 125, 0, 520]);
ax = gca;
ax.Color = '#2f3640';
ax.XColor = '#44bd32';
ax.YColor = '#44bd32';
ax.FontWeight = 'bold';
hold on;
xlabel('Relative Horizontal Position (m)');
ylabel('Relative Altitude (m)');
title('Landing Trajectory', 'Color', '#44bd32');


% If we aren't doing an animation, just plot it whole
if ~shouldSaveAnimation
    line = plot(position_timeseries.Data(:, 1), position_timeseries.Data(:, 2), '^');
    line.Color = '#44bd32';
    line.MarkerFaceColor = '#44bd32';
    line.MarkerSize = 2;
else
    if isunix() && ~ismac()
        % If on Linux, MATLAB can't export to 'MPEG-4'
        vidfile = VideoWriter(sprintf('%s.avi', animationFileName), 'Motion JPEG AVI');
    else
        vidfile = VideoWriter(sprintf('%s.mp4', animationFileName), 'MPEG-4'); 
    end
        
    % Video File Configuration (Frame Rate)
    vidfile.FrameRate = FrameRate;
    
    vidfile.open();
    for frameNum = 1:numel(position_timeseries.Time)
        point = scatter(position_timeseries.Data(frameNum, 1), position_timeseries.Data(frameNum, 2), '^');
        point.MarkerFaceColor = '#44bd32';
        point.MarkerEdgeColor = '#44bd32';
        point.SizeData = 5;
        drawnow();
        vidfile.writeVideo(getframe(gcf));
    end
    vidfile.close();
end

%%
figure(2);
fig = gcf();
fig.Color = '#2f3640';
clf;
ax = gca;
ax.Color = '#2f3640';
ax.XColor = '#44bd32';
ax.YColor = '#44bd32';
ax.FontWeight = 'bold';
hold on;
xlabel('Time (s)');
ylabel('Estimated Acceleration (m/s^2)');
line = plot(acceleration.Values.Time, acceleration.Values.Data, '-');
line.Color = '#44bd32';
title('Acceleration felt by Components', 'Color', '#44bd32');


