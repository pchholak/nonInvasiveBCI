function [pm, f] = plotPSD(signal, Fs, to_plot)

% ===== PARSE INPUTS =====
if nargin < 3 || isempty(to_plot)
    to_plot = 0;
end

% Windowing
L = size(signal, 2); % window length = time length of signal
w = hamming(L); x = signal'.*w;

% FFT
y = fft(x);
p2 = abs(y/L); p1 = p2(1:floor(L/2)+1, :);
p1(2:end-1, :) = 2*p1(2:end-1, :);
pm = mean(p1, 2); f = Fs * (0:(L/2)) / L;

% Visualise
if to_plot
    figure
    plot(f, pm)
    xlim([1, 60])
    ylim([0, 1])
    xlabel('f (Hz)')
    ylabel('|P(f)|')
    set(gca, 'FontSize', 14)
end
