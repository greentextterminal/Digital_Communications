%% Loading Sound Files
clc
clear
fs = 8000;
speech0 = audioread("speech0.wav");
speech0 = transpose(speech0);
speech1 = audioread("speech1.wav");
speech1 = transpose(speech1);
%sound(speech0, fs)
%sound(speech1, fs)
%% Finding Sample Duration in Seconds
sp0_len = length(speech0);
sp1_len = length(speech1);
sp0_duration = sp0_len / fs;
sp1_duration = sp1_len / fs;
% creating time x axis
sp0_x = linspace(0, sp0_duration, sp0_len);
sp1_x = linspace(0, sp1_duration, sp1_len);
%% Plotting 
%figure(1)
%plot(sp0_x, speech0)
%title('Speech0 File Vs Time'); xlabel('Time (seconds)'); ylabel('Speech0 Amplitude')
%figure(2)
%plot(sp1_x, speech1)
%title('Speech1 File Vs Time'); xlabel('Time (seconds)'); ylabel('Speech1 Amplitude')
%% 8 Bit Uniform Quantizer
N = 8; % 8 bits
L = 2 ^ N; % number of intervals
% quantization step size
sp0_Q = (max(speech0) - min(speech0)) / L; % sp0 step size
sp1_Q = (max(speech1) - min(speech1)) / L; % sp1 step size
% create arrays for speech quantized index and value
sp0_Qidx_arr = zeros(1, sp0_len);
sp0_Q_arr = zeros(1, sp0_len);
sp1_Qidx_arr = zeros(1, sp1_len);
sp1_Q_arr = zeros(1, sp1_len);
% looping to assign quantization values
for i=1:sp0_len
    sp0_Qidx_arr(i) = floor((speech0(i) - min(speech0)) / sp0_Q);
    sp0_Q_arr(i) = (sp0_Qidx_arr(i) * sp0_Q) + (sp0_Q/2) + min(speech0);
end

for i=1:sp1_len
    sp1_Qidx_arr(i) = floor((speech1(i) - min(speech1)) / sp1_Q);
    sp1_Q_arr(i) = (sp1_Qidx_arr(i) * sp1_Q) + (sp1_Q/2) + min(speech1);
end

sound(sp0_Q_arr,fs) % the sound became more distorted
%sound(sp1_Q_arr,fs) % the sound became more distorted
%% Finding SQNR of uniform 8 bit quantizer 
% Finding MSE (sigma q ^ 2)
sp0_MSE = sum(abs(speech0-sp0_Q_arr).^2) / sp0_len;
sp1_MSE = sum(abs(speech1-sp1_Q_arr).^2) / sp1_len;

% find sigma x ^ 2 of signal
sp0_sigmax2 = sum(abs(speech0).^2) / sp0_len;
sp1_sigmax2 = sum(abs(speech1).^2) / sp1_len;

% calculating SQNR
sp0_SQNR = 10 * log10(sp0_sigmax2 / sp0_MSE);
sp1_SQNR = 10 * log10(sp1_sigmax2 / sp1_MSE);
%% Computing the RMS of the Speech Files
sp0_RMS = sqrt(sum(speech0.^2 / sp0_len));
sp1_RMS = sqrt(sum(speech1.^2 / sp1_len));
%% Creating the X[n]/X_RMS Histogram
% sp0_histo_vals = speech0 ./ sp0_RMS;
% sp1_histo_vals = speech1 ./ sp1_RMS;
% figure(1)
% histogram(sp0_histo_vals)
% title('Speech0 File X[n]/XRMS Histogram');xlabel('Bins');ylabel('Amplitude')
% figure(2)
% histogram(sp1_histo_vals)
% title('Speech1 File X[n]/XRMS Histogram');xlabel('Bins');ylabel('Amplitude')
%% Mu Law Compressor
mu = 255; % American standard mu val is 255
compressed_arr = sign(speech0) .* (log(1+mu.*abs(speech0)) ./ log(1+mu));
%% Expander (Decoded)
expanded_arr = sign(compressed_arr) .* (1/mu) .* ((1+mu).^abs(compressed_arr)-1);
%% Plots
% figure(1)
% plot(sp0_x, compressed_arr)
% title('Speech0 Mu Law Compressed (Encoded) Plot');xlabel('Time (seconds)');ylabel('Amplitude')
% figure(2)
% plot(sp0_x, expanded_arr)
% title('Speech0 Decoded Plot');xlabel('Time (seconds)');ylabel('Amplitude')
%% Sound
%sound(speech0, fs)
%sound(compressed_arr,fs)
%sound(expanded_arr,fs)
%% SQNR of PCM System using Mu Law
% Find MSE (noise error)
sp0_MSE_mu = sum(abs(speech0-expanded_arr).^2) / sp0_len;
% Find sigma x ^ 2 (signal)
sp0_sigmax2_mu = sum(abs(speech0).^2) / sp0_len;
SQNR_mu = 10 * log10(sp0_sigmax2_mu / sp0_MSE_mu)