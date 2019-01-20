clc;
clear;
close all;

%% xsensData  load file
xsensData = csvread('./Experiments/DBoe-001-HD_xsens.csv');
xsensTime = xsensData(:,1);
xsensJA = xsensData(:,1+1:1+66);      % Joint Angles
xsensSP = xsensData(:,67+1:67+69);    % Segment Pos
xsensCOM = xsensData(:,136+1:136+3);  % COM


%% FSR - Importing data from CSV
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f';
data{1} = readtable('./Experiments/DBoe-001_FSR.csv', 'Delimiter',',','Format',formatSpec);  % start reading the csv file from row 2, column 1

% Merge the outputs into one bigger matrix
allData = vertcat(data{:});
allDataArray = table2array(allData);

% Syncing start of FSR with XSENS
sync = allDataArray(:,3);
for i = 1:length(allDataArray)
    if sync(i) > 100
        fSkip = i;
        break;
    end
end
allDataArray = allDataArray(fSkip:end,:);

% Timing
fTime = allDataArray(:,1) - allDataArray(1,1);

% Forces for each FSR
fV = allDataArray(:,4:13);
fL1V = allDataArray(:,4);
fL2V = allDataArray(:,5);
fL3V = allDataArray(:,6);
fL4V = allDataArray(:,7);
fL5V = allDataArray(:,8);
fR1V = allDataArray(:,9);
fR2V = allDataArray(:,10);
fR3V = allDataArray(:,11);
fR4V = allDataArray(:,12);
fR5V = allDataArray(:,13);

% Conversion from voltage to forces (N)
p1 = [0.1039 0.1549 0.2891 0.2120 0.1893 0.1045 0.2338 0.2396 0.1675 0.1206];
p2 = [-52.19 -41.64 -107.3 -57.81 -74.56 -73.60 -86.61 -108.3 -62.46 -49.69];
for i = 1:length(p1)
   fN(:,i) = p1(i).*fV(:,i) + p2(i);
end


%% Resampling FSR data to match sampling frequency of XSENS
Fs = 60;
ds = 1000/Fs;
ts = 1:ds:fTime(end);   % resampled time stamp for FSR data

% Interpolate fN into samplefN
% -- This is 10 FSR data sampled at the same rate as XSENS
samplefN = interp1(fTime, fN, ts, 'linear');

% Chopping data length such that it ends the same time as XSENS
% (the beginning is synced, but the end could be at different point thus
% has to be chopped off manually)
sampleFSRTime = ts(1:length(xsensTime));
% -- This is the 10 FSR data sampled at the same time as XSENS with same
% -- end and beginning as XSENS
sampleFSR = samplefN(1:length(xsensTime),:);

% Sanity check if the resampled (interpolated) force values are correct
% figure; plot(fTime,fN(:,1),'b'); hold on; plot(sampleFSRTime, sampleFSR(:,1), '--r'); 

%% Data visualization for splicing purpose
totalLeftForce = sum(sampleFSR(:,1:5),2);
totalRightForce = sum(sampleFSR(:,6:end),2);

%% Automated Data Parsing - START points
% filter will initially decrease by this y-value (AKA volts) each iteration
filter_step = 20;

% filter starting position for y-value (AKA volts)
filter_left_start = 450;
filter_right_start = 350;

% time start and end, for one descent down stairs
time_start = 1900; % 1850;
time_end = 2510; % 2395;
filtered_time_range = time_start:time_end;

% extract data based on time selection above, for one descent down stairs
filtered_total_left_force = totalLeftForce(filtered_time_range);
filtered_total_right_force = totalRightForce(filtered_time_range);


%% start processing with smoothed data
% actual number of values want recorded (number of steps on staircase)
true_step_count = 8;

% call smoothing function
[lfoot_smooth, rfoot_smooth] = smooth_data(filtered_total_left_force, filter_left_start, filtered_total_right_force, filter_right_start, true_step_count);

