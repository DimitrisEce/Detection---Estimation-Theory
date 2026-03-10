function [eeg_bp_fil] = Band_Pass_Filtering(eeg , Fs , freq_pass_1 , freq_pass_2)
    
    if 1.2*freq_pass_2 > Fs / 2
        freq_pass_2 = Fs / 2;
    end

    d = designfilt('bandpassfir', 'FilterOrder', 200 , 'PassbandFrequency1', freq_pass_1 , 'PassbandFrequency2', freq_pass_2 ...
         , 'StopbandFrequency1' , 0.6*freq_pass_1 , 'StopbandFrequency2' , 1.2*freq_pass_2 , 'SampleRate', Fs);
               
    eeg_bp_fil = filtfilt(d, double(eeg') )';

end