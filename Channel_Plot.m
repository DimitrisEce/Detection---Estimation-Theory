function [] = Channel_Plot(eeg , eeg_filtered)
    
    [~ , num_samples] = size(eeg);
    Fs = 400;                               
    time_stamps = (0:num_samples-1)/Fs;
    for ch = 1:19
        figure;
        plot(time_stamps, double(eeg(ch, :)), 'b', 'LineWidth', 1);
        hold on;
        plot(time_stamps, double(eeg_filtered(ch, :)), 'r', 'LineWidth', 1);
        hold off;
        xlabel('Sample index');
        ylabel('Amplitude (µV)');
        title(sprintf('Channel %d: Raw (blue) vs. Filtered (red)', ch));
        legend({'Raw','Filtered'}, 'Location', 'northeast');
    end

end