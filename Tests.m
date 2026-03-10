clc
clear;

data = load("train.mat");

blinks = data.blinks;
eeg = data.train_eeg;

weights = linspace(0 , 0.2 , 21);

num_weights = numel(weights);
data_pre_vec = zeros(1 , num_weights);
noise_elim_vec = zeros(1 , num_weights);
snr_gain_vec = zeros(1 , num_weights);
labels = cell(1 , num_weights);

for i = 1 : num_weights

    w = weights(i);
    [W, R_noisy, R_clean] = Weiner_Filter(eeg, blinks, w);
    [~, ~, snr_g, d_p, n_e] = SNR_Checks(W, R_clean, R_noisy, 0);

    data_pre_vec(i) = d_p;
    noise_elim_vec(i) = n_e;
    snr_gain_vec(i) = snr_g;
    labels{i} = sprintf('w=%.2f', w);

end

Plot_Parameter_Effect(data_pre_vec , noise_elim_vec , snr_gain_vec , labels);


l_cuts = linspace(0.2 , 5 , 5);
h_cuts = linspace(30 , 55 , 5);
weights = linspace(0 , 1 , 10);

num_weights = numel(weights);
data_pre_vec = zeros(1 , num_weights);
noise_elim_vec = zeros(1 , num_weights);
snr_gain_vec = zeros(1 , num_weights);
labels = cell(1 , num_weights);

index = 0;

tol = 10^-9;

for lc = l_cuts
    for hc = h_cuts
        for w = weights

            index = index + 1;
            eeg_bp = Band_Pass_Filtering(eeg , 400 , lc, hc);

            [W, R_noisy, R_clean] = Weiner_Filter(eeg_bp, blinks, w);
            Rxx = R_clean + w*R_noisy;
            f1 = norm(W*Rxx - R_clean, 'fro');
            f2 = norm(W + w*(R_noisy/Rxx) - eye(size(W)), 'fro');
            if f1>tol || f2>tol
                continue 
            end

            [~, ~, snr_g, d_p, n_e] = SNR_Checks(W, R_clean, R_noisy, 0);

            data_pre_vec(index) = d_p;
            noise_elim_vec(index) = n_e;
            snr_gain_vec(index) = snr_g;
            labels{index} = sprintf('lc=%.1f hc=%.0f w=%.2f', lc, hc, w);

        end
    end
end
Plot_Parameter_Effect(data_pre_vec, noise_elim_vec, snr_gain_vec, labels);







