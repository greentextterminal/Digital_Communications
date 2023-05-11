clear
clc
%% 16-QAM
%% SNR
% by increasing the SNR the mismatches decrease
SNR = 10.^(-1:0.1:1); % create SNR 
step_count_length = length(SNR);
SNR_dB = 10 .* log10(SNR) ;

% START OF MAIN LOOP
idx_count = 1 ;
error_prob_array = zeros(1, step_count_length) ;
for snr = SNR_dB
    %% 16-QAM Signal Constellation and Signal Generation
    % the set is {-3,-1,1,3}
    QAM_data = [-3-3i, -3-1i, -3+1i, -3+3i ...
                -1-3i, -1-1i, -1+1i, -1+3i ...
                1-3i, 1-1i, 1+1i, 1+3i ...
                3-3i, 3-1i, 3+1i, 3+3i] ;
    QAM_rand_idx = randi([1 16],1,10000) ;
    QAM_signal = QAM_data(QAM_rand_idx) ; % signal is 10^4 (True Signal)
    %% Adding Noise
    signal_power = 10*log10(1/length(QAM_signal) * sum(abs(QAM_signal).^2)) ; % signal power dB
    QAM_noisy_signal = awgn(QAM_signal, snr, signal_power);

    % QAM_noisy_signal
    QAM_approximations_array = mlDecisions(QAM_data, QAM_noisy_signal) ;
    %% Error Determination
    % determine number of mismatches between X and Y-estimate
    mismatches = 0 ;
    for i=1:10000
        if (QAM_approximations_array(i) ~= QAM_signal(i))
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
    error_prob_array2(idx_count2) = 3 * (qfunc(sqrt((1/5)*snr))) - (9/4) * (qfunc(sqrt((1/5)*snr))) ^ 2;
    idx_count2 = idx_count2 + 1 ;
end

plot(SNR, error_prob_array, 'DisplayName', 'Empirical')
hold on
plot(SNR, error_prob_array2, "-*", 'DisplayName', 'Theoretical' )
hold off
lgd = legend;
lgd.NumColumns = 2;
xlabel("SNR (Es/No = 10^-^1^:^0^.^1^:^1)"); ylabel("SER")
title("Plot of 16-QAM Empirical and Theoretical Error Probability vs SNR")