function [] = Plot_Parameter_Effect(data_preservation_vector , noise_elimination_vector , SNR_gain_vector , labels)

    figure;
    scatter(noise_elimination_vector , data_preservation_vector , 60 , SNR_gain_vector , 'filled');
    colormap("jet"); 
    colorbar;
    xlabel('Noise Eliminated'); 
    ylabel('Data Preserved');
    title('Filter‐Parameter Sweep: Trade‐off & SNR Gain');
    grid on; 
    axis([0 1 0 1]);

    if exist('labels','var') && ~isempty(labels)
        text(noise_elimination_vector+0.02, data_preservation_vector , labels, 'FontSize',8);
    end
end


    