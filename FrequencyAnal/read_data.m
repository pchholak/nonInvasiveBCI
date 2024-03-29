function [trials, time, eeg] = read_data(iSubj, info)
% Function to read data in text format to a mat variable

subject_name = sprintf('sub%02d', iSubj); % subject number to name string
fname = fullfile(info.data_path, subject_name, 'RAW.txt'); % join strings to
% get final path/location of the input file.

fileID = fopen(fname); % Open file to get file ID
formatSpec = ['%*s' repmat('%f', 1, 8) repmat('%*s', 1, 3) '%{HH:mm:ss.SSS}D'];
data = textscan(fileID, formatSpec, 'delimiter', ',', 'headerlines', 7, ...
        'collectoutput', 1);
fclose(fileID);

eeg = data{1}'; % All EEG data from 8 channels and total recording time
timeObj = data{2}; % Recording time stored as datetime object in MATLAB
time = timeObj.Hour * 3600 + timeObj.Minute * 60 + timeObj.Second; % Recording
% time converted to seconds in the day after 00:00 AM.

% Find nearest timestamps to recording events
t0 = info.time_events(1); % Time at which first event (background) started
T = floor(info.time_events - t0); % Change time reference to first event
err = abs(time-t0); [~, i_min] = min(err); % time <-> OpenBCI; t0 <-> MATLAB

inx_events = i_min + T * info.Fs;

% Segment data into trials of fixed length
n_trials = numel(info.time_events);
trials = cell(1, n_trials);
for q=1:n_trials
    trials{q} = eeg(:, ...
        inx_events(q)+1 : inx_events(q)+info.trial_length*info.Fs);
end
