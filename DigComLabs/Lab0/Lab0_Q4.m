f0 = 1 ;
T = 2 ;
phi = -(pi / 3) ;
fs = 100 ;

len = 2 / (1/fs) ; % get the amount of elements for range
t = zeros(1, len+1) ; % +1 to account for 0 start
idx = 1 ; % index
num = 0 ; % initialized zero val
t(idx) = num; % first idx element at 0
while (num <= T)
    num = num + (1 / fs) ;
    idx = idx + 1 ;
    t(idx) = num ;
end

X = @ (t) exp(2 * pi * 1i * f0 * t + 1i * phi) + 2*cos(2 * pi * f0 * t);

% 4a (magnitude of X vs t)
figure(1)
func = X(t) ;
plot(t, abs(func)) 
title("Magnitude of X vs t")
xlabel("t")
ylabel("X(t)")
grid on
legend("X(t) vs t")


% 4b
figure(2)
phase_func = angle(func) ;
plot(t, phase_func)
title("Phase of X (in rads) vs t")
xlabel("t")
ylabel("Phase of X (in radians)")
grid on
legend("Phase of X vs t")


% 4c
figure(3)
real_func = real(func) ;
plot(t, real_func)
title("Real Part of X vs t")
xlabel("t")
ylabel("Real parts of X")
grid on 
legend("Real part of X vs t")

figure(4)
imag_func = imag(func) ; 
plot(t, imag_func)
title("Imaginary Part of X vs t")
xlabel("t")
ylabel("Imaginary parts of X")
grid on
legend("Imaginar part of X vs t")

