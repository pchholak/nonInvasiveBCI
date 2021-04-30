close all
clear
clc

iSubj = 1; % Subject number
info.channels = 7:8; % EEG channels to analyse
info.time_events = [61142.122, 61302.21, 61572.246, 61842.272];
info.conds = {'B', 'F', 'F', 'F'};
info.data_path = 'C:/Users/Usuario/data/BCI';
info.trial_length = 120; % in seconds
info.Fs = 250; % Sampling frequency (Hz)
info.plot_PSD = 0; % Flag to plot power spectral density or not
t = (1 : info.Fs*info.trial_length) / info.Fs;

sprintf('Loading and segmenting data into trials...')
[trials, time, eeg] = read_data(iSubj, info);

% Check power spectrum for tags
sprintf('Computing power spectrum...')
[pm_B, f] = findPSD(trials{1}(info.channels, :), info.Fs);
n_trials = numel(info.time_events);
pm = nan(numel(pm_B), 3);
for q = 2 : n_trials
    pm(:, q-1) = findPSD(trials{q}(info.channels, :), info.Fs);
end
pm_F = mean(pm, 2);

figure
plot(f, pm_B, f, pm_F, 'LineWidth', 2)
xlim([1, 60])
ylim([0, 1])
xlabel('f (Hz)')
ylabel('|P(f)|')
set(gca, 'FontSize', 14)
legend({'B', 'F'}, 'FontSize', 12)
