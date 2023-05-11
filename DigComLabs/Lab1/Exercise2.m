load('ecen455_lab1_sound.mat')  % y is the audio clip vector
transposed_y = transpose(y) ;
upsample_factor = 2 ;
fs = 48000 * upsample_factor; % upsampled sampling frequency (Hz) by factor of 2
%sound(y, fs) ; % original sound at fs sounds twice as fast as original
%% Upsampling (In Time Domain ; Now Stretched)
b = zeros(upsample_factor-1,numel(transposed_y)) ; % 2 is upsample factor : N-1 : 2-1 : 1
upsamp_result = reshape([transposed_y; b],1,[]) ; % b is a length matched zero vector
%% Plot Time Domain Upsampled Result (and Sound)
x_time_domain = linspace(0, 5, length(upsamp_result)) ; 
%subplot(4,1,1)
%plot(x_time_domain, upsamp_result) 
%title('Signal In Time Domain (Fs=96kHz)'); xlabel('Time (sec)'); ylabel('Magnitude'); grid on
%% FFT and IFFT 
% Num of frequency point : 
fft_result = fft(upsamp_result) ; % fft
ifft_result = ifft(fft_result) ;  % ifft of fft
%sound(ifft_result,fs)
%% Plot Frequency Domain Upsampled Result
x_freq_domain = linspace(0, fs, length(fft_result)) ;
%subplot(4,1,2)
freq_magnitudes = abs(fft_result) ; % this is the absolute result; derived from fft_result
%plot(x_freq_domain,freq_magnitudes)
%title('Signal In Frequncy Domain (Fs=96kHz)'); xlabel('Frequency (Hz)'); ylabel('Magnitude')
%xlim([0, fs]) ; grid on
%% Low Pass Filter Application % apply to cut the frequency
low_pass_filter = ones(1, length(x_freq_domain)) ; % low pass filter
low_passed_frequencies = fft_result .* low_pass_filter ; % applying low pass filter
%subplot(4,1,3)
%plot(x_freq_domain, abs(low_passed_frequencies))
%title('Lowpassed Signal In Frequncy Domain (Fs=96kHz)'); xlabel('Frequency (Hz)'); ylabel('Magnitude')
%xlim([0,fs]); grid on
%% Low Passed Signal to Time Domain
lp_time_domain_signal = real(ifft(low_passed_frequencies)) ; % plot real part
%subplot(4,1,4)
%plot(x_time_domain, lp_time_domain_signal)
%title('Low Passed Signal In Time Domain (Fs=96kHz)'); xlabel('Time (sec)'); ylabel('Magnitude')
%% Playing Upsampled Sound
sound(lp_time_domain_signal,fs)
% the signal sounds similar to the original with the same plyback speed but is smoother 
%% Upsample Plot
figure(1)
plot(x_time_domain, lp_time_domain_signal)
title("Upsampled By Factor of 2 Audio File Plot as a Function of Discrete Time (Fs=96kHz)")
xlabel('Time (sec)'); ylabel('Magnitude')
legend("Upsampled Audio File vs Discrete Time") ; grid on
%% Original Signal
% the signal from exercise 1, compare to that 
%% Process
% fft : converts signal from time domain into frequency domain
% have a discrete signal ->FFT ->frequency domain ->LPF ->apply IFFT (time domain) 
% know how fft works in matlab
% FFT -> IFFT
%%

% sample_duration = 5 ; % adjusted duration due to upsampling
% num_discrete_time_points = fs * sample_duration ;
% x_time_domain = linspace(0, sample_duration, num_discrete_time_points) ;