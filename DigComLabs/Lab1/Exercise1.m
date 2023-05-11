load('ecen455_lab1_sound.mat')
% function call to play sound is "sound"
fs = 48000 ; % sampling frequency (Hz)

sound(y, fs) ; % playing the sound

% number of discrete time points is fs * sample duration
sample_duration = 5 ; % secs
num_discrete_time_points = fs * sample_duration ;
discrete_time_points = linspace(0, sample_duration, num_discrete_time_points) ;

plot(discrete_time_points, y) 
title("Original Audio File Plot as a Function of Discrete Time")
xlabel("Discrete Time (s)")
ylabel("Audio Sample")
legend("Audio File vs Discrete Time")
grid on
