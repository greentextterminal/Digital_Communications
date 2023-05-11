f0 = 5 ;
T = 2 ;
phi = pi/4 ;
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

X = @ (t) -2*sin(2 * pi * f0 * t) + 4*cos(pi * f0 * t + phi) ;

func_length = length(-2*sin(2 * pi * f0 * t) + 4*cos(pi * f0 * t + phi)) 

% 3b
max_val = max(-2*sin(2 * pi * f0 * t) + 4*cos(pi * f0 * t + phi)) ;

% 3c
min_val = min(-2*sin(2 * pi * f0 * t) + 4*cos(pi * f0 * t + phi)) ;

% 3d
sum_val = sum(-2*sin(2 * pi * f0 * t) + 4*cos(pi * f0 * t + phi)) ;

%3e
mean_val = mean(-2*sin(2 * pi * f0 * t) + 4*cos(pi * f0 * t + phi)) ;

% 3f
var_x = var(-2*sin(2 * pi * f0 * t) + 4*cos(pi * f0 * t + phi)) ;

% 3g
t1 = 0.1 ;
t2 = 0.51 ;
x_at_t1 = X(t1) ;
x_at_t2 = X(t2) ;
