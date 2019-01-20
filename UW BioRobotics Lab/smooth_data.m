function [lfoot_filtered, rfoot_filtered] = smooth_data(total_left_force, left_start, total_right_force, right_start, true_step_count)
% SMOOTH_DATA - filters signals based on input and returns the results.
% There are spurious steps in each foot (last transition for the left and
% first transition for the right). Smoothing ignores these data. 
%    [lfoot, rfoot] = SMOOTH_DATA(total_left_force, left_start, total_right_force, right_start, true_step_count)
%    input
%        total_left_force - unfiltered data for left foot
%        left_start - filtering threshold for left foot
%        total_right_force - unfiltered data for right foot
%        right_start - filtering threshold for right foot
%        true_step_count - known number of steps in data
%    output
%        lfoot_filtered - filtered data for left foot
%        rfoot_filtered - filtered data for right foot


%% left foot
lfoot_filtered = total_left_force;
% based on filter_left_start; returns 0 or 1
lf_tf = (lfoot_filtered < left_start)*1;
transition_left = abs(lf_tf(2:end) - lf_tf(1:end-1));
% ignore last transition
ind_cutoff_left = find(transition_left == 1, 1, 'last');
lfoot_filtered(ind_cutoff_left-1:end) = left_start + 10; 
lf_tf = (lfoot_filtered < left_start)*1;
transition_left = abs(lf_tf(2:end) - lf_tf(1:end-1));
iter = 0;
while sum(transition_left)/2 > true_step_count + 1
    iter = iter + 1;
    if iter > 10
        lfoot_filtered = -1;
        break
    end
    % location of 1s
    ind_ones = find(transition_left == 1);
    % compute distance between 1s
    dist_ones = diff(ind_ones);
    [~, ind_dist_ones_sorted] = sort(dist_ones);
    for i = ind_ones(ind_dist_ones_sorted(1))+1:ind_ones(ind_dist_ones_sorted(1)+1)
        lfoot_filtered(i) = lfoot_filtered(ind_ones(ind_dist_ones_sorted(1))-1); % index is adjusted for left foot
    end
    lf_tf = (lfoot_filtered < left_start)*1;
    transition_left = abs(lf_tf(2:end) - lf_tf(1:end-1));
end


%% right foot
rfoot_filtered = total_right_force;
% based on filter_right_start; returns 0 or 1
rf_tf = (rfoot_filtered < right_start)*1;
transition_right = abs(rf_tf(2:end) - rf_tf(1:end-1));
% ignore first transition
ind_cutoff_right = find(transition_right == 1, 1);
rfoot_filtered(1:ind_cutoff_right) = right_start + 10; 
rf_tf = (rfoot_filtered < right_start)*1;
transition_right = abs(rf_tf(2:end) - rf_tf(1:end-1));
iter = 0;
while sum(transition_right)/2 > true_step_count + 1       
    iter = iter + 1;
    if iter > 10
        rfoot_filtered = -1;
        break
    end
    % need smoothing
    % location of 1s
    ind_ones = find(transition_right == 1);
    % compute distance between 1s
    dist_ones = diff(ind_ones);
    [~, ind_dist_ones_sorted] = sort(dist_ones);
    for i = ind_ones(ind_dist_ones_sorted(1))+1:ind_ones(ind_dist_ones_sorted(1)+1)
        rfoot_filtered(i) = rfoot_filtered(ind_ones(ind_dist_ones_sorted(1)+1)+1); % index is adjusted for right foot
    end
    rf_tf = (rfoot_filtered < right_start)*1;
    transition_right = abs(rf_tf(2:end) - rf_tf(1:end-1));
end
