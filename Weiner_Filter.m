function [W , R_noisy , R_clean] = Weiner_Filter(eeg , blinks , weight)

    [~ , num_samples] = size(eeg);
    num_blinks = length(blinks);
    

    boolean_blinks = zeros(1 , width(eeg));
    boolean_blinks(1 , blinks) = 1;

    clean_eeg = eeg(: , boolean_blinks == 0);
    noisy_eeg = eeg(: , boolean_blinks == 1);

    if width(clean_eeg) + width(noisy_eeg) ~= width(eeg)
    error("Clean and noisy eeg vector dimensions are wrong.")
    end

    mu_clean_eeg = mean(clean_eeg , 2);
    mu_noisy_eeg = mean(noisy_eeg , 2);

    if length(mu_noisy_eeg) ~= 19 || length(mu_clean_eeg) ~= 19
    error("Error. Mean vector dimensions are not correct.")
    end

    zm_clean_eeg = clean_eeg - mu_clean_eeg;
    zm_noisy_eeg = noisy_eeg - mu_noisy_eeg;

    R_clean = (zm_clean_eeg * zm_clean_eeg') / (num_samples - num_blinks);
    R_noisy = (zm_noisy_eeg * zm_noisy_eeg') / (num_blinks);

    if height(R_clean) ~= 19 || width(R_clean) ~= 19
    error("Error. R_clean matrix dimensions are not correct")
    end

    if height(R_noisy) ~= 19 || width(R_noisy) ~= 19
        error("Error. R_noisy matrix dimensions are not correct")
    end

    R_xx = R_clean + weight*R_noisy;

    W = R_clean / R_xx;

    diff = W*(R_xx) - R_clean;

    if norm(diff , 'fro') > 10^-8
        warning("Frobinuis norm of difference was found to be too large.")
    end
    
    not_W = weight * R_noisy / R_xx;
    diff_2 = W + not_W - eye(19);


    if norm(diff_2 , 'fro') > 10^-8
        warning("Frobinuis norm of difference was found to be too large for the noise extraction filter.")
    end

    return

end

    

    