% figure out how many steps there are in the selected time frame based on filter value
% iteratively adjust the filter value
% left foot
flag_change_filter = 1;
filter_left = filter_left_start;
filter_step_left = filter_step;
flag_toolow = 0;
flag_toohigh = 0;
i = 0;
did_not_converge_left = 0;
disp('Processing Left Foot')
while flag_change_filter
    i = i + 1;
    if i > 10
        disp('Iteration is greater than 10. Manually check the data for outliers. Exiting...\n')
        did_not_converge_left = 1;
        break
    end
    
    lf_tf = (lfoot_smooth < filter_left)*1;
    transitions_left = abs(lf_tf(2:end) - lf_tf(1:end-1));
    step_count = sum(transitions_left)/2;
    if step_count == true_step_count+1
        if i > 1
            flag_toohigh = 1;
        end
        if flag_toolow + flag_toohigh == 2 % visited both thresholds, finish loop
           break
        end
        filter_left = filter_left - filter_step_left;
    else
        filter_step_left = filter_step_left/2; % bisection to converge on desired data points
        filter_left = filter_left + filter_step_left;
        flag_toolow = 1;
    end
end

if ~did_not_converge_left
    fprintf(['Finished: Detected ', num2str(true_step_count), ' steps with final filter value of y=', num2str(filter_left), '\n\n']);
    step_xs_left = zeros(true_step_count, 1);
    step_ys_left = zeros(true_step_count, 1);
    transition_cumsum = cumsum(transitions_left);
    for i=1:true_step_count
        ind_ns = find(transition_cumsum == i*2, 1) - 1;
        step_xs_left(i) = filtered_time_range(ind_ns);
        step_ys_left(i) = lfoot_smooth(ind_ns);
    end
end

% right foot
flag_change_filter = 1;
filter_right = filter_right_start;
filter_step_right = filter_step;
flag_toolow = 0;
flag_toohigh = 0;
i = 0;
did_not_converge_right = 0;
disp('Processing Right Foot')
while flag_change_filter
    i = i + 1;
    if i > 10
        disp('Iteration is greater than 10. Manually check the data for outliers. Exiting...')
        did_not_converge_right = 1;
        break
    end
    
    rf_tf = (rfoot_smooth < filter_right)*1;
    transition_right = abs(rf_tf(2:end) - rf_tf(1:end-1));
    step_count = sum(transition_right)/2;
    if step_count == true_step_count+1
        if i > 1
            flag_toohigh = 1;
        end
        if flag_toolow + flag_toohigh == 2 % visited both thresholds, finish loop
            break
        end
        filter_right = filter_right - filter_step_right;
    else
        filter_step_right = filter_step_right/2; % bisection to converge on desired data points
        filter_right = filter_right + filter_step_right;
        flag_toolow = 1;
    end
end

if ~did_not_converge_right
    fprintf(['Finished: Detected ', num2str(true_step_count), ' steps with final filter value of y=', num2str(filter_right), '\n\n']);
    step_xs_right = zeros(true_step_count, 1);
    step_ys_right = zeros(true_step_count, 1);
    transition_cumsum = cumsum(transition_right);
    for i=2:true_step_count+1
        ind_ns = find(transition_cumsum == (i-1)*2+1, 1) + 1;
        step_xs_right(i-1) = filtered_time_range(ind_ns);
        step_ys_right(i-1) = rfoot_smooth(ind_ns);
    end
end

%% Data Visualization - Splicing Confirmation
if ~did_not_converge_left && ~did_not_converge_right
    figure(1)
    hold on
    % left
    plot(filtered_time_range, lfoot_smooth,'*', 'color', [255, 51, 51]/256);
    plot(filtered_time_range, linspace(filter_left, filter_left, length(filtered_time_range)), ':m', 'linewidth', 2)
    plot(step_xs_left, step_ys_left, 'o', 'markersize', 7, 'MarkerFaceColor', 'k')
    % right
    plot(filtered_time_range, rfoot_smooth,'*', 'color', [0, 128, 255]/256);
    plot(filtered_time_range, linspace(filter_right, filter_right, length(filtered_time_range)), ':', 'linewidth', 2, 'color', [0, 204, 34]/256)
    plot(step_xs_right, step_ys_right, 'o', 'markersize', 7, 'MarkerFaceColor', 'k')
    % legend
    legend("L FSR", 'L Filter', 'Start', "R FSR", 'R filter', 'End');
    % axes limit
    xlim([filtered_time_range(1)-10, filtered_time_range(end)+10])
    % title
    title('Identification of the foot position in xsensData')
    hold off
end
