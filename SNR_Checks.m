function [SNR_in , SNR_out , SNR_gain , data_preservation , noise_elimination] = SNR_Checks(W , R_clean , R_noisy , verbose)

    signal_out = trace(W * R_clean * W');
    noise_out = trace(W * R_noisy * W');

    signal_in = trace(R_clean);
    noise_in = trace(R_noisy);

    SNR_in = signal_in / noise_in;
    SNR_out = signal_out / noise_out;

    SNR_gain = 10 * log10(SNR_out / SNR_in);

    data_preservation = signal_out / signal_in;
    noise_elimination = 1 - (noise_out / noise_in);

    if verbose == 1
        fprintf("Input SNR = %.2f . \n" , SNR_in);
        fprintf("Output SNR = %.2f . \n" , SNR_out);
        fprintf("SNR Gain = %.2f dB . \n", SNR_gain);
        fprintf("Data are preserved by a factor of %.2f .\n" , data_preservation);
        fprintf("Noise is eliminated by a factor of %.2f . \n" , noise_elimination);
    end
     

