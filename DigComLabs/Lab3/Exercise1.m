%% Optimal Non Uniform Quantization
%% setup
N = 3;
M = 2^N; 
loops = 1000; % number of times to run for loop
fprintf('N bits = %d', N)
%% Creating the Quantization Points (q) ; init. with linspace
q_array = linspace(-10,10,M); % initial q set
%% Init Boundary Array
size = M + 1; % b values will be M+1
b_array = zeros(1,size);
%% BEGIN main for loop here
for iteration=1:loops
%% Calculating and finding b's
%fprintf('iteration = %d', iteration)
for idx = 1:M+1
    if (idx == 1)
        b_array(idx) = -10;
    elseif (idx == M+1)
        b_array(end) = 10;
    else
        b_array(idx) = (q_array(idx) + q_array(idx-1)) / 2;
    end
end
b_array;
%% Calculate Updated q's (From b's)
% number of points is N , find dx
% pick N uniformly spaced points between boundaries of b_array to
% make updated q points

updated_q_array = zeros(1, M);
dx_array = zeros(1,M);
for idx = 1:M
    dx = (b_array(idx+1) - b_array(idx)) / 1000;
    dx_array(idx) = dx;
end
dx_array;

% creating the summation to find new q's
for i=1:M
    q = 0;
    for k=1:1000
        q = q + (normpdf(b_array(i) + (dx_array(i) * (k-1)))) * dx_array(i);
    end
    updated_q_array(i) = q;
end
updated_q_array;
%% Reassign q with updated q val array
q_array = updated_q_array;
%% END main for loop here
end
%% MSE Calculation (X-Q(X))^2  ; (observed - predicted)^2
X_vals = linspace(-10,10,M); 
X_vals_len = length(X_vals);
sum = 0;
for i=1:M % idx loop through b array
    for rand_val=1:X_vals_len % idx loop through random vals
        if (i==M) % last bound cond test
            if (b_array(i) <= rand_val && rand_val <= b_array(i+1))
                sum = sum + (rand_val - q_array(i)) ^ 2;
            end
        else % all other conditions
            if (b_array(i) <= rand_val && rand_val < b_array(i+1))
                sum = sum + (rand_val - q_array(i)) ^ 2;
            end
        end
    end
end

q_array;
b_array;
MSE = sum / X_vals_len
% for the MSE use a random variable of x between -10 and 10
% the Q(X) will be if the random variable is in a certain region
% using conditional logic we can find what region the x is in 
% which corresponds to the q we find from our lloyd max algo,
% the little q is what becomes q(x), x is the condition for it
%% MSE Calculation (Many Samples)
X_vals = linspace(-10,10,1000); % rand vals for sampling increased to 1000
X_vals_len = length(X_vals);
sum = 0;
for i=1:M % idx loop through b array
    for rand_val=1:X_vals_len % idx loop through random vals
        if (i==M) % last bound cond test
            if (b_array(i) <= rand_val && rand_val <= b_array(i+1))
                sum = sum + (rand_val - q_array(i)) ^ 2;
            end
        else % all other conditions
            if (b_array(i) <= rand_val && rand_val < b_array(i+1))
                sum = sum + (rand_val - q_array(i)) ^ 2;
            end
        end
    end
end

disp('Many Samples MSE')
MSE = sum / X_vals_len