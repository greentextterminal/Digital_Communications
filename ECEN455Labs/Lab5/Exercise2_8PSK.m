clear
clc
%% 8-PSK
%% SNR
% by increasing the SNR the mismatches decrease
SNR = 10.^(-1:0.1:1); % create SNR 
step_count_length = length(SNR);
SNR_dB = 10 .* log10(SNR) ;

% START OF MAIN LOOP
idx_count = 1 ;
error_prob_array = zeros(1, step_count_length) ;
for snr = SNR_dB
    %% 8-PSK Signal Constellation and Signal Generation
    PSK_data = [1, -1, 1i, -1i ...
                (1/sqrt(2)) * (-1-1i), (1/sqrt(2)) * (-1+1i) ...
                (1/sqrt(2)) * (1-1i), (1/sqrt(2)) * (1+1i)] ;
    PSK_rand_idx = randi([1 8],1,10000) ;
    PSK_signal = PSK_data(PSK_rand_idx) ; % signal is 10^4 (True Signal)
    %% Adding Noise
    signal_power = 10*log10(1/length(PSK_signal) * sum(abs(PSK_signal).^2)) ; % signal power dB
    PSK_noisy_signal = awgn(PSK_signal, snr, signal_power);

    % PSK_noisy_signal
    PSK_approximations_array = mlDecisions(PSK_data, PSK_noisy_signal) ;
    %% Error Determination
    % determine number of mismatches between X and Y-estimate
    mismatches = 0 ;
    for i=1:10000
        if (PSK_approximations_array(i) ~= PSK_signal(i))
            mismatches = mismatches + 1;
        end
    end
    % mismatches
    error_prob = mismatches / 10000 ;
    error_prob_array(idx_count) = error_prob ;
    idx_count = idx_count + 1 ;
end
% END OF MAIN LOOP

%% Error Plotting
% find vals for analytical probability of QAM
error_prob_array2 = zeros(1, length(SNR)) ;
idx_count2 = 1 ;
for snr=SNR
    error_prob_array2(idx_count2) = 2 * (qfunc(sqrt(2* snr * (sin(pi/8))^2 ))) ;
    idx_count2 = idx_count2 + 1 ;
end

plot(SNR, error_prob_array, 'DisplayName', 'Empirical')
hold on
plot(SNR, error_prob_array2, "-*", 'DisplayName', 'Theoretical' )
hold off
lgd = legend;
lgd.NumColumns = 2;
xlabel("SNR (Es/No = 10^-^1^:^0^.^1^:^1)"); ylabel("SER")
title("Plot of 8-PSK Empirical and Theoretical SER vs SNR")