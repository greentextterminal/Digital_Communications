clear
clc
%% Gray Coding Map Schemes
% like problem 2, after the ml decision, convert to a binary mapping, then
% find the actual recieved and convert it to its binary mapping, find the
% BER bit error rate by finding the difference in bits, if sent signal has
% bin map 011 and recieved signal was mapped to 011 then there is no error,
% however if sent signal has bin map 011 and recieved signal was mapped to
% 000 then there is a bit error of 2 since there is a mismatch of 2 bits
% between sent and recieved

bin_map4qpsk = ["00", "01", "11", "10"]
bin_map16psk = ["0000", "1000", "1001", "1011" ... 
            "1010", "1110", "1111", "1101" ...
            "1100", "0100", "0101", "0111" ...
            "0110", "0010", "0011", "0001"]
bi_map8psk = ["000", "001", "011", "010", "110", "111", "101", "100"]

QAM_data = [-3-3i, -3-1i, -3+1i, -3+3i ...
            -1-3i, -1-1i, -1+1i, -1+3i ...
            1-3i, 1-1i, 1+1i, 1+3i ...
            3-3i, 3-1i, 3+1i, 3+3i] ;
QAM_gray_mapped = dictionary(QAM_data, bin_map16psk)

%% SNR
% by increasing the SNR the mismatches decrease
SNR = 10.^(-1:0.1:1); % create SNR 
step_count_length = length(SNR);

SNR_dB = 10 .* log10(SNR) ;

% START OF MAIN LOOP
idx_count = 1 ;
error_prob_array = zeros(1, step_count_length) ; % BER
error_prob_array2 = zeros(1, step_count_length); % SER
for snr = SNR_dB
    %% QPSK Signal Constellation and Signal Generation
    % from quadrant 1 to quadrant 4
    QAM_rand_idx = randi([1 16],1,10000) ;
    QAM_signal = QAM_data(QAM_rand_idx) ; % signal is 10^4 (True Signal)
    %% Adding Noise
    signal_power = 10*log10(1/length(QAM_signal) * sum(abs(QAM_signal).^2)) ; % signal power dB
    QAM_noisy_signal = awgn(QAM_signal, snr, signal_power);
    QAM_approximations_array = mlDecisions(QAM_data, QAM_noisy_signal) ;
    %% Gray Coding QAM transmitted and recieved
    QAM_gray_transmitted = QAM_gray_mapped(QAM_signal) ; % actual
    QAM_gray_recieved = QAM_gray_mapped(QAM_approximations_array); % approx
    %% Error Determination (BER)
    % determine number of mismatches between X and Y-estimate
    % BER
    bit_mismatches = 0 ;
    for i=1:10000
        code_t = QAM_gray_transmitted(i) ;
        code_r = QAM_gray_recieved(i) ;

        for j=1:4 % adjust to 4 bits
            bit1 = extract(code_t, j) ;
            bit2 = extract(code_r, j) ;
            if (bit1 ~= bit2)
                bit_mismatches = bit_mismatches + 1;
            end
        end
    end
    bit_mismatches
    num_total_symbol = 10000;
    num_total_bits = 2 * num_total_symbol;
    error_prob = bit_mismatches / num_total_bits ;
    error_prob_array(idx_count) = error_prob ; % stores the collected BER
    %idx_count = idx_count + 1 ; 

    %% SER
    mismatches = 0 ;
    for i=1:10000
        if (QAM_approximations_array(i) ~= QAM_signal(i))
            mismatches = mismatches + 1;
        end
    end
    % mismatches
    error_prob2 = mismatches / 10000 ;
    error_prob_array2(idx_count) = error_prob2 ;
    idx_count = idx_count + 1 ;

end
% END OF MAIN LOOP

%% Error Plotting
plot(SNR, error_prob_array, 'DisplayName', 'BER')
hold on
plot(SNR, error_prob_array2, 'DisplayName', 'SER')
hold off
lgd = legend;
lgd.NumColumns = 2;
xlabel("SNR"); ylabel("BER and SER (empirical)")
title("16-QAM BER and SER vs SNR")
