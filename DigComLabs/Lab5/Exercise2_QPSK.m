clear
clc
%% QPSK
%% SNR
% by increasing the SNR the mismatches decrease
SNR = 10.^(-1:0.1:1); % create SNR 
step_count_length = length(SNR);
SNR_dB = 10 .* log10(SNR) ;

% START OF MAIN LOOP
idx_count = 1 ;
error_prob_array = zeros(1, step_count_length) ;
for snr = SNR_dB
    %% QPSK Signal Constellation and Signal Generation
    % from quadrant 1 to quadrant 4
    QPSK_data = [1+1i, -1+1i, -1-1i, 1-1i] ;
    QPSK_rand_idx = randi([1 4],1,10000) ;
    QPSK_signal = QPSK_data(QPSK_rand_idx) ; % signal is 10^4 (True Signal)
    %% Adding Noise
    signal_power = 10*log10(1/length(QPSK_signal) * sum(abs(QPSK_signal).^2)) ; % signal power dB
    %QPSK_noisy_signal = awgn(QPSK_signal, SNR_dB, signal_power)
    QPSK_noisy_signal = awgn(QPSK_signal, snr, signal_power);

    % QPSK_noisy_signal
    QPSK_approximations_array = mlDecisions(QPSK_data, QPSK_noisy_signal) ;
    %% Error Determination
    % determine number of mismatches between X and Y-estimate
    mismatches = 0 ;
    for i=1:10000
        if (QPSK_approximations_array(i) ~= QPSK_signal(i))
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
% find vals for analytical probability of QPSK
error_prob_array2 = zeros(1, length(SNR)) ;
idx_count2 = 1 ;
for snr=SNR
    error_prob_array2(idx_count2) = 2 * (qfunc(sqrt(snr))) - (qfunc(sqrt(snr))) ^ 2;
    idx_count2 = idx_count2 + 1 ;
end

plot(SNR, error_prob_array, 'DisplayName', 'Empirical')
hold on
plot(SNR, error_prob_array2, "-*", 'DisplayName', 'Theoretical' )
hold off
lgd = legend;
lgd.NumColumns = 2;
xlabel("SNR (Es/No = 10^-^1^:^0^.^1^:^1)"); ylabel("SER")
title("Plot of Empirical and Theoretical QPSK SER vs SNR")