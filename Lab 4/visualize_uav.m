%% Configuration Flags
% Record Animation Flag. Set this to true only if your computer is good enough!
% This _DOES_ work on the Remote Desktops if you like.
shouldSaveAnimation = false;
animationFileName = 'UAV_Animation';

%% Load Data Dictionary and get path information.
datadict = Simulink.data.dictionary.open('Lab_4_Data.sldd');
section = datadict.getSection('Design Data');
pathDirection_value = section.getEntry('pathDirection').getValue();
pathReferencePoint_value = section.getEntry('pathReferencePoint').getValue();
V_value = section.getEntry('V').getValue();
datadict.close();

pathDirection_value = pathDirection_value / norm(pathDirection_value, 2);

%% Simulate the System
sim('Lab_4');

%% Acquire Position Data
position = logsout.getElement('x');
heading = logsout.getElement('heading');
output = logsout.getElement('y');

%% Resample Signal at 50 Hz
TimeStart = 0;
TimeEnd = 50;
FrameRate = 50;
TimePoints = linspace(TimeStart, TimeEnd, (TimeEnd - TimeStart)*FrameRate);

position_timeseries = position.Values.resample(TimePoints);
heading_timeseries = heading.Values.resample(TimePoints);

% I've got the data now. So let us save some memory
clear('position', 'heading', 'logsout');

%% Setup the Figure
figure(1);
clf;
hold on;
axis([0, 1500, 0, 1500]);
xlabel('Longitudinal Position (m)');
ylabel('Latitudinal Position (m)');
title('UAV in World');

% If we aren't doing an animation, just plot it whole
if ~shouldSaveAnimation
    startPoint = pathReferencePoint_value;
    endPoint = pathReferencePoint_value + (TimeEnd - TimeStart)*V_value*pathDirection_value;
    reference = plot([pathReferencePoint_value(1); endPoint(1)], [pathReferencePoint_value(2); endPoint(2)], 'r--');
    line = plot(position_timeseries.Data(:, 1), position_timeseries.Data(:, 2), 'b-');
    
    [X, Y] = UAV_Patch(position_timeseries.Data(end, :), heading_timeseries.Data(end), 150);
    
    patch(X, Y, 'g');
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
    
    startPoint = pathReferencePoint_value;
    endPoint = pathReferencePoint_value + (TimeEnd - TimeStart)*V_value*pathDirection_value;
    reference = plot([pathReferencePoint_value(1); endPoint(1)], [pathReferencePoint_value(2); endPoint(2)], 'r--');
    
    line = plot(position_timeseries.Data(1, 1), position_timeseries.Data(1, 2), 'b-');
    [X, Y] = UAV_Patch(position_timeseries.Data(1, :), heading_timeseries.Data(1, :), 150);
    p = patch(X, Y, 'g');
    drawnow();
    vidfile.writeVideo(getframe(gcf));
    
    for frameNum = 2:numel(position_timeseries.Time)       
        delete(line);
        delete(p);
                
        line = plot(position_timeseries.Data(1:(frameNum), 1), position_timeseries.Data(1:frameNum, 2), 'b-');
        [X, Y] = UAV_Patch(position_timeseries.Data(frameNum, :), heading_timeseries.Data(frameNum), 150);
        p = patch(X, Y, 'g');
        
        drawnow();
        vidfile.writeVideo(getframe(gcf));
    end
    vidfile.close();
end

%% 
figure(2);
clf;
plot(output.Values.Time, output.Values.Data, 'k-');
xlabel('Time (s)');
ylabel('y (m) [Distance to Path]');


