clc
clear

data = load("train.mat");

blinks = data.blinks;
eeg = data.train_eeg;

test_data = load("test.mat");
eeg_test = test_data.test_eeg;


[W , R_noisy , R_clean] = Weiner_Filter(eeg , blinks , 0.04);

SNR_Checks(W , R_clean , R_noisy , 1);

denoised_test_data = W * eeg_test;

Channel_Plot(eeg , W * eeg)
Channel_Plot(eeg_test , denoised_test_data)


var_raw   = var(double(eeg_test),    0, 2);   
var_filt  = var(double(denoised_test_data), 0, 2);


reduction = 1 - (var_filt ./ var_raw);        

fprintf("Median variance reduction (test)= %.1f%%\n", median(reduction)*100);
fprintf("Mean   variance reduction (test)= %.1f%%\n", mean(reduction)*100);

T = table((1:19)', var_raw, var_filt, reduction, ...
    'VariableNames', {'Channel','VarRaw','VarFilt','Reduction'});
disp(T)

figure;
bar([var_raw, var_filt]);
legend({'Raw','Filtered'},'Location','northeast');
xlabel('Channel'); ylabel('Variance');
title('Test Data: Raw vs. Filtered Variance per Channel');