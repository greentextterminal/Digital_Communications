load('ecen455_lab1_sound.mat')  % y is the audio clip vector
transposed_y = transpose(y) ;
N = 12 ;
downsample_factor = 1/N ;
fs = 48000 * downsample_factor; % downsampled sampling frequency (Hz) 
%sound(y, fs) ; % original sound at fs sounds twice as slow as original
%% Downsampling (In Time Domain)
downsampled_result = transposed_y(1 : N : length(transposed_y)) ; % taking every Nth sample
%% Plot Time Domain Downsampled Result (and Sound)
x_time_domain = linspace(0, 5, length(downsampled_result)) ; 
%subplot(4,1,1)
%plot(x_time_domain, downsampled_result) 
%title('Signal In Time Domain (Fs=24kHz)'); xlabel('Time (sec)'); ylabel('Magnitude'); grid on
%% FFT and IFFT 
fft_result = fft(downsampled_result) ; % fft
ifft_result = ifft(fft_result) ;  % ifft of fft
%% Plot Frequency Domain Upsampled Result
x_freq_domain = linspace(0, fs, length(fft_result)) ;
%subplot(4,1,2)
freq_magnitudes = abs(fft_result) ; % this is the absolute result; derived from fft_result
%plot(x_freq_domain,freq_magnitudes)
%title('Signal In Frequncy Domain (Fs=24kHz)'); xlabel('Frequency (Hz)'); ylabel('Magnitude')
%xlim([0, fs]) ; grid on
%% Low Pass Filter Application % apply to cut the frequency
low_pass_filter = ones(1, length(x_freq_domain)) ; % low pass filter
low_passed_frequencies = fft_result .* low_pass_filter ; % applying low pass filter
%subplot(4,1,3)
%plot(x_freq_domain, abs(low_passed_frequencies))
%title('Lowpassed Signal In Frequncy Domain (Fs=24kHz)'); xlabel('Frequency (Hz)'); ylabel('Magnitude')
%xlim([0,fs]); grid on
%% Low Passed Signal to Time Domain
lp_time_domain_signal = real(ifft(low_passed_frequencies)) ; % plot real part
%subplot(4,1,4)
%plot(x_time_domain, lp_time_domain_signal)
%title('Low Passed Signal In Time Domain (Fs=24kHz)'); xlabel('Time (sec)'); ylabel('Magnitude')
%title("Downsampled By Factor of 2 Audio File Plot as a Function of Discrete Time")
%legend("Downsampled Audio File vs Discrete Time"); grid on
%% Playing Upsampled Sound and Comparison
sound(lp_time_domain_signal,fs)
% the signal plays back at the same speed as the original but the audio
% signal is slightly reduced in quality
%% Plot of the Downsampled Signal
figure(1)
plot(x_time_domain, lp_time_domain_signal)
title("Downsampled By Factor of 2 Audio File Plot as a Function of Discrete Time (Fs=24kHz)"); 
xlabel('Time (sec)'); ylabel('Magnitude')
legend("Downsampled Audio File by Factor of 2 vs Discrete Time") ; grid on
%% Original Signal
% the signal from exercise 1, compare to that 
%% Process
% fft : converts signal from time domain into frequency domain
% have a discrete signal ->FFT ->frequency domain ->LPF ->apply IFFT (time domain) 
% FFT -> IFFT